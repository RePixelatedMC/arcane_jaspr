/// Style configuration for ArcaneMap.
///
/// Supports both CSS variables (for theme integration) and explicit hex colors.
/// By default, uses CSS variables that work with ShadCN and Codex stylesheets.
class MapStyle {
  /// Background/ocean color.
  final String backgroundColor;

  /// Default fill color for regions (land/states).
  final String regionFill;

  /// Stroke color for region borders.
  final String regionStroke;

  /// Stroke width for region borders.
  final String strokeWidth;

  /// Fill color when hovering over a region.
  final String regionHoverFill;

  /// Fill color for active/selected regions.
  final String regionActiveFill;

  /// Default pin color.
  final String pinColor;

  /// Pin color on hover.
  final String pinHoverColor;

  /// Pin color when active.
  final String pinActiveColor;

  /// Pin size in SVG units.
  final double pinSize;

  /// Pin glow intensity (0.0 to 1.0).
  final double pinGlowIntensity;

  /// Pin glow color.
  final String pinGlowColor;

  /// Tooltip background color.
  final String tooltipBackground;

  /// Tooltip border color.
  final String tooltipBorder;

  /// Tooltip primary text color.
  final String tooltipTextColor;

  /// Tooltip secondary/muted text color.
  final String tooltipSecondaryColor;

  const MapStyle({
    this.backgroundColor = 'var(--arcane-map-background, var(--card))',
    this.regionFill = 'var(--arcane-map-region, var(--muted))',
    this.regionStroke = 'var(--arcane-map-stroke, var(--border))',
    this.strokeWidth = '0.5',
    this.regionHoverFill = 'var(--arcane-map-region-hover, var(--accent))',
    this.regionActiveFill = 'var(--arcane-map-region-active, var(--primary))',
    this.pinColor = 'var(--arcane-map-pin, var(--primary))',
    this.pinHoverColor = 'var(--arcane-map-pin-hover, var(--primary))',
    this.pinActiveColor = 'var(--arcane-map-pin-active, var(--success, #22c55e))',
    this.pinSize = 6,
    this.pinGlowIntensity = 0.3,
    this.pinGlowColor = 'var(--arcane-map-pin-glow, var(--primary))',
    this.tooltipBackground = 'var(--arcane-map-tooltip-bg, var(--popover))',
    this.tooltipBorder = 'var(--arcane-map-tooltip-border, var(--border))',
    this.tooltipTextColor = 'var(--arcane-map-tooltip-text, var(--popover-foreground))',
    this.tooltipSecondaryColor = 'var(--arcane-map-tooltip-secondary, var(--muted-foreground))',
  });

  /// Default theme-aware preset (uses CSS variables).
  static const MapStyle themed = MapStyle();

  /// Dark theme preset with explicit hex colors.
  static const MapStyle dark = MapStyle(
    backgroundColor: '#111827',
    regionFill: '#374151',
    regionStroke: '#4b5563',
    regionHoverFill: '#4b5563',
    regionActiveFill: '#3b82f6',
    pinColor: '#3b82f6',
    pinHoverColor: '#60a5fa',
    pinActiveColor: '#22c55e',
    pinGlowColor: '#3b82f6',
    tooltipBackground: '#1e1e2e',
    tooltipBorder: '#4b5563',
    tooltipTextColor: '#f8fafc',
    tooltipSecondaryColor: '#9ca3af',
  );

  /// Light theme preset with explicit hex colors.
  static const MapStyle light = MapStyle(
    backgroundColor: '#f8fafc',
    regionFill: '#e2e8f0',
    regionStroke: '#cbd5e1',
    regionHoverFill: '#cbd5e1',
    regionActiveFill: '#3b82f6',
    pinColor: '#2563eb',
    pinHoverColor: '#3b82f6',
    pinActiveColor: '#22c55e',
    pinGlowColor: '#2563eb',
    tooltipBackground: '#ffffff',
    tooltipBorder: '#e2e8f0',
    tooltipTextColor: '#1e293b',
    tooltipSecondaryColor: '#64748b',
  );

