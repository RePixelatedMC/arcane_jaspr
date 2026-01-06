import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Properties for button panel components.
class ButtonPanelProps {
  /// The button components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Gap between buttons
  final double gap;

  /// Whether to stack vertically on small screens
  final bool responsive;

  /// Padding around the panel
  final EdgeInsets? padding;

  const ButtonPanelProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.gap = 8,
    this.responsive = true,
    this.padding,
  });
}

/// Properties for toolbar components.
class ToolbarProps {
  /// The child components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Gap between items
  final double gap;

  /// Padding around the toolbar
  final EdgeInsets? padding;

  const ToolbarProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 8,
    this.padding,
  });
}

/// Properties for button group components.
class ButtonGroupProps {
  /// The child components
  final List<Component> children;

  /// Whether vertical layout
  final bool vertical;

  /// Gap between buttons
  final double gap;

  const ButtonGroupProps({
    required this.children,
    this.vertical = false,
    this.gap = 0,
  });
}
