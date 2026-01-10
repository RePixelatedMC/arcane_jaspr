// JavaScript utilities for the documentation site
// Extracted from arcane_docs_layout.dart for better maintainability

/// SVG icons used in JavaScript (for dynamic DOM manipulation)
/// Note: Theme icons use ArcaneIcon components rendered server-side
class DocsIcons {
  /// Copy icon for code blocks (Lucide copy icon)
  static const String copy = '''
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"></rect><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"></path></svg>''';

  /// Check icon for copied state (Lucide check icon)
  static const String check = '''
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6 9 17l-5-5"></path></svg>''';
}

/// Configuration constants for scripts
class DocsScriptConfig {
  /// Maximum search results to display
  static const int maxSearchResults = 10;

  /// Minimum query length to trigger search
  static const int minSearchQueryLength = 2;

  /// Copy feedback timeout in milliseconds
  static const int copyFeedbackTimeout = 2000;

  /// Default theme mode
  static const String defaultThemeMode = 'dark';
}

/// Generates the client-side JavaScript for the documentation site
class DocsScripts {
  /// Generate the complete documentation scripts
  static String generate({String basePath = '/arcane_jaspr'}) {
    return '''
document.addEventListener('DOMContentLoaded', function() {
  ${_themeUtilities()}
  ${_themeToggleHandler()}
  ${_variantSelectorHandler()}
  ${_searchFunctionality(basePath)}
  ${_codeBlockCopyButtons()}
  ${_syntaxHighlighting()}
  ${_interactiveComponents()}
  ${_tocScrollTracking()}
});
''';
  }

  static String _themeUtilities() => '''
// ===== THEME UTILITIES =====
// Dark mode uses .dark class on root element
function getCurrentMode() {
  return localStorage.getItem('arcane-theme-mode') || '${DocsScriptConfig.defaultThemeMode}';
}
function updateClasses() {
  var mode = getCurrentMode();
  var root = document.getElementById('arcane-root');
  if (root) {
    root.className = mode === 'dark' ? 'dark' : '';
  }
}
function setMode(mode) {
  localStorage.setItem('arcane-theme-mode', mode);
  updateClasses();
  updateModeToggleIcon(mode);
}
function updateModeToggleIcon(mode) {
  var themeToggle = document.getElementById('theme-toggle');
  if (!themeToggle) return;
  // Toggle visibility of sun/moon icons (rendered by ArcaneIcon)
  var sunIcon = themeToggle.querySelector('.theme-icon-sun');
  var moonIcon = themeToggle.querySelector('.theme-icon-moon');
  if (sunIcon && moonIcon) {
    sunIcon.style.display = mode === 'dark' ? 'flex' : 'none';
    moonIcon.style.display = mode === 'dark' ? 'none' : 'flex';
  }
}
// Initialize on load
updateClasses();
updateModeToggleIcon(getCurrentMode());
''';

  static String _themeToggleHandler() => '''
// ===== THEME MODE TOGGLE (sun/moon button) =====
var themeToggle = document.getElementById('theme-toggle');
if (themeToggle) {
  themeToggle.addEventListener('click', function() {
    var currentMode = getCurrentMode();
    var newMode = currentMode === 'dark' ? 'light' : 'dark';
    setMode(newMode);
  });
}
''';

