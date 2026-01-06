import 'package:jaspr/jaspr.dart';

/// Scroll direction
enum ScrollDirectionVariant {
  /// Vertical scrolling only
  vertical,

  /// Horizontal scrolling only
  horizontal,

  /// Both directions
  both,
}

/// Scrollbar visibility
enum ScrollbarVisibilityVariant {
  /// Always visible
  always,

  /// Visible on hover
  hover,

  /// Auto (browser default)
  auto_,

  /// Hidden (still scrollable)
  hidden,
}

/// Scrollbar style
enum ScrollbarStyleVariant {
  /// Default browser scrollbar
  default_,

  /// Thin scrollbar
  thin,

  /// Minimal (very thin, mostly transparent)
  minimal,

  /// Custom styled scrollbar
  custom,
}

/// Properties for scroll area components.
class ScrollAreaProps {
  /// Content to scroll
  final Component child;

  /// Fixed height (required for vertical scroll)
  final String? height;

  /// Fixed width (required for horizontal scroll)
  final String? width;

  /// Maximum height
  final String? maxHeight;

  /// Maximum width
  final String? maxWidth;

  /// Scroll direction
  final ScrollDirectionVariant direction;

  /// Scrollbar visibility
  final ScrollbarVisibilityVariant scrollbar;

  /// Scrollbar style
  final ScrollbarStyleVariant scrollbarStyle;

  /// Scrollbar track color
  final String? trackColor;

  /// Scrollbar thumb color
  final String? thumbColor;

  /// Scrollbar size (width for vertical, height for horizontal)
  final String scrollbarSize;

  /// Whether to show scroll shadows (gradient fade at edges)
  final bool showScrollShadows;

  /// Padding inside scroll area
  final String? padding;

  /// Additional CSS classes
  final String? className;

  /// Unique ID for CSS scoping
  final int instanceId;

  const ScrollAreaProps({
    required this.child,
    this.height,
    this.width,
    this.maxHeight,
    this.maxWidth,
    this.direction = ScrollDirectionVariant.vertical,
    this.scrollbar = ScrollbarVisibilityVariant.hover,
    this.scrollbarStyle = ScrollbarStyleVariant.thin,
    this.trackColor,
    this.thumbColor,
    this.scrollbarSize = '8px',
    this.showScrollShadows = false,
    this.padding,
    this.className,
    this.instanceId = 0,
  });

  /// Create a copy with modified properties
  ScrollAreaProps copyWith({
    Component? child,
    String? height,
    String? width,
    String? maxHeight,
    String? maxWidth,
    ScrollDirectionVariant? direction,
    ScrollbarVisibilityVariant? scrollbar,
    ScrollbarStyleVariant? scrollbarStyle,
    String? trackColor,
    String? thumbColor,
    String? scrollbarSize,
    bool? showScrollShadows,
    String? padding,
    String? className,
    int? instanceId,
  }) {
    return ScrollAreaProps(
      child: child ?? this.child,
      height: height ?? this.height,
      width: width ?? this.width,
      maxHeight: maxHeight ?? this.maxHeight,
      maxWidth: maxWidth ?? this.maxWidth,
      direction: direction ?? this.direction,
      scrollbar: scrollbar ?? this.scrollbar,
      scrollbarStyle: scrollbarStyle ?? this.scrollbarStyle,
      trackColor: trackColor ?? this.trackColor,
      thumbColor: thumbColor ?? this.thumbColor,
      scrollbarSize: scrollbarSize ?? this.scrollbarSize,
      showScrollShadows: showScrollShadows ?? this.showScrollShadows,
      padding: padding ?? this.padding,
      className: className ?? this.className,
      instanceId: instanceId ?? this.instanceId,
    );
  }
}

/// Properties for virtual scroll components.
class VirtualScrollProps<T> {
  /// List of items
  final List<T> items;

  /// Item builder
  final Component Function(BuildContext context, T item, int index) itemBuilder;

  /// Fixed item height (required for virtualization)
  final double itemHeight;

  /// Container height
  final String height;

  /// Overscan count (items to render outside viewport)
  final int overscan;

  /// Current scroll position
  final double scrollTop;

  /// Callback when scroll position changes
  final void Function(double)? onScroll;

  const VirtualScrollProps({
    required this.items,
    required this.itemBuilder,
    required this.itemHeight,
    required this.height,
    this.overscan = 3,
    this.scrollTop = 0,
    this.onScroll,
  });
}
