import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'map_data.dart';
import 'map_projection.dart';
import 'map_style.dart';
import 'paths/usa_paths.dart';
import 'paths/world_paths.dart';

export 'map_data.dart';
export 'map_projection.dart';
export 'map_style.dart';

/// Unified map component supporting both world and USA maps.
///
/// Renders an interactive SVG map with optional location pins,
/// region highlighting, and tooltips.
class ArcaneMap extends StatelessComponent {
  /// The type of map to display.
  final MapType type;

  /// Location pins to display on the map.
  final List<MapLocation> locations;

  /// Callback when a location pin is tapped.
  final MapLocationCallback? onLocationTap;

  /// Callback when hovering over a location pin.
  final MapLocationCallback? onLocationHover;

  /// Callback when a region (state/country) is tapped.
  final MapRegionCallback? onRegionTap;

  /// Callback when hovering over a region.
  final MapRegionCallback? onRegionHover;

  /// Custom tooltip builder for location pins.
  final Component Function(MapLocation)? tooltipBuilder;

  /// Style configuration for the map.
  final MapStyle style;

  /// Whether to show tooltips on hover.
  final bool showTooltips;

  /// Optional fixed height (CSS value).
  final String? height;

  /// Set of region codes that are highlighted/active.
  final Set<String> activeRegions;

  /// Enable debug mode to show coordinates on hover.
  final bool debugMode;

  const ArcaneMap({
    this.type = MapType.world,
    this.locations = const [],
    this.onLocationTap,
    this.onLocationHover,
    this.onRegionTap,
    this.onRegionHover,
    this.tooltipBuilder,
    this.style = const MapStyle(),
    this.showTooltips = true,
    this.height,
    this.activeRegions = const {},
    this.debugMode = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final dims = MapProjection.dimensions(type);
    final className =
        type == MapType.world ? 'arcane-world-map' : 'arcane-usa-map';

    return dom.div(
      classes: className,
      attributes: {
        if (debugMode) 'data-debug-mode': 'true',
        'data-map-type': type.name,
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
        if (height != null) 'height': height!,
        'aspect-ratio': '${dims.aspectRatio}',
        'background': style.backgroundColor,
        'border-radius': '8px',
        'overflow': 'hidden',
      }),
      [
        // SVG Map rendered as raw HTML
        dom.RawText(_buildSvgHtml(dims)),
      ],
    );
  }

  String _buildSvgHtml(
      ({double width, double height, String viewBox, double aspectRatio})
          dims) {
    final buffer = StringBuffer();

    // Open SVG tag
    buffer.write('<svg viewBox="${dims.viewBox}" ');
    buffer.write('preserveAspectRatio="xMidYMid meet" ');
    buffer.write('style="width:100%;height:100%;display:block;">');

    // Regions (states/countries)
    buffer.write(_buildRegionsHtml());

    // Location pins with glow filters
    buffer.write(_buildPinsHtml());

    // Close SVG tag
    buffer.write('</svg>');

    return buffer.toString();
  }

  String _buildRegionsHtml() {
    final buffer = StringBuffer();

    if (type == MapType.usa) {
      for (final entry in ArcaneUSAMapPaths.states.entries) {
        final code = entry.key;
        final (name, path) = entry.value;
        final isActive = activeRegions.contains(code);

        buffer.write('<path ');
        buffer.write('d="$path" ');
        buffer.write('data-region="$code" ');
        buffer.write('data-name="$name" ');
        buffer.write('style="');
        buffer.write('fill:${isActive ? style.regionActiveFill : style.regionFill};');
        buffer.write('stroke:${style.regionStroke};');
        buffer.write('stroke-width:${style.strokeWidth};');
        buffer.write('cursor:${onRegionTap != null ? 'pointer' : 'default'};');
        buffer.write('transition:fill 150ms ease;');
        buffer.write('" />');
      }
    } else {
      // World map - paths are stored as alternating [path, code, path, code...]
      const paths = ArcaneWorldMapPaths.allPaths;
      for (var i = 0; i < paths.length - 1; i += 2) {
        final path = paths[i];
        final code = paths[i + 1];
        final isActive = activeRegions.contains(code);

        buffer.write('<path ');
        buffer.write('d="$path" ');
        buffer.write('data-region="$code" ');
        buffer.write('style="');
        buffer.write('fill:${isActive ? style.regionActiveFill : style.regionFill};');
        buffer.write('stroke:${style.regionStroke};');
        buffer.write('stroke-width:${style.strokeWidth};');
        buffer.write('cursor:${onRegionTap != null ? 'pointer' : 'default'};');
        buffer.write('transition:fill 150ms ease;');
        buffer.write('" />');
      }
    }

    return buffer.toString();
  }

  String _buildPinsHtml() {
    if (locations.isEmpty) return '';

    final buffer = StringBuffer();

    // Glow filter definitions
    if (style.pinGlowIntensity > 0) {
      buffer.write('<defs>');
      for (final location in locations) {
        buffer.write('<filter id="glow-${location.id}" ');
        buffer.write('x="-50%" y="-50%" width="200%" height="200%">');
        buffer.write('<feGaussianBlur stdDeviation="${style.pinSize * 0.5}" result="coloredBlur"/>');
        buffer.write('<feMerge>');
        buffer.write('<feMergeNode in="coloredBlur"/>');
        buffer.write('<feMergeNode in="SourceGraphic"/>');
        buffer.write('</feMerge>');
        buffer.write('</filter>');
      }
      buffer.write('</defs>');
    }

    // Pin circles
    for (final location in locations) {
      final (x, y) = MapProjection.getCoordinates(
        type,
        location.id,
        location.latitude,
        location.longitude,
      );

      final color =
          location.isActive ? style.pinActiveColor : style.pinColor;

      buffer.write('<circle ');
      buffer.write('cx="$x" cy="$y" r="${style.pinSize}" ');
      buffer.write('data-location="${location.id}" ');
      if (style.pinGlowIntensity > 0) {
        buffer.write('filter="url(#glow-${location.id})" ');
      }
      buffer.write('style="');
      buffer.write('fill:$color;');
      buffer.write('cursor:${onLocationTap != null ? 'pointer' : 'default'};');
      buffer.write('transition:fill 150ms ease;');
      buffer.write('opacity:${location.isActive ? 1 : 1 - style.pinGlowIntensity * 0.3};');
      buffer.write('" />');
    }

    return buffer.toString();
  }
}
