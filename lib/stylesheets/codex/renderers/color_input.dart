import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/color_input_props.dart';

/// Codex Color Input renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon color swatches with intense borders
/// - Holographic preset palette with glow effects
/// - Cyberpunk-style hex input with neon accents
/// - Animated selection states with pulse effects
class CodexColorInput extends StatelessComponent {
  final ColorInputProps props;

  const CodexColorInput(this.props);

  @override
  Component build(BuildContext context) {
    // Codex Neon sizes - larger with more presence
    final (swatchSize, fontSize, inputPadding) = switch (props.size) {
      ComponentSize.sm => ('40px', '0.875rem', '10px 14px'),
      ComponentSize.md => ('48px', '1rem', '12px 16px'),
      ComponentSize.lg => ('56px', '1.125rem', '14px 20px'),
    };

    final List<String> colorPresets = props.presets ?? ColorInputProps.defaultPresets;
    final String normalizedValue = _normalizeColor(props.value);

    return div(
      classes: 'codex-color-input codex-neon',
      id: props.id,
      attributes: {
        'data-value': normalizedValue,
        'data-disabled': props.disabled.toString(),
        ...?props.attributes,
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.875rem',
      }),
      [
        // Label with neon styling
        if (props.label != null)
          span(
            classes: 'codex-color-input-label codex-neon',
            styles: const Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Main input row
        div(
          classes: 'codex-color-input-row',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
          }),
          [
            // Neon color swatch with glow
            div(
              classes: 'codex-color-input-swatch codex-neon',
              styles: Styles(raw: {
                'position': 'relative',
                'width': swatchSize,
                'height': swatchSize,
                'border-radius': 'var(--radius)',
                'background': normalizedValue,
                'border': '2px solid rgba(var(--primary-rgb), 0.5)',
                'cursor': props.disabled ? 'not-allowed' : 'pointer',
                'opacity': props.disabled ? '0.4' : '1',
                'overflow': 'hidden',
                'flex-shrink': '0',
                // Neon glow around swatch
                'box-shadow': '0 0 20px ${normalizedValue}66, 0 0 10px rgba(var(--primary-rgb), 0.2)',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
              }),
              [
                // Native color input (invisible but functional)
                input(
                  type: InputType.color,
                  classes: 'codex-color-input-native',
                  attributes: {
                    'value': normalizedValue,
                    if (props.disabled) 'disabled': 'true',
                  },
                  styles: const Styles(raw: {
                    'position': 'absolute',
                    'inset': '0',
                    'width': '100%',
                    'height': '100%',
                    'opacity': '0',
                    'cursor': 'inherit',
                    'border': 'none',
                    'padding': '0',
                  }),
                  events: props.disabled
                      ? null
                      : {
                          'input': (e) {
                            final String? color =
                                (e.target as dynamic)?.value as String?;
                            if (color != null) {
                              props.onChanged?.call(color.toUpperCase());
                            }
                          },
                        },
                ),
              ],
            ),

            // Neon hex text input
            if (props.showHexInput)
              input(
                type: InputType.text,
                classes: 'codex-color-input-hex codex-neon',
                attributes: {
                  'value': normalizedValue.toUpperCase(),
                  'placeholder': '#000000',
                  'maxlength': '7',
                  'spellcheck': 'false',
                  if (props.disabled) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'width': '120px',
                  'padding': inputPadding,
                  'font-size': fontSize,
                  'font-family':
                      'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
                  'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
                  'border': '1px solid rgba(var(--primary-rgb), 0.3)',
                  'border-radius': 'var(--radius)',
                  'color': 'var(--primary)',
                  'outline': 'none',
                  'text-transform': 'uppercase',
                  // Neon text glow
                  'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.4)',
                  'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.1)',
                  'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                }),
                events: props.disabled
                    ? null
                    : {
                        'input': (e) {
                          String? color = (e.target as dynamic)?.value as String?;
                          if (color != null) {
                            if (!color.startsWith('#')) {
                              color = '#$color';
                            }
                            if (RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(color)) {
                              props.onChanged?.call(color.toUpperCase());
                            }
                          }
                        },
                      },
              ),
          ],
        ),

        // Neon preset swatches
        if (colorPresets.isNotEmpty)
          div(
            classes: 'codex-color-input-presets codex-neon',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-wrap': 'wrap',
              'gap': '0.5rem',
            }),
            [
              for (final String preset in colorPresets)
                button(
                  type: ButtonType.button,
                  classes: 'codex-color-input-preset codex-neon',
                  attributes: {
                    'data-color': preset.toUpperCase(),
                    if (props.disabled) 'disabled': 'true',
                  },
                  styles: Styles(raw: {
                    'width': '32px',
                    'height': '32px',
                    'padding': '0',
                    'border': preset.toUpperCase() == normalizedValue.toUpperCase()
                        ? '2px solid var(--primary)'
                        : '2px solid rgba(var(--border-rgb), 0.4)',
                    'border-radius': 'var(--radius-sm)',
                    'background': preset,
                    'cursor': props.disabled ? 'not-allowed' : 'pointer',
                    'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                    // Neon glow on selected preset
                    'box-shadow': preset.toUpperCase() == normalizedValue.toUpperCase()
                        ? '0 0 15px ${preset}99, 0 0 25px rgba(var(--primary-rgb), 0.3)'
                        : '0 0 8px ${preset}44',
                  }),
                  events: props.disabled
                      ? null
                      : {
                          'click': (_) =>
                              props.onChanged?.call(preset.toUpperCase()),
                        },
                  [],
                ),
            ],
          ),
      ],
    );
  }

  String _normalizeColor(String color) {
    String normalized = color;
    if (!normalized.startsWith('#')) {
      normalized = '#$normalized';
    }
    if (normalized.length == 4) {
      // Expand shorthand #RGB to #RRGGBB
      normalized =
          '#${normalized[1]}${normalized[1]}${normalized[2]}${normalized[2]}${normalized[3]}${normalized[3]}';
    }
    return normalized.length == 7 ? normalized : '#000000';
  }
}
