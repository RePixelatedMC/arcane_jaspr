import '../../../arcane_jaspr.dart' hide Key, Factory, Target, Import, Contrast, SpellCheck, TextWrap;

/// An interactive, themeable SVG world map component.
///
/// Displays location markers with hover tooltips and click callbacks.
/// Fully themeable via CSS variables.
///
/// ```dart
/// ArcaneWorldMap(
///   locations: [
///     ArcaneMapLocation(
///       id: 'nyc',
///       name: 'New York',
///       latitude: 40.7128,
///       longitude: -74.0060,
///       code: 'NYC',
///       region: 'North America',
///     ),
///   ],
///   onLocationTap: (location) => print('Tapped ${location.name}'),
///   tooltipBuilder: (location) => MyCustomTooltip(location),
/// )
/// ```
class ArcaneWorldMap extends StatefulComponent {
  /// List of locations to display as pins.
  final List<ArcaneMapLocation> locations;

  /// Callback when a location pin is clicked.
  final MapLocationCallback? onLocationTap;

  /// Callback when a location pin is hovered.
  final MapLocationCallback? onLocationHover;

  /// Custom tooltip builder (overrides default tooltip).
  final Component Function(ArcaneMapLocation location)? tooltipBuilder;

  /// Map style configuration.
  final ArcaneWorldMapStyle style;

  /// Whether to show tooltips on hover.
  final bool showTooltips;

  /// Custom height (width auto-calculates from aspect ratio).
  final String? height;

  /// Optional CSS class name.
  final String? className;

  /// Aspect ratio (width:height), default matches the SVG viewBox.
  final double aspectRatio;

  const ArcaneWorldMap({
    required this.locations,
    this.onLocationTap,
    this.onLocationHover,
    this.tooltipBuilder,
    this.style = const ArcaneWorldMapStyle(),
    this.showTooltips = true,
    this.height,
    this.className,
    this.aspectRatio = 2.33, // 2000/857 from the SVG viewBox
    super.key,
  });

  @override
  State<ArcaneWorldMap> createState() => _ArcaneWorldMapState();

  @css
  static final List<StyleRule> styles = [
    // Pin hover effects - use filter only, no transform to avoid SVG origin issues
    css('.arcane-map-pin').styles(raw: {
      'cursor': 'pointer',
      'transition': 'filter 150ms ease, opacity 150ms ease',
    }),
    css('.arcane-map-pin:hover').styles(raw: {
      'filter': 'drop-shadow(0 0 8px var(--arcane-accent)) brightness(1.2)',
    }),

    // Tooltip container
    css('.arcane-map-tooltip').styles(raw: {
      'position': 'absolute',
      'z-index': ArcaneZIndex.tooltip,
      'pointer-events': 'none',
      'opacity': '0',
      'visibility': 'hidden',
      'transition': 'opacity 150ms ease, visibility 150ms ease',
    }),

    // Show tooltip when visible
    css('.arcane-map-tooltip.visible').styles(raw: {
      'opacity': '1',
      'visibility': 'visible',
    }),
  ];
}

class _ArcaneWorldMapState extends State<ArcaneWorldMap> {
  ArcaneMapLocation? _hoveredLocation;

  void _handlePinEnter(ArcaneMapLocation location) {
    setState(() => _hoveredLocation = location);
    component.onLocationHover?.call(location);
  }

  void _handlePinLeave() {
    setState(() => _hoveredLocation = null);
  }

  void _handlePinTap(ArcaneMapLocation location) {
    component.onLocationTap?.call(location);
  }

