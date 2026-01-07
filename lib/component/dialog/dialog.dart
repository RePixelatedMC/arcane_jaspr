import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// Modal dialog component with title, content, and actions.
class ArcaneDialog extends StatelessComponent {
  final String? title;
  final Component? _child;
  final List<Component>? _children;
  final List<Component>? actions;
  final bool showCloseButton;
  final void Function()? onClose;
  final double maxWidth;
  final bool barrierDismissible;

  const ArcaneDialog({
    this.title,
    Component? child,
    List<Component>? children,
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
  Component build(BuildContext context) {
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
