/// Data models for ArcaneWorldMap component.
library world_map_data;

/// Callback type for map location interactions.
typedef MapLocationCallback = void Function(ArcaneMapLocation location);

/// Represents a location pin on the world map.
///
/// ```dart
/// ArcaneMapLocation(
///   id: 'nyc',
///   name: 'New York',
///   latitude: 40.7128,
///   longitude: -74.0060,
///   code: 'NYC',
///   region: 'North America',
/// )
/// ```
class ArcaneMapLocation {
  /// Unique identifier for this location.
  final String id;

  /// Display name (e.g., "New York").
  final String name;

  /// Latitude coordinate (-90 to 90).
  final double latitude;

  /// Longitude coordinate (-180 to 180).
  final double longitude;

  /// Optional region or country name.
  final String? region;

  /// Optional short code (e.g., "NYC", "LHR").
  final String? code;

  /// Optional description for tooltip.
  final String? description;

  /// Optional custom metadata (latency, features, etc.).
  final Map<String, dynamic>? metadata;

  /// Whether this pin is highlighted/active.
  final bool isActive;

  const ArcaneMapLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.region,
    this.code,
    this.description,
    this.metadata,
    this.isActive = false,
  });

  /// Creates a copy with optional overrides.
  ArcaneMapLocation copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    String? region,
    String? code,
    String? description,
    Map<String, dynamic>? metadata,
    bool? isActive,
  }) {
    return ArcaneMapLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      region: region ?? this.region,
      code: code ?? this.code,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Style configuration for ArcaneWorldMap.
///
/// All color properties accept CSS color strings or CSS variable references.
///
/// ```dart
/// ArcaneWorldMapStyle(
///   landFill: 'rgba(255, 255, 255, 0.05)',
///   pinColor: '#10b981',
///   pinSize: 10,
/// )
/// ```
class ArcaneWorldMapStyle {
  /// Fill color for land masses.
  /// Defaults to theme surface variant.
  final String? landFill;

  /// Stroke color for land outlines.
  /// Defaults to theme border color.
  final String? landStroke;

  /// Stroke width for land outlines.
  final String strokeWidth;

  /// Background/ocean color.
  /// Defaults to theme background.
  final String? oceanFill;

  /// Default pin color.
  /// Defaults to theme accent.
  final String? pinColor;

  /// Pin color on hover.
  /// Defaults to theme accent hover.
  final String? pinHoverColor;

  /// Active/highlighted pin color.
  /// Defaults to theme success.
  final String? pinActiveColor;

  /// Pin radius in SVG units.
  final double pinSize;

  /// Whether to show pulse animation on hover.
  final bool pinPulse;

  /// Glow intensity around pins (0.0 to 1.0).
  final double pinGlowIntensity;

  const ArcaneWorldMapStyle({
    this.landFill,
    this.landStroke,
    this.strokeWidth = '0.5',
    this.oceanFill,
    this.pinColor,
    this.pinHoverColor,
    this.pinActiveColor,
    this.pinSize = 6,
    this.pinPulse = true,
    this.pinGlowIntensity = 0.3,
  });

  /// Standard style preset.
  static const ArcaneWorldMapStyle standard = ArcaneWorldMapStyle();

  /// Subtle style with thinner lines and smaller pins.
  static const ArcaneWorldMapStyle subtle = ArcaneWorldMapStyle(
    strokeWidth: '0.3',
    pinSize: 5,
    pinGlowIntensity: 0.2,
  );

  /// Prominent style with thicker lines and larger pins.
  static const ArcaneWorldMapStyle prominent = ArcaneWorldMapStyle(
    strokeWidth: '1',
    pinSize: 8,
    pinPulse: true,
    pinGlowIntensity: 0.4,
  );

  /// Creates a copy with optional overrides.
  ArcaneWorldMapStyle copyWith({
    String? landFill,
    String? landStroke,
    String? strokeWidth,
    String? oceanFill,
    String? pinColor,
    String? pinHoverColor,
    String? pinActiveColor,
    double? pinSize,
    bool? pinPulse,
    double? pinGlowIntensity,
  }) {
    return ArcaneWorldMapStyle(
      landFill: landFill ?? this.landFill,
      landStroke: landStroke ?? this.landStroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      oceanFill: oceanFill ?? this.oceanFill,
      pinColor: pinColor ?? this.pinColor,
      pinHoverColor: pinHoverColor ?? this.pinHoverColor,
      pinActiveColor: pinActiveColor ?? this.pinActiveColor,
      pinSize: pinSize ?? this.pinSize,
      pinPulse: pinPulse ?? this.pinPulse,
      pinGlowIntensity: pinGlowIntensity ?? this.pinGlowIntensity,
    );
  }
}
