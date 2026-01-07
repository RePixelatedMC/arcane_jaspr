import 'package:web/web.dart' as web;

import '../../../arcane_jaspr.dart' hide Key, Factory, Target, Import, Contrast, SpellCheck, TextWrap;

/// An interactive, themeable SVG USA map component.
class ArcaneUSAMap extends StatefulComponent {
  final List<ArcaneUSAMapLocation> locations;
  final USAMapLocationCallback? onLocationTap;
  final USAMapLocationCallback? onLocationHover;
  final USAMapStateCallback? onStateTap;
  final USAMapStateCallback? onStateHover;
  final Component Function(ArcaneUSAMapLocation location)? tooltipBuilder;
  final ArcaneUSAMapStyle style;
  final bool showTooltips;
  final String? height;
  final String? className;
  final double aspectRatio;
  final Set<String> activeStates;
  final bool showStateBorders;
  final bool debugMode;

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
    this.aspectRatio = 1.70,
    this.activeStates = const {},
    this.showStateBorders = true,
    this.debugMode = false,
    super.key,
  });

  @override
  State<ArcaneUSAMap> createState() => _ArcaneUSAMapState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-usa-map-state').styles(raw: {
      'cursor': 'pointer',
      'transition': 'fill 150ms ease, filter 150ms ease',
    }),
    css('.arcane-usa-map-state:hover').styles(raw: {
      'filter': 'brightness(1.2)',
    }),
    css('.arcane-usa-map-pin').styles(raw: {
      'cursor': 'pointer',
      'transition': 'filter 150ms ease, opacity 150ms ease',
    }),
    css('.arcane-usa-map-pin:hover').styles(raw: {
      'filter': 'drop-shadow(0 0 8px var(--arcane-primary)) brightness(1.2)',
    }),
    css('.arcane-usa-map-tooltip').styles(raw: {
      'position': 'absolute',
      'z-index': '1070',
      'pointer-events': 'none',
      'opacity': '0',
      'visibility': 'hidden',
      'transition': 'opacity 150ms ease, visibility 150ms ease',
    }),
    css('.arcane-usa-map-tooltip.visible').styles(raw: {
      'opacity': '1',
      'visibility': 'visible',
    }),
  ];
}

class _ArcaneUSAMapState extends State<ArcaneUSAMap> {
  ArcaneUSAMapLocation? _hoveredLocation;
  String? _hoveredState;
  double? _debugSvgX;
  double? _debugSvgY;

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

  void _handleDebugMouseMove(web.MouseEvent mouseEvent) {
    if (!component.debugMode) return;

    final target = mouseEvent.currentTarget as web.Element;
    final rect = target.getBoundingClientRect();
    final svgWidth = rect.width;
    final svgHeight = rect.height;

    final relX = (mouseEvent.clientX - rect.left) / svgWidth;
    final relY = (mouseEvent.clientY - rect.top) / svgHeight;

    final svgX = relX * ArcaneUSAMapProjection.mapWidth;
    final svgY = relY * ArcaneUSAMapProjection.mapHeight;

    setState(() {
      _debugSvgX = svgX;
      _debugSvgY = svgY;
    });
  }

  void _handleDebugMouseLeave() {
    if (!component.debugMode) return;
    setState(() {
      _debugSvgX = null;
      _debugSvgY = null;
    });
  }

  void _handleDebugClick() {
    if (!component.debugMode || _debugSvgX == null || _debugSvgY == null) return;

    final (lat, lng) = ArcaneUSAMapProjection.svgToLatLng(_debugSvgX!, _debugSvgY!);
    final coordText = '${lat.toStringAsFixed(4)}, ${lng.toStringAsFixed(4)}';

    web.window.navigator.clipboard.writeText(coordText);
  }

