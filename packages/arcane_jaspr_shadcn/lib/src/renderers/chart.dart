import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/chart_props.dart';

class ShadcnChart extends StatelessComponent {
  final ChartProps props;

  const ShadcnChart(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final num maxValue = props.points.isEmpty
        ? 1
        : props.points
              .map((ChartPointProps point) => point.value)
              .reduce((num a, num b) => a > b ? a : b);

    return dom.div(
      classes: 'arcane-chart',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.75rem',
          'padding': '1rem',
          'border': '1px solid var(--border)',
          'border-radius': '0.75rem',
          'background': 'var(--card)',
        },
      ),
      [
        if (props.title != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': '1rem',
                'font-weight': '600',
                'color': 'var(--card-foreground)',
              },
            ),
            [Component.text(props.title!)],
          ),
        if (props.description != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': '0.875rem',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(props.description!)],
          ),
        for (final ChartPointProps point in props.points)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.5rem',
              },
            ),
            [
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'width': '5rem',
                    'font-size': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(point.label)],
              ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'height': '0.5rem',
                    'flex': '1',
                    'border-radius': '9999px',
                    'background':
                        'color-mix(in srgb, var(--foreground) 12%, transparent)',
                    'overflow': 'hidden',
                  },
                ),
                [
                  dom.div(
                    styles: dom.Styles(
                      raw: {
                        'height': '100%',
                        'width':
                            '${((point.value / maxValue) * 100).toStringAsFixed(2)}%',
                        'background': props.color,
                      },
                    ),
                    const [],
                  ),
                ],
              ),
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': '0.75rem',
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                  },
                ),
                [Component.text(point.value.toString())],
              ),
            ],
          ),
      ],
    );
  }
}
