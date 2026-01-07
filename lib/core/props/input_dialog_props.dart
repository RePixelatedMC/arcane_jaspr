enum InputDialogType {
  text,
  email,
  password,
  multiline,
  number,
}

/// Input dialog component properties.
class InputDialogProps {
  final String title;
  final String? message;
  final String placeholder;
  final String? initialValue;
  final String confirmText;
  final String cancelText;
  final void Function(String value)? onConfirm;
  final void Function()? onCancel;
  final String? Function(String value)? validator;
  final InputDialogType type;
  final int? maxLength;
  final int maxLines;
  final bool requireWorkEmail;
  final List<String>? blockedDomains;
  final num? minValue;
  final num? maxValue;

  const InputDialogProps({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.type = InputDialogType.text,
    this.maxLength,
    this.maxLines = 1,
    this.requireWorkEmail = false,
    this.blockedDomains,
    this.minValue,
    this.maxValue,
  });
}
