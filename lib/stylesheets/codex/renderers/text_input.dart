import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/text_input_props.dart';

/// Codex Text Input renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing focus rings with neon accent colors
/// - Animated border effects on focus
/// - Cyberpunk-style gradients and shadows
/// - OLED-optimized dark backgrounds
class CodexTextInput extends StatelessComponent {
  final TextInputProps props;

  const CodexTextInput(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null;
    final bool hasWrapper =
        props.label != null ||
        props.error != null ||
        props.helperText != null ||
        props.prefix != null ||
        props.suffix != null;

    // Codex Neon sizes - larger with more presence
    final (String height, String paddingX, String paddingY, String fontSize) =
        switch (props.size) {
      TextInputSize.sm => ('40px', '1rem', '0.5rem', '0.8125rem'),
      TextInputSize.md => ('48px', '1.25rem', '0.75rem', '0.875rem'),
      TextInputSize.lg => ('56px', '1.5rem', '1rem', '1rem'),
    };

    // Map TextInputType to HTML input type
    final dom.InputType inputType = switch (props.type) {
      TextInputType.text => dom.InputType.text,
      TextInputType.email => dom.InputType.email,
      TextInputType.password => dom.InputType.password,
      TextInputType.number => dom.InputType.number,
      TextInputType.tel => dom.InputType.tel,
      TextInputType.url => dom.InputType.url,
      TextInputType.search => dom.InputType.search,
    };

    // Codex Neon border/glow based on state
    final String borderColor = hasError ? 'var(--destructive)' : 'rgba(var(--primary-rgb), 0.3)';
    final String glowColor = hasError
        ? '0 0 15px rgba(var(--destructive-rgb), 0.2)'
        : '0 0 15px rgba(var(--primary-rgb), 0.1)';

    // Build input element with Codex Neon styling
    final Component inputElement = dom.input(
      type: inputType,
      id: props.id,
      name: props.name,
      classes: 'codex-text-input codex-neon',
      attributes: {
        if (props.placeholder != null) 'placeholder': props.placeholder!,
        if (props.value != null) 'value': props.value!,
        if (props.disabled) 'disabled': 'true',
        if (props.required) 'required': 'true',
        if (props.readOnly) 'readonly': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'height': height,
        'width': '100%',
        // Codex Neon: larger radius
        'border-radius': 'var(--radius)',
        // Neon border with glow
        'border': '1px solid $borderColor',
        // Dark cyberpunk background
        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
        'padding': '$paddingY $paddingX',
        'font-size': fontSize,
        'font-family': 'inherit',
        'line-height': '1.5',
        'color': 'var(--foreground)',
        'outline': 'none',
        // Neon glow effect
        'box-shadow': glowColor,
        if (props.disabled) 'cursor': 'not-allowed',
        if (props.disabled) 'opacity': '0.4',
        // Smooth neon transition
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
      }),
      events: {
        if (props.onChanged != null)
          'input': (e) {
            final dynamic target = e.target;
            final String? valueStr = target?.value;
            if (valueStr != null) {
              props.onChanged!(valueStr);
            }
          },
        if (props.onFocus != null) 'focus': (e) => props.onFocus!(),
        if (props.onBlur != null) 'blur': (e) => props.onBlur!(),
        if (props.onSubmit != null)
          'keydown': (e) {
            final dynamic event = e;
            if (event?.key == 'Enter') {
              final dynamic target = e.target;
              final String? valueStr = target?.value;
              if (valueStr != null) {
                props.onSubmit!(valueStr);
              }
            }
          },
      },
    );

    // Without wrapper, return simple input
    if (!hasWrapper) {
      return dom.div(
        styles: dom.Styles(raw: {
          if (props.fullWidth) 'width': '100%',
        }),
        [inputElement],
      );
    }

    // With wrapper (label, prefix/suffix, helper/error)
    return dom.div(
      classes: 'codex-text-input-wrapper codex-neon',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.75rem',
        if (props.fullWidth) 'width': '100%',
      }),
      [
        // Label with neon accent
        if (props.label != null)
          Component.element(
            tag: 'label',
            attributes: props.id != null ? {'for': props.id!} : null,
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--primary)',
                    'margin-left': '0.375rem',
                    'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.5)',
                  }),
                  [dom.RawText('*')],
                ),
            ],
          ),

        // Input with optional prefix/suffix - neon container
        if (props.prefix != null || props.suffix != null)
          dom.div(
            classes: 'codex-text-input-container codex-neon',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'border-radius': 'var(--radius)',
              'border': '1px solid $borderColor',
              'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
              'overflow': 'hidden',
              'box-shadow': glowColor,
              'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            }),
            [
              if (props.prefix != null)
                dom.span(
                  classes: 'codex-text-input-prefix',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'padding-left': '1.25rem',
                    'color': 'var(--primary)',
                    'filter': 'drop-shadow(0 0 4px currentColor)',
                  }),
                  [props.prefix!],
                ),
              // Borderless input inside container
              dom.input(
                type: inputType,
                id: props.id,
                name: props.name,
                classes: 'codex-text-input',
                attributes: {
                  if (props.placeholder != null)
                    'placeholder': props.placeholder!,
                  if (props.value != null) 'value': props.value!,
                  if (props.disabled) 'disabled': 'true',
                  if (props.required) 'required': 'true',
                  if (props.readOnly) 'readonly': 'true',
                },
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'height': height,
                  'border': 'none',
                  'background': 'transparent',
                  'padding': '$paddingY $paddingX',
                  'font-size': fontSize,
                  'font-family': 'inherit',
                  'color': 'var(--foreground)',
                  'outline': 'none',
                  if (props.disabled) 'cursor': 'not-allowed',
                  if (props.disabled) 'opacity': '0.4',
                }),
                events: {
                  if (props.onChanged != null)
                    'input': (e) {
                      final dynamic target = e.target;
                      final String? valueStr = target?.value;
                      if (valueStr != null) {
                        props.onChanged!(valueStr);
                      }
                    },
                  if (props.onFocus != null) 'focus': (e) => props.onFocus!(),
                  if (props.onBlur != null) 'blur': (e) => props.onBlur!(),
                  if (props.onSubmit != null)
                    'keydown': (e) {
                      final dynamic event = e;
                      if (event?.key == 'Enter') {
                        final dynamic target = e.target;
                        final String? valueStr = target?.value;
                        if (valueStr != null) {
                          props.onSubmit!(valueStr);
                        }
                      }
                    },
                },
              ),
              if (props.suffix != null)
                dom.span(
                  classes: 'codex-text-input-suffix',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'padding-right': '1.25rem',
                    'color': 'var(--primary)',
                    'filter': 'drop-shadow(0 0 4px currentColor)',
                  }),
                  [props.suffix!],
                ),
            ],
          )
        else
          inputElement,

        // Error with neon glow or helper text
        if (props.error != null)
          dom.span(
            classes: 'codex-text-input-error',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--destructive)',
              'text-shadow': '0 0 8px rgba(var(--destructive-rgb), 0.4)',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.span(
            classes: 'codex-text-input-helper',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }
}
