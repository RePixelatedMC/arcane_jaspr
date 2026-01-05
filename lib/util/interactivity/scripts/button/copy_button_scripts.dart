/// Copy button interactivity scripts.
///
/// Handles clipboard copy functionality for buttons with data-code attribute.
library;

/// Scripts for copy-to-clipboard buttons.
class CopyButtonScripts {
  CopyButtonScripts._();

  static String get code => '''
  // ===== COPY BUTTONS =====
  function bindCopyButtons() {
    document.querySelectorAll('[data-code]').forEach(function(btn) {
      if (btn.dataset.arcaneCopyBound) return;
      btn.dataset.arcaneCopyBound = 'true';

      btn.addEventListener('click', function(e) {
        e.preventDefault();
        var code = this.dataset.code;
        if (!code) return;

        navigator.clipboard.writeText(code).then(function() {
          // Find the icon inside the button and swap it
          var icon = btn.querySelector('svg');
          if (icon) {
            var originalPath = icon.innerHTML;
            // Set to checkmark icon
            icon.innerHTML = '<polyline points="20 6 9 17 4 12" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"></polyline>';
            btn.style.color = 'var(--arcane-success)';

            setTimeout(function() {
              icon.innerHTML = originalPath;
              btn.style.color = '';
            }, 2000);
          }
        }).catch(function(err) {
          console.warn('[Arcane] Clipboard write failed:', err);
        });
      });
    });
  }
''';
}
