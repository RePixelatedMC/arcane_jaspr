import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/text_input_props.dart';

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

    final (String height, String paddingX, String paddingY, String fontSize) =
        switch (props.size) {
      ComponentSize.sm => ('38px', '0.875rem', '0.5rem', '0.8125rem'),
      ComponentSize.md => ('46px', '1rem', '0.675rem', '0.875rem'),
      ComponentSize.lg => ('54px', '1.125rem', '0.875rem', '1rem'),
    };

    final dom.InputType inputType = switch (props.type) {
      TextInputType.text => dom.InputType.text,
      TextInputType.email => dom.InputType.email,
      TextInputType.password => dom.InputType.password,
      TextInputType.number => dom.InputType.number,
      TextInputType.tel => dom.InputType.tel,
      TextInputType.url => dom.InputType.url,
      TextInputType.search => dom.InputType.search,
    };

    final String borderColor = hasError
        ? 'var(--destructive)'
        : 'var(--codex-accent-border)';

    final String surface =
        'linear-gradient(180deg, color-mix(in srgb, var(--primary) 4%, var(--card)), var(--card))';

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
        'data-disabled': '${props.disabled}',
        'data-error': '$hasError',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'height': height,
        'width': '100%',
        'border-radius': 'var(--radius)',
        'border': '1px solid $borderColor',
        'background': surface,
        'padding': '$paddingY $paddingX',
        'font-size': fontSize,
        'font-family': 'inherit',
        'line-height': '1.5',
        'color': 'var(--foreground)',
        'outline': 'none',
        if (props.disabled) 'cursor': 'not-allowed',
        if (props.disabled) 'opacity': '0.45',
        'transition':
            'border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease',
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

    if (!hasWrapper) {
      return dom.div(
        styles: dom.Styles(raw: {
          if (props.fullWidth) 'width': '100%',
        }),
        [inputElement],
      );
    }

    return dom.div(
      classes: 'codex-text-input-wrapper',
      attributes: {
        'data-disabled': '${props.disabled}',
        'data-error': '$hasError',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.625rem',
        if (props.fullWidth) 'width': '100%',
      }),
      [
        if (props.label != null)
          Component.element(
            tag: 'label',
            attributes: props.id != null ? {'for': props.id!} : null,
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--destructive)',
                    'margin-left': '0.25rem',
                  }),
                  [Component.text('*')],
                ),
            ],
          ),
        if (props.prefix != null || props.suffix != null)
          dom.div(
            classes: 'codex-text-input-container',
            attributes: {
              'data-disabled': '${props.disabled}',
              'data-error': '$hasError',
            },
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'border-radius': 'var(--radius)',
              'border': '1px solid $borderColor',
              'background': surface,
              'overflow': 'hidden',
            }),
            [
              if (props.prefix != null)
                dom.span(
                  classes: 'codex-text-input-prefix',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'padding-left': '0.875rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [props.prefix!],
                ),
              dom.input(
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
                  if (props.disabled) 'opacity': '0.45',
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
                    'padding-right': '0.875rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [props.suffix!],
                ),
            ],
          )
        else
          inputElement,
        if (props.error != null)
          dom.span(
            classes: 'codex-text-input-error',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--destructive)',
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
