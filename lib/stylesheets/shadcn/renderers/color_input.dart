import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/color_input_props.dart';

/// ShadCN Color Input renderer.
///
/// Renders a color picker with swatch preview and hex input
/// following ShadCN design patterns.
class ShadcnColorInput extends StatelessComponent {
  final ColorInputProps props;

  const ShadcnColorInput(this.props);

  @override
  Component build(BuildContext context) {
    final (swatchSize, fontSize, inputPadding) = switch (props.size) {
      ColorInputSize.sm => ('28px', '0.875rem', '6px 10px'),
      ColorInputSize.md => ('36px', '1rem', '8px 12px'),
      ColorInputSize.lg => ('44px', '1.125rem', '10px 16px'),
    };

    final List<String> colorPresets = props.presets ?? ColorInputProps.defaultPresets;
    final String normalizedValue = _normalizeColor(props.value);

    return div(
      classes: 'arcane-color-input',
      id: props.id,
      attributes: {
        'data-value': normalizedValue,
        'data-disabled': props.disabled.toString(),
        ...?props.attributes,
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.5rem',
      }),
      [
        // Label
        if (props.label != null)
          span(
            classes: 'arcane-color-input-label',
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
            }),
            [text(props.label!)],
          ),

        // Main input row
        div(
          classes: 'arcane-color-input-row',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.5rem',
          }),
          [
            // Color swatch with native picker
            div(
              classes: 'arcane-color-input-swatch',
              styles: Styles(raw: {
                'position': 'relative',
                'width': swatchSize,
                'height': swatchSize,
                'border-radius': '0.375rem',
                'background': normalizedValue,
                'border': '2px solid var(--border)',
                'cursor': props.disabled ? 'not-allowed' : 'pointer',
                'opacity': props.disabled ? '0.5' : '1',
                'overflow': 'hidden',
                'flex-shrink': '0',
              }),
              [
                // Native color input (invisible but functional)
                input(
                  type: InputType.color,
                  classes: 'arcane-color-input-native',
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

            // Hex text input
            if (props.showHexInput)
              input(
                type: InputType.text,
                classes: 'arcane-color-input-hex',
                attributes: {
                  'value': normalizedValue.toUpperCase(),
                  'placeholder': '#000000',
                  'maxlength': '7',
                  'spellcheck': 'false',
                  if (props.disabled) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'width': '90px',
                  'padding': inputPadding,
                  'font-size': fontSize,
                  'font-family':
                      'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
                  'background': 'var(--input)',
                  'border': '1px solid var(--border)',
                  'border-radius': '0.375rem',
                  'color': 'var(--foreground)',
                  'outline': 'none',
                  'text-transform': 'uppercase',
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

        // Preset swatches
        if (colorPresets.isNotEmpty)
          div(
            classes: 'arcane-color-input-presets',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-wrap': 'wrap',
              'gap': '0.25rem',
            }),
            [
              for (final String preset in colorPresets)
                button(
                  type: ButtonType.button,
                  classes: 'arcane-color-input-preset',
                  attributes: {
                    'data-color': preset.toUpperCase(),
                    if (props.disabled) 'disabled': 'true',
                  },
                  styles: Styles(raw: {
                    'width': '24px',
                    'height': '24px',
                    'padding': '0',
                    'border':
                        preset.toUpperCase() == normalizedValue.toUpperCase()
                            ? '2px solid var(--accent)'
                            : '2px solid var(--border)',
                    'border-radius': '0.125rem',
                    'background': preset,
                    'cursor': props.disabled ? 'not-allowed' : 'pointer',
                    'transition': 'all 150ms ease',
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
