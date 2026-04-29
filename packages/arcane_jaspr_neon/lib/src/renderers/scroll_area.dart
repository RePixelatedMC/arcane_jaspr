import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/scroll_area_props.dart';

/// Neon Scroll Area renderer.
class NeonScrollArea extends StatelessComponent {
  final ScrollAreaProps props;

  const NeonScrollArea(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Overflow values based on direction
    final (String overflowX, String overflowY) = switch (props.direction) {
      ScrollDirectionVariant.vertical => ('hidden', 'auto'),
      ScrollDirectionVariant.horizontal => ('auto', 'hidden'),
      ScrollDirectionVariant.both => ('auto', 'auto'),
    };

    // Scrollbar visibility styles
    final Map<String, String> scrollbarVisibilityStyles =
        switch (props.scrollbar) {
          ScrollbarVisibilityVariant.always => {},
          ScrollbarVisibilityVariant.hover => {'scrollbar-width': 'none'},
          ScrollbarVisibilityVariant.auto_ => {},
          ScrollbarVisibilityVariant.hidden => {
            'scrollbar-width': 'none',
            '-ms-overflow-style': 'none',
          },
        };

    // Generate unique class for this instance
    final scrollClassName = 'neon-scroll-area-${props.instanceId}';

    return dom.div(
      classes: 'neon-scroll-area $scrollClassName ${props.className ?? ""}',
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          if (props.height != null) 'height': props.height!,
          if (props.width != null) 'width': props.width!,
          if (props.maxHeight != null) 'max-height': props.maxHeight!,
          if (props.maxWidth != null) 'max-width': props.maxWidth!,
          'overflow-x': overflowX,
          'overflow-y': overflowY,
          if (props.padding != null) 'padding': props.padding!,
          ...scrollbarVisibilityStyles,
          'scroll-behavior': 'smooth',
          '-webkit-overflow-scrolling': 'touch',
          'scrollbar-color':
              'color-mix(in srgb, var(--neon-accent) 38%, transparent) transparent',
          'scrollbar-width': 'thin',
        },
      ),
      [
        // Scroll shadows (top/bottom or left/right gradients)
        if (props.showScrollShadows) ...[
          _buildScrollShadow(props.direction, isStart: true),
          _buildScrollShadow(props.direction, isStart: false),
        ],

        // Content
        props.child,
      ],
    );
  }

  Component _buildScrollShadow(
    ScrollDirectionVariant direction, {
    required bool isStart,
  }) {
    final isVertical =
        direction == ScrollDirectionVariant.vertical ||
        direction == ScrollDirectionVariant.both;
    final isHorizontal =
        direction == ScrollDirectionVariant.horizontal ||
        direction == ScrollDirectionVariant.both;

    if (isVertical && !isHorizontal) {
      return dom.div(
        classes: 'neon-scroll-shadow ${isStart ? "top" : "bottom"}',
        styles: dom.Styles(
          raw: {
            'position': 'sticky',
            if (isStart) 'top': '0',
            if (!isStart) 'bottom': '0',
            'left': '0',
            'right': '0',
            'height': '32px',
            'background': isStart
                ? 'linear-gradient(to bottom, var(--background), transparent)'
                : 'linear-gradient(to top, var(--background), transparent)',
            'pointer-events': 'none',
            'z-index': '1',
          },
        ),
        [],
      );
    }

    if (isHorizontal) {
      return dom.div(
        classes: 'neon-scroll-shadow ${isStart ? "left" : "right"}',
        styles: dom.Styles(
          raw: {
            'position': 'sticky',
            if (isStart) 'left': '0',
            if (!isStart) 'right': '0',
            'top': '0',
            'bottom': '0',
            'width': '32px',
            'background': isStart
                ? 'linear-gradient(to right, var(--background), transparent)'
                : 'linear-gradient(to left, var(--background), transparent)',
            'pointer-events': 'none',
            'z-index': '1',
          },
        ),
        [],
      );
    }

    return const dom.span(styles: dom.Styles(raw: {'display': 'none'}), []);
  }
}

/// Neon Virtual Scroll renderer.
class NeonVirtualScroll<T> extends StatelessComponent {
  final VirtualScrollProps<T> props;

  const NeonVirtualScroll(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final items = props.items;
    final itemHeight = props.itemHeight;
    final overscan = props.overscan;

    // Parse height to get container size
    final containerHeight =
        double.tryParse(props.height.replaceAll('px', '')) ?? 400;

    // Calculate visible range
    final startIndex = ((props.scrollTop / itemHeight).floor() - overscan)
        .clamp(0, items.length);
    final visibleCount = ((containerHeight / itemHeight).ceil() + overscan * 2)
        .clamp(0, items.length - startIndex);
    final endIndex = (startIndex + visibleCount).clamp(0, items.length);

    final totalHeight = items.length * itemHeight;

    return dom.div(
      classes: 'neon-virtual-scroll',
      styles: dom.Styles(
        raw: {
          'height': props.height,
          'overflow-y': 'auto',
          'position': 'relative',
          'scrollbar-color':
              'color-mix(in srgb, var(--neon-accent) 38%, transparent) transparent',
          'scrollbar-width': 'thin',
        },
      ),
      events: props.onScroll != null
          ? {
              'scroll': (e) {
                final target = e.target as dynamic;
                props.onScroll!((target.scrollTop as num).toDouble());
              },
            }
          : null,
      [
        // Total height spacer
        dom.div(
          styles: dom.Styles(
            raw: {'height': '${totalHeight}px', 'position': 'relative'},
          ),
          [
            // Visible items
            for (var i = startIndex; i < endIndex; i++)
              dom.div(
                styles: dom.Styles(
                  raw: {
                    'position': 'absolute',
                    'top': '${i * itemHeight}px',
                    'left': '0',
                    'right': '0',
                    'height': '${itemHeight}px',
                  },
                ),
                [props.itemBuilder(context, items[i], i)],
              ),
          ],
        ),
      ],
    );
  }
}
