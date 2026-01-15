/// Callback for location pin interactions.
typedef MapLocationCallback = void Function(MapLocation location);

/// Callback for region (state/country) interactions.
typedef MapRegionCallback = void Function(MapRegion region);

/// The type of map to render.
enum MapType {
  /// World map with all countries.
  world,

  /// USA map with all states.
  usa,
}

/// A location pin on the map.
class MapLocation {
  /// Unique identifier for this location.
  final String id;

  /// Display name for the location.
  final String name;

  /// Latitude coordinate (-90 to 90).
  final double latitude;

  /// Longitude coordinate (-180 to 180).
  final double longitude;

  /// Optional region/country name.
  final String? region;

  /// Optional region code (e.g., 'US', 'CA', 'NY').
  final String? regionCode;

  /// Optional custom code (e.g., airport code 'JFK').
  final String? code;

  /// Optional description shown in tooltip.
  final String? description;

  /// Optional custom metadata.
  final Map<String, dynamic>? metadata;

  /// Whether this location is in an active/highlighted state.
  final bool isActive;

  /// Optional custom pin color (CSS color value).
  /// If not provided, uses the map's default pin color.
  final String? color;

  const MapLocation({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.region,
    this.regionCode,
    this.code,
    this.description,
    this.metadata,
    this.isActive = false,
    this.color,
  });

  MapLocation copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
    String? region,
    String? regionCode,
    String? code,
    String? description,
    Map<String, dynamic>? metadata,
    bool? isActive,
    String? color,
  }) {
    return MapLocation(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      region: region ?? this.region,
      regionCode: regionCode ?? this.regionCode,
      code: code ?? this.code,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
      isActive: isActive ?? this.isActive,
      color: color ?? this.color,
    );
  }
}

/// A region on the map (state or country).
class MapRegion {
  /// Region code (e.g., 'CA', 'US', 'NY').
  final String code;

  /// Full region name (e.g., 'California', 'United States').
  final String name;

  /// SVG path data for rendering the region.
  final String svgPath;

  const MapRegion({
    required this.code,
    required this.name,
    required this.svgPath,
  });
}
