import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/time_dialog_props.dart';

/// Time picker dialog with hour/minute selection.
class ArcaneTimeDialog extends StatelessComponent {
  final String title;
  final String? message;
  final TimeOfDay? initialTime;
  final String confirmText;
  final String cancelText;
  final void Function(TimeOfDay time)? onConfirm;
  final void Function()? onCancel;
  final bool use24Hour;
  final int minuteInterval;
  final bool showSeconds;

  const ArcaneTimeDialog({
    required this.title,
    this.message,
    this.initialTime,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.showSeconds = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.timeDialog(TimeDialogProps(
      title: title,
      message: message,
      initialTime: initialTime,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      use24Hour: use24Hour,
      minuteInterval: minuteInterval,
      showSeconds: showSeconds,
    ));
  }
}
