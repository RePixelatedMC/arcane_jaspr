// JavaScript utilities for the documentation site
// Extracted from arcane_docs_layout.dart for better maintainability

/// SVG icons used in the documentation site
class DocsIcons {
  /// Sun icon for light mode
  static const String sun = '''
<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg>''';

  /// Moon icon for dark mode
  static const String moon = '''
<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg>''';

  /// Copy icon for code blocks
  static const String copy = '''
<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>''';

  /// Checkmark icon for copied state
  static const String check = '''
<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>''';
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
});
''';
  }

  static String _themeUtilities() => '''
// ===== THEME UTILITIES =====
// Stylesheet-agnostic theming - works with any ArcaneStyleSheet
function getCurrentMode() {
  return localStorage.getItem('arcane-theme-mode') || '${DocsScriptConfig.defaultThemeMode}';
}
function getCurrentVariant() {
  // Get from localStorage, fallback to window.arcaneThemeVariant (set by server)
  return localStorage.getItem('arcane-theme-variant') || window.arcaneThemeVariant || 'shadcn-neutral';
}
function updateClasses() {
  var mode = getCurrentMode();
  var variant = getCurrentVariant();
  var root = document.getElementById('arcane-root');
  if (root) {
    // CSS class format: arcane-{variant-id} arcane-{mode}
    root.className = 'arcane-' + variant + ' ' + (mode === 'dark' ? 'arcane-dark' : 'arcane-light');
  }
}
function setMode(mode) {
  localStorage.setItem('arcane-theme-mode', mode);
  updateClasses();
  updateModeToggleIcon(mode);
}
function setVariant(variantId) {
  localStorage.setItem('arcane-theme-variant', variantId);
  updateClasses();
}
function updateModeToggleIcon(mode) {
  var themeToggle = document.getElementById('theme-toggle');
  if (!themeToggle) return;
  var iconContainer = themeToggle.querySelector('.theme-icon');
  if (iconContainer) {
    // Lucide-style SVGs matching ArcaneIcon.sun/moon (16px for IconSize.sm)
    var sunIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="4"></circle><path d="M12 2v2"></path><path d="M12 20v2"></path><path d="m4.93 4.93 1.41 1.41"></path><path d="m17.66 17.66 1.41 1.41"></path><path d="M2 12h2"></path><path d="M20 12h2"></path><path d="m6.34 17.66-1.41 1.41"></path><path d="m19.07 4.93-1.41 1.41"></path></svg>';
    var moonIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"></path></svg>';
    iconContainer.innerHTML = mode === 'dark' ? sunIcon : moonIcon;
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
// SVGs use currentColor to inherit from CSS
var copyIconSvg = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>';
var checkIconSvg = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg>';

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

  static String _variantSelectorHandler() => '''
// ===== VARIANT SELECTOR (stylesheet-agnostic) =====
var variantSelect = document.getElementById('variant-select');
if (variantSelect) {
  // Set initial value from localStorage
  var savedVariant = getCurrentVariant();
  variantSelect.value = savedVariant;

  // Handle change events
  variantSelect.addEventListener('change', function(e) {
    var variantId = e.target.value;
    setVariant(variantId);
  });
}
''';
}
