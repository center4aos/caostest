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

{% assign upcoming = site.events | where_exp: "event", "event.date >= site.time" | sort: "date" %}
{% if upcoming.size > 0 %}
<ul>
  {% for event in upcoming limit:3 %}
  <li>
    <a href="{{ event.url | relative_url }}">{{ event.title | escape }}</a>
    — <time datetime="{{ event.date | date_to_xmlschema }}">{{ event.date | date: "%B %-d, %Y" }}</time>
    {% if event.time %} at {{ event.time }}{% endif %}
  </li>
  {% endfor %}
</ul>
<p><a href="{{ "/calendar/" | relative_url }}">Full calendar →</a></p>
{% else %}
<p>No upcoming events at this time. <a href="{{ "/calendar/" | relative_url }}">Check the calendar.</a></p>
{% endif %}

---

### Stay Connected

Subscribe to the CAOS newsletter to receive updates on our work, events, and opportunities to get involved.

<!-- TODO: Wire up newsletter signup (groups.io or other list service) -->
<p><a href="/caostest/contact/">Sign up via our contact page →</a></p>
