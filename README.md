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
| `_layouts/default.html` | Base page template (skip link, nav, breadcrumbs, footer, focus management, external link handling) |
| `_layouts/event.html` | Event detail page template |
| `_includes/header.html` | Skip-to-main link, site title, nav with aria-current |
| `_includes/footer.html` | Social links, accessibility statement, license, donate |
| `_includes/breadcrumbs.html` | Auto breadcrumbs using `parent` / `parent_url` front matter |
| `assets/css/accessibility.scss` | Accessibility-focused style overrides |
| `index.md` | Home page: mission, blog preview, upcoming events, newsletter signup |
| `about.md` | About CAOS, mission, board bios |
| `projects.md` | Active partnerships (CREATE, Teach Access, NV Access) |
| `resources.md` | Curated accessibility resources (content placeholder) |
| `governance.md` | Policy Library link, board meeting info |
| `support.md` | Donation information |
| `contact.md` | Contact form and newsletter signup |
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

## Internal Links

All internal links must use Jekyll's `relative_url` filter so they remain correct when the site moves from `/caostest/` to the domain root:

```liquid
[Link text]({{ "/path/to/page/" | relative_url }})
```

Never hardcode `/caostest/...` paths or bare root-relative `/path/` links — both break on migration.

---

## Technical Notes

- **Theme:** `minima` (native gem) with `skin: auto` for system light/dark preference
- **Breadcrumbs:** Child pages (bylaws, COI, events) use `parent` and `parent_url` front matter
- **Screen reader focus:** On page load, focus moves programmatically to the first H2 in `.post-content`, falling back to `#main-content`, for consistent NVDA/JAWS experience
- **External links:** Automatically open in a new tab with a screen-reader-friendly `aria-label`
- **Forms:** Contact form backend not yet configured — see `contact.md` for TODO
- **GitHub Pages:** Legacy build from root of `main` branch; `baseurl: /caostest`

---

## Outstanding TODOs

- Wire up contact form backend (Formspree or groups.io POST URL)
- Wire up newsletter signup on contact page (Buttondown embed)
- Add real content to resources page
- Add full board member bios and photos to about page
- Add advisory board member list to about page
- Add mailing address and EIN to support page
- Add Form 990 link to governance page
- Add board meeting schedule to governance page
- ~~Enable HTTPS enforcement on GitHub Pages settings~~ ✅ done
- ~~Delete legacy `docs/` folder from repo~~ ✅ done
