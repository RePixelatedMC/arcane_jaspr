import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

// Re-export for backwards compatibility
export '../../core/props/slider_props.dart' show SliderSize, SliderVariant;

import '../../core/props/slider_props.dart';
import '../../core/theme_provider.dart';

/// Range slider input component matching shadcn/ui design.
///
/// The actual rendering is delegated to the current stylesheet's renderer,
/// ensuring consistent API regardless of which design system is active.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneSlider(
///   value: 50,
///   onChanged: (v) => setState(() => value = v),
/// )
/// ```
///
/// ## With Label and Value Display
///
/// ```dart
/// ArcaneSlider(
///   value: 75,
///   label: 'Volume',
///   showValue: true,
///   valueSuffix: '%',
///   onChanged: (v) => setState(() => volume = v),
/// )
/// ```
///
/// ## Variants
///
/// ```dart
/// ArcaneSlider.primary(value: 50, label: 'Primary')
/// ArcaneSlider.success(value: 50, label: 'Success')
/// ```
class ArcaneSlider extends StatelessComponent {
  /// Current value
  final double value;

  /// Minimum value
  final double min;

  /// Maximum value
  final double max;

  /// Step increment (null for continuous)
  final double? step;

  /// Label text displayed above the slider
  final String? label;

  /// Whether to show the current value
  final bool showValue;

  /// Prefix for the value display (e.g., "$")
  final String? valuePrefix;

  /// Suffix for the value display (e.g., "%")
  final String? valueSuffix;

  /// Number of decimal places for value display
  final int valueDecimals;

  /// Color variant
  final SliderVariant variant;

  /// Size variant
  final SliderSize size;

  /// Whether to show step markers on the track
  final bool showSteps;

  /// Whether the slider is disabled
  final bool disabled;

  /// Callback when value changes
  final void Function(double)? onChanged;

  const ArcaneSlider({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.variant = SliderVariant.primary,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  });

  /// Primary styled slider
  const ArcaneSlider.primary({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  }) : variant = SliderVariant.primary;

  /// Success styled slider
  const ArcaneSlider.success({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  }) : variant = SliderVariant.success;

  /// Warning styled slider
  const ArcaneSlider.warning({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  }) : variant = SliderVariant.warning;

  /// Error styled slider
  const ArcaneSlider.error({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValue = true,
    this.valuePrefix,
    this.valueSuffix,
    this.valueDecimals = 0,
    this.size = SliderSize.md,
    this.showSteps = false,
    this.disabled = false,
    this.onChanged,
    super.key,
  }) : variant = SliderVariant.error;

  @override
  Component build(BuildContext context) {
    // Delegate to the current stylesheet's slider renderer
    return context.renderers.slider(SliderProps(
      value: value,
      min: min,
      max: max,
      step: step,
      label: label,
      showValue: showValue,
      valuePrefix: valuePrefix,
      valueSuffix: valueSuffix,
      valueDecimals: valueDecimals,
      variant: variant,
      size: size,
      showSteps: showSteps,
      disabled: disabled,
      onChanged: onChanged,
    ));
  }
}

/// Range slider with two handles for selecting a range.
///
/// ```dart
/// ArcaneRangeSlider(
///   minValue: 20,
///   maxValue: 80,
///   onChanged: (min, max) => setState(() {
///     minValue = min;
///     maxValue = max;
///   }),
/// )
/// ```
class ArcaneRangeSlider extends StatelessComponent {
  /// Current minimum value
  final double minValue;

  /// Current maximum value
  final double maxValue;

  /// Minimum allowed value
  final double min;

  /// Maximum allowed value
  final double max;

  /// Step increment
  final double? step;

  /// Label text
  final String? label;

  /// Whether to show range values
  final bool showValues;

  /// Color variant
  final SliderVariant variant;

  /// Size variant
  final SliderSize size;

  /// Whether the slider is disabled
  final bool disabled;

  /// Callback when range changes
  final void Function(double min, double max)? onChanged;

