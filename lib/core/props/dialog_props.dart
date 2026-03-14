import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/jaspr.dart' hide BuildContext, InheritedComponent, Key, State, StatefulComponent, StatelessComponent, UniqueKey, ValueKey, runApp;

/// Dialog component properties.
class DialogProps {
  final String? title;
  final List<Widget> content;
  final List<Widget>? actions;
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
    List<Widget>? content,
    List<Widget>? actions,
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
  final Widget child;
  final SheetPosition position;
  final SheetSizeVariant size;
  final void Function()? onClose;
  final bool showCloseButton;
  final String? title;
  final String? description;
  final Widget? header;
  final Widget? footer;
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
    Widget? child,
    SheetPosition? position,
    SheetSizeVariant? size,
    void Function()? onClose,
    bool? showCloseButton,
    String? title,
    String? description,
    Widget? header,
    Widget? footer,
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
  Widget dialog(DialogProps props);
  Widget sheet(SheetProps props);
}
