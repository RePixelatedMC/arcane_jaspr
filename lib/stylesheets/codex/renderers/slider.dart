import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/slider_props.dart';

/// Codex Slider renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon track with gradient fill
/// - Pulsing thumb with intense glow
/// - Cyberpunk-style step markers
/// - Holographic value display
class CodexSlider extends StatelessComponent {
  final SliderProps props;

  const CodexSlider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double percentage =
        ((props.value - props.min) / (props.max - props.min) * 100)
            .clamp(0.0, 100.0);

    // Codex Neon Slider sizes - larger with more presence
    final (String trackHeight, String thumbSize, String hitAreaHeight) =
        switch (props.size) {
      SliderSize.sm => ('10px', '24px', '40px'),
      SliderSize.md => ('12px', '28px', '48px'),
      SliderSize.lg => ('14px', '32px', '56px'),
    };

    final int thumbSizeNum = int.parse(thumbSize.replaceAll('px', ''));

    // Codex Neon variant colors with intense glows
    final (String fillGradient, String glowColor, String thumbGlow) = switch (props.variant) {
      SliderVariant.primary => (
        'linear-gradient(90deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
        '0 0 20px rgba(var(--primary-rgb), 0.4)',
        '0 0 15px rgba(var(--primary-rgb), 0.5), 0 0 30px rgba(var(--primary-rgb), 0.25)',
      ),
      SliderVariant.success => (
        'linear-gradient(90deg, var(--success) 0%, color-mix(in srgb, var(--success) 70%, #00ffaa) 100%)',
        '0 0 20px rgba(var(--success-rgb), 0.4)',
        '0 0 15px rgba(var(--success-rgb), 0.5), 0 0 30px rgba(var(--success-rgb), 0.25)',
      ),
      SliderVariant.warning => (
        'linear-gradient(90deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 70%, #ffaa00) 100%)',
        '0 0 20px rgba(var(--warning-rgb), 0.4)',
        '0 0 15px rgba(var(--warning-rgb), 0.5), 0 0 30px rgba(var(--warning-rgb), 0.25)',
      ),
      SliderVariant.error => (
        'linear-gradient(90deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #ff0066) 100%)',
        '0 0 20px rgba(var(--destructive-rgb), 0.4)',
        '0 0 15px rgba(var(--destructive-rgb), 0.5), 0 0 30px rgba(var(--destructive-rgb), 0.25)',
      ),
    };

    return dom.div(
      classes: 'codex-slider codex-neon ${props.disabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        'opacity': props.disabled ? '0.4' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
      }),
      [
        // Label row with neon styling
        if (props.label != null || props.showValue)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'margin-bottom': '1rem',
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'letter-spacing': '0.025em',
                    'text-transform': 'uppercase',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  classes: 'codex-slider-value codex-neon',
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-bold)',
                    'font-variant-numeric': 'tabular-nums',
                    'color': 'var(--primary)',
                    'text-shadow': '0 0 10px rgba(var(--primary-rgb), 0.4)',
                    'min-width': '50px',
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
            // Track background with neon style
            dom.div(
              classes: 'codex-slider-track codex-neon',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': '0',
                'right': '0',
                'height': trackHeight,
                'background': 'linear-gradient(135deg, rgba(var(--muted-rgb), 0.6) 0%, rgba(var(--muted-rgb), 0.4) 100%)',
                'border-radius': '9999px',
                'overflow': 'hidden',
                'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.05)',
              }),
              [
                // Range/filled portion with neon gradient
                dom.div(
                  classes: 'codex-slider-track-fill codex-neon',
                  styles: dom.Styles(raw: {
                    'position': 'absolute',
                    'left': '0',
                    'top': '0',
                    'width': '$percentage%',
                    'height': '100%',
                    'background': fillGradient,
                    'box-shadow': glowColor,
                    'transition': 'width 0.1s ease-out',
                  }),
                  [],
                ),
              ],
            ),

            // Step markers (if enabled)
            if (props.showSteps && props.step != null)
              _buildStepMarkers(trackHeight),

            // Neon thumb with intense glow
            dom.div(
              classes: 'codex-slider-thumb codex-neon',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'left': 'calc($percentage% - ${thumbSizeNum / 2}px)',
                'top': '50%',
                'transform': 'translateY(-50%)',
                'width': thumbSize,
                'height': thumbSize,
                'background': 'linear-gradient(135deg, #ffffff 0%, rgba(255, 255, 255, 0.9) 100%)',
                'border': '3px solid var(--primary)',
                'border-radius': '50%',
                // Intense neon glow on thumb
                'box-shadow': '$thumbGlow, 0 4px 12px rgba(0, 0, 0, 0.3)',
                'transition': 'all 0.15s ease-out',
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

        // Min/Max labels with neon styling
        if (props.label == null && !props.showValue)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'margin-top': '0.5rem',
            }),
            [
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.min.toStringAsFixed(0))],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
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
              'width': '4px',
              'height': '4px',
              'background': 'var(--primary)',
              'border-radius': '50%',
              'box-shadow': '0 0 6px rgba(var(--primary-rgb), 0.4)',
            }),
            [],
          ),
      ],
    );
  }
}
