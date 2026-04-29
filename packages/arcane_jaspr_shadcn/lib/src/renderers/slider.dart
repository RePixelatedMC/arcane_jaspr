import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/slider_props.dart';

/// ShadCN Slider renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/slider
class ShadcnSlider extends StatelessComponent {
  final SliderProps props;

  const ShadcnSlider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String sliderId = props.id ?? 'slider-${identityHashCode(props)}';
    final double effectiveValue = props.isRange ? (props.rangeMin ?? props.min) : props.value;
    final double loValue = props.rangeMin ?? props.min;
    final double hiValue = props.rangeMax ?? props.max;
    final double singleValue = effectiveValue;

    final double percentage =
        ((singleValue - props.min) / (props.max - props.min) * 100).clamp(
          0.0,
          100.0,
        );
    final double loPct =
        ((loValue - props.min) / (props.max - props.min) * 100).clamp(0.0, 100.0);
    final double hiPct =
        ((hiValue - props.min) / (props.max - props.min) * 100).clamp(0.0, 100.0);

    final (
      String trackHeight,
      String thumbSize,
      String hitAreaHeight,
    ) = switch (props.size) {
      ComponentSize.sm => ('6px', '16px', '24px'),
      ComponentSize.md => ('8px', '20px', '32px'), // ShadCN default h-2 (8px)
      ComponentSize.lg => ('10px', '24px', '40px'),
    };

    final int thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    // Get variant colors
    final String fillColor = switch (props.variant) {
      SliderVariant.primary => 'var(--primary)',
      SliderVariant.success => 'var(--success, #22c55e)',
      SliderVariant.warning => 'var(--warning, #f59e0b)',
      SliderVariant.error => 'var(--destructive)',
    };

    final Map<String, String> rootAttrs = sliderAttrs(
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
    );

    return dom.div(
      classes: 'arcane-slider ${props.disabled ? 'disabled' : ''}',
      attributes: rootAttrs,
      styles: dom.Styles(
        raw: {
          'width': '100%',
          'opacity': props.disabled ? '0.5' : '1',
          'pointer-events': props.disabled ? 'none' : 'auto',
        },
      ),
      [
        // Label row
        if (props.label != null || props.showValue)
          dom.div(
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'justify-content': 'space-between',
                'align-items': 'center',
                'margin-bottom': '0.5rem',
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
                  classes: 'arcane-slider-value',
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'font-variant-numeric': 'tabular-nums',
                      'color': 'var(--muted-foreground)',
                      'min-width': '40px',
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
        // Track container with hit area
        // ShadCN: relative flex w-full touch-none select-none items-center
        dom.div(
          classes: 'arcane-slider-track-container',
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
              classes: 'arcane-slider-track',
              styles: dom.Styles(
                raw: {
                  'position': 'absolute',
                  'left': '0',
                  'right': '0',
                  'height': trackHeight,
                  'background-color': 'var(--secondary)',
                  'border-radius': 'var(--radius-full)',
                  'overflow': 'hidden',
                },
              ),
              [
                if (!props.isRange)
                  dom.div(
                    classes: 'arcane-slider-track-fill',
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
                        'background-color': fillColor,
                        'transition': 'width 0.1s ease-out',
                      },
                    ),
                    [],
                  )
                else
                  dom.div(
                    classes: 'arcane-slider-track-fill',
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
                        'background-color': fillColor,
                        'transition': 'left 0.1s ease-out, right 0.1s ease-out',
                      },
                    ),
                    [],
                  ),
              ],
            ),
            if (props.showSteps && props.step != null)
              _buildStepMarkers(trackHeight),
            if (!props.isRange)
              dom.div(
                classes: 'arcane-slider-thumb',
                attributes: <String, String>{
                  'data-arcane-slider-thumb': 'value',
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
                    'background-color': 'var(--background)',
                    'border': '2px solid $fillColor',
                    'border-radius': 'var(--radius-full)',
                    'transition':
                        'left 0.1s ease-out, color var(--transition), transform var(--transition), box-shadow var(--transition)',
                    'z-index': '2',
                    'cursor': props.disabled ? 'not-allowed' : 'grab',
                  },
                ),
                [],
              )
            else ...[
              dom.div(
                classes: 'arcane-slider-thumb',
                attributes: <String, String>{
                  'data-arcane-slider-thumb': 'lo',
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
                    'background-color': 'var(--background)',
                    'border': '2px solid $fillColor',
                    'border-radius': 'var(--radius-full)',
                    'transition':
                        'left 0.1s ease-out, color var(--transition), transform var(--transition), box-shadow var(--transition)',
                    'z-index': '2',
                    'cursor': props.disabled ? 'not-allowed' : 'grab',
                  },
                ),
                [],
              ),
              dom.div(
                classes: 'arcane-slider-thumb',
                attributes: <String, String>{
                  'data-arcane-slider-thumb': 'hi',
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
                    'background-color': 'var(--background)',
                    'border': '2px solid $fillColor',
                    'border-radius': 'var(--radius-full)',
                    'transition':
                        'left 0.1s ease-out, color var(--transition), transform var(--transition), box-shadow var(--transition)',
                    'z-index': '2',
                    'cursor': props.disabled ? 'not-allowed' : 'grab',
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
                'margin-top': '0.25rem',
              },
            ),
            [
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(props.min.toStringAsFixed(0))],
              ),
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-xs)',
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

  Component _buildStepMarkers(String trackHeight) {
    if (props.step == null || props.step! <= 0) {
      return const dom.div([], styles: dom.Styles(raw: {}));
    }

    final int steps = ((props.max - props.min) / props.step!).floor();
    if (steps > 20) {
      return const dom.div([], styles: dom.Styles(raw: {})); // Too many steps
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
        for (var i = 0; i <= steps; i++)
          const dom.div(
            styles: dom.Styles(
              raw: {
                'width': '2px',
                'height': '2px',
                'background': 'var(--muted-foreground)',
                'border-radius': 'var(--radius-full)',
              },
            ),
            [],
          ),
      ],
    );
  }
}
