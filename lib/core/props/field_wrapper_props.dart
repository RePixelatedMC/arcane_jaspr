import 'package:jaspr/jaspr.dart';

/// Field wrapper component properties.
class FieldWrapperProps {
  final Component field;
  final String? labelText;
  final String? description;
  final String? icon;
  final String? error;
  final bool required;
  final bool showValidation;
  final Component? leading;
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

/// Form section component properties.
class FormSectionProps {
  final String? title;
  final String? description;
  final List<Component> children;
  final double spacing;

  const FormSectionProps({
    this.title,
    this.description,
    required this.children,
    this.spacing = 16,
  });
}

/// Form component properties.
class FormProps {
  final List<Component> children;
  final String? submitText;
  final String? cancelText;
  final void Function()? onSubmit;
  final void Function()? onCancel;
  final bool showActions;
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

/// Input group component properties.
class InputGroupProps {
  final List<Component> children;
  final double gap;

  const InputGroupProps({
    required this.children,
    this.gap = 8,
  });
}
