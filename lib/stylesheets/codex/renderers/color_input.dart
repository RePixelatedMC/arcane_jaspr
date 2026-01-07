import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/color_input_props.dart';

/// Codex Color Input renderer.
class CodexColorInput extends StatelessComponent {
  final ColorInputProps props;

  const CodexColorInput(this.props);

  @override
  Component build(BuildContext context) {
    final (swatchSize, fontSize, inputPadding) = switch (props.size) {
      ColorInputSize.sm => ('32px', '0.875rem', '8px 12px'),
      ColorInputSize.md => ('40px', '1rem', '10px 14px'),
      ColorInputSize.lg => ('48px', '1.125rem', '12px 18px'),
    };

    final List<String> colorPresets = props.presets ?? ColorInputProps.defaultPresets;
    final String normalizedValue = _normalizeColor(props.value);

    return div(
      classes: 'codex-color-input',
      id: props.id,
      attributes: {
        'data-value': normalizedValue,
        'data-disabled': props.disabled.toString(),
        ...?props.attributes,
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.75rem',
      }),
      [
        // Label
        if (props.label != null)
          span(
            classes: 'codex-color-input-label',
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
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
            'gap': '0.75rem',
          }),
          [
            // Color swatch with native picker
            div(
              classes: 'codex-color-input-swatch',
              styles: Styles(raw: {
                'position': 'relative',
                'width': swatchSize,
                'height': swatchSize,
                'border-radius': 'var(--radius)',
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

            // Hex text input
            if (props.showHexInput)
              input(
                type: InputType.text,
                classes: 'codex-color-input-hex',
                attributes: {
                  'value': normalizedValue.toUpperCase(),
                  'placeholder': '#000000',
                  'maxlength': '7',
                  'spellcheck': 'false',
                  if (props.disabled) 'disabled': 'true',
                },
                styles: Styles(raw: {
                  'width': '100px',
                  'padding': inputPadding,
                  'font-size': fontSize,
                  'font-family':
                      'ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace',
                  'background': 'var(--input)',
                  'border': '1px solid var(--border)',
                  'border-radius': 'var(--radius)',
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
            classes: 'codex-color-input-presets',
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-wrap': 'wrap',
              'gap': '0.375rem',
            }),
            [
              for (final String preset in colorPresets)
                button(
                  type: ButtonType.button,
                  classes: 'codex-color-input-preset',
                  attributes: {
                    'data-color': preset.toUpperCase(),
                    if (props.disabled) 'disabled': 'true',
                  },
                  styles: Styles(raw: {
                    'width': '28px',
                    'height': '28px',
                    'padding': '0',
                    'border':
                        preset.toUpperCase() == normalizedValue.toUpperCase()
                            ? '2px solid var(--codex-accent)'
                            : '2px solid var(--border)',
                    'border-radius': 'var(--radius-sm)',
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
