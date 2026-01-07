import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/slider_props.dart';

/// Codex Slider renderer.
///
/// Implements the Codex design language:
/// - Larger track and thumb sizes (1.25x)
/// - Accent-colored fill with subtle glow
/// - Larger border radius
class CodexSlider extends StatelessComponent {
  final SliderProps props;

  const CodexSlider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double percentage =
        ((props.value - props.min) / (props.max - props.min) * 100)
            .clamp(0.0, 100.0);

    // Codex Slider sizes - 1.25x larger than ShadCN
    final (String trackHeight, String thumbSize, String hitAreaHeight) =
        switch (props.size) {
      SliderSize.sm => ('8px', '20px', '32px'), // vs ShadCN 6px/16px
      SliderSize.md => ('10px', '24px', '40px'), // vs ShadCN 8px/20px
      SliderSize.lg => ('12px', '28px', '48px'), // vs ShadCN 10px/24px
    };

    final int thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    // Codex variant colors with accent as primary
    final (String fillColor, String glowColor) = switch (props.variant) {
      SliderVariant.primary => (
          'var(--codex-accent)',
          'var(--codex-accent-glow-subtle)',
        ),
      SliderVariant.success => (
          'var(--success)',
          '0 0 10px rgba(var(--success-rgb), 0.25)',
        ),
      SliderVariant.warning => (
          'var(--warning)',
          '0 0 10px rgba(var(--warning-rgb), 0.25)',
        ),
      SliderVariant.error => (
          'var(--destructive)',
          '0 0 10px rgba(var(--destructive-rgb), 0.25)',
        ),
    };

    return dom.div(
      classes: 'codex-slider ${props.disabled ? 'disabled' : ''}',
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
              'margin-bottom': '0.75rem', // Codex: more spacing
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  classes: 'codex-slider-value',
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
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
        dom.div(
          classes: 'codex-slider-track-container',
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
            // Track background - Codex uses muted color
            dom.div(
              classes: 'codex-slider-track',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'right': '0',
                'height': trackHeight,
                'background-color': 'var(--muted)',
                'border-radius': '9999px',
                'overflow': 'hidden',
              }),
              [
                // Range/filled portion with accent color
                dom.div(
                  classes: 'codex-slider-track-fill',
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

            // Thumb - Codex styling with glow
            dom.div(
              classes: 'codex-slider-thumb',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': 'calc($percentage% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background-color': 'var(--foreground)',
                'border': '2px solid $fillColor',
                'border-radius': '9999px',
                // Codex: subtle glow on thumb
                'box-shadow': glowColor,
                'transition': 'all var(--transition)',
                'pointer-events': 'none',
                'z-index': '2',
              }),
              [],
            ),

            // Hidden native range input for interaction
            dom.input(
              type: dom.InputType.range,
              classes: 'codex-slider-input',
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
              'margin-top': '0.375rem', // Codex: slightly more
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.min.toStringAsFixed(0))],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
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
              'width': '3px', // Codex: slightly larger markers
              'height': '3px',
              'background': 'var(--muted-foreground)',
              'border-radius': '9999px',
            }),
            [],
          ),
      ],
    );
  }
}
