import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'map_data.dart';
import 'map_projection.dart';
import 'map_style.dart';

export 'map_data.dart';
export 'map_projection.dart';
export 'map_style.dart';

/// Unified map component supporting both world and USA maps.
///
/// Renders an SVG map image with location pins overlaid on top.
/// The SVG should be served from /assets/map/world.svg or /assets/map/us.svg.
class ArcaneMap extends StatelessComponent {
  /// The type of map to display.
  final MapType type;

  /// Location pins to display on the map.
  final List<MapLocation> locations;

  /// Callback when a location pin is tapped.
  final MapLocationCallback? onLocationTap;

  /// Callback when hovering over a location pin.
  final MapLocationCallback? onLocationHover;

  /// Custom tooltip builder for location pins.
  final Component Function(MapLocation)? tooltipBuilder;

  /// Style configuration for the map.
  final MapStyle style;

  /// Whether to show tooltips on hover.
  final bool showTooltips;

  /// Optional fixed height (CSS value).
  final String? height;

  /// Enable debug mode to show coordinates on hover.
  final bool debugMode;

  /// Custom SVG URL (overrides default asset path).
  final String? svgUrl;

  const ArcaneMap({
    this.type = MapType.world,
    this.locations = const [],
    this.onLocationTap,
    this.onLocationHover,
    this.tooltipBuilder,
    this.style = const MapStyle(),
    this.showTooltips = true,
    this.height,
    this.debugMode = false,
    this.svgUrl,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final dims = MapProjection.dimensions(type);
    final className =
        type == MapType.world ? 'arcane-world-map' : 'arcane-usa-map';
    final mapUrl =
        svgUrl ?? (type == MapType.world ? '/assets/map/world.svg' : '/assets/map/us.svg');

    // Use aspect-ratio container to ensure pins align with SVG
    return dom.div(
      classes: className,
      attributes: {
        if (debugMode) 'data-debug-mode': 'true',
        'data-map-type': type.name,
        if (showTooltips && tooltipBuilder != null) 'data-has-tooltips': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'center',
        'align-items': 'center',
        'width': '100%',
        if (height != null) 'height': height!,
        'max-height': '80vh',
        'overflow': 'visible',
      }),
      [
        // Inner container with aspect ratio matching the SVG
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'max-width': '100%',
            'aspect-ratio': '${dims.aspectRatio}',
            'max-height': '100%',
            'overflow': 'visible',
          }),
          [
            // SVG Map as image - fills the aspect-ratio container
            dom.img(
              src: mapUrl,
              attributes: {'alt': 'Map'},
              styles: dom.Styles(raw: {
                'width': '100%',
                'height': '100%',
                'display': 'block',
                'border-radius': '8px',
              }),
            ),
            // Location pins as overlays - positioned relative to this container
            for (final location in locations) _buildPin(location, dims),
            // Tooltip containers (if tooltipBuilder is provided)
            if (showTooltips && tooltipBuilder != null)
              for (final location in locations) _buildTooltipWrapper(location, dims),
          ],
        ),
      ],
    );
  }

  Component _buildPin(
    MapLocation location,
    ({double width, double height, String viewBox, double aspectRatio}) dims,
  ) {
    final (x, y) = MapProjection.getCoordinates(
      type,
      location.id,
      location.latitude,
      location.longitude,
    );

    // Calculate percentage position
    final leftPct = (x / dims.width) * 100;
    final topPct = (y / dims.height) * 100;
    // Use location's custom color if provided, otherwise fall back to style
    final color = location.color ??
        (location.isActive ? style.pinActiveColor : style.pinColor);
    final size = style.pinSize * 2; // Double for HTML rendering

    return dom.div(
      classes: 'arcane-map-pin',
      attributes: {
        'data-location': location.id,
      },
      styles: dom.Styles(raw: {
        'position': 'absolute',
        'left': '${leftPct.toStringAsFixed(2)}%',
        'top': '${topPct.toStringAsFixed(2)}%',
        'width': '${size}px',
        'height': '${size}px',
        'background': color,
        'border-radius': '50%',
        'transform': 'translate(-50%, -50%)',
        'cursor': onLocationTap != null ? 'pointer' : 'default',
        'transition': 'transform 150ms ease, box-shadow 150ms ease',
        'box-shadow': style.pinGlowIntensity > 0
            ? '0 0 ${size}px ${(size * 0.5).toInt()}px ${color}40'
            : 'none',
        'z-index': '10',
      }),
      [],
    );
  }

  Component _buildTooltipWrapper(
    MapLocation location,
    ({double width, double height, String viewBox, double aspectRatio}) dims,
  ) {
    final (x, y) = MapProjection.getCoordinates(
      type,
      location.id,
      location.latitude,
      location.longitude,
    );

    // Calculate percentage position for absolute positioning
    final leftPct = (x / dims.width) * 100;
    final topPct = (y / dims.height) * 100;

    return dom.div(
      classes: 'arcane-map-tooltip',
      attributes: {
        'data-for-location': location.id,
      },
      styles: dom.Styles(raw: {
        'position': 'absolute',
        'left': '${leftPct.toStringAsFixed(2)}%',
        'top': '${topPct.toStringAsFixed(2)}%',
        'transform': 'translate(-50%, -100%) translateY(-16px)',
        'z-index': '100',
        'pointer-events': 'none',
        'opacity': '0',
        'visibility': 'hidden',
        'transition': 'opacity 150ms ease, visibility 150ms ease',
      }),
      [tooltipBuilder!(location)],
    );
  }
}
