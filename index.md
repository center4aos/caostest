---
layout: default
title: Home
permalink: /
description: The Center for Accessibility and Open Source — making open source accessible to everyone.
---

## Open source, accessible to all.

CAOS is a nonprofit organization led by people with disabilities, working to make the open-source world more accessible and inclusive. We connect communities, support projects, and advocate for accessibility as a first-class value in open source.

---

### Latest from the CAOS Blog

{% if site.posts.size > 0 %}
<ul>
  {% for post in site.posts limit:3 %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span> — <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time></span>
    </li>
  {% endfor %}
</ul>
<p><a href="{{ "/blog" | relative_url }}">All posts →</a></p>
{% else %}
<p>Blog posts coming soon. <a href="{{ "/about" | relative_url }}">Learn more about CAOS.</a></p>
{% endif %}

---

### Upcoming Events

<!-- PLACEHOLDER: Calendar embed or events list goes here -->
<p>Check back soon for our schedule of events and board meetings. In the meantime, <a href="{{ "/contact" | relative_url }}">get in touch</a>.</p>

---

### Stay Connected

Subscribe to the CAOS newsletter to receive updates on our work, events, and opportunities to get involved.

<!-- TODO: Wire up newsletter signup (groups.io or other list service) -->
<p><a href="{{ "/contact" | relative_url }}">Sign up via our contact page →</a></p>
