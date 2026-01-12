/// Map debug mode interactivity scripts.
///
/// Handles coordinate display on hover and clipboard copy on click
/// for ArcaneMap components in debug mode.
class MapScripts {
  MapScripts._();

  static const String code = r'''
  // ===== MAP DEBUG MODE =====
  function bindMapDebugMode() {
    // World Map debug mode
    document.querySelectorAll('.arcane-world-map[data-debug-mode="true"]').forEach(function(map) {
      if (map.dataset.arcaneMapDebugBound) return;
      map.dataset.arcaneMapDebugBound = 'true';
      bindMapDebug(map, 2000, 857, 83, -60, 360, 143, 'world');
    });

    // USA Map debug mode
    document.querySelectorAll('.arcane-usa-map[data-debug-mode="true"]').forEach(function(map) {
      if (map.dataset.arcaneMapDebugBound) return;
      map.dataset.arcaneMapDebugBound = 'true';
      bindMapDebug(map, 1000, 589, 50, 25, 58, 25, 'usa');
    });
  }

  function bindMapDebug(map, mapWidth, mapHeight, latMax, latMin, lngRange, latRange, mapType) {
    var tooltip = createMapDebugTooltip();
    map.appendChild(tooltip);
    map.style.cursor = 'crosshair';

    map.addEventListener('mousemove', function(e) {
      var rect = map.getBoundingClientRect();
      var relX = (e.clientX - rect.left) / rect.width;
      var relY = (e.clientY - rect.top) / rect.height;

      var svgX = relX * mapWidth;
      var svgY = relY * mapHeight;

      var lat, lng;
      if (mapType === 'usa') {
        // USA map projection inverse
        lng = ((svgX - 50) / 900) * 58 - 125;
        lat = 50 - ((svgY - 50) / 450) * 25;
      } else {
        // World map projection (equirectangular)
        lng = (svgX / mapWidth) * lngRange - 180;
        lat = latMax - (svgY / mapHeight) * latRange;
      }

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

      var lat, lng;
      if (mapType === 'usa') {
        lng = ((svgX - 50) / 900) * 58 - 125;
        lat = 50 - ((svgY - 50) / 450) * 25;
      } else {
        lng = (svgX / mapWidth) * lngRange - 180;
        lat = latMax - (svgY / mapHeight) * latRange;
      }

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
    inner.style.cssText = 'background: #1e1e2e; border: 1px solid #4b5563; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.5); padding: 10px 14px;';

    inner.innerHTML = '<div class="debug-lat" style="font-size: 13px; font-family: ui-monospace, monospace; color: #f8fafc; white-space: nowrap; font-weight: 500;">Lat: 0.0000</div>' +
      '<div class="debug-lng" style="font-size: 13px; font-family: ui-monospace, monospace; color: #f8fafc; white-space: nowrap; font-weight: 500;">Lng: 0.0000</div>' +
      '<div class="debug-svg" style="font-size: 11px; font-family: ui-monospace, monospace; color: #9ca3af; white-space: nowrap; margin-top: 6px;">SVG: 0, 0</div>' +
      '<div class="debug-hint" style="font-size: 11px; color: #60a5fa; margin-top: 6px; font-weight: 500;">Click to copy</div>';

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
      hint.style.color = '#22c55e';
      setTimeout(function() {
        hint.textContent = original;
        hint.style.color = '#60a5fa';
      }, 1500);
    }
  }

  // ===== MAP PIN TOOLTIPS =====
  function bindMapPinTooltips() {
    document.querySelectorAll('.arcane-world-map[data-has-tooltips="true"], .arcane-usa-map[data-has-tooltips="true"]').forEach(function(map) {
      if (map.dataset.arcaneMapTooltipsBound) return;
      map.dataset.arcaneMapTooltipsBound = 'true';
      bindPinTooltips(map);
    });
  }

  function bindPinTooltips(map) {
    var pins = map.querySelectorAll('.arcane-map-pin[data-location]');
    pins.forEach(function(pin) {
      var locationId = pin.getAttribute('data-location');
      if (!locationId) return;

      pin.addEventListener('mouseenter', function() {
        highlightMapPin(map, locationId);
      });

      pin.addEventListener('mouseleave', function() {
        unhighlightMapPin(map, locationId);
      });
    });
  }

  function highlightMapPin(map, locationId) {
    var pin = map.querySelector('.arcane-map-pin[data-location="' + locationId + '"]');
    var tooltip = map.querySelector('.arcane-map-tooltip[data-for-location="' + locationId + '"]');

    if (pin) {
      pin.style.transform = 'translate(-50%, -50%) scale(1.5)';
      pin.style.boxShadow = '0 0 20px 10px rgba(34, 197, 94, 0.6)';
    }
    if (tooltip) {
      tooltip.style.opacity = '1';
      tooltip.style.visibility = 'visible';
    }
  }

  function unhighlightMapPin(map, locationId) {
    var pin = map.querySelector('.arcane-map-pin[data-location="' + locationId + '"]');
    var tooltip = map.querySelector('.arcane-map-tooltip[data-for-location="' + locationId + '"]');

    if (pin) {
      pin.style.transform = 'translate(-50%, -50%) scale(1)';
      pin.style.boxShadow = '';
    }
    if (tooltip) {
      tooltip.style.opacity = '0';
      tooltip.style.visibility = 'hidden';
    }
  }

  // ===== LOCATION LIST HOVER =====
  function bindLocationListHover() {
    document.querySelectorAll('.location-list-item').forEach(function(item) {
      if (item.dataset.arcaneListHoverBound) return;
      item.dataset.arcaneListHoverBound = 'true';

      // Extract location ID from id attribute (format: location-item-{id})
      var itemId = item.getAttribute('id');
      var locationId = itemId ? itemId.replace('location-item-', '') : null;
      if (!locationId) return;

      // Find the map container (may not be a direct parent)
      var mapContainer = document.querySelector('.arcane-world-map, .arcane-usa-map');
      if (!mapContainer) return;

      item.addEventListener('mouseenter', function() {
        item.style.background = 'var(--arcane-surface-variant, rgba(255,255,255,0.05))';
        highlightMapPin(mapContainer, locationId);
      });

      item.addEventListener('mouseleave', function() {
        item.style.background = '';
        unhighlightMapPin(mapContainer, locationId);
      });
    });
  }
''';
}
