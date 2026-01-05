import '../../../arcane_jaspr.dart' hide Key, Factory, Target, Import, Contrast, SpellCheck, TextWrap;

/// An interactive, themeable SVG USA map component.
///
/// Displays location markers with hover tooltips and click callbacks.
/// Supports state highlighting and selection.
///
/// ```dart
/// ArcaneUSAMap(
///   locations: [
///     ArcaneUSAMapLocation(
///       id: 'nyc',
///       name: 'New York City',
///       latitude: 40.7128,
///       longitude: -74.0060,
///       code: 'NYC',
///       state: 'NY',
///     ),
///   ],
///   onLocationTap: (location) => print('Tapped ${location.name}'),
///   onStateTap: (stateCode) => print('Tapped $stateCode'),
/// )
/// ```
class ArcaneUSAMap extends StatefulComponent {
  /// List of locations to display as pins.
  final List<ArcaneUSAMapLocation> locations;

  /// Callback when a location pin is clicked.
  final USAMapLocationCallback? onLocationTap;

  /// Callback when a location pin is hovered.
  final USAMapLocationCallback? onLocationHover;

  /// Callback when a state is clicked.
  final USAMapStateCallback? onStateTap;

  /// Callback when a state is hovered.
  final USAMapStateCallback? onStateHover;

  /// Custom tooltip builder (overrides default tooltip).
  final Component Function(ArcaneUSAMapLocation location)? tooltipBuilder;

  /// Map style configuration.
  final ArcaneUSAMapStyle style;

  /// Whether to show tooltips on hover.
  final bool showTooltips;

  /// Custom height (width auto-calculates from aspect ratio).
  final String? height;

  /// Optional CSS class name.
  final String? className;

  /// Aspect ratio (width:height), default matches the SVG viewBox.
  final double aspectRatio;

  /// Set of highlighted/active state codes.
  final Set<String> activeStates;

  /// Whether to show state borders.
  final bool showStateBorders;

  const ArcaneUSAMap({
    this.locations = const [],
    this.onLocationTap,
    this.onLocationHover,
    this.onStateTap,
    this.onStateHover,
    this.tooltipBuilder,
    this.style = const ArcaneUSAMapStyle(),
    this.showTooltips = true,
    this.height,
    this.className,
    this.aspectRatio = 1.70, // 1000/589 from the SVG viewBox
    this.activeStates = const {},
    this.showStateBorders = true,
    super.key,
  });

  @override
  State<ArcaneUSAMap> createState() => _ArcaneUSAMapState();

  @css
  static final List<StyleRule> styles = [
    // State hover effects
    css('.arcane-usa-map-state').styles(raw: {
      'cursor': 'pointer',
      'transition': 'fill 150ms ease, filter 150ms ease',
    }),
    css('.arcane-usa-map-state:hover').styles(raw: {
      'filter': 'brightness(1.2)',
    }),

    // Pin hover effects
    css('.arcane-usa-map-pin').styles(raw: {
      'cursor': 'pointer',
      'transition': 'transform 150ms ease, filter 150ms ease',
    }),
    css('.arcane-usa-map-pin:hover').styles(raw: {
      'transform': 'scale(1.3)',
      'filter': 'drop-shadow(0 0 6px ${ArcaneColors.accent})',
    }),

    // Pulse animation keyframes
    css('@keyframes arcane-usa-map-pulse').styles(raw: {
      '0%': 'opacity: 1; r: 6',
      '100%': 'opacity: 0; r: 18',
    }),

    // Tooltip container
    css('.arcane-usa-map-tooltip').styles(raw: {
      'position': 'absolute',
      'z-index': ArcaneZIndex.tooltip,
      'pointer-events': 'none',
      'opacity': '0',
      'visibility': 'hidden',
      'transition': 'opacity 150ms ease, visibility 150ms ease',
    }),

    // Show tooltip when visible
    css('.arcane-usa-map-tooltip.visible').styles(raw: {
      'opacity': '1',
      'visibility': 'visible',
    }),
  ];
}

class _ArcaneUSAMapState extends State<ArcaneUSAMap> {
  ArcaneUSAMapLocation? _hoveredLocation;
  String? _hoveredState;

