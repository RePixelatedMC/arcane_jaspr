/// Data models for ArcaneUSAMap component.
library usa_map_data;

/// Callback type for map location interactions.
typedef USAMapLocationCallback = void Function(ArcaneUSAMapLocation location);

/// Callback type for state interactions.
typedef USAMapStateCallback = void Function(String stateCode);

/// Represents a location pin on the USA map.
///
/// ```dart
/// ArcaneUSAMapLocation(
///   id: 'nyc',
///   name: 'New York City',
///   latitude: 40.7128,
///   longitude: -74.0060,
///   code: 'NYC',
///   state: 'NY',
/// )
/// ```
class ArcaneUSAMapLocation {
  /// Unique identifier for this location.
  final String id;

  /// Display name (e.g., "New York City").
  final String name;

  /// Latitude coordinate.
  final double latitude;

  /// Longitude coordinate.
  final double longitude;

  /// State code (e.g., "NY", "CA").
  final String? state;

  /// Optional short code (e.g., "NYC", "LAX").
  final String? code;

  /// Optional description for tooltip.
  final String? description;

  /// Optional custom metadata (latency, features, etc.).
  final Map<String, dynamic>? metadata;

  /// Whether this pin is highlighted/active.
  final bool isActive;

  const ArcaneUSAMapLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.state,
    this.code,
    this.description,
    this.metadata,
    this.isActive = false,
  });

  /// Creates a copy with optional overrides.
  ArcaneUSAMapLocation copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    String? state,
    String? code,
    String? description,
    Map<String, dynamic>? metadata,
    bool? isActive,
  }) {
    return ArcaneUSAMapLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      state: state ?? this.state,
      code: code ?? this.code,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
    );
  }
}

/// Style configuration for ArcaneUSAMap.
///
/// All color properties accept CSS color strings or CSS variable references.
///
/// ```dart
/// ArcaneUSAMapStyle(
///   stateFill: 'rgba(255, 255, 255, 0.05)',
///   pinColor: '#10b981',
///   pinSize: 8,
/// )
/// ```
class ArcaneUSAMapStyle {
  /// Fill color for states.
  /// Defaults to theme surface variant.
  final String? stateFill;

  /// Stroke color for state outlines.
  /// Defaults to theme border color.
  final String? stateStroke;

  /// Stroke width for state outlines.
  final String strokeWidth;

  /// Background color.
  /// Defaults to theme background.
  final String? backgroundFill;

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

  /// Fill color for hovered states.
  final String? stateHoverFill;

  /// Fill color for active/selected states.
  final String? stateActiveFill;

  const ArcaneUSAMapStyle({
    this.stateFill,
    this.stateStroke,
    this.strokeWidth = '0.5',
    this.backgroundFill,
    this.pinColor,
    this.pinHoverColor,
    this.pinActiveColor,
    this.pinSize = 6,
    this.pinPulse = true,
    this.pinGlowIntensity = 0.3,
    this.stateHoverFill,
    this.stateActiveFill,
  });

  /// Standard style preset.
  static const ArcaneUSAMapStyle standard = ArcaneUSAMapStyle();

  /// Subtle style with thinner lines and smaller pins.
  static const ArcaneUSAMapStyle subtle = ArcaneUSAMapStyle(
    strokeWidth: '0.3',
    pinSize: 5,
    pinGlowIntensity: 0.2,
  );

  /// Prominent style with thicker lines and larger pins.
  static const ArcaneUSAMapStyle prominent = ArcaneUSAMapStyle(
    strokeWidth: '1',
    pinSize: 8,
    pinPulse: true,
    pinGlowIntensity: 0.4,
  );

  /// Creates a copy with optional overrides.
  ArcaneUSAMapStyle copyWith({
    String? stateFill,
    String? stateStroke,
    String? strokeWidth,
    String? backgroundFill,
    String? pinColor,
    String? pinHoverColor,
    String? pinActiveColor,
    double? pinSize,
    bool? pinPulse,
    double? pinGlowIntensity,
    String? stateHoverFill,
    String? stateActiveFill,
  }) {
    return ArcaneUSAMapStyle(
      stateFill: stateFill ?? this.stateFill,
      stateStroke: stateStroke ?? this.stateStroke,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      backgroundFill: backgroundFill ?? this.backgroundFill,
      pinColor: pinColor ?? this.pinColor,
      pinHoverColor: pinHoverColor ?? this.pinHoverColor,
      pinActiveColor: pinActiveColor ?? this.pinActiveColor,
      pinSize: pinSize ?? this.pinSize,
      pinPulse: pinPulse ?? this.pinPulse,
      pinGlowIntensity: pinGlowIntensity ?? this.pinGlowIntensity,
      stateHoverFill: stateHoverFill ?? this.stateHoverFill,
      stateActiveFill: stateActiveFill ?? this.stateActiveFill,
    );
  }
}
