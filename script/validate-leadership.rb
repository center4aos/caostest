#!/usr/bin/env ruby
# Validates the _leadership/ collection: every person needs a .md (with
# name/role/bio/desc frontmatter, all non-blank). A matching .jpg is
# optional -- if absent, the site falls back to fallback.jpg with a
# fixed "CAOS generic image" alt text at render time, so a missing
# photo is not an error here. An orphaned .jpg with no matching .md is
# still flagged, since that's more likely a mistake than intentional.
# Run manually whenever leadership content changes -- not wired into CI.
#
# Usage: ruby script/validate-leadership.rb

require "yaml"

REQUIRED_FIELDS = %w[name role bio desc].freeze
FALLBACK_STEM = "fallback"

repo_root = File.expand_path("..", __dir__)
leadership_dir = File.join(repo_root, "_leadership")

abort "_leadership/ does not exist -- nothing to validate." unless Dir.exist?(leadership_dir)

entries = Dir.children(leadership_dir).reject { |e| e.start_with?("_") || e.start_with?(".") }

by_stem = Hash.new { |h, k| h[k] = {} }
entries.each do |entry|
  ext = File.extname(entry)
  stem = File.basename(entry, ext)
  case ext.downcase
  when ".md"
    by_stem[stem][:md] = entry
  when ".jpg"
    by_stem[stem][:jpg] = entry
  else
    (by_stem[stem][:other] ||= []) << entry
  end
end

errors = []
person_count = 0

by_stem.each do |stem, files|
  files[:other]&.each do |f|
    errors << "#{f}: unexpected file (only .md and .jpg are recognized -- check the extension)"
  end

  has_md = !files[:md].nil?
  has_jpg = !files[:jpg].nil?

  if stem == FALLBACK_STEM
    errors << "#{files[:md]}: '#{FALLBACK_STEM}' is a reserved stem for the fallback image and can't also be a person entry" if has_md
    next
  end

  errors << "#{files[:jpg]}: has a photo but no matching .md" if has_jpg && !has_md
  next unless has_md

  person_count += 1
  content = File.read(File.join(leadership_dir, files[:md]))
  frontmatter_match = content.match(/\A---\s*\n(.*?)\n---\s*(?:\n|\z)/m)
  unless frontmatter_match
    errors << "#{files[:md]}: could not parse frontmatter (missing --- delimiters)"
    next
  end

  begin
    data = YAML.safe_load(frontmatter_match[1]) || {}
  rescue Psych::SyntaxError => e
    errors << "#{files[:md]}: invalid YAML in frontmatter (#{e.message})"
    next
  end

  unless data.is_a?(Hash)
    errors << "#{files[:md]}: frontmatter did not parse as a set of fields (check for a stray leading '-' or bad indentation)"
    next
  end

  REQUIRED_FIELDS.each do |field|
    value = data[field]
    errors << "#{files[:md]}: missing or blank required field '#{field}'" if value.nil? || value.to_s.strip.empty?
  end
end

unless by_stem[FALLBACK_STEM][:jpg]
  errors << "#{FALLBACK_STEM}.jpg is missing -- required as the fallback image for entries with no photo"
end

if errors.any?
  warn "Leadership validation failed:\n\n"
  errors.each { |e| warn "  - #{e}" }
  warn "\n#{errors.size} problem(s) found."
  exit 1
end

entry_word = person_count == 1 ? "entry" : "entries"
puts "Validated #{person_count} leadership #{entry_word} in _leadership/ -- all good."
