import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/input_dialog_props.dart';

/// Input dialog supporting text, email, password, multiline, and number inputs.
class ArcaneInputDialog extends StatelessComponent {
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

  const ArcaneInputDialog({
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
    super.key,
  });

  const ArcaneInputDialog.text({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.maxLength,
    super.key,
  })  : type = InputDialogType.text,
        maxLines = 1,
        requireWorkEmail = false,
        blockedDomains = null,
        minValue = null,
        maxValue = null;

  const ArcaneInputDialog.email({
    required this.title,
    this.message,
    this.placeholder = 'Enter email address...',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.requireWorkEmail = false,
    this.blockedDomains,
    super.key,
  })  : type = InputDialogType.email,
        maxLength = null,
        maxLines = 1,
        minValue = null,
        maxValue = null;

  const ArcaneInputDialog.password({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.maxLength,
    super.key,
  })  : type = InputDialogType.password,
        maxLines = 1,
        requireWorkEmail = false,
        blockedDomains = null,
        minValue = null,
        maxValue = null;

  const ArcaneInputDialog.multiline({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.maxLength,
    this.maxLines = 4,
    super.key,
  })  : type = InputDialogType.multiline,
        requireWorkEmail = false,
        blockedDomains = null,
        minValue = null,
        maxValue = null;

  const ArcaneInputDialog.number({
    required this.title,
    this.message,
    this.placeholder = '',
    this.initialValue,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.validator,
    this.minValue,
    this.maxValue,
    super.key,
  })  : type = InputDialogType.number,
        maxLength = null,
        maxLines = 1,
        requireWorkEmail = false,
        blockedDomains = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.inputDialog(InputDialogProps(
      title: title,
      message: message,
      placeholder: placeholder,
      initialValue: initialValue,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      validator: validator,
      type: type,
      maxLength: maxLength,
      maxLines: maxLines,
      requireWorkEmail: requireWorkEmail,
      blockedDomains: blockedDomains,
      minValue: minValue,
      maxValue: maxValue,
    ));
  }
}
