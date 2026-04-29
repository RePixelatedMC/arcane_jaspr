import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';

/// Neubrutalism FieldWrapper renderer.
class NeubrutalismFieldWrapper extends StatelessComponent {
  final FieldWrapperProps props;

  const NeubrutalismFieldWrapper(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null && props.error!.isNotEmpty;

    return dom.div(
      classes: 'neubrutalism-field-wrapper',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)',
        },
      ),
      [
        // Label row
        if (props.labelText != null)
          dom.div(
            classes: 'neubrutalism-field-label-row',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--space-2)',
              },
            ),
            [
              if (props.leading != null) props.leading!,
              dom.label(
                styles: const dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--foreground)',
                  },
                ),
                [
                  Component.text(props.labelText!),
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
              if (props.trailing != null) props.trailing!,
            ],
          ),

        // Description
        if (props.description != null)
          dom.p(
            classes: 'neubrutalism-field-description',
            styles: const dom.Styles(
              raw: {
                'font-size': '0.8125rem',
                'color': 'var(--muted-foreground)',
                'margin': '0',
              },
            ),
            [Component.text(props.description!)],
          ),

        // Field
        props.field,

        // Error message
        if (hasError && props.showValidation)
          dom.p(
            classes: 'neubrutalism-field-error',
            styles: const dom.Styles(
              raw: {
                'font-size': '0.8125rem',
                'color': 'var(--destructive)',
                'margin': '0',
              },
            ),
            [Component.text(props.error!)],
          ),
      ],
    );
  }
}

/// Neubrutalism FormSection renderer.
class NeubrutalismFormSection extends StatelessComponent {
  final FormSectionProps props;

  const NeubrutalismFormSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.fieldset(
      classes: 'neubrutalism-form-section',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${props.spacing}px',
          'border': 'none',
          'padding': '0',
          'margin': '0',
        },
      ),
      [
        // Section header
        if (props.title != null || props.description != null)
          dom.div(
            classes: 'neubrutalism-form-section-header',
            styles: const dom.Styles(raw: {'margin-bottom': '0.5rem'}),
            [
              if (props.title != null)
                dom.legend(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-base)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                      'padding': '0',
                    },
                  ),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.p(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'margin': '0.25rem 0 0 0',
                    },
                  ),
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

/// Neubrutalism InputGroup renderer.
class NeubrutalismInputGroup extends StatelessComponent {
  final InputGroupProps props;

  const NeubrutalismInputGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<Component> children = <Component>[];
    for (final Component child in props.children) {
      children.add(
        dom.div(
          classes: 'neubrutalism-input-group-item',
          styles: const dom.Styles(
            raw: {'display': 'flex', 'align-items': 'stretch'},
          ),
          [child],
        ),
      );
    }

    return dom.div(
      classes: 'neubrutalism-input-group',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'stretch',
          'gap': '${props.gap}px',
        },
      ),
      children,
    );
  }
}