  void _handlePinEnter(ArcaneUSAMapLocation location) {
    setState(() => _hoveredLocation = location);
    component.onLocationHover?.call(location);
  }

  void _handlePinLeave() {
    setState(() => _hoveredLocation = null);
  }

  void _handlePinTap(ArcaneUSAMapLocation location) {
    component.onLocationTap?.call(location);
  }

  void _handleStateEnter(String stateCode) {
    setState(() => _hoveredState = stateCode);
    component.onStateHover?.call(stateCode);
  }

  void _handleStateLeave() {
    setState(() => _hoveredState = null);
  }

  void _handleStateTap(String stateCode) {
    component.onStateTap?.call(stateCode);
  }

  @override
  Component build(BuildContext context) {
    final style = component.style;

    // Default colors using theme tokens
    final stateFill = style.stateFill ?? ArcaneColors.surfaceVariant;
    final stateStroke = style.stateStroke ?? ArcaneColors.border;
    final backgroundFill = style.backgroundFill ?? ArcaneColors.background;

    return Component.element(
      tag: 'div',
      classes: 'arcane-usa-map ${component.className ?? ""}',
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
          viewBox: ArcaneUSAMapProjection.viewBox,
          attributes: {
            'preserveAspectRatio': 'xMidYMid meet',
            'style': 'width: 100%; height: 100%; display: block;',
          },
          children: [
            // Background
            ArcaneSvgRect(
              x: '0',
              y: '0',
              width: '${ArcaneUSAMapProjection.mapWidth}',
              height: '${ArcaneUSAMapProjection.mapHeight}',
              fill: backgroundFill,
            ),

            // State paths
            ...ArcaneUSAMapPaths.states.entries.map((entry) {
              final stateCode = entry.key;
              final (_, path) = entry.value;
              final isHovered = _hoveredState == stateCode;
              final isActive = component.activeStates.contains(stateCode);

              String fill;
              if (isActive) {
                fill = style.stateActiveFill ?? ArcaneColors.accent;
              } else if (isHovered) {
                fill = style.stateHoverFill ?? ArcaneColors.onSurfaceAlpha08;
              } else {
                fill = stateFill;
              }

              return Component.element(
                tag: 'path',
                classes: 'arcane-usa-map-state',
                attributes: {
                  'd': path,
                  'fill': fill,
                  if (component.showStateBorders) 'stroke': stateStroke,
                  if (component.showStateBorders) 'stroke-width': style.strokeWidth,
                  'data-state': stateCode,
                },
                events: {
                  'mouseenter': (_) => _handleStateEnter(stateCode),
                  'mouseleave': (_) => _handleStateLeave(),
                  'click': (_) => _handleStateTap(stateCode),
                },
                children: const [],
              );
            }),

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

  Component _buildPin(ArcaneUSAMapLocation location) {
    final (x, y) = ArcaneUSAMapProjection.latLngToSvg(
      location.latitude,
      location.longitude,
    );

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
      classes: 'arcane-usa-map-pin',
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

  Component _buildTooltip(ArcaneUSAMapLocation location) {
    final (x, y) = ArcaneUSAMapProjection.latLngToSvg(
      location.latitude,
      location.longitude,
    );

    // Convert SVG coordinates to percentage for positioning
    final leftPercent = (x / ArcaneUSAMapProjection.mapWidth) * 100;
    final topPercent = (y / ArcaneUSAMapProjection.mapHeight) * 100;

    // Custom tooltip or default
    final tooltipContent = component.tooltipBuilder?.call(location) ??
        _buildDefaultTooltip(location);

    return ArcaneDiv(
      classes: 'arcane-usa-map-tooltip visible',
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

  Component _buildDefaultTooltip(ArcaneUSAMapLocation location) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        background: Background.surface,
        border: BorderPreset.subtle,
        borderRadius: Radius.lg,
        shadow: Shadow.lg,
        padding: PaddingPreset.md,
        minWidth: '140px',
        maxWidthCustom: '220px',
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

        // State
        if (location.state != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.bottomSm,
            ),
            children: [
              Component.text(
                ArcaneUSAMapProjection.stateNames[location.state] ?? location.state!,
              ),
            ],
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
