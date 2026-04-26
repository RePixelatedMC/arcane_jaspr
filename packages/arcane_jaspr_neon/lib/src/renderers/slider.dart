import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/slider_props.dart';

/// Neon slider renderer with restrained accent treatment.
class NeonSlider extends StatelessComponent {
  final SliderProps props;

  const NeonSlider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double span = (props.max - props.min).abs();
    final double percentage = span == 0
        ? 0
        : ((props.value - props.min) / (props.max - props.min) * 100).clamp(
            0.0,
            100.0,
          );

    final (
      String trackHeight,
      String thumbSize,
      String hitAreaHeight,
    ) = switch (props.size) {
      ComponentSize.sm => ('8px', '18px', '32px'),
      ComponentSize.md => ('10px', '20px', '36px'),
      ComponentSize.lg => ('12px', '24px', '40px'),
    };

    final int thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    final String tone = switch (props.variant) {
      SliderVariant.primary => 'var(--primary)',
      SliderVariant.success => 'var(--success)',
      SliderVariant.warning => 'var(--warning)',
      SliderVariant.error => 'var(--destructive)',
    };

    final String fillGradient =
        'linear-gradient(90deg, color-mix(in srgb, $tone 84%, #0d1110), $tone)';

    return dom.div(
      classes: 'neon-slider ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'data-state': props.disabled ? 'disabled' : 'enabled',
        'data-disabled': '${props.disabled}',
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      },
      styles: dom.Styles(
        raw: {
          'width': '100%',
          'opacity': props.disabled ? '0.5' : '1',
          'pointer-events': props.disabled ? 'none' : 'auto',
        },
      ),
      [
        if (props.label != null || props.showValue)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'justify-content': 'space-between',
                'align-items': 'center',
                'margin-bottom': '0.75rem',
              },
            ),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'color': 'var(--foreground)',
                    },
                  ),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  classes: 'neon-slider-value',
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'font-variant-numeric': 'tabular-nums',
                      'color': 'var(--neon-accent)',
                      'min-width': '52px',
                      'text-align': 'right',
                    },
                  ),
                  [
                    Component.text(
                      '${props.valuePrefix ?? ''}${props.value.toStringAsFixed(props.valueDecimals)}${props.valueSuffix ?? ''}',
                    ),
                  ],
                ),
            ],
          ),
        dom.div(
          classes: 'neon-slider-track-container',
          styles: dom.Styles(
            raw: {
              'position': 'relative',
              'width': '100%',
              'height': hitAreaHeight,
              'display': 'flex',
              'align-items': 'center',
              'cursor': 'pointer',
              'touch-action': 'none',
              'user-select': 'none',
            },
          ),
          [
            dom.div(
              classes: 'neon-slider-track',
              styles: dom.Styles(
                raw: {
                  'position': 'absolute',
                  'left': '0',
                  'right': '0',
                  'height': trackHeight,
                  'background': 'var(--neon-surface-2)',
                  'border': '1px solid var(--border)',
                  'border-radius': '999px',
                  'overflow': 'hidden',
                },
              ),
              [
                dom.div(
                  classes: 'neon-slider-track-fill',
                  styles: dom.Styles(
                    raw: {
                      'position': 'absolute',
                      'left': '0',
                      'top': '0',
                      'width': '$percentage%',
                      'height': '100%',
                      'background': fillGradient,
                      'transition': 'width 0.1s ease-out',
                    },
                  ),
                  [],
                ),
              ],
            ),
            if (props.showSteps && props.step != null)
              _buildStepMarkers(trackHeight, tone),
            dom.div(
              classes: 'neon-slider-thumb',
              attributes: {
                'data-state': props.disabled ? 'disabled' : 'active',
              },
              styles: dom.Styles(
                raw: {
                  'position': 'absolute',
                  'left': 'calc($percentage% - ${thumbSizeNum / 2}px)',
                  'top': '50%',
                  'transform': 'translateY(-50%)',
                  'width': thumbSize,
                  'height': thumbSize,
                  'background': '#f8f8f8',
                  'border': '2px solid $tone',
                  'border-radius': '50%',
                  'box-shadow': '0 4px 14px rgba(0, 0, 0, 0.28)',
                  'transition': 'left 0.1s ease-out',
                  'pointer-events': 'none',
                  'z-index': '2',
                },
              ),
              [],
            ),
            dom.input(
              type: dom.InputType.range,
              classes: 'neon-slider-input',
              attributes: {
                'min': props.min.toString(),
                'max': props.max.toString(),
                'value': props.value.toString(),
                'step': props.step?.toString() ?? 'any',
                'data-state': props.disabled ? 'disabled' : 'active',
                if (props.disabled) 'disabled': 'true',
              },
              styles: const dom.Styles(
                raw: {
                  'position': 'absolute',
                  'width': '100%',
                  'height': '100%',
                  'opacity': '0',
                  'cursor': 'pointer',
                  'margin': '0',
                  'z-index': '3',
                },
              ),
              events: props.onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final dynamic target = e.target;
                        final double? next = double.tryParse(
                          '${target?.value ?? ''}',
                        );
                        if (next != null) {
                          props.onChanged!(next);
                        }
                      },
                    },
            ),
          ],
        ),
        if (props.label == null && !props.showValue)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'justify-content': 'space-between',
                'margin-top': '0.4rem',
              },
            ),
            [
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(props.min.toStringAsFixed(0))],
              ),
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(props.max.toStringAsFixed(0))],
              ),
            ],
          ),
      ],
    );
  }

  Component _buildStepMarkers(String trackHeight, String tone) {
    if (props.step == null || props.step! <= 0) {
      return const dom.div([], styles: dom.Styles(raw: {}));
    }

    final int steps = ((props.max - props.min) / props.step!).floor();
    if (steps > 24) {
      return const dom.div([], styles: dom.Styles(raw: {}));
    }

    return dom.div(
      styles: dom.Styles(
        raw: {
          'position': 'absolute',
          'left': '0',
          'right': '0',
          'height': trackHeight,
          'display': 'flex',
          'justify-content': 'space-between',
          'align-items': 'center',
          'pointer-events': 'none',
        },
      ),
      [
        for (int i = 0; i <= steps; i++)
          dom.div(
            styles: dom.Styles(
              raw: {
                'width': '3px',
                'height': '3px',
                'border-radius': '50%',
                'background':
                    'color-mix(in srgb, $tone 55%, var(--muted-foreground))',
              },
            ),
            [],
          ),
      ],
    );
  }
}
