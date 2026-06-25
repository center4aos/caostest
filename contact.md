---
layout: default
title: Contact
permalink: /contact/
description: We want to hear from you. Reach out, stay in touch, or get involved with CAOS.
---

## Contact Us

We want to hear from you and welcome your questions, ideas, and contributions. Fill out the form below or reach us directly.

<div data-fs-success role="alert" tabindex="-1" id="contact-success">
<p>Your message has been sent. We look forward to being in touch.</p>
</div>

<div data-fs-error role="alert"></div>

<form id="contact-form" action="https://formspree.io/f/mkolwzlo" method="POST" aria-label="Contact CAOS">

  <div>
    <label for="contact-name">Name <span aria-hidden="true">*</span></label>
    <input type="text" id="contact-name" name="name" required autocomplete="name" data-fs-field>
    <span data-fs-error="name"></span>
  </div>

  <div>
    <label for="contact-email">Email address <span aria-hidden="true">*</span></label>
    <input type="email" id="contact-email" name="email" required autocomplete="email" data-fs-field>
    <span data-fs-error="email"></span>
  </div>

  <div>
    <label for="contact-topic">Topic <span aria-hidden="true">*</span></label>
    <select id="contact-topic" name="topic" required data-fs-field>
      <option value="">— Please select —</option>
      <option value="accessibility-advice">Seeking advice on open-source accessibility</option>
      <option value="partnership">Partnership proposal</option>
      <option value="support">Seeking support</option>
      <option value="media">Media inquiry</option>
      <option value="advisory-board">Advisory Board</option>
      <option value="donation">Donation</option>
    </select>
    <span data-fs-error="topic"></span>
  </div>

  <div>
    <label for="contact-subject">Subject <span aria-hidden="true">*</span></label>
    <input type="text" id="contact-subject" name="subject" required data-fs-field>
    <span data-fs-error="subject"></span>
  </div>

  <div>
    <label for="contact-message">Message <span aria-hidden="true">*</span></label>
    <textarea id="contact-message" name="message" rows="6" required
      aria-describedby="message-hint" data-fs-field></textarea>
    <p id="message-hint" class="field-hint">Please do not include links in your message.</p>
    <span data-fs-error="message"></span>
  </div>

  <div>
    <button type="submit" data-fs-submit-btn>Send message</button>
  </div>

</form>

<script>
  window.formspree = window.formspree || function () { (formspree.q = formspree.q || []).push(arguments); };
  formspree('initForm', { formElement: '#contact-form', formId: 'mkolwzlo' });

  document.addEventListener('DOMContentLoaded', function () {
    var success = document.getElementById('contact-success');
    if (!success) return;
    new MutationObserver(function () {
      if (success.offsetParent !== null) success.focus();
    }).observe(success, { attributes: true, attributeFilter: ['style', 'class'] });
  });
</script>
<script src="https://unpkg.com/@formspree/ajax@1" defer></script>

---

### Newsletter

Stay up to date with CAOS news, events, and opportunities by subscribing to CAOS News.

<form action="https://buttondown.com/api/emails/embed-subscribe/caos" method="post" aria-label="Subscribe to CAOS News newsletter">
  <div>
    <label for="contact-bd-email">Email address</label>
    <input type="email" name="email" id="contact-bd-email" required autocomplete="email">
  </div>
  <div>
    <button type="submit">Subscribe to CAOS News</button>
  </div>
</form>

---

### Mailing Address

<!-- TODO: Add physical address -->
*Address coming soon.*
