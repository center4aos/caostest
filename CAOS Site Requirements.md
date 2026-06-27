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

### Contact

- ✅ Page structure and framing text
- ✅ Contact form fields: name, email, subject, topic dropdown, message body
  - Topics: Seeking advice, Partnership proposal, Seeking support, Media inquiry, Advisory Board, Donation
- 🔲 Contact form backend (Formspree or groups.io POST URL)
- 🔲 Newsletter signup embed on contact page (Buttondown)
- 🔲 Snail mail address

### Support CAOS

- ✅ Mission-framed donation intro
- ✅ PayPal, Venmo, Zelle, Benevity, planned giving language, check instructions
- ✅ giving@caos.org contact
- 🔲 Mailing address
- 🔲 EIN

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

## Resources Used in Implementation

- Blog setup reference: https://trstringer.com/blog-hosting-details/
- Accessible Jekyll reference: https://jekyllhub.com/tutorial/2026/05/29/jekyll-accessibility-wcag/
