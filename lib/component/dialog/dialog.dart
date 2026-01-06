import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// A modal dialog component.
///
/// Example:
/// ```dart
/// // Using child:
/// ArcaneDialog(
///   title: 'Confirm',
///   child: Text('Are you sure?'),
///   actions: [ArcaneButton(label: 'OK', onPressed: () {})],
/// )
///
/// // Using children: for multiple elements
/// ArcaneDialog(
///   title: 'Settings',
///   children: [
///     ArcaneTextInput(label: 'Name'),
///     ArcaneTextInput(label: 'Email'),
///   ],
/// )
/// ```
class ArcaneDialog extends StatelessComponent {
  /// Dialog title
  final String? title;

  /// Dialog content (single component)
  final Component? _child;

  /// Dialog content (multiple components) - convenience parameter
  final List<Component>? _children;

  /// Footer actions
  final List<Component>? actions;

  /// Whether to show close button
  final bool showCloseButton;

  /// Close handler
  final void Function()? onClose;

  /// Maximum width
  final double maxWidth;

  /// Whether to close on barrier click
  final bool barrierDismissible;

  /// Creates a dialog.
  ///
  /// Provide either [child] or [children].
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
    // Resolve content: children takes precedence over child
    final content = _children ?? [_child!];

    // Delegate rendering to the current stylesheet's dialog renderer
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
