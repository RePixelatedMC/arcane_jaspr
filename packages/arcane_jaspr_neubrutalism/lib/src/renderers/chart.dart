import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/chart_props.dart';

class NeubrutalismChart extends StatelessComponent {
  final ChartProps props;

  const NeubrutalismChart(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final num maxValue = props.points.isEmpty
        ? 1
        : props.points
              .map((ChartPointProps point) => point.value)
              .reduce((num a, num b) => a > b ? a : b);

    return dom.div(
      classes: 'neubrutalism-chart',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.875rem',
          'padding': '1.25rem',
          'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'background': 'var(--nb-paper, var(--card))',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
        },
      ),
      [
        if (props.title != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-family': 'var(--font-heading)',
                'font-size': 'var(--font-size-md)',
                'font-weight': 'var(--font-weight-semibold)',
                'letter-spacing': '0.04em',
                'color': 'var(--card-foreground)',
              },
            ),
            [Component.text(props.title!)],
          ),
        if (props.description != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
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
                'gap': '0.625rem',
              },
            ),
            [
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'width': '5rem',
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(point.label)],
              ),
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'height': '14px',
                    'flex': '1',
                    'background': 'var(--nb-paper-soft, var(--card))',
                    'border':
                        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
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
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': 'var(--font-weight-medium)',
                    'font-variant-numeric': 'tabular-nums',
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
