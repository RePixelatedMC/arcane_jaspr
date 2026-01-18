import 'package:jaspr/jaspr.dart';

enum DrawerPosition {
  left,
  right,
  top,
  bottom,
}

enum DrawerSize {
  sm,
  md,
  lg,
  xl,
  full,
}

/// Drawer component properties.
class DrawerProps {
  final bool isOpen;
  final void Function()? onClose;
  final DrawerPosition position;
  final DrawerSize size;
  final Component child;
  final Component? header;
  final Component? footer;
  final bool showBackdrop;
  final bool closeOnBackdropClick;
  final bool showCloseButton;
  final String? width;
  final String? height;

  const DrawerProps({
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
  });

  DrawerProps copyWith({
    bool? isOpen,
    void Function()? onClose,
    DrawerPosition? position,
    DrawerSize? size,
    Component? child,
    Component? header,
    Component? footer,
    bool? showBackdrop,
    bool? closeOnBackdropClick,
    bool? showCloseButton,
    String? width,
    String? height,
  }) {
    return DrawerProps(
      isOpen: isOpen ?? this.isOpen,
      onClose: onClose ?? this.onClose,
      position: position ?? this.position,
      size: size ?? this.size,
      child: child ?? this.child,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      showBackdrop: showBackdrop ?? this.showBackdrop,
      closeOnBackdropClick: closeOnBackdropClick ?? this.closeOnBackdropClick,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for drawer components.
mixin DrawerRendererContract {
  Component drawer(DrawerProps props);
}
