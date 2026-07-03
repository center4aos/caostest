# CAOS Site Requirements

*Last updated: June 2026. Items marked ✅ are complete; items marked 🔲 are still pending.*

## Core Requirements

- ✅ Use Jekyll with GitHub Pages
- ✅ Excellent accessibility: visual contrast, font simplicity and size; screen reader structural markup with headings and landmarks; keyboard navigation; programmatic focus management on page load. Usability is more important than compliance.
- ✅ Simple, professional, authoritative visual design
- ✅ Management and maintenance uses GitHub and open-source mechanisms; site management and form responses should be easy and low attention.

## Site Map

### Primary Pages

- ✅ CAOS Home
- ✅ About CAOS
- ✅ Projects of Interest
- ✅ Resources
- ✅ Governance
- ✅ Support CAOS
- ✅ Contact
- ✅ Blog
- ✅ Calendar
- ✅ Accessibility Statement
- ✅ Bylaws (child of Governance)
- ✅ Conflict of Interest Policy (child of Governance)

### General Wire Frame — applies to all pages

- ✅ Page title — Center for Accessibility and Open Source — [current page]
- ✅ Navigation bar — tab-style major page links with current page indicated visually and to screen readers (`aria-current`)
- ✅ Skip to main content link
- ✅ Breadcrumbs for child pages
- ✅ H1 page title rendered by layout; H2 as first content heading
- ✅ Screen reader focus initializes on first H2 on page load
- ✅ Footer: social media links, donate, accessibility statement, license
- 🔲 Footer: "Submit an Issue" link (see Technical Implementation Notes)

---

## Page Structures

### Home

- ✅ H2 succinct mission statement
- ✅ 2-sentence description of CAOS
- ✅ CAOS Blog preview (3 most recent posts, link to full blog)
- ✅ CAOS Calendar preview (upcoming events, link to full calendar)
- ✅ Newsletter subscribe form (Buttondown)

### About CAOS

- ✅ Brief statement: open-source organization led by people with disabilities to promote open-source accessibility
- ✅ Mission statement
- ✅ Short paragraph on CAOS origin
- ✅ Board member bios with headings
- 🔲 Board member photos
- 🔲 Advisory board description and member list

### Resources

- ✅ Page structure, headings, and framing text in place
- 🔲 Actual resource listings with one-sentence descriptions (accessibility standards, open-source tools, disability/tech communities, learning/training)

### Governance

- ✅ 501(c)(3) statement
- ✅ Transparency statement
- ✅ Bylaws link
- ✅ Conflict of Interest Policy link
- 🔲 Form 990 link
- 🔲 Board meeting schedule
- 🔲 Full governance policy library served from governance repository via git submodule (see Technical Implementation Notes)

### Contact

- ✅ Page structure and framing text
- ✅ Contact form fields: name, email, subject, topic dropdown, message body
  - Topics: Seeking advice, Partnership proposal, Seeking support, Media inquiry, Advisory Board, Donation
- ✅ Contact form backend configured
- ✅ Newsletter signup embed on contact page
- 🔲 Newsletter signup backend (Buttondown)
- ✅ Snail mail address

### Support CAOS

- ✅ Mission-framed donation intro
- ✅ PayPal, Venmo, Zelle, Benevity, planned giving language, check instructions
- ✅ giving@caos.org contact
- ✅ Mailing address
- ✅ EIN (39-2978169)

### Projects of Interest

- ✅ Framing text about partnership priorities and strategic plan
- ✅ CREATE (UW)
- ✅ Teach Access
- ✅ NV Access / NVDA
- 🔲 Additional partners as relationships develop

---

## Technical Implementation Notes

- **Internal links:** Always use `{{ "/path/" | relative_url }}` — never hardcode `/caostest/` or bare root-relative paths, so links survive migration to domain root.
- **Blog:** `_posts/YYYY-MM-DD-title.md` with `layout: post`
- **Events:** `_events/YYYY-MM-DD-title.md` with `layout: event`; past events drop off calendar automatically on each build
- **Forms:** backend not yet wired up
- **GitHub Pages:** Legacy build, `baseurl: /caostest`; migration to domain root requires changing `baseurl: ""` in `_config.yml`

---

## Governance Repository Integration

### Architecture

The CAOS governance repository (`center4aos/governance` on GitHub) is a standalone Git repository containing all organizational policies, decision records, meeting notes, and related documents. Rather than duplicating this content in the main website repo or maintaining a separate Jekyll site, the governance repo is included in the main website repo as a **git submodule** mounted at `/governance/`.

Jekyll renders governance markdown files as full site pages using the same layouts, nav bar, header, and footer as the rest of the site. No separate theme or site structure is needed for governance pages.

### Setup steps

1. Add the governance repo as a submodule in the main website repo:
   ```
   git submodule add https://github.com/center4aos/governance governance
   ```
2. Add a `defaults:` block to `_config.yml` to apply Jekyll frontmatter to all files in the `governance/` directory without modifying the source files:
   ```yaml
   defaults:
     - scope:
         path: "governance"
       values:
         layout: page
         github_repo: center4aos/governance
         issue_template: policy-issue.md
   ```