  @override
  Component build(BuildContext context) {
    final style = component.style;

    final stateFill = style.stateFill ?? 'var(--muted)';
    final stateStroke = style.stateStroke ?? 'var(--border)';
    final backgroundFill = style.backgroundFill ?? 'var(--background)';

    return Component.element(
      tag: 'div',
      classes: 'arcane-usa-map ${component.className ?? ""}',
      styles: Styles(raw: {
        'position': 'relative',
        'width': '100%',
        if (component.height != null) 'height': component.height!,
        'aspect-ratio': '${component.aspectRatio}',
        'overflow': 'visible',
        if (component.debugMode) 'cursor': 'crosshair',
      }),
      events: component.debugMode
          ? {
              'mousemove': (event) =>
                  _handleDebugMouseMove(event as web.MouseEvent),
              'mouseleave': (_) => _handleDebugMouseLeave(),
              'click': (_) => _handleDebugClick(),
            }
          : null,
      children: [
        ArcaneSvg(
          viewBox: ArcaneUSAMapProjection.viewBox,
          attributes: {
            'preserveAspectRatio': 'xMidYMid meet',
            'style': 'width: 100%; height: 100%; display: block;',
          },
          children: [
            ArcaneSvgRect(
              x: '0',
              y: '0',
              width: '${ArcaneUSAMapProjection.mapWidth}',
              height: '${ArcaneUSAMapProjection.mapHeight}',
              fill: backgroundFill,
            ),
            ...ArcaneUSAMapPaths.states.entries.map((entry) {
              final stateCode = entry.key;
              final (_, path) = entry.value;
              final isHovered = _hoveredState == stateCode;
              final isActive = component.activeStates.contains(stateCode);

              String fill;
              if (isActive) {
                fill = style.stateActiveFill ?? 'var(--primary)';
              } else if (isHovered) {
                fill = style.stateHoverFill ?? 'hsl(var(--foreground) / 0.08)';
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
            ...component.locations.map((location) => _buildPin(location)),
          ],
        ),
        if (_hoveredLocation != null && component.showTooltips)
          _buildTooltip(_hoveredLocation!),
        if (component.debugMode && _debugSvgX != null && _debugSvgY != null)
          _buildDebugTooltip(),
      ],
    );
  }

  Component _buildDebugTooltip() {
    final (lat, lng) = ArcaneUSAMapProjection.svgToLatLng(_debugSvgX!, _debugSvgY!);

    final leftPercent = (_debugSvgX! / ArcaneUSAMapProjection.mapWidth) * 100;
    final topPercent = (_debugSvgY! / ArcaneUSAMapProjection.mapHeight) * 100;

    return ArcaneDiv(
      classes: 'arcane-usa-map-debug-tooltip',
      styles: ArcaneStyleData(
        position: Position.absolute,
        left: '$leftPercent%',
        top: 'calc($topPercent% + 15px)',
        transformCustom: 'translateX(-50%)',
        zIndex: ZIndex.tooltip,
        pointerEvents: PointerEvents.none,
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            background: Background.surface,
            border: BorderPreset.subtle,
            borderRadius: Radius.md,
            shadow: Shadow.md,
            padding: PaddingPreset.sm,
          ),
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                fontFamily: FontFamily.mono,
                textColor: TextColor.primary,
                whiteSpace: WhiteSpace.nowrap,
              ),
              children: [
                Component.text('Lat: ${lat.toStringAsFixed(4)}'),
              ],
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                fontFamily: FontFamily.mono,
                textColor: TextColor.primary,
                whiteSpace: WhiteSpace.nowrap,
              ),
              children: [
                Component.text('Lng: ${lng.toStringAsFixed(4)}'),
              ],
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                fontFamily: FontFamily.mono,
                textColor: TextColor.mutedForeground,
                whiteSpace: WhiteSpace.nowrap,
                margin: MarginPreset.topXs,
              ),
              children: [
                Component.text('SVG: ${_debugSvgX!.toInt()}, ${_debugSvgY!.toInt()}'),
              ],
            ),
            ArcaneDiv(
              styles: const ArcaneStyleData(
                fontSize: FontSize.xs,
                textColor: TextColor.brand,
                margin: MarginPreset.topXs,
              ),
              children: [
                Component.text('Click to copy'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildPin(ArcaneUSAMapLocation location) {
    final (double x, double y) = ArcaneUSAMapProjection.citySvgCoords[location.id] ??
        ArcaneUSAMapProjection.latLngToSvg(location.latitude, location.longitude);

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

  Component _buildTooltip(ArcaneUSAMapLocation location) {
    final (double x, double y) = ArcaneUSAMapProjection.citySvgCoords[location.id] ??
        ArcaneUSAMapProjection.latLngToSvg(location.latitude, location.longitude);

    final leftPercent = (x / ArcaneUSAMapProjection.mapWidth) * 100;
    final topPercent = (y / ArcaneUSAMapProjection.mapHeight) * 100;

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
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.md,
            fontWeight: FontWeight.w600,
            textColor: TextColor.primary,
            margin: MarginPreset.bottomXs,
          ),
          children: [Component.text(location.name)],
        ),
        if (location.state != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.bottomSm,
            ),
            children: [
              Component.text(
                ArcaneUSAMapProjection.stateNames[location.state] ?? location.state!,
              ),
            ],
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
