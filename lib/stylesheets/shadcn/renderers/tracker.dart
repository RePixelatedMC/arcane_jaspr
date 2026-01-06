import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tracker_props.dart';

/// ShadCN Tracker renderer.
class ShadcnTracker extends StatelessComponent {
  final TrackerProps props;

  const ShadcnTracker(this.props, {super.key});

  String _getColor(TrackerLevel level) {
    if (props.levelColors != null && props.levelColors!.containsKey(level)) {
      return props.levelColors![level]!;
    }
    return switch (level) {
      TrackerLevel.fine => 'hsl(142 76% 36%)',
      TrackerLevel.warning => 'hsl(38 92% 50%)',
      TrackerLevel.critical => 'var(--destructive)',
      TrackerLevel.unknown => 'var(--muted)',
    };
  }

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-tracker',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1rem',
      }),
      [
        // Grid
        dom.div(
          classes: 'arcane-tracker-grid',
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat(${props.columns}, ${props.cellSize}px)',
            'gap': '${props.gap}px',
          }),
          [
            for (var i = 0; i < props.data.length; i++)
              _buildCell(i, props.data[i]),
          ],
        ),

        // Legend
        if (props.showLegend)
          dom.div(
            classes: 'arcane-tracker-legend',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '1rem',
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
            }),
            [
              dom.span([Component.text('Less')]),
              for (final level in TrackerLevel.values)
                dom.div(
                  styles: dom.Styles(raw: {
                    'width': '${props.cellSize}px',
                    'height': '${props.cellSize}px',
                    'border-radius': '0.125rem',
                    'background': _getColor(level),
                  }),
                  [],
                ),
              dom.span([Component.text('More')]),
            ],
          ),
      ],
    );
  }

  Component _buildCell(int index, TrackerData cellData) {
    final hasTooltip = props.showTooltips && cellData.tooltip != null;

    return dom.div(
      classes: 'arcane-tracker-cell',
      attributes: {
        if (hasTooltip) 'title': cellData.tooltip!,
        'data-level': cellData.level.name,
        'data-index': '$index',
      },
      styles: dom.Styles(raw: {
        'width': '${props.cellSize}px',
        'height': '${props.cellSize}px',
        'border-radius': '0.125rem',
        'background': _getColor(cellData.level),
        'cursor': props.onCellTap != null ? 'pointer' : 'default',
        'transition': 'transform 150ms ease',
      }),
      events: props.onCellTap != null
          ? {'click': (_) => props.onCellTap!(index, cellData)}
          : null,
      [],
    );
  }
}

/// ShadCN Uptime Tracker renderer.
class ShadcnUptimeTracker extends StatelessComponent {
  final UptimeTrackerProps props;

  const ShadcnUptimeTracker(this.props, {super.key});

  String _getBarColor(double uptime) {
    if (uptime >= 99.9) return 'hsl(142 76% 36%)';
    if (uptime >= 99.0) return 'hsl(142 76% 50%)';
    if (uptime >= 95.0) return 'hsl(38 92% 50%)';
    return 'var(--destructive)';
  }

  double _calculateAverageUptime() {
    if (props.days.isEmpty) return 0;
    return props.days.map((d) => d.uptime).reduce((a, b) => a + b) / props.days.length;
  }

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-uptime-tracker',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.5rem',
      }),
      [
        // Bars
        dom.div(
          classes: 'arcane-uptime-bars',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-end',
            'gap': '${props.gap}px',
            'height': '${props.barHeight}px',
          }),
          [
            for (final day in props.days)
              dom.div(
                classes: 'arcane-uptime-bar',
                attributes: {
                  if (props.showPercentage)
                    'title': '${day.date.month}/${day.date.day}: ${day.uptime.toStringAsFixed(2)}%',
                },
                styles: dom.Styles(raw: {
                  'width': '${props.barWidth}px',
                  'height': '${(day.uptime / 100 * props.barHeight).round()}px',
                  'min-height': '2px',
                  'background': _getBarColor(day.uptime),
                  'border-radius': '${props.barWidth / 2}px ${props.barWidth / 2}px 0 0',
                  'transition': 'opacity 150ms ease',
                }),
                [],
              ),
          ],
        ),

        // Percentage summary
        if (props.days.isNotEmpty)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('${props.days.length} days')],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': 'hsl(142 76% 36%)',
                }),
                [
                  Component.text(
                    '${_calculateAverageUptime().toStringAsFixed(2)}% uptime',
                  )
                ],
              ),
            ],
          ),
      ],
    );
  }
}
