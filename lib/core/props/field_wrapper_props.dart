import 'package:jaspr/jaspr.dart';

/// Properties for field wrapper components.
class FieldWrapperProps {
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

  const FieldWrapperProps({
    required this.field,
    this.labelText,
    this.description,
    this.icon,
    this.error,
    this.required = false,
    this.showValidation = true,
    this.leading,
    this.trailing,
  });
}

/// Properties for form section components.
class FormSectionProps {
  /// Section title.
  final String? title;

  /// Section description.
  final String? description;

  /// Fields in this section.
  final List<Component> children;

  /// Spacing between fields.
  final double spacing;

  const FormSectionProps({
    this.title,
    this.description,
    required this.children,
    this.spacing = 16,
  });
}

/// Properties for complete form components.
class FormProps {
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

  const FormProps({
    required this.children,
    this.submitText = 'Submit',
    this.cancelText = 'Cancel',
    this.onSubmit,
    this.onCancel,
    this.showActions = true,
    this.spacing = 16,
  });
}

/// Properties for input group components.
class InputGroupProps {
  /// Children inputs.
  final List<Component> children;

  /// Gap between inputs.
  final double gap;

  const InputGroupProps({
    required this.children,
    this.gap = 8,
  });
}
