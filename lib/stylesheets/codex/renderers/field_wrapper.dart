import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/field_wrapper_props.dart';

/// Codex FieldWrapper renderer.
class CodexFieldWrapper extends StatelessComponent {
  final FieldWrapperProps props;

  const CodexFieldWrapper(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null && props.error!.isNotEmpty;

    return dom.div(
      classes: 'codex-field-wrapper',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--arcane-space-2)',
      }),
      [
        // Label row
        if (props.labelText != null)
          dom.div(
            classes: 'codex-field-label-row',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-2)',
            }),
            [
              if (props.leading != null) props.leading!,
              dom.label(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-sm)',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'color': 'var(--foreground)',
                }),
                [
                  Component.text(props.labelText!),
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
              if (props.trailing != null) props.trailing!,
            ],
          ),

        // Description
        if (props.description != null)
          dom.p(
            classes: 'codex-field-description',
            styles: const dom.Styles(raw: {
              'font-size': '0.8125rem',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [Component.text(props.description!)],
          ),

        // Field
        props.field,

        // Error message
        if (hasError && props.showValidation)
          dom.p(
            classes: 'codex-field-error',
            styles: const dom.Styles(raw: {
              'font-size': '0.8125rem',
              'color': 'var(--destructive)',
              'margin': '0',
            }),
            [Component.text(props.error!)],
          ),
      ],
    );
  }
}

/// Codex FormSection renderer.
class CodexFormSection extends StatelessComponent {
  final FormSectionProps props;

  const CodexFormSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.fieldset(
      classes: 'codex-form-section',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${props.spacing}px',
        'border': 'none',
        'padding': '0',
        'margin': '0',
      }),
      [
        // Section header
        if (props.title != null || props.description != null)
          dom.div(
            classes: 'codex-form-section-header',
            styles: const dom.Styles(raw: {
              'margin-bottom': '0.5rem',
            }),
            [
              if (props.title != null)
                dom.legend(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-base)',
                    'font-weight': 'var(--arcane-font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'padding': '0',
                  }),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.p(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-sm)',
                    'color': 'var(--muted-foreground)',
                    'margin': '0.25rem 0 0 0',
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),

        // Fields
        ...props.children,
      ],
    );
  }
}

/// Codex InputGroup renderer.
class CodexInputGroup extends StatelessComponent {
  final InputGroupProps props;

  const CodexInputGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-input-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '${props.gap}px',
      }),
      props.children,
    );
  }
}