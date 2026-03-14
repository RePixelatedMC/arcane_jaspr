import 'package:arcane_jaspr/component/input/button.dart';
import 'package:arcane_jaspr/component/layout/flow.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/util/arcane.dart';

class FabSocket extends StatelessWidget {
  final Widget child;

  const FabSocket({required this.child, super.key});

  @override
  Widget build(BuildContext context) => Container(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: child,
    ),
  );
}

class Fab extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final void Function()? onPressed;
  final String? href;

  const Fab({
    required this.child,
    this.leading,
    this.onPressed,
    this.href,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Button.primary(
    onPressed: onPressed,
    href: href,
    icon: leading,
    child: child,
  );
}
