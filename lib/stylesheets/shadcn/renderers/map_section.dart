import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/map/arcane_map.dart';
import '../../../core/props/map_section_props.dart';

/// ShadCN Map Section renderer - simple fallback implementation.
///
/// This is a basic implementation that can be overridden by Codex
/// with more elaborate styling.
class ShadcnMapSection extends StatelessComponent {
  final MapSectionProps props;

  const ShadcnMapSection(this.props, {super.key});

  String _getRegionColor(String? region) {
    if (region == null) return 'var(--primary)';
    final MapRegionConfig? config = props.regions[region];
    return config?.color ?? 'var(--primary)';
  }

  @override
  Component build(BuildContext context) {
    // Apply region colors to locations
    final List<MapLocation> coloredLocations = props.locations
        .map((MapLocation loc) => loc.copyWith(color: _getRegionColor(loc.region)))
        .toList();

    return dom.section(
      classes: 'arcane-map-section',
      styles: const dom.Styles(raw: {
        'padding': '64px 24px',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
          }),
          [
            // Header
            dom.div(
              styles: const dom.Styles(raw: {
                'text-align': 'center',
                'margin-bottom': '32px',
              }),
              [
                dom.h2(
                  styles: const dom.Styles(raw: {
                    'font-size': '1.75rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                    'margin': '0 0 8px 0',
                  }),
                  [Component.text(props.title)],
                ),
                if (props.subtitle != null)
                  dom.p(
                    styles: const dom.Styles(raw: {
                      'font-size': '1rem',
                      'color': 'var(--muted-foreground)',
                      'margin': '0',
                    }),
                    [Component.text(props.subtitle!)],
                  ),
              ],
            ),
            // Map container
            dom.div(
              styles: dom.Styles(raw: {
                'height': props.height,
                'border-radius': '12px',
                'overflow': 'hidden',
                'background': 'var(--card)',
                'border': '1px solid var(--border)',
              }),
              [
                ArcaneMap(
                  type: MapType.world,
                  style: props.mapStyle,
                  locations: coloredLocations,
                  tooltipBuilder: props.tooltipBuilder,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