  static String _searchFunctionality(String basePath) => '''
// ===== SEARCH FUNCTIONALITY =====
var searchInput = document.getElementById('docs-search');
var searchResults = document.getElementById('search-results');
var searchIndex = [];

// Build search index from sidebar navigation
document.querySelectorAll('nav a').forEach(function(link) {
  var text = link.textContent.trim();
  var href = link.getAttribute('href');
  if (text && href && href.includes('/docs')) {
    var parts = href.split('/');
    var category = parts.length > 2 ? parts[2] : 'docs';
    category = category.charAt(0).toUpperCase() + category.slice(1).replace(/-/g, ' ');
    searchIndex.push({
      title: text,
      href: href,
      category: category,
      searchText: text.toLowerCase()
    });
  }
});

function filterSearchResults(query) {
  return searchIndex.filter(function(item) {
    return item.searchText.includes(query);
  }).slice(0, ${DocsScriptConfig.maxSearchResults});
}

function showResults(results) {
  if (!searchResults) return;
  if (results.length === 0) {
    searchResults.innerHTML = '<div style="padding: 12px; color: var(--arcane-on-surface-variant); text-align: center;">No results found</div>';
    searchResults.style.display = 'block';
    return;
  }
  var html = results.map(function(item) {
    return '<a href="' + item.href + '" style="display: block; padding: 10px 12px; text-decoration: none; border-bottom: 1px solid var(--arcane-outline-variant); transition: background 0.15s;">' +
      '<div style="font-weight: 500; color: var(--arcane-on-surface);">' + item.title + '</div>' +
      '<div style="font-size: 12px; color: var(--arcane-on-surface-variant);">' + item.category + '</div>' +
    '</a>';
  }).join('');
  searchResults.innerHTML = html;
  searchResults.style.display = 'block';
  // Add hover effects
  searchResults.querySelectorAll('a').forEach(function(link) {
    link.addEventListener('mouseenter', function() { this.style.background = 'var(--arcane-surface-variant)'; });
    link.addEventListener('mouseleave', function() { this.style.background = 'transparent'; });
  });
}

function hideResults() {
  if (searchResults) searchResults.style.display = 'none';
}

if (searchInput) {
  searchInput.addEventListener('input', function() {
    var query = this.value.toLowerCase().trim();
    if (query.length < ${DocsScriptConfig.minSearchQueryLength}) { hideResults(); return; }
    showResults(filterSearchResults(query));
  });
  searchInput.addEventListener('focus', function() {
    if (this.value.length >= ${DocsScriptConfig.minSearchQueryLength}) {
      showResults(filterSearchResults(this.value.toLowerCase().trim()));
    }
  });
  document.addEventListener('click', function(e) {
    if (searchResults && !searchInput.contains(e.target) && !searchResults.contains(e.target)) hideResults();
  });
  searchInput.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') { hideResults(); this.blur(); }
  });

  // Keyboard shortcut: Cmd+K or Ctrl+K to focus search
  document.addEventListener('keydown', function(e) {
    if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
      e.preventDefault();
      searchInput.focus();
      searchInput.select();
    }
  });
}
''';

  static String _codeBlockCopyButtons() => '''
// ===== CODE BLOCK COPY BUTTONS =====
// Lucide icons matching ArcaneIcon.copy() and ArcaneIcon.check()
var copyIconSvg = '${DocsIcons.copy}';
var checkIconSvg = '${DocsIcons.check}';

var proseBlocks = document.querySelectorAll('.prose pre');
proseBlocks.forEach(function(pre, index) {
  // Skip if already wrapped or inside a component demo
  if (pre.parentNode.classList.contains('code-block-wrapper')) {
    return;
  }
  if (pre.closest('.arcane-code-block')) {
    return;
  }

  var wrapper = document.createElement('div');
  wrapper.className = 'code-block-wrapper';
  pre.parentNode.insertBefore(wrapper, pre);
  wrapper.appendChild(pre);
  pre.style.paddingRight = '50px';

  var copyBtn = document.createElement('button');
  copyBtn.className = 'copy-code-btn';
  copyBtn.setAttribute('data-no-tooltip', 'true');
  copyBtn.setAttribute('type', 'button');
  copyBtn.innerHTML = copyIconSvg;
  wrapper.appendChild(copyBtn);

  copyBtn.onclick = function(e) {
    e.preventDefault();
    e.stopPropagation();
    var btn = this;
    var codeEl = pre.querySelector('code') || pre;
    var text = codeEl.textContent || '';

    navigator.clipboard.writeText(text).then(function() {
      btn.innerHTML = checkIconSvg;
      btn.classList.add('copied');
      setTimeout(function() {
        btn.innerHTML = copyIconSvg;
        btn.classList.remove('copied');
      }, ${DocsScriptConfig.copyFeedbackTimeout});
    }).catch(function(err) {
      console.error('[Arcane] Copy failed:', err);
      // Fallback: try execCommand
      var textarea = document.createElement('textarea');
      textarea.value = text;
      textarea.style.position = 'fixed';
      textarea.style.opacity = '0';
      document.body.appendChild(textarea);
      textarea.select();
      try {
        document.execCommand('copy');
        btn.innerHTML = checkIconSvg;
        btn.classList.add('copied');
        setTimeout(function() {
          btn.innerHTML = copyIconSvg;
          btn.classList.remove('copied');
        }, ${DocsScriptConfig.copyFeedbackTimeout});
      } catch(e) {
        console.error('[Arcane] Fallback copy failed:', e);
      }
      document.body.removeChild(textarea);
    });
  };
});
''';

