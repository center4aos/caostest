---
layout: default
title: Calendar
permalink: /calendar/
description: Upcoming CAOS events, board meetings, and community gatherings.
---

## Calendar

{% assign now = site.time %}
{% assign upcoming = site.events | where_exp: "event", "event.date >= now" | sort: "date" %}
{% assign past = site.events | where_exp: "event", "event.date < now" | sort: "date" | reverse %}

{% if upcoming.size > 0 %}
### Upcoming Events

<ul class="event-list">
  {% for event in upcoming %}
  <li class="event-list-item">
    <time datetime="{{ event.date | date_to_xmlschema }}">{{ event.date | date: "%B %-d, %Y" }}</time>
    {% if event.time %} at {{ event.time }}{% endif %}
    — <a href="{{ event.url | relative_url }}">{{ event.title | escape }}</a>
  </li>
  {% endfor %}
</ul>
{% else %}
<p>No upcoming events at this time. Check back soon.</p>
{% endif %}

{% if past.size > 0 %}
### Past Events

<ul class="event-list event-list--past">
  {% for event in past %}
  <li class="event-list-item">
    <time datetime="{{ event.date | date_to_xmlschema }}">{{ event.date | date: "%B %-d, %Y" }}</time>
    — <a href="{{ event.url | relative_url }}">{{ event.title | escape }}</a>
  </li>
  {% endfor %}
</ul>
{% endif %}
