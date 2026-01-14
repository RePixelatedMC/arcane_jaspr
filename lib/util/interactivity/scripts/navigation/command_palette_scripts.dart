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
      var input = overlay.querySelector('.arcane-command-input, .codex-command-input');
      var items = overlay.querySelectorAll('.arcane-command-item, .codex-command-item');
      var selectedIndex = -1;

      function updateSelection() {
        items.forEach(function(item, i) {
          item.classList.toggle('selected', i === selectedIndex);
        });
        if (selectedIndex >= 0 && items[selectedIndex]) {
          items[selectedIndex].scrollIntoView({ block: 'nearest' });
        }
      }

      // Add hover handlers for mouse interaction
      items.forEach(function(item, i) {
        item.addEventListener('mouseenter', function() {
          selectedIndex = i;
          updateSelection();
        });
      });

      overlay.addEventListener('keydown', function(e) {
        if (e.key === 'ArrowDown') {
          e.preventDefault();
          selectedIndex = Math.min(selectedIndex + 1, items.length - 1);
          updateSelection();
        } else if (e.key === 'ArrowUp') {
          e.preventDefault();
          selectedIndex = Math.max(selectedIndex - 1, 0);
          updateSelection();
        } else if (e.key === 'Enter' && selectedIndex >= 0) {
          e.preventDefault();
          items[selectedIndex].click();
        } else if (e.key === 'Escape') {
          overlay.style.display = 'none';
        }
      });

      if (input) {
        input.addEventListener('input', function() {
          var query = input.value.toLowerCase();
          items.forEach(function(item) {
            var label = item.textContent.toLowerCase();
            item.style.display = label.includes(query) ? '' : 'none';
          });
          selectedIndex = -1;
          updateSelection();
        });
      }

      overlay.addEventListener('click', function(e) {
        if (!dialog.contains(e.target)) {
          overlay.style.display = 'none';
        }
      });

      items.forEach(function(item) {
        item.addEventListener('click', function() {
          if (!item.classList.contains('disabled')) {
            overlay.style.display = 'none';
          }
        });
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
