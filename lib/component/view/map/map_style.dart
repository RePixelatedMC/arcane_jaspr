/// Style configuration for ArcaneMap.
///
/// Uses explicit hex colors for reliability across all themes.
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
    this.backgroundColor = '#111827',
    this.regionFill = '#374151',
    this.regionStroke = '#4b5563',
    this.strokeWidth = '0.5',
    this.regionHoverFill = '#4b5563',
    this.regionActiveFill = '#3b82f6',
    this.pinColor = '#3b82f6',
    this.pinHoverColor = '#60a5fa',
    this.pinActiveColor = '#22c55e',
    this.pinSize = 6,
    this.pinGlowIntensity = 0.3,
    this.pinGlowColor = '#3b82f6',
    this.tooltipBackground = '#1e1e2e',
    this.tooltipBorder = '#4b5563',
    this.tooltipTextColor = '#f8fafc',
    this.tooltipSecondaryColor = '#9ca3af',
  });

  /// Dark theme preset (default).
  static const MapStyle dark = MapStyle();

  /// Light theme preset.
  static const MapStyle light = MapStyle(
    backgroundColor: '#f8fafc',
    regionFill: '#e2e8f0',
    regionStroke: '#cbd5e1',
    regionHoverFill: '#cbd5e1',
    regionActiveFill: '#3b82f6',
    pinColor: '#2563eb',
    pinHoverColor: '#3b82f6',
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
