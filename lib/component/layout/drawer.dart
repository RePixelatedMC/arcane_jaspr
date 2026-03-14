import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

import '../../core/theme_provider.dart';

export '../../core/props/drawer_props.dart' show DrawerPosition, DrawerSize;

/// Slide-in drawer/sheet panel.
class ArcaneDrawer extends StatelessWidget {
  final bool isOpen;
  final VoidCallback? onClose;
  final DrawerPosition position;
  final DrawerSize size;
  final Widget child;
  final Widget? header;
  final Widget? footer;
  final bool showBackdrop;
  final bool closeOnBackdropClick;
  final bool showCloseButton;
  final String? width;
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
  Widget build(BuildContext context) {
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