  /// Subtle preset with thinner lines and smaller pins.
  static const MapStyle subtle = MapStyle(
    strokeWidth: '0.3',
    pinSize: 5,
    pinGlowIntensity: 0.2,
  );

  /// Prominent preset with thicker lines and larger pins.
  static const MapStyle prominent = MapStyle(
    strokeWidth: '1',
    pinSize: 8,
    pinGlowIntensity: 0.4,
  );

  MapStyle copyWith({
    String? backgroundColor,
    String? regionFill,
    String? regionStroke,
    String? strokeWidth,
    String? regionHoverFill,
    String? regionActiveFill,
    String? pinColor,
    String? pinHoverColor,
    String? pinActiveColor,
    double? pinSize,
    double? pinGlowIntensity,
    String? pinGlowColor,
    String? tooltipBackground,
    String? tooltipBorder,
    String? tooltipTextColor,
    String? tooltipSecondaryColor,
  }) {
    return MapStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      regionFill: regionFill ?? this.regionFill,
      regionStroke: regionStroke ?? this.regionStroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      regionHoverFill: regionHoverFill ?? this.regionHoverFill,
      regionActiveFill: regionActiveFill ?? this.regionActiveFill,
      pinColor: pinColor ?? this.pinColor,
      pinHoverColor: pinHoverColor ?? this.pinHoverColor,
      pinActiveColor: pinActiveColor ?? this.pinActiveColor,
      pinSize: pinSize ?? this.pinSize,
      pinGlowIntensity: pinGlowIntensity ?? this.pinGlowIntensity,
      pinGlowColor: pinGlowColor ?? this.pinGlowColor,
      tooltipBackground: tooltipBackground ?? this.tooltipBackground,
      tooltipBorder: tooltipBorder ?? this.tooltipBorder,
      tooltipTextColor: tooltipTextColor ?? this.tooltipTextColor,
      tooltipSecondaryColor: tooltipSecondaryColor ?? this.tooltipSecondaryColor,
    );
  }
}

