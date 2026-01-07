import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/text_input_props.dart';

/// Codex Text Input renderer.
///
/// Implements the Codex design language:
/// - Larger heights (44px md vs ShadCN 40px)
/// - Accent-colored focus ring
/// - Larger border radius
/// - OLED-optimized colors
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

    // Codex sizes - slightly larger than ShadCN
    final (String height, String paddingX, String paddingY, String fontSize) =
        switch (props.size) {
      TextInputSize.sm => ('36px', '0.75rem', '0.375rem', '0.75rem'),
      TextInputSize.md =>
        ('44px', '1rem', '0.625rem', '0.875rem'), // vs ShadCN 40px
      TextInputSize.lg => ('52px', '1.25rem', '0.875rem', '1rem'),
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

    // Build input element with Codex styling
    final Component inputElement = dom.input(
      type: inputType,
      id: props.id,
      name: props.name,
      classes: 'codex-text-input',
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
        // Codex: larger radius
        'border-radius': 'var(--radius-md)', // 10px
        // Codex: accent border on error, subtle border otherwise
        'border': hasError
            ? '1px solid var(--destructive)'
            : '1px solid var(--border)',
        // Codex: card background for inputs (not pure black)
        'background-color': 'var(--input)',
        'padding': '$paddingY $paddingX',
        'font-size': fontSize,
        'font-family': 'inherit',
        'line-height': '1.5',
        'color': 'var(--foreground)',
        'outline': 'none',
        if (props.disabled) 'cursor': 'not-allowed',
        if (props.disabled) 'opacity': '0.5',
        // Codex transition
        'transition': 'border-color var(--transition), box-shadow var(--transition)',
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
      classes: 'codex-text-input-wrapper',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.625rem', // Codex: slightly more gap (10px vs ShadCN 8px)
        if (props.fullWidth) 'width': '100%',
      }),
      [
        // Label
        if (props.label != null)
          Component.element(
            tag: 'label',
            attributes: props.id != null ? {'for': props.id!} : null,
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--codex-accent)',
                    'margin-left': '0.25rem',
                  }),
                  [dom.RawText('*')],
                ),
            ],
          ),

        // Input with optional prefix/suffix
        if (props.prefix != null || props.suffix != null)
          dom.div(
            classes: 'codex-text-input-container',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'border-radius': 'var(--radius-md)',
              'border': hasError
                  ? '1px solid var(--destructive)'
                  : '1px solid var(--border)',
              'background-color': 'var(--input)',
              'overflow': 'hidden',
              'transition': 'border-color var(--transition), box-shadow var(--transition)',
            }),
            [
              if (props.prefix != null)
                dom.span(
                  classes: 'codex-text-input-prefix',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'padding-left': '1rem', // Codex: more padding
                    'color': 'var(--muted-foreground)',
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
                  if (props.disabled) 'opacity': '0.5',
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
                    'padding-right': '1rem', // Codex: more padding
                    'color': 'var(--muted-foreground)',
                  }),
                  [props.suffix!],
                ),
            ],
          )
        else
          inputElement,

        // Error or helper text
        if (props.error != null)
          dom.span(
            classes: 'codex-text-input-error',
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--destructive)',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.span(
            classes: 'codex-text-input-helper',
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }
}
