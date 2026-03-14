import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

import '../../core/theme_provider.dart';

/// Modal dialog component with title, content, and actions.
class ArcaneDialog extends StatelessWidget {
  final String? title;
  final Widget? _child;
  final List<Widget>? _children;
  final List<Widget>? actions;
  final bool showCloseButton;
  final void Function()? onClose;
  final double maxWidth;
  final bool barrierDismissible;

  const ArcaneDialog({
    this.title,
    Widget? child,
    List<Widget>? children,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
    this.maxWidth = 500,
    this.barrierDismissible = true,
    super.key,
  })  : _child = child,
        _children = children,
        assert(child != null || children != null,
            'Either child or children must be provided');

  @override
  Widget build(BuildContext context) {
    final content = _children ?? [_child!];

    return context.renderers.dialog(DialogProps(
      title: title,
      content: content,
      actions: actions,
      showCloseButton: showCloseButton,
      onClose: onClose,
      maxWidth: maxWidth,
      barrierDismissible: barrierDismissible,
    ));
  }
}