/// CSS styles for ArcaneMap components.
///
/// Include this in your stylesheet's baseCss for proper map styling.
/// Provides ShadCN base styles and Codex neon overrides.
const String arcaneMapCss = '''
/* ============================================
   ARCANE MAP - Base Styles (ShadCN)
   ============================================ */

/* Map container */
.arcane-world-map,
.arcane-usa-map {
  position: relative;
  width: 100%;
  background: var(--card);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  overflow: hidden;
}

/* Region paths */
.arcane-world-map path[data-region],
.arcane-usa-map path[data-region] {
  transition: fill 150ms ease, opacity 150ms ease;
}

.arcane-world-map path[data-region]:hover,
.arcane-usa-map path[data-region]:hover {
  fill: var(--accent) !important;
  opacity: 0.9;
}

/* Location pins */
.arcane-world-map circle[data-location],
.arcane-usa-map circle[data-location] {
  transition: fill 150ms ease, r 150ms ease;
}

.arcane-world-map circle[data-location]:hover,
.arcane-usa-map circle[data-location]:hover {
  fill: var(--primary) !important;
}

/* Debug tooltip */
.arcane-map-debug-tooltip {
  position: absolute;
  z-index: 9999;
  pointer-events: none;
}

.arcane-map-debug-tooltip > div {
  background: var(--popover);
  border: 1px solid var(--border);
  border-radius: var(--radius);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
  padding: 10px 14px;
}

.arcane-map-debug-tooltip .debug-lat,
.arcane-map-debug-tooltip .debug-lng {
  font-size: 13px;
  font-family: var(--font-mono, ui-monospace, monospace);
  color: var(--popover-foreground);
  white-space: nowrap;
  font-weight: 500;
}

.arcane-map-debug-tooltip .debug-svg {
  font-size: 11px;
  font-family: var(--font-mono, ui-monospace, monospace);
  color: var(--muted-foreground);
  white-space: nowrap;
  margin-top: 6px;
}

.arcane-map-debug-tooltip .debug-hint {
  font-size: 11px;
  color: var(--primary);
  margin-top: 6px;
  font-weight: 500;
}

/* ============================================
   ARCANE MAP - Codex Style (Neon/Cyberpunk)
   ============================================ */

[class*="codex-"] .arcane-world-map,
[class*="codex-"] .arcane-usa-map,
.codex .arcane-world-map,
.codex .arcane-usa-map {
  background: color-mix(in srgb, var(--card) 80%, transparent);
  border-color: color-mix(in srgb, var(--primary) 30%, var(--border));
  box-shadow:
    inset 0 0 30px color-mix(in srgb, var(--primary) 5%, transparent),
    0 0 20px color-mix(in srgb, var(--primary) 10%, transparent);
}

/* Codex region paths - neon glow on hover */
[class*="codex-"] .arcane-world-map path[data-region]:hover,
[class*="codex-"] .arcane-usa-map path[data-region]:hover,
.codex .arcane-world-map path[data-region]:hover,
.codex .arcane-usa-map path[data-region]:hover {
  fill: var(--primary) !important;
  opacity: 0.7;
  filter: drop-shadow(0 0 4px var(--primary));
}

/* Codex active regions - bright glow */
[class*="codex-"] .arcane-world-map path[data-region][data-active="true"],
[class*="codex-"] .arcane-usa-map path[data-region][data-active="true"],
.codex .arcane-world-map path[data-region][data-active="true"],
.codex .arcane-usa-map path[data-region][data-active="true"] {
  fill: var(--primary) !important;
  filter: drop-shadow(0 0 8px var(--primary));
}

/* Codex location pins - pulsing glow */
[class*="codex-"] .arcane-world-map circle[data-location],
[class*="codex-"] .arcane-usa-map circle[data-location],
.codex .arcane-world-map circle[data-location],
.codex .arcane-usa-map circle[data-location] {
  filter: drop-shadow(0 0 4px var(--primary));
  animation: arcane-map-pin-pulse 2s ease-in-out infinite;
}

[class*="codex-"] .arcane-world-map circle[data-location]:hover,
[class*="codex-"] .arcane-usa-map circle[data-location]:hover,
.codex .arcane-world-map circle[data-location]:hover,
.codex .arcane-usa-map circle[data-location]:hover {
  filter: drop-shadow(0 0 8px var(--primary)) drop-shadow(0 0 12px var(--primary));
  animation: none;
}

/* Codex debug tooltip - neon style */
[class*="codex-"] .arcane-map-debug-tooltip > div,
.codex .arcane-map-debug-tooltip > div {
  background: color-mix(in srgb, var(--card) 95%, transparent);
  border-color: color-mix(in srgb, var(--primary) 40%, var(--border));
  box-shadow:
    0 4px 12px rgba(0, 0, 0, 0.3),
    0 0 20px color-mix(in srgb, var(--primary) 15%, transparent);
}

[class*="codex-"] .arcane-map-debug-tooltip .debug-lat,
[class*="codex-"] .arcane-map-debug-tooltip .debug-lng,
.codex .arcane-map-debug-tooltip .debug-lat,
.codex .arcane-map-debug-tooltip .debug-lng {
  color: var(--primary);
  text-shadow: 0 0 8px color-mix(in srgb, var(--primary) 50%, transparent);
}

[class*="codex-"] .arcane-map-debug-tooltip .debug-hint,
.codex .arcane-map-debug-tooltip .debug-hint {
  color: var(--primary);
  text-shadow: 0 0 6px color-mix(in srgb, var(--primary) 40%, transparent);
}

/* Pin pulse animation for Codex */
@keyframes arcane-map-pin-pulse {
  0%, 100% {
    opacity: 1;
    filter: drop-shadow(0 0 4px var(--primary));
  }
  50% {
    opacity: 0.8;
    filter: drop-shadow(0 0 8px var(--primary)) drop-shadow(0 0 12px var(--primary));
  }
}
''';