3. Ensure the governance submodule is updated on each site build (GitHub Actions workflow or manual `git submodule update --remote` before push).
4. Add a governance index page at `governance/index.md` (or `governance/index.html`) listing all policy documents with links.

### Submodule update workflow

When governance documents are updated in the governance repo, the main website repo must be updated to point to the new commit:

```
git submodule update --remote governance
git add governance
git commit -m "Update governance submodule"
git push
```

This can be automated with a GitHub Actions workflow triggered by pushes to the governance repo's `main` branch.

### Open questions — governance repo integration

- **Automation:** Should submodule updates be automated via GitHub Actions, or handled manually before each site build? Automated is lower-friction but requires a workflow to be set up and a deploy key or PAT with write access to the main repo.
- **Governance index page:** What should the governance landing page look like? A simple list of policy documents? Grouped by category? With one-line descriptions? This page lives in the main website repo, not the governance repo.
- **Frontmatter in governance files:** The `_config.yml` defaults approach avoids adding Jekyll frontmatter to governance markdown files, keeping them clean for non-web use. Verify this approach works as expected with the current Jekyll version on GitHub Pages before committing to it.
- **Navigation:** Should individual governance/policy pages appear in the site nav, or only be reachable from the Governance landing page and direct links? Current assumption is the latter.
- **Breadcrumbs:** Governance pages should show breadcrumbs like "Home > Governance > Conflict of Interest Policy." Verify the current breadcrumb implementation handles submodule-served pages correctly.

---

## "Submit an Issue" Footer Link

### Purpose

Every page on the CAOS website includes a "Submit an Issue" link in the footer. Clicking the link opens a pre-filled GitHub issue in the correct repository, referencing the specific page the visitor was on. This provides a low-friction, accessible mechanism for any visitor to report a problem, ask a question, or propose a change — without needing to navigate GitHub independently.

### Behavior by page type

| Page type | Issue opens in | Template used | Pre-filled reference |
|---|---|---|---|
| Main site pages (home, about, blog, etc.) | `center4aos/caostest` (or successor repo) | `general.md` | Page title and URL |
| Governance / policy pages | `center4aos/governance` | `policy-issue.md` | Policy document filename and URL |

### Implementation

The footer include (`_includes/footer.html` or equivalent) constructs the GitHub new-issue URL dynamically using Jekyll Liquid variables:

```liquid
{% assign repo = page.github_repo | default: "center4aos/caostest" %}
{% assign template = page.issue_template | default: "general.md" %}
{% assign issue_title = "Issue: " | append: page.title | url_encode %}
{% assign issue_body = "**Page:** [" | append: page.title | append: "](https://caos.org" | append: page.url | append: ")\n**File:** `" | append: page.path | append: "`\n\n[Describe your issue here]" | url_encode %}

<a href="https://github.com/{{ repo }}/issues/new?template={{ template }}&title={{ issue_title }}&body={{ issue_body }}">
  Submit an Issue
</a>
```

The `github_repo` and `issue_template` values are set per page type via `_config.yml` defaults (see Governance Repository Integration above). Main site pages inherit the defaults; governance pages get the governance repo values automatically.

### Issue template coordination

The pre-filled issue body should align with the field structure of the target template so that the pre-filled content lands in the right section. Specifically:

- For `policy-issue.md`: the pre-filled body should populate the "Which policy does this relate to?" field
- For `general.md`: the pre-filled body should populate the "What's on your mind?" field

Review both templates against the Liquid-generated body format during implementation to confirm alignment.

### Open questions — Submit an Issue footer link

- **Link placement:** Where exactly in the footer does this link appear? Current footer has social links, donate, accessibility statement, and license. Proposed addition should be visually and semantically grouped logically — probably near the accessibility statement.
- **Link label:** "Submit an Issue" is clear for GitHub-familiar users. Is it clear enough for a general audience? Alternatives: "Give feedback," "Report a problem," "Suggest a change." Consider whether the label should vary by page type (e.g., "Suggest a policy change" on governance pages).
- **Post-migration repo name:** The main site is currently `center4aos/caostest`. After migration to the primary domain, the repo name may change. The default `github_repo` value in the footer Liquid will need to be updated at that time.
- **Unauthenticated users:** Clicking the link opens GitHub's new issue form. Users who are not logged into GitHub will be prompted to sign in or create an account before submitting. This is a real friction point for non-GitHub users. The footer link should complement — not replace — the email-based alternative described in CONTRIBUTING.md.
- **Blog and calendar posts:** Individual blog posts and calendar events are generated from `_posts/` and `_events/`. Verify that `page.path` correctly resolves to the source file path (e.g., `_posts/2026-06-30-title.md`) for these page types, so the pre-filled reference is meaningful.

---

## Resources Used in Implementation

- Blog setup reference: https://trstringer.com/blog-hosting-details/
- Accessible Jekyll reference: https://jekyllhub.com/tutorial/2026/05/29/jekyll-accessibility-wcag/
