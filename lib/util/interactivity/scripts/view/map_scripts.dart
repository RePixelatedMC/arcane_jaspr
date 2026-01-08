/// Map debug mode interactivity scripts.
///
/// Handles coordinate display on hover and clipboard copy on click
/// for ArcaneWorldMap and ArcaneUSAMap components in debug mode.
class MapScripts {
  MapScripts._();

  static const String code = r'''
  // ===== MAP DEBUG MODE =====
  function bindMapDebugMode() {
    // World Map debug mode
    document.querySelectorAll('.arcane-world-map[data-debug-mode="true"]').forEach(function(map) {
      if (map.dataset.arcaneMapDebugBound) return;
      map.dataset.arcaneMapDebugBound = 'true';
      bindMapDebug(map, 2000, 857, 83, -60, 360, 143);
    });

    // USA Map debug mode
    document.querySelectorAll('.arcane-usa-map[data-debug-mode="true"]').forEach(function(map) {
      if (map.dataset.arcaneMapDebugBound) return;
      map.dataset.arcaneMapDebugBound = 'true';
      bindUSAMapDebug(map, 1000, 589);
    });
  }

  function bindMapDebug(map, mapWidth, mapHeight, latMax, latMin, lngRange, latRange) {
    var tooltip = createMapDebugTooltip();
    map.appendChild(tooltip);
    map.style.cursor = 'crosshair';

    var currentSvgX = 0;
    var currentSvgY = 0;

    map.addEventListener('mousemove', function(e) {
      var rect = map.getBoundingClientRect();
      var relX = (e.clientX - rect.left) / rect.width;
      var relY = (e.clientY - rect.top) / rect.height;

      currentSvgX = relX * mapWidth;
      currentSvgY = relY * mapHeight;

      // Convert SVG coords to lat/lng (world map projection)
      var lng = (currentSvgX / mapWidth) * lngRange - 180;
      var lat = latMax - (currentSvgY / mapHeight) * latRange;

      updateMapDebugTooltip(tooltip, lat, lng, currentSvgX, currentSvgY, relX * 100, relY * 100);
    });

    map.addEventListener('mouseleave', function() {
      tooltip.style.opacity = '0';
      tooltip.style.visibility = 'hidden';
    });

    map.addEventListener('click', function(e) {
      // Recalculate in case mouse moved
      var rect = map.getBoundingClientRect();
      var relX = (e.clientX - rect.left) / rect.width;
      var relY = (e.clientY - rect.top) / rect.height;

      var svgX = relX * mapWidth;
      var svgY = relY * mapHeight;

      var lng = (svgX / mapWidth) * lngRange - 180;
      var lat = latMax - (svgY / mapHeight) * latRange;

      var coordText = lat.toFixed(4) + ', ' + lng.toFixed(4);
      navigator.clipboard.writeText(coordText).then(function() {
        showCopiedFeedback(tooltip);
      }).catch(function(err) {
        console.warn('[Arcane] Clipboard write failed:', err);
      });
    });
  }

  function bindUSAMapDebug(map, mapWidth, mapHeight) {
    var tooltip = createMapDebugTooltip();
    map.appendChild(tooltip);
    map.style.cursor = 'crosshair';

    map.addEventListener('mousemove', function(e) {
      var rect = map.getBoundingClientRect();
      var relX = (e.clientX - rect.left) / rect.width;
      var relY = (e.clientY - rect.top) / rect.height;

      var svgX = relX * mapWidth;
      var svgY = relY * mapHeight;

      // USA map projection inverse
      var lng = ((svgX - 50) / 900) * 58 - 125;
      var lat = 50 - ((svgY - 50) / 450) * 25;

      updateMapDebugTooltip(tooltip, lat, lng, svgX, svgY, relX * 100, relY * 100);
    });

    map.addEventListener('mouseleave', function() {
      tooltip.style.opacity = '0';
      tooltip.style.visibility = 'hidden';
    });

    map.addEventListener('click', function(e) {
      var rect = map.getBoundingClientRect();
      var relX = (e.clientX - rect.left) / rect.width;
      var relY = (e.clientY - rect.top) / rect.height;

      var svgX = relX * mapWidth;
      var svgY = relY * mapHeight;

      var lng = ((svgX - 50) / 900) * 58 - 125;
      var lat = 50 - ((svgY - 50) / 450) * 25;

      var coordText = lat.toFixed(4) + ', ' + lng.toFixed(4);
      navigator.clipboard.writeText(coordText).then(function() {
        showCopiedFeedback(tooltip);
      }).catch(function(err) {
        console.warn('[Arcane] Clipboard write failed:', err);
      });
    });
  }

  function createMapDebugTooltip() {
    var tooltip = document.createElement('div');
    tooltip.className = 'arcane-map-debug-tooltip';
    tooltip.style.cssText = 'position: absolute; z-index: 9999; pointer-events: none; opacity: 0; visibility: hidden; transition: opacity 150ms ease;';

    var inner = document.createElement('div');
    inner.style.cssText = 'background: var(--surface, #1e1e2e); border: 1px solid var(--border, #333); border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.3); padding: 8px 12px;';

    inner.innerHTML = '<div class="debug-lat" style="font-size: 12px; font-family: monospace; color: var(--foreground, #f8fafc); white-space: nowrap;">Lat: 0.0000</div>' +
      '<div class="debug-lng" style="font-size: 12px; font-family: monospace; color: var(--foreground, #f8fafc); white-space: nowrap;">Lng: 0.0000</div>' +
      '<div class="debug-svg" style="font-size: 12px; font-family: monospace; color: var(--muted-foreground, #888); white-space: nowrap; margin-top: 4px;">SVG: 0, 0</div>' +
      '<div class="debug-hint" style="font-size: 12px; color: var(--primary, #3b82f6); margin-top: 4px;">Click to copy</div>';

    tooltip.appendChild(inner);
    return tooltip;
  }

  function updateMapDebugTooltip(tooltip, lat, lng, svgX, svgY, leftPct, topPct) {
    tooltip.style.left = leftPct + '%';
    tooltip.style.top = 'calc(' + topPct + '% + 15px)';
    tooltip.style.transform = 'translateX(-50%)';
    tooltip.style.opacity = '1';
    tooltip.style.visibility = 'visible';

    var latEl = tooltip.querySelector('.debug-lat');
    var lngEl = tooltip.querySelector('.debug-lng');
    var svgEl = tooltip.querySelector('.debug-svg');

    if (latEl) latEl.textContent = 'Lat: ' + lat.toFixed(4);
    if (lngEl) lngEl.textContent = 'Lng: ' + lng.toFixed(4);
    if (svgEl) svgEl.textContent = 'SVG: ' + Math.round(svgX) + ', ' + Math.round(svgY);
  }

  function showCopiedFeedback(tooltip) {
    var hint = tooltip.querySelector('.debug-hint');
    if (hint) {
      var original = hint.textContent;
      hint.textContent = 'Copied!';
      hint.style.color = 'var(--success, #22c55e)';
      setTimeout(function() {
        hint.textContent = original;
        hint.style.color = 'var(--primary, #3b82f6)';
      }, 1500);
    }
  }
''';
}
