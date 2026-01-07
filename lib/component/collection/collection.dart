import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Flexible container for rendering lists of components.
class ArcaneCollection extends StatelessComponent {
  final List<Component> children;
  final Component Function(BuildContext context, int index)? builder;
  final int? childCount;
  final Axis direction;
  final double gap;
  final bool scrollable;
  final String? padding;

  const ArcaneCollection({
    super.key,
    this.children = const [],
    this.direction = Axis.vertical,
    this.gap = 0,
    this.scrollable = false,
    this.padding,
  })  : builder = null,
        childCount = null;

  const ArcaneCollection.builder({
    super.key,
    required this.builder,
    required this.childCount,
    this.direction = Axis.vertical,
    this.gap = 0,
    this.scrollable = false,
    this.padding,
  }) : children = const [];

  @override
  Component build(BuildContext context) {
    final List<Component> items = builder != null
        ? List.generate(childCount ?? 0, (index) => builder!(context, index))
        : children;

    final Map<String, String> containerStyles = {
      'display': 'flex',
      'flex-direction': direction == Axis.vertical ? 'column' : 'row',
      if (gap > 0) 'gap': '${gap}px',
      if (padding != null) 'padding': padding!,
    };

    if (scrollable) {
      containerStyles['overflow'] =
          direction == Axis.vertical ? 'auto' : 'auto';
      containerStyles['max-height'] =
          direction == Axis.vertical ? '100%' : 'none';
      containerStyles['max-width'] =
          direction == Axis.horizontal ? '100%' : 'none';
    }

    return div(
      classes: 'arcane-collection',
      styles: Styles(raw: containerStyles),
      items,
    );
  }
}

enum Axis {
  horizontal,
  vertical,
}

/// Scrollable list view component.
class ArcaneListView extends StatelessComponent {
  final List<Component> children;
  final Component Function(BuildContext context, int index)? builder;
  final int? itemCount;
  final double gap;
  final String? padding;
  final bool horizontal;

  const ArcaneListView({
    super.key,
    this.children = const [],
    this.gap = 0,
    this.padding,
    this.horizontal = false,
  })  : builder = null,
        itemCount = null;

  const ArcaneListView.builder({
    super.key,
    required this.builder,
    required this.itemCount,
    this.gap = 0,
    this.padding,
    this.horizontal = false,
  }) : children = const [];

  @override
  Component build(BuildContext context) {
    final List<Component> items = builder != null
        ? List.generate(itemCount ?? 0, (index) => builder!(context, index))
        : children;

    return div(
      classes: 'arcane-list-view',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': horizontal ? 'row' : 'column',
        'gap': '${gap}px',
        'overflow-y': horizontal ? 'hidden' : 'auto',
        'overflow-x': horizontal ? 'auto' : 'hidden',
        if (padding != null) 'padding': padding!,
      }),
      items,
    );
  }
}

/// Grid layout component.
class ArcaneGridView extends StatelessComponent {
  final List<Component> children;
  final Component Function(BuildContext context, int index)? builder;
  final int? itemCount;
  final int crossAxisCount;
  final double gap;
  final String? padding;
  final double? minItemWidth;

  const ArcaneGridView({
    super.key,
    this.children = const [],
    this.crossAxisCount = 2,
    this.gap = 16,
    this.padding,
    this.minItemWidth,
  })  : builder = null,
        itemCount = null;

  const ArcaneGridView.builder({
    super.key,
    required this.builder,
    required this.itemCount,
    this.crossAxisCount = 2,
    this.gap = 16,
    this.padding,
    this.minItemWidth,
  }) : children = const [];

  @override
  Component build(BuildContext context) {
    final List<Component> items = builder != null
        ? List.generate(itemCount ?? 0, (index) => builder!(context, index))
        : children;

    final String gridTemplateColumns = minItemWidth != null
        ? 'repeat(auto-fit, minmax(${minItemWidth}px, 1fr))'
        : 'repeat($crossAxisCount, 1fr)';

    return div(
      classes: 'arcane-grid-view',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': gridTemplateColumns,
        'gap': '${gap}px',
        if (padding != null) 'padding': padding!,
      }),
      items,
    );
  }
}

/// Masonry-style layout component.
class ArcaneMasonryGrid extends StatelessComponent {
  final List<Component> children;
  final int columns;
  final double gap;
  final String? padding;

  const ArcaneMasonryGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.gap = 16,
    this.padding,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-masonry-grid',
      styles: Styles(raw: {
        'column-count': '$columns',
        'column-gap': '${gap}px',
        if (padding != null) 'padding': padding!,
      }),
      [
        for (final child in children)
          div(
            styles: Styles(raw: {
              'break-inside': 'avoid',
              'margin-bottom': '${gap}px',
            }),
            [child],
          ),
      ],
    );
  }
}

/// Simple repeater component for generating repeated elements.
class ArcaneRepeater extends StatelessComponent {
  final int count;
  final Component Function(BuildContext context, int index) builder;

  const ArcaneRepeater({
    super.key,
    required this.count,
    required this.builder,
  });

  @override
  Component build(BuildContext context) {
    return Component.fragment(
      List.generate(count, (index) => builder(context, index)),
    );
  }
}
