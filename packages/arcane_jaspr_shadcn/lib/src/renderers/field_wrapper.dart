import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';

/// ShadCN Field Wrapper renderer.
class ShadcnFieldWrapper extends StatelessComponent {
  final FieldWrapperProps props;

  const ShadcnFieldWrapper(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null && props.error!.isNotEmpty;

    return dom.div(
      classes: 'arcane-field-wrapper',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-1)',
          'width': '100%',
        },
      ),
      [
        // Label row
        if (props.labelText != null || props.icon != null || props.required)
          dom.div(
            classes: 'arcane-field-label-row',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--space-2)',
              },
            ),
            [
              if (props.leading != null) props.leading!,
              if (props.icon != null)
                dom.span(
                  styles: dom.Styles(
                    raw: {
                      'color': hasError
                          ? 'var(--destructive)'
                          : 'var(--muted-foreground)',
                      'font-size': 'var(--font-size-base)',
                    },
                  ),
                  [Component.text(props.icon!)],
                ),
              if (props.labelText != null)
                dom.label(
                  classes: 'arcane-field-label',
                  styles: dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'color': hasError
                          ? 'var(--destructive)'
                          : 'var(--foreground)',
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
          dom.div(
            classes: 'arcane-field-description',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-xs)',
                'color': 'var(--muted-foreground)',
                'line-height': '1.625',
              },
            ),
            [Component.text(props.description!)],
          ),

        // Field content
        dom.div(
          classes: 'arcane-field-content',
          styles: const dom.Styles(raw: {'width': '100%'}),
          [props.field],
        ),

        // Error message
        if (hasError && props.showValidation)
          dom.div(
            classes: 'arcane-field-error',
            styles: const dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--space-1)',
                'font-size': 'var(--font-size-xs)',
                'color': 'var(--destructive)',
              },
            ),
            [
              const dom.span([Component.text('!')]),
              Component.text(props.error!),
            ],
          ),
      ],
    );
  }
}

/// ShadCN Form Section renderer.
class ShadcnFormSection extends StatelessComponent {
  final FormSectionProps props;

  const ShadcnFormSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-form-section',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '${props.spacing}px',
        },
      ),
      [
        if (props.title != null || props.description != null)
          dom.div(
            classes: 'arcane-form-section-header',
            styles: const dom.Styles(raw: {'margin-bottom': '0.5rem'}),
            [
              if (props.title != null)
                dom.div(
                  styles: dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-base)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                      'margin-bottom': props.description != null
                          ? '0.25rem'
                          : '0',
                    },
                  ),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.625',
                    },
                  ),
                  [Component.text(props.description!)],
                ),
            ],
          ),
        ...props.children,
      ],
    );
  }
}

/// ShadCN Input Group renderer.
class ShadcnInputGroup extends StatelessComponent {
  final InputGroupProps props;

  const ShadcnInputGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<Component> children = <Component>[];
    for (final Component child in props.children) {
      children.add(
        dom.div(
          classes: 'arcane-input-group-item',
          styles: const dom.Styles(
            raw: {'display': 'flex', 'align-items': 'stretch'},
          ),
          [child],
        ),
      );
    }

    return dom.div(
      classes: 'arcane-input-group',
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
