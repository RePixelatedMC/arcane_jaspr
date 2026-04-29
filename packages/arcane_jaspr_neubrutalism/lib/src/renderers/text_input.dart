import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/text_input_props.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';

class NeubrutalismTextInput extends StatelessComponent {
  final TextInputProps props;

  const NeubrutalismTextInput(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    bool hasError = props.error != null;
    bool hasWrapper =
        props.label != null ||
        props.error != null ||
        props.helperText != null ||
        props.prefix != null ||
        props.suffix != null;

    (String, String, String, String) sizeValues = switch (props.size) {
      ComponentSize.sm => ('38px', '0.875rem', '0.5rem', '0.8125rem'),
      ComponentSize.md => ('46px', '1rem', '0.675rem', '0.875rem'),
      ComponentSize.lg => ('54px', '1.125rem', '0.875rem', '1rem'),
    };
    String height = sizeValues.$1;
    String paddingX = sizeValues.$2;
    String paddingY = sizeValues.$3;
    String fontSize = sizeValues.$4;

    dom.InputType inputType = switch (props.type) {
      TextInputType.text => dom.InputType.text,
      TextInputType.email => dom.InputType.email,
      TextInputType.password => dom.InputType.password,
      TextInputType.number => dom.InputType.number,
      TextInputType.tel => dom.InputType.tel,
      TextInputType.url => dom.InputType.url,
      TextInputType.search => dom.InputType.search,
    };

    String borderColor = hasError
        ? 'var(--destructive)'
        : 'var(--nb-ink, #000)';

    String surface = 'var(--nb-paper, var(--card))';

    Map<String, String> runtimeAttrs = textInputAttrs(
      onChange: props.onChangeAction,
      onSubmit: props.onSubmitAction,
      formId: props.formId,
      fieldName: props.fieldName,
    );

    Component inputElement = dom.input(
      type: inputType,
      id: props.id,
      name: props.name,
      classes: 'neubrutalism-text-input',
      attributes: {
        if (props.placeholder != null) 'placeholder': props.placeholder!,
        if (props.value != null) 'value': props.value!,
        if (props.disabled) 'disabled': 'true',
        if (props.required) 'required': 'true',
        if (props.readOnly) 'readonly': 'true',
        'data-disabled': '${props.disabled}',
        'data-error': '$hasError',
        ...runtimeAttrs,
        ...?props.attributes,
      },
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'height': height,
          'width': '100%',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'border':
              'var(--nb-border-base, 3px) solid $borderColor',
          'background-color': surface,
          'padding': '$paddingY $paddingX',
          'font-size': fontSize,
          'font-family': 'inherit',
          'line-height': '1.5',
          'color': 'var(--foreground)',
          'outline': 'none',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
          if (props.disabled) 'cursor': 'not-allowed',
          if (props.disabled) 'opacity': '0.5',
          'transition':
              'transform 120ms cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 120ms cubic-bezier(0.2, 0.8, 0.2, 1)',
        },
      ),
      events: {
        if (props.onChanged != null)
          'input': (e) {
            dynamic target = e.target;
            String? valueStr = target?.value;
            if (valueStr != null) {
              props.onChanged!(valueStr);
            }
          },
        if (props.onFocus != null) 'focus': (e) => props.onFocus!(),
        if (props.onBlur != null) 'blur': (e) => props.onBlur!(),
        if (props.onSubmit != null)
          'keydown': (e) {
            dynamic event = e;
            if (event?.key == 'Enter') {
              dynamic target = e.target;
              String? valueStr = target?.value;
              if (valueStr != null) {
                props.onSubmit!(valueStr);
              }
            }
          },
      },
    );

    if (!hasWrapper) {
      return dom.div(
        styles: dom.Styles(raw: {if (props.fullWidth) 'width': '100%'}),
        [inputElement],
      );
    }

    return dom.div(
      classes: 'neubrutalism-text-input-wrapper',
      attributes: {
        'data-disabled': '${props.disabled}',
        'data-error': '$hasError',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.625rem',
          if (props.fullWidth) 'width': '100%',
        },
      ),
      [
        if (props.label != null)
          Component.element(
            tag: 'label',
            attributes: props.id != null ? {'for': props.id!} : null,
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'line-height': '1',
                'color': 'var(--foreground)',
              },
            ),
            children: [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(
                    raw: {
                      'color': 'var(--destructive)',
                      'margin-left': '0.25rem',
                    },
                  ),
                  [Component.text('*')],
                ),
            ],
          ),
        if (props.prefix != null || props.suffix != null)
          dom.div(
            classes: 'neubrutalism-text-input-container',
            attributes: {
              'data-disabled': '${props.disabled}',
              'data-error': '$hasError',
            },
            styles: dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'align-items': 'center',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'border':
                    'var(--nb-border-base, 3px) solid $borderColor',
                'background-color': surface,
                'box-shadow':
                    'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
                'transition':
                    'transform 120ms cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 120ms cubic-bezier(0.2, 0.8, 0.2, 1)',
              },
            ),
            [
              if (props.prefix != null)
                dom.span(
                  classes: 'neubrutalism-text-input-prefix',
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'padding-left': '0.875rem',
                      'color': 'var(--muted-foreground)',
                    },
                  ),
                  [props.prefix!],
                ),
              dom.input(
                type: inputType,
                id: props.id,
                name: props.name,
                classes: 'neubrutalism-text-input',
                attributes: {
                  if (props.placeholder != null)
                    'placeholder': props.placeholder!,
                  if (props.value != null) 'value': props.value!,
                  if (props.disabled) 'disabled': 'true',
                  if (props.required) 'required': 'true',
                  if (props.readOnly) 'readonly': 'true',
                  ...runtimeAttrs,
                  ...?props.attributes,
                },
                styles: dom.Styles(
                  raw: <String, String>{
                    'flex': '1',
                    'height': height,
                    'border': 'none',
                    'background-color': 'transparent',
                    'padding': '$paddingY $paddingX',
                    'font-size': fontSize,
                    'font-family': 'inherit',
                    'color': 'var(--foreground)',
                    'outline': 'none',
                    'box-shadow': 'none',
                    if (props.disabled) 'cursor': 'not-allowed',
                    if (props.disabled) 'opacity': '0.5',
                  },
                ),
                events: {
                  if (props.onChanged != null)
                    'input': (e) {
                      dynamic target = e.target;
                      String? valueStr = target?.value;
                      if (valueStr != null) {
                        props.onChanged!(valueStr);
                      }
                    },
                  if (props.onFocus != null) 'focus': (e) => props.onFocus!(),
                  if (props.onBlur != null) 'blur': (e) => props.onBlur!(),
                  if (props.onSubmit != null)
                    'keydown': (e) {
                      dynamic event = e;
                      if (event?.key == 'Enter') {
                        dynamic target = e.target;
                        String? valueStr = target?.value;
                        if (valueStr != null) {
                          props.onSubmit!(valueStr);
                        }
                      }
                    },
                },
              ),
              if (props.suffix != null)
                dom.span(
                  classes: 'neubrutalism-text-input-suffix',
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'padding-right': '0.875rem',
                      'color': 'var(--muted-foreground)',
                    },
                  ),
                  [props.suffix!],
                ),
            ],
          )
        else
          inputElement,
        if (props.error != null)
          dom.span(
            classes: 'neubrutalism-text-input-error',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.span(
            classes: 'neubrutalism-text-input-helper',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }
}
