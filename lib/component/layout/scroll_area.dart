import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/scroll_area_props.dart'
    show
        ScrollDirectionVariant,
        ScrollbarVisibilityVariant,
        ScrollbarStyleVariant,
        ScrollAreaProps,
        VirtualScrollProps;

/// Scroll direction (local alias)
typedef ScrollDirection = ScrollDirectionVariant;

/// Scrollbar visibility (local alias)
typedef ScrollbarVisibility = ScrollbarVisibilityVariant;

/// Scrollbar style (local alias)
typedef ScrollbarStyle = ScrollbarStyleVariant;

/// A scrollable area with custom styled scrollbars matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/scroll-area
///
/// ShadCN: relative overflow-hidden
/// ShadCN ScrollBar: flex touch-none select-none transition-colors h-full w-2.5 / w-full h-2.5
///
/// ```dart
/// ArcaneScrollArea(
///   height: '400px',
///   child: LongContent(),
/// )
/// ```
class ArcaneScrollArea extends StatelessComponent {
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
  final ScrollDirection direction;

  /// Scrollbar visibility
  final ScrollbarVisibility scrollbar;

  /// Scrollbar style
  final ScrollbarStyle scrollbarStyle;

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

  const ArcaneScrollArea({
    required this.child,
    this.height,
    this.width,
    this.maxHeight,
    this.maxWidth,
    this.direction = ScrollDirection.vertical,
    this.scrollbar = ScrollbarVisibility.hover,
    this.scrollbarStyle = ScrollbarStyle.thin,
    this.trackColor,
    this.thumbColor,
    this.scrollbarSize = '8px',
    this.showScrollShadows = false,
    this.padding,
    this.className,
    super.key,
  });

  /// Creates a vertical scroll area with fixed height
  const ArcaneScrollArea.vertical({
    required this.child,
    required String this.height,
    this.maxHeight,
    this.scrollbar = ScrollbarVisibility.hover,
    this.scrollbarStyle = ScrollbarStyle.thin,
    this.thumbColor,
    this.trackColor,
    this.showScrollShadows = false,
    this.padding,
    this.className,
    super.key,
  })  : width = null,
        maxWidth = null,
        direction = ScrollDirection.vertical,
        scrollbarSize = '8px';

  /// Creates a horizontal scroll area with fixed width
  const ArcaneScrollArea.horizontal({
    required this.child,
    required String this.width,
    this.maxWidth,
    this.scrollbar = ScrollbarVisibility.hover,
    this.scrollbarStyle = ScrollbarStyle.thin,
    this.thumbColor,
    this.trackColor,
    this.showScrollShadows = false,
    this.padding,
    this.className,
    super.key,
  })  : height = null,
        maxHeight = null,
        direction = ScrollDirection.horizontal,
        scrollbarSize = '8px';

  ScrollDirectionVariant get _propsDirection => switch (direction) {
        ScrollDirection.vertical => ScrollDirectionVariant.vertical,
        ScrollDirection.horizontal => ScrollDirectionVariant.horizontal,
        ScrollDirection.both => ScrollDirectionVariant.both,
      };

  ScrollbarVisibilityVariant get _propsScrollbar => switch (scrollbar) {
        ScrollbarVisibility.always => ScrollbarVisibilityVariant.always,
        ScrollbarVisibility.hover => ScrollbarVisibilityVariant.hover,
        ScrollbarVisibility.auto_ => ScrollbarVisibilityVariant.auto_,
        ScrollbarVisibility.hidden => ScrollbarVisibilityVariant.hidden,
      };

  ScrollbarStyleVariant get _propsScrollbarStyle => switch (scrollbarStyle) {
        ScrollbarStyle.default_ => ScrollbarStyleVariant.default_,
        ScrollbarStyle.thin => ScrollbarStyleVariant.thin,
        ScrollbarStyle.minimal => ScrollbarStyleVariant.minimal,
        ScrollbarStyle.custom => ScrollbarStyleVariant.custom,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.scrollArea(ScrollAreaProps(
      child: child,
      height: height,
      width: width,
      maxHeight: maxHeight,
      maxWidth: maxWidth,
      direction: _propsDirection,
      scrollbar: _propsScrollbar,
      scrollbarStyle: _propsScrollbarStyle,
      trackColor: trackColor,
      thumbColor: thumbColor,
      scrollbarSize: scrollbarSize,
      showScrollShadows: showScrollShadows,
      padding: padding,
      className: className,
      instanceId: identityHashCode(this),
    ));
  }
}

/// A virtualized scroll list for large datasets.
/// Only renders visible items for performance.
class ArcaneVirtualScroll<T> extends StatefulComponent {
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

  const ArcaneVirtualScroll({
    required this.items,
    required this.itemBuilder,
    required this.itemHeight,
    required this.height,
    this.overscan = 3,
    super.key,
  });

  @override
  State<ArcaneVirtualScroll<T>> createState() => _ArcaneVirtualScrollState<T>();
}

class _ArcaneVirtualScrollState<T> extends State<ArcaneVirtualScroll<T>> {
  double _scrollTop = 0;

  @override
  Component build(BuildContext context) {
    return context.renderers.virtualScroll<T>(VirtualScrollProps<T>(
      items: component.items,
      itemBuilder: component.itemBuilder,
      itemHeight: component.itemHeight,
      height: component.height,
      overscan: component.overscan,
      scrollTop: _scrollTop,
      onScroll: (scrollTop) => setState(() => _scrollTop = scrollTop),
    ));
  }
}