  static String _syntaxHighlighting() => '''
// ===== SYNTAX HIGHLIGHTING =====
if (typeof hljs !== 'undefined') {
  // Configure highlight.js
  hljs.configure({
    ignoreUnescapedHTML: true,
    languages: ['dart', 'javascript', 'yaml', 'bash', 'json', 'html', 'css']
  });

  // Add language classes to code blocks that don't have them
  document.querySelectorAll('pre code').forEach(function(block) {
    // If no language class, assume Dart
    if (!block.className || !block.className.includes('language-')) {
      block.classList.add('language-dart');
    }
  });

  // Also handle .arcane-code-block which uses plain code elements
  document.querySelectorAll('.arcane-code-block').forEach(function(block) {
    var codeEl = document.createElement('code');
    codeEl.className = 'language-dart';
    codeEl.textContent = block.textContent;
    block.textContent = '';
    block.appendChild(codeEl);
  });

  // Run highlighting
  hljs.highlightAll();
}
''';

  // Interactive component scripts are now handled by ArcaneApp's built-in
  // fallback scripts. The scripts are automatically injected when
  // Jaspr client hydration is unavailable.
  static String _interactiveComponents() => '''
// Component interactivity is now handled by ArcaneApp's built-in scripts.
// See: lib/util/interactivity/arcane_scripts.dart
''';

  // Variant selector removed - using single stylesheet system
  static String _variantSelectorHandler() => '';

  static String _tocScrollTracking() => '''
// ===== TOC SCROLL TRACKING =====
// Highlights the current section in the "On this page" TOC based on scroll position
var tocContainer = document.querySelector('.toc-content');
if (tocContainer) {
  var tocLinks = tocContainer.querySelectorAll('a');
  var headings = [];

  // Build array of headings that match TOC links
  tocLinks.forEach(function(link) {
    var href = link.getAttribute('href');
    if (href && href.startsWith('#')) {
      var id = href.slice(1);
      var heading = document.getElementById(id);
      if (heading) {
        headings.push({ id: id, element: heading, link: link });
      }
    }
  });

  if (headings.length > 0) {
    // Track active heading
    var currentActive = null;

    function updateActiveLink(activeId) {
      if (currentActive === activeId) return;
      currentActive = activeId;

      tocLinks.forEach(function(link) {
        var href = link.getAttribute('href');
        var isActive = href === '#' + activeId;
        link.classList.toggle('toc-active', isActive);
      });
    }

    // Use Intersection Observer for efficient scroll tracking
    var observerOptions = {
      root: null,
      rootMargin: '-80px 0px -70% 0px',
      threshold: 0
    };

    var observer = new IntersectionObserver(function(entries) {
      entries.forEach(function(entry) {
        if (entry.isIntersecting) {
          updateActiveLink(entry.target.id);
        }
      });
    }, observerOptions);

    headings.forEach(function(h) {
      observer.observe(h.element);
    });

    // Also handle scroll to top - activate first heading
    window.addEventListener('scroll', function() {
      if (window.scrollY < 100 && headings.length > 0) {
        updateActiveLink(headings[0].id);
      }
    });

    // Initialize - activate first heading if at top
    if (window.scrollY < 100 && headings.length > 0) {
      updateActiveLink(headings[0].id);
    }
  }
}
''';
}
