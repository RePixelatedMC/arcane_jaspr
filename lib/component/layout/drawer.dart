import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/drawer_props.dart' show DrawerPosition, DrawerSize;

/// Slide-in drawer/sheet panel
///
/// A panel that slides in from the edge of the screen.
///
/// ```dart
/// ArcaneDrawer(
///   isOpen: showDrawer,
///   onClose: () => setState(() => showDrawer = false),
///   position: DrawerPosition.right,
///   child: DrawerContent(),
/// )
/// ```
class ArcaneDrawer extends StatelessComponent {
  /// Whether the drawer is open
  final bool isOpen;

  /// Callback when drawer should close
  final VoidCallback? onClose;

  /// Drawer position
  final DrawerPosition position;

  /// Drawer size
  final DrawerSize size;

  /// Drawer content
  final Component child;

  /// Optional header content
  final Component? header;

  /// Optional footer content
  final Component? footer;

  /// Whether to show backdrop overlay
  final bool showBackdrop;

  /// Whether clicking backdrop closes drawer
  final bool closeOnBackdropClick;

  /// Whether to show close button
  final bool showCloseButton;

  /// Custom width (overrides size for left/right)
  final String? width;

  /// Custom height (overrides size for top/bottom)
  final String? height;

  const ArcaneDrawer({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.position = DrawerPosition.right,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    super.key,
  });

  /// Right drawer constructor
  const ArcaneDrawer.right({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    super.key,
  }) : position = DrawerPosition.right;

  /// Left drawer constructor
  const ArcaneDrawer.left({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.width,
    this.height,
    super.key,
  }) : position = DrawerPosition.left;

  /// Bottom sheet constructor
  const ArcaneDrawer.bottom({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = DrawerSize.md,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = false,
    this.width,
    this.height,
    super.key,
  }) : position = DrawerPosition.bottom;

  @override
  Component build(BuildContext context) {
    // Delegate rendering to the current stylesheet's drawer renderer
    return context.renderers.drawer(DrawerProps(
      isOpen: isOpen,
      onClose: onClose,
      position: position,
      size: size,
      child: child,
      header: header,
      footer: footer,
      showBackdrop: showBackdrop,
      closeOnBackdropClick: closeOnBackdropClick,
      showCloseButton: showCloseButton,
      width: width,
      height: height,
    ));
  }
}
