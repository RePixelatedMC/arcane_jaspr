import '../../component/input/time_picker.dart';

/// Time dialog component properties.
class TimeDialogProps {
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

  const TimeDialogProps({
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
  });
}
