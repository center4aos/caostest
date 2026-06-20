---
layout: default
title: Home
permalink: /
description: The Center for Accessibility and Open Source — where the values of the open-source and disability rights movements come together.
---

## Open source must be open to everyone.

People with disabilities have a right to equal access to digital tools and the opportunities they unlock. CAOS is the first organization to make the accessibility of open-source resources its primary mission — supporting disability inclusion in open-source communities and the development of open-source assistive technologies worldwide.

> "We need to build a future in which the educational and economic opportunities promised by open source are also open to people with disabilities."
> — Dr. Joshua A. Miele, CAOS Founder

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
<p>Blog posts coming soon. <a href="{{ "/caostest/about/" | relative_url }}">Learn more about CAOS.</a></p>
{% endif %}

---

### Upcoming Events

<!-- PLACEHOLDER: Calendar embed or events list goes here -->
<p>Check back soon for our schedule of events and board meetings. In the meantime, <a href="/caostest/contact/">get in touch</a>.</p>

---

### Stay Connected

Subscribe to the CAOS newsletter to receive updates on our work, events, and opportunities to get involved.

<!-- TODO: Wire up newsletter signup (groups.io or other list service) -->
<p><a href="/caostest/contact/">Sign up via our contact page →</a></p>
