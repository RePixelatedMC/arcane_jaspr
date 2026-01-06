import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/field_wrapper_props.dart';

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
    return context.renderers.fieldWrapper(FieldWrapperProps(
      field: field,
      labelText: labelText,
      description: description,
      icon: icon,
      error: error,
      required: required,
      showValidation: showValidation,
      leading: leading,
      trailing: trailing,
    ));
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
    return context.renderers.formSection(FormSectionProps(
      title: title,
      description: description,
      children: children,
      spacing: spacing,
    ));
  }
}

/// A complete form component with built-in state management.
class ArcaneForm extends StatelessComponent {
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
  Component build(BuildContext context) {
    return context.renderers.form(FormProps(
      children: children,
      submitText: submitText,
      cancelText: cancelText,
      onSubmit: onSubmit,
      onCancel: onCancel,
      showActions: showActions,
      spacing: spacing,
    ));
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
    return context.renderers.inputGroup(InputGroupProps(
      children: children,
      gap: gap,
    ));
  }
}
