import 'package:arcane_jaspr/component/dialog/text.dart';
import 'package:arcane_jaspr/component/input/text_input.dart';
import 'package:arcane_jaspr/flutter.dart';

class DialogEmail extends StatelessWidget {
  final String title;
  final String? description;
  final String? initialValue;
  final void Function(String result) onConfirm;

  const DialogEmail({
    required this.title,
    required this.onConfirm,
    this.description,
    this.initialValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) => DialogText(
    title: title,
    description: description,
    initialValue: initialValue,
    keyboardType: TextInputType.email,
    onConfirm: onConfirm,
  );
}
