/// JavaScript for Codex rainbow theme animation.
///
/// This script animates the --primary and --ring CSS variables
/// through a rainbow color cycle when the .codex-rainbow class is present.
class RainbowScripts {
  RainbowScripts._();

  static const String code = '''
  // Rainbow theme animation
  function bindRainbowTheme() {
    console.log('[Arcane Rainbow] bindRainbowTheme called');

    // Try to find the element, or set up observer to wait for it
    function tryBind(source) {
      console.log('[Arcane Rainbow] tryBind called from:', source);
      const root = document.querySelector('.codex-rainbow') ||
                   document.querySelector('#arcane-root.codex-rainbow');
      console.log('[Arcane Rainbow] Found element:', root);
      if (!root) {
        // Debug: show what elements exist
        const arcaneRoot = document.getElementById('arcane-root');
        console.log('[Arcane Rainbow] #arcane-root exists:', !!arcaneRoot);
        if (arcaneRoot) {
          console.log('[Arcane Rainbow] #arcane-root classes:', arcaneRoot.className);
        }
        return false;
      }
      startRainbowAnimation(root);
      return true;
    }

    // Try immediately
    if (tryBind('immediate')) return;

    console.log('[Arcane Rainbow] Setting up MutationObserver...');
    // If not found, watch for DOM changes (handles Jaspr hydration)
    const observer = new MutationObserver(function(mutations, obs) {
      if (tryBind('mutation')) {
        obs.disconnect();
      }
    });
    observer.observe(document.body || document.documentElement, {
      childList: true,
      subtree: true,
      attributes: true,
      attributeFilter: ['class']
    });

    // Also retry after a delay as fallback
    setTimeout(function() { tryBind('timeout-500'); }, 500);
    setTimeout(function() { tryBind('timeout-1000'); }, 1000);
    setTimeout(function() { tryBind('timeout-2000'); }, 2000);
  }

  function startRainbowAnimation(root) {
    if (root.dataset.rainbowBound) return;
    root.dataset.rainbowBound = 'true';
    console.log('[Arcane] Rainbow theme detected, starting animation...');

    // Rainbow colors in HSL (hue values)
    const colors = [
      { h: 0, name: 'red' },      // Red
      { h: 30, name: 'orange' },  // Orange
      { h: 50, name: 'yellow' },  // Yellow
      { h: 140, name: 'green' },  // Green
      { h: 200, name: 'cyan' },   // Cyan
      { h: 220, name: 'blue' },   // Blue
      { h: 270, name: 'indigo' }, // Indigo
      { h: 300, name: 'violet' }, // Violet
    ];

    let startTime = null;
    const duration = 8000; // 8 seconds for full cycle

    function hslToHex(h, s, l) {
      l /= 100;
      const a = s * Math.min(l, 1 - l) / 100;
      const f = n => {
        const k = (n + h / 30) % 12;
        const color = l - a * Math.max(Math.min(k - 3, 9 - k, 1), -1);
        return Math.round(255 * color).toString(16).padStart(2, '0');
      };
      return '#' + f(0) + f(8) + f(4);
    }

    let frameCount = 0;
    function animate(timestamp) {
      if (!startTime) startTime = timestamp;
      const elapsed = timestamp - startTime;
      const progress = (elapsed % duration) / duration;

      // Calculate current hue (0-360)
      const hue = progress * 360;

      // Log every 60 frames (about once per second)
      frameCount++;
      if (frameCount % 60 === 0) {
        console.log('[Arcane Rainbow] Hue:', Math.round(hue));
      }

      // Check if we're in dark mode
      const isDark = root.classList.contains('dark');

      // Generate colors
      const saturation = isDark ? 85 : 80;
      const lightness = isDark ? 60 : 55;
      const ringLightness = isDark ? 50 : 45;

      const primaryColor = hslToHex(hue, saturation, lightness);
      const ringColor = hslToHex(hue, saturation, ringLightness);

      // Apply to root element
      root.style.setProperty('--primary', primaryColor);
      root.style.setProperty('--ring', ringColor);

      // Apply glow color for dark mode shadows
      if (isDark) {
        const glowColor = 'rgba(' +
          parseInt(primaryColor.slice(1,3), 16) + ',' +
          parseInt(primaryColor.slice(3,5), 16) + ',' +
          parseInt(primaryColor.slice(5,7), 16) + ',0.3)';
        root.style.setProperty('--glow-color', glowColor);
      }

      requestAnimationFrame(animate);
    }

    requestAnimationFrame(animate);
  }
''';
}
