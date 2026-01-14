/// Command palette interactivity scripts.
class CommandPaletteScripts {
  CommandPaletteScripts._();

  static const String code = r'''
  function bindCommandPalettes() {
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

    // Handle both arcane- and codex- prefixed overlays
    var overlays = document.querySelectorAll('.arcane-command-overlay, .codex-command-overlay');
    overlays.forEach(function(overlay) {
      if (overlay.dataset.arcaneInteractive === 'true') return;
      overlay.dataset.arcaneInteractive = 'true';

      var dialog = overlay.querySelector('.arcane-command-dialog, .codex-command-dialog');
      var selectedIndex = -1;

      // Helper to get current visible items
      function getVisibleItems() {
        var allItems = overlay.querySelectorAll('.arcane-command-item:not(.disabled):not(.js-hidden), .codex-command-item:not(.disabled):not(.js-hidden)');
        return Array.from(allItems).filter(function(item) {
          return item.offsetParent !== null;
        });
      }

      function updateSelection(items) {
        overlay.querySelectorAll('.arcane-command-item, .codex-command-item').forEach(function(item) {
          item.classList.remove('selected');
        });
        if (selectedIndex >= 0 && items[selectedIndex]) {
          items[selectedIndex].classList.add('selected');
          items[selectedIndex].scrollIntoView({ block: 'nearest' });
        }
      }

      // Close overlay helper
      function closeOverlay() {
        overlay.style.display = 'none';
        // Dispatch custom event for Jaspr to handle state update
        overlay.dispatchEvent(new CustomEvent('arcane-command-close', { bubbles: true }));
      }

      // Handle item click - navigate via data-href
      function handleItemClick(item) {
        var href = item.dataset.href;
        var target = item.dataset.target;
        if (href) {
          if (target === '_blank') {
            window.open(href, '_blank', 'noopener,noreferrer');
          } else {
            window.location.href = href;
          }
          closeOverlay();
        }
      }

      // Filter items based on search query
      function filterItems(query) {
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

        // Also hide group headings if all their items are hidden
        var groups = overlay.querySelectorAll('.arcane-command-list > div, .codex-command-list > div');
        // Group headings don't have role="option", items do
      }

      // Event delegation for item clicks
      overlay.addEventListener('click', function(e) {
        var item = e.target.closest('.arcane-command-item, .codex-command-item');
        if (item && !item.classList.contains('disabled')) {
          e.stopPropagation();
          handleItemClick(item);
          return;
        }

        // Close on overlay background click
        if (overlay.dataset.commandClosable === 'true') {
          if (!dialog || !dialog.contains(e.target)) {
            closeOverlay();
          }
        }
      });

      // Hover selection
      overlay.addEventListener('mouseover', function(e) {
        var item = e.target.closest('.arcane-command-item, .codex-command-item');
        if (item && !item.classList.contains('disabled') && !item.classList.contains('js-hidden')) {
          var items = getVisibleItems();
          selectedIndex = items.indexOf(item);
          updateSelection(items);
        }
      });

      // Keyboard navigation
      overlay.addEventListener('keydown', function(e) {
        var items = getVisibleItems();

        if (e.key === 'ArrowDown') {
          e.preventDefault();
          if (items.length > 0) {
            selectedIndex = Math.min(selectedIndex + 1, items.length - 1);
            if (selectedIndex < 0) selectedIndex = 0;
            updateSelection(items);
          }
        } else if (e.key === 'ArrowUp') {
          e.preventDefault();
          if (items.length > 0) {
            selectedIndex = Math.max(selectedIndex - 1, 0);
            updateSelection(items);
          }
        } else if (e.key === 'Enter') {
          e.preventDefault();
          if (selectedIndex >= 0 && items[selectedIndex]) {
            handleItemClick(items[selectedIndex]);
          } else if (items.length > 0) {
            handleItemClick(items[0]);
          }
        } else if (e.key === 'Escape') {
          e.preventDefault();
          closeOverlay();
        }
      });

      // Search input filtering
      var input = overlay.querySelector('.arcane-command-input, .codex-command-input');
      if (input) {
        input.addEventListener('input', function() {
          selectedIndex = -1;
          filterItems(this.value);
        });
      }
    });

    // Global Ctrl+K / Cmd+K keyboard shortcut
    if (!document._arcaneCommandKeyBound) {
      document._arcaneCommandKeyBound = true;
      document.addEventListener('keydown', function(e) {
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
          e.preventDefault();
          var trigger = document.querySelector('[data-command-trigger]');
          if (trigger) {
            trigger.click();
          }
        }
      });
    }
  }
''';
}
