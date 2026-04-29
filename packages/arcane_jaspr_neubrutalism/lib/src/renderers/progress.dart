import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/progress_props.dart';

/// Neubrutalism Progress Bar renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger track heights (1.25x)
/// - Accent-colored indicator with subtle glow
/// - Larger border radius
class NeubrutalismProgress extends StatelessComponent {
  final ProgressProps props;

  const NeubrutalismProgress(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double clampedValue = props.value.clamp(0.0, 1.0);
    final double percentage = clampedValue * 100;

    final String trackHeight = switch (props.size) {
      ComponentSize.small => '8px',
      ComponentSize.medium => '12px',
      ComponentSize.large => '16px',
    };

    final String indicatorColor = switch (props.variant) {
      ProgressVariant.primary =>
        props.indicatorColor ?? 'var(--nb-accent, var(--primary))',
      ProgressVariant.success => props.indicatorColor ?? 'var(--success)',
      ProgressVariant.warning => props.indicatorColor ?? 'var(--warning)',
      ProgressVariant.error => props.indicatorColor ?? 'var(--destructive)',
      ProgressVariant.info => props.indicatorColor ?? 'var(--info)',
    };

    return dom.div(
      classes: 'neubrutalism-progress',
      styles: const dom.Styles(raw: <String, String>{'width': '100%'}),
      <Component>[
        dom.div(
          classes: 'neubrutalism-progress-track',
          styles: dom.Styles(
            raw: <String, String>{
              'position': 'relative',
              'width': '100%',
              'height': trackHeight,
              'background-color':
                  props.trackColor ?? 'var(--nb-paper, var(--card))',
              'border':
                  'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
              'border-radius': '9999px',
              'overflow': 'hidden',
              'box-shadow':
                  'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
            },
          ),
          <Component>[
            if (props.indeterminate)
              dom.div(
                classes:
                    'neubrutalism-progress-indicator neubrutalism-progress-fill indeterminate',
                styles: dom.Styles(
                  raw: <String, String>{
                    'position': 'absolute',
                    'top': '0',
                    'left': '0',
                    'height': '100%',
                    'width': '40%',
                    'background-color': indicatorColor,
                    'border-right':
                        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                    'animation':
                        'neubrutalism-progress-indeterminate 1.5s ease-in-out infinite',
                  },
                ),
                const <Component>[],
              )
            else
              dom.div(
                classes:
                    'neubrutalism-progress-indicator neubrutalism-progress-fill',
                styles: dom.Styles(
                  raw: <String, String>{
                    'position': 'absolute',
                    'top': '0',
                    'left': '0',
                    'height': '100%',
                    'width': '$percentage%',
                    'background-color': indicatorColor,
                    'border-right': percentage < 100
                        ? 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)'
                        : 'none',
                    'transition': 'width var(--nb-transition, 120ms ease)',
                  },
                ),
                const <Component>[],
              ),
          ],
        ),

        if (props.showValue)
          dom.div(
            classes: 'neubrutalism-progress-value',
            styles: const dom.Styles(
              raw: <String, String>{
                'margin-top': '0.5rem',
                'font-family': 'var(--font-heading)',
                'font-size': 'var(--font-size-xs)',
                'font-weight': '800',
                'color': 'var(--foreground)',
                'text-align': 'right',
                'font-variant-numeric': 'tabular-nums',
                'letter-spacing': '0.04em',
              },
            ),
            <Component>[Component.text('${percentage.toStringAsFixed(0)}%')],
          ),
      ],
    );
  }
}

class NeubrutalismCircularProgress extends StatelessComponent {
  final CircularProgressProps props;

  const NeubrutalismCircularProgress(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double clampedValue = props.value.clamp(0.0, 1.0);
    final int percentage = (clampedValue * 100).round();

    final String size = props.size ?? '64px';
    final String strokeWidth = props.strokeWidth ?? '8px';
    final String fillColor =
        props.fillColor ?? 'var(--nb-accent, var(--primary))';
    final String trackColor =
        props.trackColor ?? 'var(--nb-paper-soft, var(--card))';

    return dom.div(
      classes: 'neubrutalism-circular-progress',
      attributes: <String, String>{
        'role': 'progressbar',
        'aria-valuemin': '0',
        'aria-valuemax': '100',
        'aria-valuenow': '$percentage',
      },
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': size,
          'height': size,
        },
      ),
      <Component>[
        dom.div(
          styles: dom.Styles(
            raw: <String, String>{
              'position': 'absolute',
              'width': '100%',
              'height': '100%',
              'border-radius': '9999px',
              'background':
                  'conic-gradient($fillColor 0deg ${clampedValue * 360}deg, $trackColor ${clampedValue * 360}deg 360deg)',
              'mask':
                  'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
              '-webkit-mask':
                  'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
              'transition': 'background var(--nb-transition, 120ms ease)',
            },
          ),
          const <Component>[],
        ),

        if (props.showPercentage || props.label != null)
          dom.div(
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'justify-content': 'center',
              },
            ),
            <Component>[
              if (props.showPercentage)
                dom.span(
                  styles: const dom.Styles(
                    raw: <String, String>{
                      'font-family': 'var(--font-heading)',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': '900',
                      'color': 'var(--foreground)',
                      'font-variant-numeric': 'tabular-nums',
                      'letter-spacing': '0.02em',
                    },
                  ),
                  <Component>[Component.text('$percentage%')],
                ),
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: <String, String>{
                      'font-family': 'var(--font-heading)',
                      'font-size': '0.625rem',
                      'font-weight': '700',
                      'color': 'var(--foreground)',
                      'margin-top': '0.125rem',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.06em',
                    },
                  ),
                  <Component>[Component.text(props.label!)],
                ),
            ],
          ),
      ],
    );
  }
}

class NeubrutalismLoadingSpinner extends StatelessComponent {
  final LoadingSpinnerProps props;

  const NeubrutalismLoadingSpinner(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String size = props.size ?? '24px';
    final String color = props.color ?? 'var(--nb-accent, var(--primary))';

    return dom.span(
      classes: 'neubrutalism-loading-spinner',
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-block',
          'width': size,
          'height': size,
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-right-color': color,
          'border-radius': '9999px',
          'animation': 'arcane-spin 0.75s linear infinite',
          'box-sizing': 'border-box',
        },
      ),
      const <Component>[],
    );
  }
}
