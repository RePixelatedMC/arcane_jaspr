import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/slider_props.dart';

/// ShadCN Slider renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/slider
class ShadcnSlider extends StatelessComponent {
  final SliderProps props;

  const ShadcnSlider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double percentage =
        ((props.value - props.min) / (props.max - props.min) * 100)
            .clamp(0.0, 100.0);

    // ShadCN Slider sizes
    // Reference: https://ui.shadcn.com/docs/components/slider
    // Default track: h-2 (8px), thumb: h-5 w-5 (20px)
    final (String trackHeight, String thumbSize, String hitAreaHeight) =
        switch (props.size) {
      SliderSize.sm => ('6px', '16px', '24px'),
      SliderSize.md => ('8px', '20px', '32px'), // ShadCN default h-2 (8px)
      SliderSize.lg => ('10px', '24px', '40px'),
    };

    final int thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    // Get variant colors
    final String fillColor = switch (props.variant) {
      SliderVariant.primary => 'var(--primary)',
      SliderVariant.success => 'var(--success, #22c55e)',
      SliderVariant.warning => 'var(--warning, #f59e0b)',
      SliderVariant.error => 'var(--destructive)',
    };

    return dom.div(
      classes: 'arcane-slider ${props.disabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        'opacity': props.disabled ? '0.5' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
      }),
      [
        // Label row
        if (props.label != null || props.showValue)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': '0.5rem', // spacing-sm
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem', // text-sm
                    'font-weight': '500', // font-medium
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  classes: 'arcane-slider-value',
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem', // text-sm
                    'font-weight': '500', // font-medium
                    'font-variant-numeric': 'tabular-nums',
                    'color': 'var(--muted-foreground)',
                    'min-width': '40px',
                    'text-align': 'right',
                  }),
                  [
                    Component.text(
                      '${props.valuePrefix ?? ''}${props.value.toStringAsFixed(props.valueDecimals)}${props.valueSuffix ?? ''}',
                    ),
                  ],
                ),
            ],
          ),

        // Track container with hit area
        // ShadCN: relative flex w-full touch-none select-none items-center
        dom.div(
          classes: 'arcane-slider-track-container',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': hitAreaHeight,
            'display': 'flex',
            'align-items': 'center',
            'cursor': 'pointer',
            'touch-action': 'none',
            'user-select': 'none',
          }),
          [
            // Track background
            // ShadCN: relative h-2 w-full grow overflow-hidden rounded-full bg-secondary
            dom.div(
              classes: 'arcane-slider-track',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'right': '0',
                'height': trackHeight,
                // ShadCN: bg-secondary
                'background-color': 'var(--secondary)',
                // ShadCN: rounded-full
                'border-radius': '9999px',
                // ShadCN: overflow-hidden
                'overflow': 'hidden',
              }),
              [
                // Range/filled portion
                // ShadCN: absolute h-full bg-primary
                dom.div(
                  classes: 'arcane-slider-track-fill',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'left': '0',
                    'top': '0',
                    'width': '$percentage%',
                    'height': '100%',
                    'background-color': fillColor,
                    'transition': 'width 0.1s ease-out',
                  }),
                  [],
                ),
              ],
            ),

            // Step markers (if enabled)
            if (props.showSteps && props.step != null)
              _buildStepMarkers(trackHeight),

            // Thumb
            // ShadCN: block h-5 w-5 rounded-full border-2 border-primary bg-background
            // ring-offset-background transition-colors focus-visible:outline-none
            // focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2
            // disabled:pointer-events-none disabled:opacity-50
            dom.div(
              classes: 'arcane-slider-thumb',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': 'calc($percentage% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                // ShadCN: bg-background
                'background-color': 'var(--background)',
                // ShadCN: border-2 border-primary
                'border': '2px solid $fillColor',
                // ShadCN: rounded-full
                'border-radius': '9999px',
                // ShadCN: transition-colors
                'transition':
                    'color 150ms ease, transform 150ms ease, box-shadow 150ms ease',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Hidden native range input for interaction
            dom.input(
              type: dom.InputType.range,
              classes: 'arcane-slider-input',
              attributes: {
                'min': props.min.toString(),
                'max': props.max.toString(),
                'value': props.value.toString(),
                'step': props.step?.toString() ?? 'any',
                if (props.disabled) 'disabled': 'true',
              },
              styles: const dom.Styles(raw: {
                'position': 'absolute',
                'width': '100%',
                'height': '100%',
                'opacity': '0',
                'cursor': 'pointer',
                'margin': '0',
                'z-index': '3',
              }),
              events: props.onChanged == null
                  ? null
                  : {
                      'input': (e) {
                        final dynamic target = e.target;
                        final String? valueStr = target?.value;
                        final double? newValue = double.tryParse(valueStr ?? '');
                        if (newValue != null) {
                          props.onChanged!(newValue);
                        }
                      },
                    },
            ),
          ],
        ),

        // Min/Max labels (optional, shown when no label is provided)
        if (props.label == null && !props.showValue)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'margin-top': '0.25rem',
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem', // text-xs
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.min.toStringAsFixed(0))],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem', // text-xs
                  'color': 'var(--muted-foreground)',
                }),
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
      styles: dom.Styles(raw: {
        'position': 'absolute',
        'left': '0',
        'right': '0',
        'height': trackHeight,
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'pointer-events': 'none',
      }),
      [
        for (var i = 0; i <= steps; i++)
          const dom.div(
            styles: dom.Styles(raw: {
              'width': '2px',
              'height': '2px',
              'background': 'var(--muted-foreground)',
              'border-radius': '9999px',
            }),
            [],
          ),
      ],
    );
  }
}