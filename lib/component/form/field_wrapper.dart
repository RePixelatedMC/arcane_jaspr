import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A wrapper widget for form fields providing consistent styling and layout.
///
/// This component displays form field values with metadata such as labels,
/// descriptions, icons, and validation feedback. It integrates with the
/// Arcane form system for a polished user experience.
class ArcaneFieldWrapper extends StatelessComponent {
  /// The form field to wrap.
  final Component field;

  /// Label text for the field.
  final String? labelText;

  /// Description text for the field.
  final String? description;

  /// Icon identifier.
  final String? icon;

  /// Error message to display.
  final String? error;

  /// Whether the field is required.
  final bool required;

  /// Whether to show validation feedback.
  final bool showValidation;

  /// Custom leading widget.
  final Component? leading;

  /// Custom trailing widget.
  final Component? trailing;

  const ArcaneFieldWrapper({
    required this.field,
    this.labelText,
    this.description,
    this.icon,
    this.error,
    this.required = false,
    this.showValidation = true,
    this.leading,
    this.trailing,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool hasError = error != null && error!.isNotEmpty;

    return div(
      classes: 'arcane-field-wrapper',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
        'width': '100%',
      }),
      [
        // Label row
        if (labelText != null || icon != null || required)
          div(
            classes: 'arcane-field-label-row',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.5rem',
            }),
            [
              if (leading != null) leading!,
              if (icon != null)
                span(
                  styles: Styles(raw: {
                    'color': hasError
                        ? 'var(--destructive)'
                        : 'var(--muted-foreground)',
                    'font-size': '1rem',
                  }),
                  [Component.text(icon!)],
                ),
              if (labelText != null)
                label(
                  classes: 'arcane-field-label',
                  styles: Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': hasError
                        ? 'var(--destructive)'
                        : 'var(--foreground)',
                  }),
                  [
                    Component.text(labelText!),
                    if (required)
                      const span(
                        styles: Styles(raw: {
                          'color': 'var(--destructive)',
                          'margin-left': '0.25rem',
                        }),
                        [Component.text('*')],
                      ),
                  ],
                ),
              if (trailing != null) trailing!,
            ],
          ),

        // Description
        if (description != null)
          div(
            classes: 'arcane-field-description',
            styles: const Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'line-height': '1.625',
            }),
            [Component.text(description!)],
          ),

        // Field content
        div(
          classes: 'arcane-field-content',
          styles: const Styles(raw: {
            'width': '100%',
          }),
          [field],
        ),

        // Error message
        if (hasError && showValidation)
          div(
            classes: 'arcane-field-error',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.25rem',
              'font-size': '0.75rem',
              'color': 'var(--destructive)',
            }),
            [
              const span([Component.text('!')]),
              Component.text(error!),
            ],
          ),
      ],
    );
  }
}

/// A form section that groups multiple fields together.
class ArcaneFormSection extends StatelessComponent {
  /// Section title.
  final String? title;

  /// Section description.
  final String? description;

  /// Fields in this section.
  final List<Component> children;

  /// Spacing between fields.
  final double spacing;

  const ArcaneFormSection({
    this.title,
    this.description,
    required this.children,
    this.spacing = 16,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-form-section',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${spacing}px',
      }),
      [
        if (title != null || description != null)
          div(
            classes: 'arcane-form-section-header',
            styles: const Styles(raw: {
              'margin-bottom': '0.5rem',
            }),
            [
              if (title != null)
                div(
                  styles: Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                    'margin-bottom': description != null ? '0.25rem' : '0',
                  }),
                  [Component.text(title!)],
                ),
              if (description != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': '0.875rem',
                    'color': 'var(--muted-foreground)',
                    'line-height': '1.625',
                  }),
                  [Component.text(description!)],
                ),
            ],
          ),
        ...children,
      ],
    );
  }
}

/// A complete form component with built-in state management.
class ArcaneForm extends StatefulComponent {
  /// Form fields.
  final List<Component> children;

  /// Submit button text.
  final String? submitText;

  /// Cancel button text.
  final String? cancelText;

  /// Submit handler.
  final void Function()? onSubmit;

  /// Cancel handler.
  final void Function()? onCancel;

  /// Whether to show action buttons.
  final bool showActions;

  /// Spacing between fields.
  final double spacing;

  const ArcaneForm({
    required this.children,
    this.submitText = 'Submit',
    this.cancelText = 'Cancel',
    this.onSubmit,
    this.onCancel,
    this.showActions = true,
    this.spacing = 16,
    super.key,
  });

  @override
  State<ArcaneForm> createState() => _ArcaneFormState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-form button[type="button"]:hover').styles(
      raw: {
        'background-color': 'var(--muted)',
      },
    ),
    css('.arcane-form button[type="submit"]:hover').styles(
      raw: {
        'filter': 'brightness(1.1)',
      },
    ),
  ];
}

class _ArcaneFormState extends State<ArcaneForm> {
  @override
  Component build(BuildContext context) {
    return form(
      classes: 'arcane-form',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.spacing}px',
      }),
      events: {
        'submit': (event) {
          event.preventDefault();
          component.onSubmit?.call();
        },
      },
      [
        ...component.children,
        if (component.showActions)
          div(
            classes: 'arcane-form-actions',
            styles: const Styles(raw: {
              'display': 'flex',
              'justify-content': 'flex-end',
              'gap': '0.5rem',
              'margin-top': '1.5rem',
              'padding-top': '1.5rem',
              'border-top': '1px solid var(--border)',
            }),
            [
              if (component.onCancel != null)
                button(
                  attributes: {'type': 'button'},
                  styles: const Styles(raw: {
                    'padding': '10px 20px',
                    'border': '1px solid var(--border)',
                    'border-radius': '0.375rem',
                    'background-color': 'transparent',
                    'color': 'var(--foreground)',
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'cursor': 'pointer',
                    'transition': 'all 150ms ease',
                  }),
                  events: {
                    'click': (_) => component.onCancel?.call(),
                  },
                  [Component.text(component.cancelText!)],
                ),
              button(
                attributes: {'type': 'submit'},
                styles: const Styles(raw: {
                  'padding': '10px 20px',
                  'border': 'none',
                  'border-radius': '0.375rem',
                  'background-color': 'var(--accent)',
                  'color': 'var(--accent-foreground)',
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                [Component.text(component.submitText!)],
              ),
            ],
          ),
      ],
    );
  }
}

/// An input group that combines multiple inputs in a row.
class ArcaneInputGroup extends StatelessComponent {
  /// Children inputs.
  final List<Component> children;

  /// Gap between inputs.
  final double gap;

  const ArcaneInputGroup({
    required this.children,
    this.gap = 8,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-input-group',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '${gap}px',
      }),
      children,
    );
  }
}
