library usa_map_data;

typedef USAMapLocationCallback = void Function(ArcaneUSAMapLocation location);

typedef USAMapStateCallback = void Function(String stateCode);

/// Represents a location pin on the USA map.
class ArcaneUSAMapLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? state;
  final String? code;
  final String? description;
  final Map<String, dynamic>? metadata;
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
class ArcaneUSAMapStyle {
  final String? stateFill;
  final String? stateStroke;
  final String strokeWidth;
  final String? backgroundFill;
  final String? pinColor;
  final String? pinHoverColor;
  final String? pinActiveColor;
  final double pinSize;
  final bool pinPulse;
  final double pinGlowIntensity;
  final String? stateHoverFill;
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

  static const ArcaneUSAMapStyle standard = ArcaneUSAMapStyle();

  static const ArcaneUSAMapStyle subtle = ArcaneUSAMapStyle(
    strokeWidth: '0.3',
    pinSize: 5,
    pinGlowIntensity: 0.2,
  );

  static const ArcaneUSAMapStyle prominent = ArcaneUSAMapStyle(
    strokeWidth: '1',
    pinSize: 8,
    pinPulse: true,
    pinGlowIntensity: 0.4,
  );

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
