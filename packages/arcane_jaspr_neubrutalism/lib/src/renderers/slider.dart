import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/slider_props.dart';

/// Neubrutalism slider renderer with restrained accent treatment.
class NeubrutalismSlider extends StatelessComponent {
  final SliderProps props;

  const NeubrutalismSlider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String sliderId = props.id ?? 'slider-${identityHashCode(props)}';
    final double loValue = props.rangeMin ?? props.min;
    final double hiValue = props.rangeMax ?? props.max;
    final double singleValue = props.isRange ? loValue : props.value;
    final double span = (props.max - props.min).abs();
    final double percentage = span == 0
        ? 0
        : ((singleValue - props.min) / (props.max - props.min) * 100).clamp(
            0.0,
            100.0,
          );
    final double loPct = span == 0
        ? 0
        : ((loValue - props.min) / (props.max - props.min) * 100)
            .clamp(0.0, 100.0);
    final double hiPct = span == 0
        ? 0
        : ((hiValue - props.min) / (props.max - props.min) * 100)
            .clamp(0.0, 100.0);

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
      SliderVariant.primary => 'var(--nb-accent, var(--primary))',
      SliderVariant.success => 'var(--success)',
      SliderVariant.warning => 'var(--warning)',
      SliderVariant.error => 'var(--destructive)',
    };

    final String fillBackground = tone;

    final Map<String, String> rootAttrs = <String, String>{
      ...sliderAttrs(
        sliderId: sliderId,
        min: props.min,
        max: props.max,
        value: props.isRange ? null : props.value,
        lo: props.isRange ? loValue : null,
        hi: props.isRange ? hiValue : null,
        step: props.step,
        range: props.isRange,
        disabled: props.disabled,
        changeAction: props.onChangeAction == null
            ? null
            : encodeArcaneAction(props.onChangeAction!),
      ),
      'data-state': props.disabled ? 'disabled' : 'enabled',
      'data-disabled': '${props.disabled}',
      'data-variant': props.variant.name,
      'data-size': props.size.name,
    };

    return dom.div(
      classes: 'neubrutalism-slider ${props.disabled ? 'disabled' : ''}',
      attributes: rootAttrs,
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
                      'font-family': 'var(--font-heading)',
                      'font-size': '0.75rem',
                      'font-weight': '600',
                      'letter-spacing': '0.08em',
                      'text-transform': 'uppercase',
                      'color': 'var(--muted-foreground)',
                    },
                  ),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  classes: 'neubrutalism-slider-value',
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'font-variant-numeric': 'tabular-nums',
                      'color': 'var(--nb-accent, var(--primary))',
                      'min-width': '52px',
                      'text-align': 'right',
                    },
                  ),
                  [
                    Component.text(
                      '${props.valuePrefix ?? ''}${(props.isRange ? loValue : props.value).toStringAsFixed(props.valueDecimals)}${props.valueSuffix ?? ''}',
                    ),
                  ],
                ),
            ],
          ),
        dom.div(
          classes: 'neubrutalism-slider-track-container',
          attributes: const <String, String>{'data-arcane-slider-track': ''},
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
              classes: 'neubrutalism-slider-track',
              styles: dom.Styles(
                raw: {
                  'position': 'absolute',
                  'left': '0',
                  'right': '0',
                  'height': trackHeight,
                  'background': 'var(--nb-paper, var(--card))',
                  'border':
                      'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
                  'border-radius': '999px',
                  'overflow': 'hidden',
                  'box-shadow':
                      'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
                },
              ),
              [
                if (!props.isRange)
                  dom.div(
                    classes: 'neubrutalism-slider-track-fill',
                    attributes: const <String, String>{
                      'data-arcane-slider-fill': '',
                    },
                    styles: dom.Styles(
                      raw: {
                        'position': 'absolute',
                        'left': '0',
                        'top': '0',
                        'width': '$percentage%',
                        'height': '100%',
                        'background': fillBackground,
                        'border-right':
                            'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                        'transition': 'width 0.1s ease-out',
                      },
                    ),
                    [],
                  )
                else
                  dom.div(
                    classes: 'neubrutalism-slider-track-fill',
                    attributes: const <String, String>{
                      'data-arcane-slider-fill': '',
                    },
                    styles: dom.Styles(
                      raw: {
                        'position': 'absolute',
                        'left': '$loPct%',
                        'right': '${100 - hiPct}%',
                        'top': '0',
                        'height': '100%',
                        'background': fillBackground,
                        'transition':
                            'left 0.1s ease-out, right 0.1s ease-out',
                      },
                    ),
                    [],
                  ),
              ],
            ),
            if (props.showSteps && props.step != null)
              _buildStepMarkers(trackHeight, tone),
            if (!props.isRange)
              dom.div(
                classes: 'neubrutalism-slider-thumb',
                attributes: <String, String>{
                  'data-arcane-slider-thumb': 'value',
                  'data-state': props.disabled ? 'disabled' : 'active',
                  'role': 'slider',
                  'tabindex': props.disabled ? '-1' : '0',
                  'aria-valuemin': props.min.toString(),
                  'aria-valuemax': props.max.toString(),
                  'aria-valuenow': props.value.toString(),
                  if (props.label != null) 'aria-label': props.label!,
                },
                styles: dom.Styles(
                  raw: {
                    'position': 'absolute',
                    'left': 'calc($percentage% - ${thumbSizeNum / 2}px)',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': thumbSize,
                    'height': thumbSize,
                    'background': 'var(--nb-accent, var(--primary))',
                    'border':
                        'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
                    'border-radius': '0',
                    'box-shadow':
                        'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
                    'transition': 'left 0.1s ease-out',
                    'cursor': props.disabled ? 'not-allowed' : 'grab',
                    'z-index': '2',
                  },
                ),
                [],
              )
            else ...[
              dom.div(
                classes: 'neubrutalism-slider-thumb',
                attributes: <String, String>{
                  'data-arcane-slider-thumb': 'lo',
                  'data-state': props.disabled ? 'disabled' : 'active',
                  'role': 'slider',
                  'tabindex': props.disabled ? '-1' : '0',
                  'aria-valuemin': props.min.toString(),
                  'aria-valuemax': props.max.toString(),
                  'aria-valuenow': loValue.toString(),
                  'aria-label': props.label != null ? '${props.label} minimum' : 'Minimum',
                },
                styles: dom.Styles(
                  raw: {
                    'position': 'absolute',
                    'left': 'calc($loPct% - ${thumbSizeNum / 2}px)',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': thumbSize,
                    'height': thumbSize,
                    'background': 'var(--nb-accent, var(--primary))',
                    'border':
                        'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
                    'border-radius': '0',
                    'box-shadow':
                        'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
                    'transition': 'left 0.1s ease-out',
                    'cursor': props.disabled ? 'not-allowed' : 'grab',
                    'z-index': '2',
                  },
                ),
                [],
              ),
              dom.div(
                classes: 'neubrutalism-slider-thumb',
                attributes: <String, String>{
                  'data-arcane-slider-thumb': 'hi',
                  'data-state': props.disabled ? 'disabled' : 'active',
                  'role': 'slider',
                  'tabindex': props.disabled ? '-1' : '0',
                  'aria-valuemin': props.min.toString(),
                  'aria-valuemax': props.max.toString(),
                  'aria-valuenow': hiValue.toString(),
                  'aria-label': props.label != null ? '${props.label} maximum' : 'Maximum',
                },
                styles: dom.Styles(
                  raw: {
                    'position': 'absolute',
                    'left': 'calc($hiPct% - ${thumbSizeNum / 2}px)',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': thumbSize,
                    'height': thumbSize,
                    'background': 'var(--nb-accent, var(--primary))',
                    'border':
                        'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
                    'border-radius': '0',
                    'box-shadow':
                        'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
                    'transition': 'left 0.1s ease-out',
                    'cursor': props.disabled ? 'not-allowed' : 'grab',
                    'z-index': '2',
                  },
                ),
                [],
              ),
            ],
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
                    'font-variant-numeric': 'tabular-nums',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(props.min.toStringAsFixed(0))],
              ),
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-variant-numeric': 'tabular-nums',
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
                'width': '4px',
                'height': '4px',
                'background': 'var(--nb-line, #000)',
              },
            ),
            [],
          ),
      ],
    );
  }
}
