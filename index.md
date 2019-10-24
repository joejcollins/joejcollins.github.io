---
permalink: /index.html
layout: default
---
<div class="posts">
  {% for post in site.posts %}
    <article class="post">
      <h3><a href="{{ site.baseurl }}{{ post.url }}">{{ post.date | date: '%b %y' }} - {{ post.title }}</a></h3>
    </article>
  {% endfor %}
</div>