  @override
  Component build(BuildContext context) {
    final style = component.style;

    // Default colors using theme tokens
    final landFill = style.landFill ?? ArcaneColors.surfaceVariant;
    final landStroke = style.landStroke ?? ArcaneColors.border;
    final oceanFill = style.oceanFill ?? ArcaneColors.background;

    // Use a wrapper with inline style for aspect-ratio since ArcaneStyleData
    // doesn't have built-in aspectRatio support yet
    return Component.element(
      tag: 'div',
      classes: 'arcane-world-map ${component.className ?? ""}',
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%',
        if (component.height != null) 'height': component.height!,
        'aspect-ratio': '${component.aspectRatio}',
        'overflow': 'visible',
      }),
      children: [
        // SVG Map
        ArcaneSvg(
          viewBox: ArcaneMapProjection.viewBox,
          attributes: {
            'preserveAspectRatio': 'xMidYMid meet',
            'style': 'width: 100%; height: 100%; display: block;',
          },
          children: [
            // Defs for gradients and filters
            _buildDefs(),

            // Background (ocean)
            ArcaneSvgRect(
              x: '0',
              y: '0',
              width: '${ArcaneMapProjection.mapWidth}',
              height: '${ArcaneMapProjection.mapHeight}',
              fill: oceanFill,
            ),

            // Country/continent paths
            ...ArcaneWorldMapPaths.allPaths.map(
              (svgPath) => ArcaneSvgPath(
                d: svgPath,
                fill: landFill,
                stroke: landStroke,
                strokeWidth: style.strokeWidth,
              ),
            ),

            // Location pins
            ...component.locations.map((location) => _buildPin(location)),
          ],
        ),

        // Floating tooltip
        if (_hoveredLocation != null && component.showTooltips)
          _buildTooltip(_hoveredLocation!),
      ],
    );
  }

  Component _buildDefs() {
    return Component.element(
      tag: 'defs',
      children: [
        // Glow filter for pins
        Component.element(
          tag: 'filter',
          attributes: const {
            'id': 'arcane-pin-glow',
            'x': '-50%',
            'y': '-50%',
            'width': '200%',
            'height': '200%',
          },
          children: [
            Component.element(
              tag: 'feGaussianBlur',
              attributes: const {
                'stdDeviation': '3',
                'result': 'coloredBlur',
              },
              children: const [],
            ),
            Component.element(
              tag: 'feMerge',
              children: [
                Component.element(
                  tag: 'feMergeNode',
                  attributes: const {'in': 'coloredBlur'},
                  children: const [],
                ),
                Component.element(
                  tag: 'feMergeNode',
                  attributes: const {'in': 'SourceGraphic'},
                  children: const [],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildPin(ArcaneMapLocation location) {
    // Use pre-calculated SVG coordinates if available, otherwise convert lat/lng
    final (double x, double y) = ArcaneMapProjection.citySvgCoords[location.id] ??
        ArcaneMapProjection.latLngToSvg(location.latitude, location.longitude);

    final style = component.style;
    final isHovered = _hoveredLocation?.id == location.id;

    // Determine pin color based on state
    final String pinColor;
    if (location.isActive) {
      pinColor = style.pinActiveColor ?? ArcaneColors.success;
    } else if (isHovered) {
      pinColor = style.pinHoverColor ?? ArcaneColors.accentHover;
    } else {
      pinColor = style.pinColor ?? ArcaneColors.accent;
    }

    final pinSize = style.pinSize;
    final glowAlpha = style.pinGlowIntensity;

    return Component.element(
      tag: 'g',
      classes: 'arcane-map-pin',
      attributes: {
        'data-location-id': location.id,
        'data-location-name': location.name,
        'transform': 'translate($x, $y)',
      },
      events: {
        'mouseenter': (_) => _handlePinEnter(location),
        'mouseleave': (_) => _handlePinLeave(),
        'click': (_) => _handlePinTap(location),
      },
      children: [
        // Outer glow
        ArcaneSvgCircle(
          cx: '0',
          cy: '0',
          r: '${pinSize + 4}',
          fill: 'rgba(var(--arcane-accent-rgb), $glowAlpha)',
        ),

        // Main pin
        ArcaneSvgCircle(
          cx: '0',
          cy: '0',
          r: '$pinSize',
          fill: pinColor,
        ),

        // Inner highlight
        ArcaneSvgCircle(
          cx: '0',
          cy: '0',
          r: '${pinSize * 0.35}',
          fill: 'rgba(255, 255, 255, 0.9)',
        ),
      ],
    );
  }

  Component _buildTooltip(ArcaneMapLocation location) {
    // Use pre-calculated SVG coordinates if available, otherwise convert lat/lng
    final (double x, double y) = ArcaneMapProjection.citySvgCoords[location.id] ??
        ArcaneMapProjection.latLngToSvg(location.latitude, location.longitude);

    // Convert SVG coordinates to percentage for positioning
    final leftPercent = (x / ArcaneMapProjection.mapWidth) * 100;
    final topPercent = (y / ArcaneMapProjection.mapHeight) * 100;

    // Custom tooltip or default
    final tooltipContent = component.tooltipBuilder?.call(location) ??
        _buildDefaultTooltip(location);

    return ArcaneDiv(
      classes: 'arcane-map-tooltip visible',
      styles: ArcaneStyleData(
        position: Position.absolute,
        left: '$leftPercent%',
        top: 'calc($topPercent% - 10px)',
        transformCustom: 'translateX(-50%) translateY(-100%)',
        zIndex: ZIndex.tooltip,
      ),
      children: [tooltipContent],
    );
  }

  Component _buildDefaultTooltip(ArcaneMapLocation location) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        background: Background.surface,
        border: BorderPreset.subtle,
        borderRadius: Radius.lg,
        shadow: Shadow.lg,
        padding: PaddingPreset.md,
        minWidth: '160px',
        maxWidthCustom: '240px',
      ),
      children: [
        // Location name
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.md,
            fontWeight: FontWeight.w600,
            textColor: TextColor.primary,
            margin: MarginPreset.bottomXs,
          ),
          children: [Component.text(location.name)],
        ),

        // Region
        if (location.region != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.bottomSm,
            ),
            children: [Component.text(location.region!)],
          ),

        // Code badge
        if (location.code != null)
          ArcaneSpan(
            styles: const ArcaneStyleData(
              display: Display.inlineBlock,
              padding: PaddingPreset.xsSm,
              background: Background.surfaceVariant,
              borderRadius: Radius.sm,
              fontSize: FontSize.xs,
              fontFamily: FontFamily.mono,
              textColor: TextColor.brand,
            ),
            child: Component.text(location.code!),
          ),

        // Description
        if (location.description != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.topSm,
              lineHeight: LineHeight.relaxed,
            ),
            children: [Component.text(location.description!)],
          ),
      ],
    );
  }
}
