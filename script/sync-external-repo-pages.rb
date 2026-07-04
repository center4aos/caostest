#!/usr/bin/env ruby
# Walks a mounted external repo and generates the data this site needs to
# render it as browsable pages:
#   - _data/external_repo_pages/<key>.yml -- hierarchical `tree` (for the
#     listing page) and flat `{relative_path => title}` map (for per-page
#     title fallbacks)
#   - merges a `redirect_from:` list (one entry per directory, any depth)
#     into the listing page's own frontmatter, so directory URLs resolve
#     to the listing instead of 404ing
#
# Usage: ruby script/sync-external-repo-pages.rb --key governance --path governance/library

require "yaml"
require "kramdown"
require "optparse"
require "fileutils"

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: sync-external-repo-pages.rb --key KEY --path PATH"
  opts.on("--key KEY", "Registry key in _data/external_repos.yml") { |v| options[:key] = v }
  opts.on("--path PATH", "Mount path relative to the repo root, e.g. governance/library") { |v| options[:path] = v }
end.parse!

key = options[:key] or abort "Missing --key"
mount_path = options[:path] or abort "Missing --path"

repo_root = File.expand_path("..", __dir__)
mount_root = File.join(repo_root, mount_path)
abort "Mount path not found: #{mount_root}" unless Dir.exist?(mount_root)

# Filename/folder-name -> display title. Hyphens/underscores become spaces;
# only fully-lowercase words get capitalized, so existing capitalization
# (including acronyms) is left alone.
def humanize(name)
  name.gsub(/[-_]/, " ").split(" ").map { |w| w =~ /[A-Z]/ ? w : w.capitalize }.join(" ")
end

# First `# heading` line wins; run through Kramdown and stripped of tags so
# inline formatting (links, bold/italic) resolves to plain text. Falls back
# to a humanized filename if the file has no heading at all.
def extract_title(file_path, fallback_name)
  content = File.read(file_path)
  content = content.sub(/\A---\s*\n.*?\n---\s*\n/m, "")
  heading_line = content.each_line.find { |line| line.start_with?("# ") }
  if heading_line
    heading_text = heading_line.sub(/\A#\s*/, "").strip
    Kramdown::Document.new(heading_text).to_html.gsub(%r{</?[^>]+>}, "").strip
  else
    humanize(fallback_name)
  end
end

# Recursively scans one directory, returning its children (files then
# subdirectories, per the agreed listing order). Mutates `flat` and
# `directories` as a side effect. A directory is omitted entirely (pruned)
# if it and all its descendants contain zero files.
def scan_children(mount_root, relative_dir, mount_path, flat, directories)
  abs_dir = relative_dir.empty? ? mount_root : File.join(mount_root, relative_dir)
  entries = Dir.children(abs_dir).reject { |e| e.start_with?("_") || e.start_with?(".") }.sort

  files = []
  dirs = []

  entries.each do |entry|
    abs_entry = File.join(abs_dir, entry)
    rel_entry = relative_dir.empty? ? entry : "#{relative_dir}/#{entry}"

    if File.directory?(abs_entry)
      children = scan_children(mount_root, rel_entry, mount_path, flat, directories)
      next if children.empty?
      dirs << { "type" => "directory", "name" => humanize(entry), "children" => children }
      directories << rel_entry
    elsif entry =~ /\.(md|markdown)\z/i
      title = extract_title(abs_entry, File.basename(entry, File.extname(entry)))
      url = "/#{mount_path}/#{rel_entry}".sub(/\.(md|markdown)\z/i, ".html")
      flat[rel_entry] = title
      files << { "type" => "file", "title" => title, "path" => rel_entry, "url" => url }
    end
  end

  files + dirs
end

flat = {}
directories = []
tree = scan_children(mount_root, "", mount_path, flat, directories)

data_dir = File.join(repo_root, "_data", "external_repo_pages")
FileUtils.mkdir_p(data_dir)
File.write(File.join(data_dir, "#{key}.yml"), { "tree" => tree, "flat" => flat }.to_yaml)

# Merge redirect_from into the listing page's own frontmatter, preserving
# everything else it already declares (permalink, ancestors, etc.)
listing_page = File.join(repo_root, "_external_repo_pages", "#{key}.md")
abort "Listing page not found: #{listing_page} -- create it first with its own permalink/ancestors frontmatter" unless File.exist?(listing_page)

content = File.read(listing_page)
content =~ /\A(---\s*\n)(.*?)(\n---\n)(.*)\z/m or abort "Could not parse frontmatter in #{listing_page}"
front = YAML.safe_load(Regexp.last_match(2)) || {}
body = Regexp.last_match(4)
front["redirect_from"] = directories.sort.map { |d| "/#{mount_path}/#{d}/" }
File.write(listing_page, "#{front.to_yaml}---\n#{body}")

puts "Wrote #{data_dir}/#{key}.yml (#{flat.size} files, #{directories.size} directories)"
