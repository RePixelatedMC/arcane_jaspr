import '../../../arcane_jaspr.dart' hide Key, Factory, Target, Import, Contrast, SpellCheck, TextWrap;

/// An interactive, themeable SVG world map component.
class ArcaneWorldMap extends StatefulComponent {
  final List<ArcaneMapLocation> locations;
  final MapLocationCallback? onLocationTap;
  final MapLocationCallback? onLocationHover;
  final Component Function(ArcaneMapLocation location)? tooltipBuilder;
  final ArcaneWorldMapStyle style;
  final bool showTooltips;
  final String? height;
  final String? className;
  final double aspectRatio;
  final bool debugMode;

  const ArcaneWorldMap({
    required this.locations,
    this.onLocationTap,
    this.onLocationHover,
    this.tooltipBuilder,
    this.style = const ArcaneWorldMapStyle(),
    this.showTooltips = true,
    this.height,
    this.className,
    this.aspectRatio = 2.33,
    this.debugMode = false,
    super.key,
  });

  @override
  State<ArcaneWorldMap> createState() => _ArcaneWorldMapState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-map-pin').styles(raw: {
      'cursor': 'pointer',
      'transition': 'filter 150ms ease, opacity 150ms ease',
    }),
    css('.arcane-map-pin:hover').styles(raw: {
      'filter': 'drop-shadow(0 0 8px var(--arcane-primary)) brightness(1.2)',
    }),
    css('.arcane-map-tooltip').styles(raw: {
      'position': 'absolute',
      'z-index': '1070',
      'pointer-events': 'none',
      'opacity': '0',
      'visibility': 'hidden',
      'transition': 'opacity 150ms ease, visibility 150ms ease',
    }),
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

    final landFill = style.landFill ?? 'var(--muted)';
    final landStroke = style.landStroke ?? 'var(--border)';
    final oceanFill = style.oceanFill ?? 'var(--background)';

    return Component.element(
      tag: 'div',
      classes: 'arcane-world-map ${component.className ?? ""}',
      attributes: {
        if (component.debugMode) 'data-debug-mode': 'true',
      },
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%',
        if (component.height != null) 'height': component.height!,
        'aspect-ratio': '${component.aspectRatio}',
        'overflow': 'visible',
      }),
      children: [
        ArcaneSvg(
          viewBox: ArcaneMapProjection.viewBox,
          attributes: {
            'preserveAspectRatio': 'xMidYMid meet',
            'style': 'width: 100%; height: 100%; display: block;',
          },
          children: [
            _buildDefs(),
            ArcaneSvgRect(
              x: '0',
              y: '0',
              width: '${ArcaneMapProjection.mapWidth}',
              height: '${ArcaneMapProjection.mapHeight}',
              fill: oceanFill,
            ),
            ...ArcaneWorldMapPaths.allPaths.map(
              (svgPath) => ArcaneSvgPath(
                d: svgPath,
                fill: landFill,
                stroke: landStroke,
                strokeWidth: style.strokeWidth,
              ),
            ),
            ...component.locations.map((location) => _buildPin(location)),
          ],
        ),
        if (_hoveredLocation != null && component.showTooltips)
          _buildTooltip(_hoveredLocation!),
        // Debug tooltip is rendered by JavaScript fallback script
      ],
    );
  }

  Component _buildDefs() {
    return const Component.element(
      tag: 'defs',
      children: [
        Component.element(
          tag: 'filter',
          attributes: {
            'id': 'arcane-pin-glow',
            'x': '-50%',
            'y': '-50%',
            'width': '200%',
            'height': '200%',
          },
          children: [
            Component.element(
              tag: 'feGaussianBlur',
              attributes: {
                'stdDeviation': '3',
                'result': 'coloredBlur',
              },
              children: [],
            ),
            Component.element(
              tag: 'feMerge',
              children: [
                Component.element(
                  tag: 'feMergeNode',
                  attributes: {'in': 'coloredBlur'},
                  children: [],
                ),
                Component.element(
                  tag: 'feMergeNode',
                  attributes: {'in': 'SourceGraphic'},
                  children: [],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildPin(ArcaneMapLocation location) {
    final (double x, double y) = ArcaneMapProjection.citySvgCoords[location.id] ??
        ArcaneMapProjection.latLngToSvg(location.latitude, location.longitude);

    final style = component.style;
    final isHovered = _hoveredLocation?.id == location.id;

    final String pinColor;
    if (location.isActive) {
      pinColor = style.pinActiveColor ?? 'var(--success)';
    } else if (isHovered) {
      pinColor = style.pinHoverColor ?? 'var(--ring)';
    } else {
      pinColor = style.pinColor ?? 'var(--primary)';
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
        ArcaneSvgCircle(
          cx: '0',
          cy: '0',
          r: '${pinSize + 4}',
          fill: 'rgba(var(--arcane-primary-rgb), $glowAlpha)',
        ),
        ArcaneSvgCircle(
          cx: '0',
          cy: '0',
          r: '$pinSize',
          fill: pinColor,
        ),
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
    final (double x, double y) = ArcaneMapProjection.citySvgCoords[location.id] ??
        ArcaneMapProjection.latLngToSvg(location.latitude, location.longitude);

    final leftPercent = (x / ArcaneMapProjection.mapWidth) * 100;
    final topPercent = (y / ArcaneMapProjection.mapHeight) * 100;

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
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.md,
            fontWeight: FontWeight.w600,
            textColor: TextColor.primary,
            margin: MarginPreset.bottomXs,
          ),
          children: [Component.text(location.name)],
        ),
        if (location.region != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.bottomSm,
            ),
            children: [Component.text(location.region!)],
          ),
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
        if (location.description != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.topSm,
              lineHeight: LineHeight.relaxed,
            ),
            children: [Component.text(location.description!)],
          ),
      ],
    );
  }
}
