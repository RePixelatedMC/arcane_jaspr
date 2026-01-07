import 'package:jaspr/jaspr.dart';

/// Plain text component wrapper.
class ArcaneText extends StatelessComponent {
  final String text;

  const ArcaneText(this.text, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.text(text);
  }
}
