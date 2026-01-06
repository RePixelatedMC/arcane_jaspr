import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/text_input_props.dart';

/// ShadCN Text Input renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/input
///
/// ShadCN Input:
/// - flex h-10 w-full rounded-md border border-input bg-background
/// - px-3 py-2 text-base
/// - ring-offset-background
/// - file:border-0 file:bg-transparent file:text-sm file:font-medium file:text-foreground
/// - placeholder:text-muted-foreground
/// - focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2
/// - disabled:cursor-not-allowed disabled:opacity-50
/// - md:text-sm
class ShadcnTextInput extends StatelessComponent {
  final TextInputProps props;

  const ShadcnTextInput(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null;
    final bool hasWrapper =
        props.label != null ||
        props.error != null ||
        props.helperText != null ||
        props.prefix != null ||
        props.suffix != null;

    // ShadCN sizes
    // Default: h-10 (40px), px-3, py-2, text-base/md:text-sm
    final (String height, String paddingX, String paddingY, String fontSize) =
        switch (props.size) {
      TextInputSize.sm => ('32px', '0.5rem', '0.25rem', '0.75rem'),
      TextInputSize.md =>
        ('40px', '0.75rem', '0.5rem', '0.875rem'), // ShadCN default h-10
      TextInputSize.lg => ('48px', '1rem', '0.75rem', '1rem'),
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

    // Build input element
    // ShadCN: flex h-10 w-full rounded-md border border-input bg-background
    //         px-3 py-2 text-base ring-offset-background
    final Component inputElement = dom.input(
      type: inputType,
      id: props.id,
      name: props.name,
      classes: 'arcane-text-input',
      attributes: {
        if (props.placeholder != null) 'placeholder': props.placeholder!,
        if (props.value != null) 'value': props.value!,
        if (props.disabled) 'disabled': 'true',
        if (props.required) 'required': 'true',
        if (props.readOnly) 'readonly': 'true',
      },
      styles: dom.Styles(raw: {
        // ShadCN: flex h-10 w-full
        'display': 'flex',
        'height': height,
        'width': '100%',
        // ShadCN: rounded-md
        'border-radius': '0.375rem',
        // ShadCN: border border-input
        'border': hasError
            ? '1px solid var(--destructive)'
            : '1px solid var(--input)',
        // ShadCN: bg-background
        'background-color': 'var(--background)',
        // ShadCN: px-3 py-2
        'padding': '$paddingY $paddingX',
        // ShadCN: text-base md:text-sm
        'font-size': fontSize,
        'font-family': 'inherit',
        'line-height': '1.5',
        'color': 'var(--foreground)',
        // ShadCN: ring-offset-background (for focus ring offset)
        'outline': 'none',
        // ShadCN: disabled:cursor-not-allowed disabled:opacity-50
        if (props.disabled) 'cursor': 'not-allowed',
        if (props.disabled) 'opacity': '0.5',
        // Transition for focus
        'transition':
            'border-color 150ms ease, box-shadow 150ms ease',
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
      classes: 'arcane-text-input-wrapper',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.5rem', // ShadCN: space-y-2
        if (props.fullWidth) 'width': '100%',
      }),
      [
        // Label
        // ShadCN: text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70
        if (props.label != null)
          Component.element(
            tag: 'label',
            attributes: props.id != null ? {'for': props.id!} : null,
            styles: dom.Styles(raw: {
              // ShadCN: text-sm font-medium leading-none
              'font-size': '0.875rem',
              'font-weight': '500',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [
              Component.text(props.label!),
              if (props.required)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--destructive)',
                    'margin-left': '0.25rem',
                  }),
                  [Component.text('*')],
                ),
            ],
          ),

        // Input with optional prefix/suffix
        if (props.prefix != null || props.suffix != null)
          dom.div(
            classes: 'arcane-text-input-container',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              // ShadCN: rounded-md border border-input bg-background
              'border-radius': '0.375rem',
              'border': hasError
                  ? '1px solid var(--destructive)'
                  : '1px solid var(--input)',
              'background-color': 'var(--background)',
              'overflow': 'hidden',
            }),
            [
              if (props.prefix != null)
                dom.span(
                  classes: 'arcane-text-input-prefix',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'padding-left': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [props.prefix!],
                ),
              // Borderless input inside container
              dom.input(
                type: inputType,
                id: props.id,
                name: props.name,
                classes: 'arcane-text-input',
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
                  classes: 'arcane-text-input-suffix',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'padding-right': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [props.suffix!],
                ),
            ],
          )
        else
          inputElement,

        // Error or helper text
        // ShadCN: text-sm text-muted-foreground (helper) or text-destructive (error)
        if (props.error != null)
          dom.span(
            classes: 'arcane-text-input-error',
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--destructive)',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.span(
            classes: 'arcane-text-input-helper',
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
