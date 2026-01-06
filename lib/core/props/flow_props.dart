import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Properties for flow layout components.
class FlowProps {
  /// The child components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Wrap alignment
  final WrapAlignment wrapAlignment;

  /// Gap between children
  final double gap;

  /// Row gap (overrides gap for rows)
  final double? rowGap;

  /// Column gap (overrides gap for columns)
  final double? columnGap;

  /// Whether to reverse the direction
  final bool reverse;

  const FlowProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.wrapAlignment = WrapAlignment.start,
    this.gap = 8,
    this.rowGap,
    this.columnGap,
    this.reverse = false,
  });
}

/// Properties for row layout components.
class RowProps {
  /// The child components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Main axis size
  final MainAxisSize mainAxisSize;

  /// Gap between children
  final double gap;

  const RowProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.gap = 0,
  });
}

/// Properties for column layout components.
class ColumnProps {
  /// The child components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Main axis size
  final MainAxisSize mainAxisSize;

  /// Gap between children
  final double gap;

  const ColumnProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisSize = MainAxisSize.max,
    this.gap = 0,
  });
}

/// Properties for center alignment components.
class CenterProps {
  /// The child component
  final Component child;

  const CenterProps({required this.child});
}

/// Properties for spacer components.
class SpacerProps {
  /// Flex value
  final int flex;

  const SpacerProps({this.flex = 1});
}

/// Properties for expanded components.
class ExpandedProps {
  /// The child component
  final Component child;

  /// Flex value
  final int flex;

  const ExpandedProps({required this.child, this.flex = 1});
}

/// Properties for sized box components.
class SizedBoxProps {
  /// Width in pixels
  final double? width;

  /// Height in pixels
  final double? height;

  /// Optional child component
  final Component? child;

  const SizedBoxProps({this.width, this.height, this.child});
}

/// Properties for padding wrapper components.
class PaddingWrapperProps {
  /// The padding
  final EdgeInsets padding;

  /// The child component
  final Component child;

  const PaddingWrapperProps({required this.padding, required this.child});
}
