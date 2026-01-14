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

      // Helper to get current visible items (re-queries DOM each time for Jaspr reactivity)
      function getVisibleItems() {
        var allItems = overlay.querySelectorAll('.arcane-command-item:not(.disabled), .codex-command-item:not(.disabled)');
        return Array.from(allItems).filter(function(item) {
          return item.offsetParent !== null; // Only visible items
        });
      }

      function updateSelection(items) {
        // Clear all selections first
        overlay.querySelectorAll('.arcane-command-item, .codex-command-item').forEach(function(item) {
          item.classList.remove('selected');
        });
        // Apply selection to current item
        if (selectedIndex >= 0 && items[selectedIndex]) {
          items[selectedIndex].classList.add('selected');
          items[selectedIndex].scrollIntoView({ block: 'nearest' });
        }
      }

      // Use event delegation for hover (works with dynamically rendered items)
      overlay.addEventListener('mouseover', function(e) {
        var item = e.target.closest('.arcane-command-item, .codex-command-item');
        if (item && !item.classList.contains('disabled')) {
          var items = getVisibleItems();
          selectedIndex = items.indexOf(item);
          updateSelection(items);
        }
      });

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
            items[selectedIndex].click();
          } else if (items.length > 0) {
            // If nothing selected, pick first item
            items[0].click();
          }
        } else if (e.key === 'Escape') {
          e.preventDefault();
          // Click overlay background to trigger onClose callback
          overlay.click();
        }
      });

      // Reset selection when input changes (Jaspr handles filtering)
      var input = overlay.querySelector('.arcane-command-input, .codex-command-input');
      if (input) {
        input.addEventListener('input', function() {
          selectedIndex = -1;
        });
      }

      overlay.addEventListener('click', function(e) {
        if (!dialog || !dialog.contains(e.target)) {
          // Clicking outside dialog - overlay handles close via onClose prop
        }
      });
    });

    // Global Ctrl+K / Cmd+K keyboard shortcut
    // Only bind once per document
    if (!document._arcaneCommandKeyBound) {
      document._arcaneCommandKeyBound = true;
      document.addEventListener('keydown', function(e) {
        if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
          e.preventDefault();
          // Look for command trigger elements (buttons that open command palettes)
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
