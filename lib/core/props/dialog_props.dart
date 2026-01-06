import 'package:jaspr/jaspr.dart';

/// Properties for dialog components.
class DialogProps {
  /// Dialog title
  final String? title;

  /// Dialog content components
  final List<Component> content;

  /// Footer action buttons
  final List<Component>? actions;

  /// Whether to show the close button
  final bool showCloseButton;

  /// Close handler callback
  final void Function()? onClose;

  /// Maximum width in pixels
  final double maxWidth;

  /// Whether clicking the backdrop closes the dialog
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

  /// Create a copy with modified properties
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

/// Sheet position relative to the viewport.
enum SheetPosition {
  /// Slides in from left
  left,
  /// Slides in from right
  right,
  /// Slides down from top
  top,
  /// Slides up from bottom
  bottom,
}

/// Sheet size variants
enum SheetSizeVariant {
  /// Compact - fits content
  auto,
  /// Small (30% viewport for vertical, 280px for horizontal)
  sm,
  /// Medium (50% viewport for vertical, 400px for horizontal)
  md,
  /// Large (70% viewport for vertical, 540px for horizontal)
  lg,
  /// Nearly full (90% viewport for vertical, 720px for horizontal)
  xl,
  /// Full viewport
  full,
}

/// Properties for sheet/drawer components.
class SheetProps {
  /// Whether the sheet is open
  final bool isOpen;

  /// Sheet content component
  final Component child;

  /// Position of the sheet
  final SheetPosition position;

  /// Size of the sheet
  final SheetSizeVariant size;

  /// Close handler callback
  final void Function()? onClose;

  /// Whether to show the close button
  final bool showCloseButton;

  /// Sheet title
  final String? title;

  /// Description below title
  final String? description;

  /// Custom header widget (overrides title/description)
  final Component? header;

  /// Footer content
  final Component? footer;

  /// Whether to show backdrop overlay
  final bool showBackdrop;

  /// Whether clicking backdrop closes sheet
  final bool closeOnBackdropClick;

  /// Whether to show drag handle (for bottom/top sheets)
  final bool showDragHandle;

  /// Custom max width
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

  /// Create a copy with modified properties
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