  const ArcaneRangeSlider({
    required this.minValue,
    required this.maxValue,
    this.min = 0,
    this.max = 100,
    this.step,
    this.label,
    this.showValues = true,
    this.variant = SliderVariant.primary,
    this.size = SliderSize.md,
    this.disabled = false,
    this.onChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final minPercent = ((minValue - min) / (max - min) * 100).clamp(0.0, 100.0);
    final maxPercent = ((maxValue - min) / (max - min) * 100).clamp(0.0, 100.0);

    final (trackHeight, thumbSize, hitAreaHeight) = switch (size) {
      SliderSize.sm => ('4px', '14px', '24px'),
      SliderSize.md => ('6px', '18px', '32px'),
      SliderSize.lg => ('8px', '22px', '40px'),
    };

    final thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    // Get active color based on variant
    final activeColor = switch (variant) {
      SliderVariant.primary => 'var(--primary)',
      SliderVariant.success => 'var(--success)',
      SliderVariant.warning => 'var(--warning)',
      SliderVariant.error => 'var(--destructive)',
    };

    return dom.div(
      classes: 'arcane-range-slider ${disabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        'opacity': disabled ? '0.5' : '1',
        'pointer-events': disabled ? 'none' : 'auto',
      }),
      [
        // Label row
        if (label != null || showValues)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': '0.5rem',
            }),
            [
              if (label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                  }),
                  [dom.text(label!)],
                ),
              if (showValues)
                dom.span(
                  classes: 'arcane-range-slider-values',
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'font-variant-numeric': 'tabular-nums',
                    'color': 'var(--muted-foreground)',
                  }),
                  [
                    dom.text('${minValue.toStringAsFixed(0)} - ${maxValue.toStringAsFixed(0)}'),
                  ],
                ),
            ],
          ),

        // Track container
        dom.div(
          classes: 'arcane-range-slider-track-container',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': hitAreaHeight,
            'display': 'flex',
            'align-items': 'center',
            'cursor': 'pointer',
          }),
          [
            // Track background
            dom.div(
              classes: 'arcane-range-slider-track',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'right': '0',
                'height': trackHeight,
                'background': 'var(--muted)',
                'border-radius': '9999px',
                'overflow': 'visible',
              }),
              [
                // Start indicator - visible marker at 0%
                dom.div(
                  classes: 'arcane-range-slider-start-indicator',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'left': '-1px',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': '3px',
                    'height': 'calc($trackHeight + 4px)',
                    'background': activeColor,
                    'border-radius': '9999px',
                    'opacity': '0.7',
                  }),
                  [],
                ),
                // End indicator - visible marker at 100%
                dom.div(
                  classes: 'arcane-range-slider-end-indicator',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'right': '-1px',
                    'top': '50%',
                    'transform': 'translateY(-50%)',
                    'width': '3px',
                    'height': 'calc($trackHeight + 4px)',
                    'background': activeColor,
                    'border-radius': '9999px',
                    'opacity': '0.7',
                  }),
                  [],
                ),
                // Active range
                dom.div(
                  classes: 'arcane-range-slider-track-fill',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'left': '$minPercent%',
                    'width': '${maxPercent - minPercent}%',
                    'height': '100%',
                    'background': activeColor,
                    'border-radius': '9999px',
                  }),
                  [],
                ),
              ],
            ),

            // Min thumb
            dom.div(
              classes: 'arcane-range-slider-thumb arcane-range-slider-thumb-min',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': 'calc($minPercent% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background': 'var(--background)',
                'border': '2px solid $activeColor',
                'border-radius': '9999px',
                'box-shadow': '0 1px 3px hsl(var(--foreground) / 0.2)',
                'transition': 'transform 0.15s ease, box-shadow 0.15s ease',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Max thumb
            dom.div(
              classes: 'arcane-range-slider-thumb arcane-range-slider-thumb-max',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': 'calc($maxPercent% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background': 'var(--background)',
                'border': '2px solid $activeColor',
                'border-radius': '9999px',
                'box-shadow': '0 1px 3px hsl(var(--foreground) / 0.2)',
                'transition': 'transform 0.15s ease, box-shadow 0.15s ease',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Hidden min input
            dom.input(
              type: dom.InputType.range,
              classes: 'arcane-range-slider-input arcane-range-slider-input-min',
              attributes: {
                'min': min.toString(),
                'max': max.toString(),
                'value': minValue.toString(),
                'step': step?.toString() ?? 'any',
                if (disabled) 'disabled': 'true',
              },
              styles: const dom.Styles(raw: {
                'position': 'absolute',
                'width': '100%',
                'height': '100%',
                'opacity': '0',
                'cursor': 'pointer',
                'margin': '0',
                'pointer-events': 'auto',
                'z-index': '3',
              }),
              events: onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final dynamic target = e.target;
                        final String? valueStr = target?.value;
                        final double? newMin = double.tryParse(valueStr ?? '');
                        if (newMin != null && newMin < maxValue) {
                          onChanged!(newMin, maxValue);
                        }
                      },
                    },
            ),

            // Hidden max input - covers the right portion
            dom.input(
              type: dom.InputType.range,
              classes: 'arcane-range-slider-input arcane-range-slider-input-max',
              attributes: {
                'min': min.toString(),
                'max': max.toString(),
                'value': maxValue.toString(),
                'step': step?.toString() ?? 'any',
                if (disabled) 'disabled': 'true',
              },
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': '${(minPercent + maxPercent) / 2}%',
                'width': '${100 - (minPercent + maxPercent) / 2}%',
                'height': '100%',
                'opacity': '0',
                'cursor': 'pointer',
                'margin': '0',
                'pointer-events': 'auto',
                'z-index': '4',
              }),
              events: onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final dynamic target = e.target;
                        final String? valueStr = target?.value;
                        final double? newMax = double.tryParse(valueStr ?? '');
                        if (newMax != null && newMax > minValue) {
                          onChanged!(minValue, newMax);
                        }
                      },
                    },
            ),
          ],
        ),
      ],
    );
  }
}