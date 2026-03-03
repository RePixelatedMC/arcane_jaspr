library;

class TocScripts {
  TocScripts._();

  static String get code => r'''
function bindDocsToc() {
  var tocContainer = document.querySelector('.toc-content');
  if (!tocContainer) return;

  var tocLinks = Array.prototype.slice.call(tocContainer.querySelectorAll('a'));

  function normalizeHeadingLabel(raw) {
    if (!raw) return '';
    var label = raw.trim();
    label = label.replace(/^#\s*/, '');
    label = label.replace(/\s*#$/, '');
    label = label.replace(/\s+/g, ' ').trim();
    return label;
  }

  function sanitizeExistingLabels() {
    tocLinks.forEach(function(link) {
      var text = link.textContent || '';
      var normalized = normalizeHeadingLabel(text);
      if (normalized) {
        link.textContent = normalized;
      }
    });
  }

  function getHeadingId(link) {
    var href = link.getAttribute('href');
    if (!href) return '';
    var hashIndex = href.indexOf('#');
    if (hashIndex === -1) return '';
    var rawId = href.slice(hashIndex + 1);
    try {
      return decodeURIComponent(rawId);
    } catch (e) {
      return rawId;
    }
  }

  sanitizeExistingLabels();

  if (!tocLinks.length) {
    var headingNodes = Array.prototype.slice.call(
      document.querySelectorAll(
        '.prose h1[id], .prose h2[id], .prose h3[id]'
      )
    );
    if (!headingNodes.length) return;

    var list = tocContainer.querySelector('ul');
    if (!list) {
      list = document.createElement('ul');
      tocContainer.innerHTML = '';
      tocContainer.appendChild(list);
    } else {
      list.innerHTML = '';
    }

    headingNodes.forEach(function(heading) {
      var id = heading.id;
      if (!id) return;
      if (heading.closest('.arcane-demo-docs')) return;
      var headingClass = heading.className || '';
      if (headingClass.indexOf('no_toc') !== -1) return;

      var label = heading.textContent ? normalizeHeadingLabel(heading.textContent) : id;
      if (!label) return;

      var item = document.createElement('li');
      var link = document.createElement('a');
      link.setAttribute('href', window.location.pathname + '#' + id);
      link.textContent = label;
      item.appendChild(link);
      list.appendChild(item);
    });

    tocLinks = Array.prototype.slice.call(tocContainer.querySelectorAll('a'));
    if (!tocLinks.length) return;
  }

  sanitizeExistingLabels();

  var headings = tocLinks.map(function(link) {
    var id = getHeadingId(link);
    if (!id) return null;
    var heading = document.getElementById(id);
    if (!heading) return null;
    return { id: id, element: heading };
  }).filter(function(entry) {
    return entry !== null;
  });

  if (!headings.length) return;

  var currentActive = '';

  function updateActiveLink(activeId) {
    if (!activeId || currentActive === activeId) return;
    currentActive = activeId;

    tocLinks.forEach(function(link) {
      var id = getHeadingId(link);
      link.classList.toggle('toc-active', id === activeId);
    });
  }

  function updateFromScroll() {
    var scrollOffset = 140;
    var activeId = headings[0].id;

    headings.forEach(function(entry) {
      if (entry.element.getBoundingClientRect().top <= scrollOffset) {
        activeId = entry.id;
      }
    });

    updateActiveLink(activeId);
  }

  tocLinks.forEach(function(link) {
    link.addEventListener('click', function() {
      var id = getHeadingId(link);
      if (id) updateActiveLink(id);
    });
  });

  window.addEventListener('scroll', updateFromScroll, { passive: true });
  window.addEventListener('resize', updateFromScroll);
  updateFromScroll();
}
''';
}
