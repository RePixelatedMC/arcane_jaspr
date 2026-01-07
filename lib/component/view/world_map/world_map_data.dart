library world_map_data;

typedef MapLocationCallback = void Function(ArcaneMapLocation location);

/// Represents a location pin on the world map.
class ArcaneMapLocation {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String? region;
  final String? code;
  final String? description;
  final Map<String, dynamic>? metadata;
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
class ArcaneWorldMapStyle {
  final String? landFill;
  final String? landStroke;
  final String strokeWidth;
  final String? oceanFill;
  final String? pinColor;
  final String? pinHoverColor;
  final String? pinActiveColor;
  final double pinSize;
  final bool pinPulse;
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

  static const ArcaneWorldMapStyle standard = ArcaneWorldMapStyle();

  static const ArcaneWorldMapStyle subtle = ArcaneWorldMapStyle(
    strokeWidth: '0.3',
    pinSize: 5,
    pinGlowIntensity: 0.2,
  );

  static const ArcaneWorldMapStyle prominent = ArcaneWorldMapStyle(
    strokeWidth: '1',
    pinSize: 8,
    pinPulse: true,
    pinGlowIntensity: 0.4,
  );

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
