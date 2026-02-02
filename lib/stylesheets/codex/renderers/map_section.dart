import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/layout/tabs.dart';
import '../../../component/view/map/arcane_map.dart';
import '../../../component/view/slot_counter.dart';
import '../../../core/props/map_section_props.dart';
import '../../../util/design_tokens.dart';
import '../../../util/style_types/arcane_color.dart';

/// Codex Map Section renderer.
///
/// Implements the Codex design language:
/// - OLED-optimized dark background with accent glows
/// - Location list panel with region grouping
/// - Gradient accent bars
/// - Interactive tooltips with ping display
class CodexMapSection extends StatelessComponent {
  final MapSectionProps props;

  const CodexMapSection(this.props, {super.key});

  String _getRegionColor(String? region) {
    if (region == null) return 'var(--primary)';
    final MapRegionConfig? config = props.regions[region];
    return config?.color ?? 'var(--primary)';
  }

  @override
  Component build(BuildContext context) {
    return dom.section(
      classes: 'codex-map-section',
      styles: const dom.Styles(raw: {
        'padding': '80px 24px',
        'background': 'transparent',
      }),
      [
        dom.div(
          classes: 'codex-map-section-container',
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
          }),
          [
            // Section Header
            dom.div(
              classes: 'codex-map-section-header',
              styles: const dom.Styles(raw: {
                'text-align': 'center',
                'margin-bottom': '48px',
              }),
              [
                dom.h2(
                  styles: const dom.Styles(raw: {
                    'font-size': '2rem',
                    'font-weight': '700',
                    'color': 'var(--foreground)',
                    'margin': '0 0 16px 0',
                  }),
                  [Component.text(props.title)],
                ),
                if (props.subtitle != null)
                  dom.p(
                    styles: const dom.Styles(raw: {
                      'font-size': '1.125rem',
                      'color': 'var(--muted-foreground)',
                      'margin': '0',
                    }),
                    [Component.text(props.subtitle!)],
                  ),
              ],
            ),

            // Map Tabs
            if (props.showMapTabs)
              _buildMapTabs()
            else
              _buildMapContent(MapType.world, props.locations),
          ],
        ),
      ],
    );
  }

  Component _buildMapTabs() {
    final List<MapLocation> naLocations = props.locations
        .where((MapLocation loc) => loc.region == 'North America')
        .toList();

    return dom.div(
      classes: 'codex-map-tabs',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'center',
      }),
      [
        ArcaneTabs(
          tabs: [
            ArcaneTabItem(
              label: 'World',
              content: _buildMapContent(MapType.world, props.locations),
            ),
            ArcaneTabItem(
              label: 'USA',
              content: _buildMapContent(MapType.usa, naLocations),
            ),
          ],
        ),
      ],
    );
  }

  Component _buildMapContent(MapType mapType, List<MapLocation> locations) {
    // Apply region colors to locations
    final List<MapLocation> coloredLocations = locations
        .map((MapLocation loc) => loc.copyWith(color: _getRegionColor(loc.region)))
        .toList();

    return dom.div(
      classes: 'codex-map-content',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': '24px',
        'align-items': 'stretch',
        'justify-content': 'center',
        'max-width': '1100px',
        'margin': '24px auto 0 auto',
      }),
      [
        // Location List Panel
        if (props.showLocationPanel) _buildLocationPanel(locations),

        // Map Container
        dom.div(
          classes: 'codex-map-container',
          styles: dom.Styles(raw: {
            'flex-grow': '1',
            'width': '70%',
            'height': props.height,
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'position': 'relative',
                'overflow': 'hidden',
                'border-radius': '16px',
                'height': '100%',
                'background': 'var(--card)',
                'border': '1px solid color-mix(in srgb, var(--foreground) 8%, transparent)',
              }),
              [
                // Top accent bar
                dom.div(
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'top': '0',
                    'left': '0',
                    'right': '0',
                    'height': '3px',
                    'background': 'linear-gradient(90deg, var(--primary), color-mix(in srgb, ${ArcaneColor.neonPurple.css} 40%, transparent))',
                    'pointer-events': 'none',
                    'z-index': '10',
                  }),
                  [],
                ),
                // Top-right glow
                const dom.div(
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'top': '-100px',
                    'right': '-100px',
                    'width': '300px',
                    'height': '300px',
                    'border-radius': '50%',
                    'background': 'radial-gradient(circle, color-mix(in srgb, var(--primary) 12%, transparent) 0%, transparent 70%)',
                    'pointer-events': 'none',
                  }),
                  [],
                ),
                // Bottom-left glow
                dom.div(
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'bottom': '-80px',
                    'left': '-80px',
                    'width': '250px',
                    'height': '250px',
                    'border-radius': '50%',
                    'background': 'radial-gradient(circle, color-mix(in srgb, ${ArcaneColor.neonPurple.css} 8%, transparent) 0%, transparent 70%)',
                    'pointer-events': 'none',
                  }),
                  [],
                ),
                // Map
                dom.div(
                  styles: const dom.Styles(raw: {
                    'padding': '24px',
                    'position': 'relative',
                    'height': '100%',
                    'display': 'flex',
                    'flex-direction': 'column',
                    'justify-content': 'center',
                    'box-sizing': 'border-box',
                  }),
                  [
                    ArcaneMap(
                      type: mapType,
                      style: props.mapStyle,
                      locations: coloredLocations,
                      tooltipBuilder: props.tooltipBuilder ?? _buildDefaultTooltip,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildLocationPanel(List<MapLocation> locations) {
    // Group by region
    final Map<String, List<MapLocation>> byRegion = <String, List<MapLocation>>{};
    for (final MapLocation loc in locations) {
      final String region = loc.region ?? 'Other';
      byRegion.putIfAbsent(region, () => <MapLocation>[]).add(loc);
    }

    return dom.div(
      classes: 'codex-map-location-panel',
      styles: dom.Styles(raw: {
        'width': '280px',
        'flex-shrink': '0',
        'position': 'relative',
        'overflow': 'hidden',
        'border-radius': '16px',
        'height': props.height,
        'background': 'linear-gradient(180deg, color-mix(in srgb, var(--primary) 10%, transparent) 0%, color-mix(in srgb, ${ArcaneColor.neonPurple.css} 5%, transparent) 100%)',
        'padding': '1px',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'background': 'var(--card)',
            'border-radius': '16px',
            'height': '100%',
            'overflow': 'hidden',
            'display': 'flex',
            'flex-direction': 'column',
          }),
          [
            // Panel Header
            dom.div(
              styles: const dom.Styles(raw: {
                'position': 'relative',
                'padding': '24px',
                'border-bottom': '1px solid color-mix(in srgb, var(--foreground) 6%, transparent)',
              }),
              [
                // Top accent bar
                dom.div(
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'top': '0',
                    'left': '0',
                    'right': '0',
                    'height': '3px',
                    'background': 'linear-gradient(90deg, var(--primary), color-mix(in srgb, ${ArcaneColor.neonPurple.css} 40%, transparent))',
                  }),
                  [],
                ),
                dom.div(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'gap': '8px',
                  }),
                  [
                    const dom.div(
                      styles: dom.Styles(raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'width': '32px',
                        'height': '32px',
                        'border-radius': '8px',
                        'background': 'color-mix(in srgb, var(--primary) 15%, transparent)',
                        'border': '1px solid color-mix(in srgb, var(--primary) 30%, transparent)',
                        'color': 'var(--primary)',
                        'font-size': '1rem',
                      }),
                      [Component.text('\u{1F310}')], // Globe icon
                    ),
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'font-size': '0.875rem',
                        'font-weight': '600',
                        'color': 'var(--foreground)',
                      }),
                      [Component.text(props.locationPanelTitle)],
                    ),
                  ],
                ),
              ],
            ),
            // Location List
            dom.div(
              styles: const dom.Styles(raw: {
                'flex-grow': '1',
                'overflow': 'auto',
                'padding': '16px',
              }),
              [
                for (final String region in byRegion.keys) ...[
                  // Region Header
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '8px',
                      'padding': '12px 8px 8px 8px',
                    }),
                    [
                      dom.div(
                        styles: dom.Styles(raw: {
                          'width': '6px',
                          'height': '6px',
                          'border-radius': '50%',
                          'background': _getRegionColor(region),
                          'box-shadow': '0 0 6px ${_getRegionColor(region)}60',
                        }),
                        [],
                      ),
                      dom.span(
                        styles: const dom.Styles(raw: {
                          'font-size': '0.75rem',
                          'font-weight': '600',
                          'color': 'var(--muted-foreground)',
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                        }),
                        [Component.text(region)],
                      ),
                    ],
                  ),
                  // Location Items
                  for (final MapLocation loc in byRegion[region]!)
                    _buildLocationItem(loc, _getRegionColor(region)),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildLocationItem(MapLocation location, String accentColor) {
    return dom.div(
      classes: 'codex-map-location-item',
      attributes: {
        'data-location': location.id,
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'stretch',
        'position': 'relative',
        'overflow': 'hidden',
        'border-radius': '8px',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
        'margin-bottom': '4px',
        'background': 'color-mix(in srgb, var(--foreground) 2%, transparent)',
      }),
      [
        // Accent Bar
        dom.div(
          classes: 'codex-map-location-accent',
          styles: dom.Styles(raw: {
            'width': '3px',
            'background': accentColor,
            'opacity': '0',
            'transition': 'opacity 150ms ease',
            'flex-shrink': '0',
          }),
          [],
        ),
        // Content
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '8px',
            'flex-grow': '1',
            'padding': '8px 12px',
          }),
          [
            // Status dot
            dom.div(
              styles: dom.Styles(raw: {
                'width': '8px',
                'height': '8px',
                'border-radius': '50%',
                'background': accentColor,
                'box-shadow': '0 0 6px ${accentColor}80',
                'flex-shrink': '0',
              }),
              [],
            ),
            // Name
            dom.span(
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--foreground)',
                'flex-grow': '1',
              }),
              [Component.text(location.name)],
            ),
            // Code badge
            if (location.code != null)
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'font-family': 'ui-monospace, monospace',
                  'color': accentColor,
                  'background': '${accentColor}15',
                  'border-radius': '4px',
                  'padding': '2px 6px',
                }),
                [Component.text(location.code!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildDefaultTooltip(MapLocation location) {
    final String accentColor = _getRegionColor(location.region);

    return dom.div(
      classes: 'codex-map-tooltip-content',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'overflow': 'hidden',
        'border-radius': '12px',
        'min-width': '200px',
        'background': 'linear-gradient(135deg, color-mix(in srgb, var(--primary) 20%, transparent) 0%, color-mix(in srgb, ${ArcaneColor.neonPurple.css} 15%, transparent) 100%)',
        'padding': '1px',
        'box-shadow': '0 4px 20px rgba(0, 0, 0, 0.3), 0 0 20px color-mix(in srgb, var(--primary) 10%, transparent)',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'background': 'var(--card)',
            'border-radius': '12px',
            'padding': '16px',
            'position': 'relative',
          }),
          [
            // Top accent bar
            dom.div(
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'top': '0',
                'left': '0',
                'right': '0',
                'height': '2px',
                'background': 'linear-gradient(90deg, var(--primary), color-mix(in srgb, ${ArcaneColor.neonPurple.css} 40%, transparent))',
              }),
              [],
            ),
            // Header Row
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'justify-content': 'space-between',
                'align-items': 'center',
                'margin-bottom': '8px',
              }),
              [
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(location.name)],
                ),
                if (location.code != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.75rem',
                      'font-family': 'ui-monospace, monospace',
                      'color': 'var(--primary)',
                      'background': 'color-mix(in srgb, var(--primary) 15%, transparent)',
                      'border-radius': '4px',
                      'padding': '2px 8px',
                    }),
                    [Component.text(location.code!)],
                  ),
              ],
            ),
            // Region
            if (location.region != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                  'margin-bottom': '8px',
                }),
                [Component.text(location.region!)],
              ),
            // Ping display with animated counter
            const dom.div(
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '8px',
                'padding': '8px 12px',
                'border-radius': '8px',
                'background': 'color-mix(in srgb, var(--primary) 10%, transparent)',
                'border': '1px solid color-mix(in srgb, var(--primary) 20%, transparent)',
              }),
              [
                dom.div(
                  styles: dom.Styles(raw: {
                    'width': '6px',
                    'height': '6px',
                    'border-radius': '50%',
                    'background': ArcaneColors.success,
                    'box-shadow': '0 0 6px ${ArcaneColors.success}',
                  }),
                  [],
                ),
                dom.span(
                  styles: dom.Styles(raw: {
                    'font-size': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text('Ping')],
                ),
                // Animated ping value
                ArcaneSlotCounter(
                  minValue: 5,
                  maxValue: 35,
                  suffix: 'ms',
                  valueSize: SlotCounterSize.sm,
                  valueColor: SlotCounterColor.accent,
                  basePauseSeconds: 1,
                  randomPauseSeconds: 2,
                  spinDurationMs: 500,
                  spinIntervalMs: 25,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}