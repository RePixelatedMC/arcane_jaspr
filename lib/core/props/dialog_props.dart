import 'package:jaspr/jaspr.dart';

/// Dialog component properties.
class DialogProps {
  final String? title;
  final List<Component> content;
  final List<Component>? actions;
  final bool showCloseButton;
  final void Function()? onClose;
  final double maxWidth;
  final bool barrierDismissible;

  const DialogProps({
    this.title,
    required this.content,
    this.actions,
    this.showCloseButton = true,
    this.onClose,
    this.maxWidth = 500,
    this.barrierDismissible = true,
  });

  DialogProps copyWith({
    String? title,
    List<Component>? content,
    List<Component>? actions,
    bool? showCloseButton,
    void Function()? onClose,
    double? maxWidth,
    bool? barrierDismissible,
  }) {
    return DialogProps(
      title: title ?? this.title,
      content: content ?? this.content,
      actions: actions ?? this.actions,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      onClose: onClose ?? this.onClose,
      maxWidth: maxWidth ?? this.maxWidth,
      barrierDismissible: barrierDismissible ?? this.barrierDismissible,
    );
  }
}

enum SheetPosition {
  left,
  right,
  top,
  bottom,
}

enum SheetSizeVariant {
  auto,
  sm,
  md,
  lg,
  xl,
  full,
}

/// Sheet/drawer component properties.
class SheetProps {
  final bool isOpen;
  final Component child;
  final SheetPosition position;
  final SheetSizeVariant size;
  final void Function()? onClose;
  final bool showCloseButton;
  final String? title;
  final String? description;
  final Component? header;
  final Component? footer;
  final bool showBackdrop;
  final bool closeOnBackdropClick;
  final bool showDragHandle;
  final String? maxWidth;

  const SheetProps({
    required this.isOpen,
    required this.child,
    this.position = SheetPosition.right,
    this.size = SheetSizeVariant.auto,
    this.onClose,
    this.showCloseButton = true,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showDragHandle = true,
    this.maxWidth,
  });

  SheetProps copyWith({
    bool? isOpen,
    Component? child,
    SheetPosition? position,
    SheetSizeVariant? size,
    void Function()? onClose,
    bool? showCloseButton,
    String? title,
    String? description,
    Component? header,
    Component? footer,
    bool? showBackdrop,
    bool? closeOnBackdropClick,
    bool? showDragHandle,
    String? maxWidth,
  }) {
    return SheetProps(
      isOpen: isOpen ?? this.isOpen,
      child: child ?? this.child,
      position: position ?? this.position,
      size: size ?? this.size,
      onClose: onClose ?? this.onClose,
      showCloseButton: showCloseButton ?? this.showCloseButton,
      title: title ?? this.title,
      description: description ?? this.description,
      header: header ?? this.header,
      footer: footer ?? this.footer,
      showBackdrop: showBackdrop ?? this.showBackdrop,
      closeOnBackdropClick: closeOnBackdropClick ?? this.closeOnBackdropClick,
      showDragHandle: showDragHandle ?? this.showDragHandle,
      maxWidth: maxWidth ?? this.maxWidth,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for dialog components.
mixin DialogRendererContract {
  Component dialog(DialogProps props);
  Component sheet(SheetProps props);
}
