/// Command palette interactivity scripts.
class CommandPaletteScripts {
  CommandPaletteScripts._();

  static const String code = r'''
  function bindCommandPalettes() {
    console.log('[ArcaneCommand] bindCommandPalettes called');

    // Guard against multiple bindings
    if (window.__arcaneCommandBound) {
      console.log('[ArcaneCommand] Already bound, skipping');
      return;
    }
    window.__arcaneCommandBound = true;
    console.log('[ArcaneCommand] Setting up event delegation...');

    // Track selection state per overlay
    var selectedIndices = new WeakMap();

    // Inject hover/selected CSS styles if not already present
    if (!document.getElementById('arcane-command-styles')) {
      var style = document.createElement('style');
      style.id = 'arcane-command-styles';
      style.textContent = '\
        .arcane-command-item:hover:not(.disabled),\
        .codex-command-item:hover:not(.disabled) {\
          background-color: var(--accent, var(--secondary, rgba(255,255,255,0.1)));\
        }\
        .arcane-command-item.selected:not(.disabled),\
        .codex-command-item.selected:not(.disabled) {\
          background-color: var(--accent, var(--secondary, rgba(255,255,255,0.1)));\
          outline: 2px solid var(--ring, var(--primary, #3b82f6));\
          outline-offset: -2px;\
        }\
        .arcane-command-item.js-hidden,\
        .codex-command-item.js-hidden {\
          display: none !important;\
        }\
      ';
      document.head.appendChild(style);
    }

    // Helper to find the overlay from any target
    function findOverlay(target) {
      return target.closest('.arcane-command-overlay, .codex-command-overlay');
    }

    // Helper to get current visible items in an overlay
    function getVisibleItems(overlay) {
      var allItems = overlay.querySelectorAll('.arcane-command-item:not(.disabled):not(.js-hidden), .codex-command-item:not(.disabled):not(.js-hidden)');
      return Array.from(allItems).filter(function(item) {
        return item.offsetParent !== null;
      });
    }

    // Get/set selected index for an overlay
    function getSelectedIndex(overlay) {
      return selectedIndices.get(overlay) || -1;
    }
    function setSelectedIndex(overlay, index) {
      selectedIndices.set(overlay, index);
    }

    function updateSelection(overlay, items) {
      var selectedIndex = getSelectedIndex(overlay);
      overlay.querySelectorAll('.arcane-command-item, .codex-command-item').forEach(function(item) {
        item.classList.remove('selected');
      });
      if (selectedIndex >= 0 && items[selectedIndex]) {
        items[selectedIndex].classList.add('selected');
        items[selectedIndex].scrollIntoView({ block: 'nearest' });
      }
    }

    // Close overlay helper
    function closeOverlay(overlay) {
      if (!overlay) return;
      overlay.style.display = 'none';
      setSelectedIndex(overlay, -1);
      // Dispatch custom event for Jaspr to handle state update
      overlay.dispatchEvent(new CustomEvent('arcane-command-close', { bubbles: true }));
    }

    // Handle item click - navigate via data-href
    function handleItemClick(item, overlay) {
      var href = item.dataset.href;
      var target = item.dataset.target;
      if (href) {
        if (target === '_blank') {
          window.open(href, '_blank', 'noopener,noreferrer');
        } else {
          window.location.href = href;
        }
        closeOverlay(overlay);
      }
    }

    // Filter items based on search query
    function filterItems(overlay, query) {
      var allItems = overlay.querySelectorAll('.arcane-command-item, .codex-command-item');
      var q = query.toLowerCase().trim();

      allItems.forEach(function(item) {
        if (!q) {
          item.classList.remove('js-hidden');
          return;
        }
        var label = (item.dataset.label || '').toLowerCase();
        var keywords = (item.dataset.keywords || '').toLowerCase();
        var matches = label.includes(q) || keywords.includes(q);
        item.classList.toggle('js-hidden', !matches);
      });
    }

    // Document-level click handler (works for dynamically rendered overlays)
    document.addEventListener('click', function(e) {
      console.log('[ArcaneCommand] Click detected on:', e.target.tagName, e.target.className);
      var overlay = findOverlay(e.target);

      // Handle item clicks
      var item = e.target.closest('.arcane-command-item, .codex-command-item');
      if (item && overlay && !item.classList.contains('disabled')) {
        console.log('[ArcaneCommand] Item click - href:', item.dataset.href);
        e.preventDefault();
        e.stopPropagation();
        handleItemClick(item, overlay);
        return;
      }

      // Handle click-outside to close
      var anyOverlay = document.querySelector('.arcane-command-overlay, .codex-command-overlay');
      console.log('[ArcaneCommand] Found overlay:', !!anyOverlay, anyOverlay ? 'display=' + anyOverlay.style.display : 'N/A');
      if (anyOverlay && anyOverlay.style.display !== 'none') {
        var dialog = anyOverlay.querySelector('.arcane-command-dialog, .codex-command-dialog');
        var closable = anyOverlay.dataset.commandClosable;
        console.log('[ArcaneCommand] Dialog found:', !!dialog, 'closable:', closable);
        if (closable === 'true') {
          if (!dialog || !dialog.contains(e.target)) {
            console.log('[ArcaneCommand] Closing overlay (click outside)');
            closeOverlay(anyOverlay);
          }
        }
      }
    }, true); // Capture phase

    // Document-level mouseover for hover selection
    document.addEventListener('mouseover', function(e) {
      var item = e.target.closest('.arcane-command-item, .codex-command-item');
      if (!item) return;
      var overlay = findOverlay(item);
      if (!overlay) return;
      if (item.classList.contains('disabled') || item.classList.contains('js-hidden')) return;

      var items = getVisibleItems(overlay);
      var idx = items.indexOf(item);
      if (idx >= 0) {
        setSelectedIndex(overlay, idx);
        updateSelection(overlay, items);
      }
    });

    // Document-level keyboard handler (works for dynamically rendered overlays)
    document.addEventListener('keydown', function(e) {
      console.log('[ArcaneCommand] Keydown:', e.key);
      var overlay = document.querySelector('.arcane-command-overlay, .codex-command-overlay');
      console.log('[ArcaneCommand] Keydown overlay found:', !!overlay, overlay ? 'display=' + overlay.style.display : 'N/A');

      if (!overlay || overlay.style.display === 'none') {
        // Only handle Ctrl+K when no overlay is open
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
          console.log('[ArcaneCommand] Ctrl+K pressed, opening command palette');
          e.preventDefault();
          e.stopPropagation();
          var trigger = document.querySelector('[data-command-trigger]');
          if (trigger) {
            trigger.click();
          }
        }
        return;
      }

      var items = getVisibleItems(overlay);
      var selectedIndex = getSelectedIndex(overlay);
      console.log('[ArcaneCommand] Items count:', items.length, 'selectedIndex:', selectedIndex);

      if (e.key === 'ArrowDown') {
        console.log('[ArcaneCommand] ArrowDown');
        e.preventDefault();
        e.stopPropagation();
        if (items.length > 0) {
          selectedIndex = selectedIndex < 0 ? 0 : Math.min(selectedIndex + 1, items.length - 1);
          setSelectedIndex(overlay, selectedIndex);
          updateSelection(overlay, items);
        }
      } else if (e.key === 'ArrowUp') {
        console.log('[ArcaneCommand] ArrowUp');
        e.preventDefault();
        e.stopPropagation();
        if (items.length > 0) {
          selectedIndex = Math.max(selectedIndex - 1, 0);
          setSelectedIndex(overlay, selectedIndex);
          updateSelection(overlay, items);
        }
      } else if (e.key === 'Enter') {
        console.log('[ArcaneCommand] Enter pressed');
        e.preventDefault();
        e.stopPropagation();
        if (selectedIndex >= 0 && items[selectedIndex]) {
          console.log('[ArcaneCommand] Clicking selected item');
          handleItemClick(items[selectedIndex], overlay);
        } else if (items.length > 0) {
          console.log('[ArcaneCommand] Clicking first item');
          handleItemClick(items[0], overlay);
        }
      } else if (e.key === 'Escape') {
        console.log('[ArcaneCommand] Escape pressed, closing');
        e.preventDefault();
        e.stopPropagation();
        closeOverlay(overlay);
      }
    }, true); // Capture phase

    // Document-level input handler for search filtering
    document.addEventListener('input', function(e) {
      var input = e.target;
      if (!input.classList.contains('arcane-command-input') && !input.classList.contains('codex-command-input')) return;
      var overlay = findOverlay(input);
      if (!overlay) return;

      setSelectedIndex(overlay, -1);
      filterItems(overlay, input.value);
    });

    console.log('[ArcaneCommand] Initialized with document-level event delegation');
  }
''';
}
