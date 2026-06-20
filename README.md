# CAOS Website

Jekyll site for the **Center for Accessibility and Open Source** (CAOS).

**Live site:** http://caos.org/caostest/  
**Organization:** https://github.com/center4aos

---

## About CAOS

CAOS is a California 501(c)(3) nonprofit — the first organization to make the accessibility of open-source resources its primary mission. We support disability inclusion in open-source communities and the development of open-source assistive technologies worldwide.

---

## Site Structure

| Path | Purpose |
|---|---|
| `_posts/` | Blog posts |
| `_events/` | Calendar events |
| `_layouts/` | Page templates (default, page, event) |
| `_includes/` | Header, footer, breadcrumbs |
| `assets/css/accessibility.scss` | Accessibility-focused style overrides |
| `index.md` | Home page |
| `about.md` | About CAOS, mission, board |
| `projects.md` | Active partnerships |
| `resources.md` | Curated accessibility resources |
| `governance.md` | Bylaws links, board meeting info |
| `bylaws.md` | Full corporate bylaws |
| `conflict-of-interest.md` | Conflict of interest policy |
| `support.md` | Donation information |
| `contact.md` | Contact form |
| `calendar.md` | Upcoming events |
| `blog.md` | Blog index |
| `accessibility-statement.md` | Public accessibility commitment |

---

## Adding a Blog Post

Create a file in `_posts/` named `YYYY-MM-DD-your-title.md`:

```yaml
---
layout: post
title: "Your Post Title"
date: 2026-06-20
author: Your Name
---

Post content in Markdown.
```

## Adding a Calendar Event

Create a file in `_events/` named `YYYY-MM-DD-event-title.md`:

```yaml
---
layout: event
title: "Event Title"
date: 2026-07-15
time: "7:00 PM Pacific Time"
location: "Zoom (optional)"
parent: Calendar
parent_url: /calendar/
---

Event description in Markdown.
```

Events are sorted chronologically. Past events are not displayed on the calendar page. The calendar rebuilds on every push, so past events drop off automatically.

---

## Technical Notes

- **Theme:** `minima` (native gem) with `skin: auto` for system light/dark preference
- **Breadcrumbs:** Child pages (bylaws, COI, events) use `parent` and `parent_url` front matter
- **External links:** Automatically open in a new tab with a screen-reader-friendly `aria-label`
- **Forms:** Contact form backend not yet configured — see `contact.md` for TODO
- **GitHub Pages:** Legacy build from root of `main` branch
