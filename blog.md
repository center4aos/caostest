---
layout: default
title: Blog
permalink: /blog/
description: News, updates, and perspectives from the Center for Accessibility and Open Source.
---

## CAOS Blog

{% if site.posts.size > 0 %}
<ul class="post-list">
  {% for post in site.posts %}
    <li>
      <h3>
        <a href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>
      </h3>
      <time datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date: "%B %-d, %Y" }}</time>
      {% if post.author %} · {{ post.author }}{% endif %}
      {% if post.excerpt %}
        <p>{{ post.excerpt | strip_html | truncatewords: 40 }}</p>
      {% endif %}
    </li>
  {% endfor %}
</ul>
{% else %}
<p>No posts yet — check back soon.</p>
{% endif %}
