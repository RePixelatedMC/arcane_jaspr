import 'package:jaspr/jaspr.dart';

/// Drawer position relative to the viewport.
enum DrawerPosition {
  /// Slide in from left
  left,

  /// Slide in from right
  right,

  /// Slide in from top
  top,

  /// Slide in from bottom
  bottom,
}

/// Drawer size variants.
enum DrawerSize {
  /// Small drawer (280px / 30vh)
  sm,

  /// Medium drawer (360px / 50vh)
  md,

  /// Large drawer (480px / 70vh)
  lg,

  /// Extra large drawer (640px / 90vh)
  xl,

  /// Full width/height
  full,
}

/// Properties for drawer components.
class DrawerProps {
  /// Whether the drawer is open
  final bool isOpen;

  /// Callback when drawer should close
  final void Function()? onClose;

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

  /// Create a copy with modified properties
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
