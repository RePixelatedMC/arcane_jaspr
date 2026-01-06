import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Properties for expander components.
class ExpanderProps {
  /// Header content (always visible)
  final Component header;

  /// Expandable content
  final Component child;

  /// Whether initially expanded
  final bool initiallyExpanded;

  /// Callback when expansion changes
  final void Function(bool expanded)? onExpansionChanged;

  /// Custom leading icon
  final Component? leading;

  /// Whether to show the expansion icon
  final bool showIcon;

  /// Custom padding for the content
  final EdgeInsets? contentPadding;

  /// Whether to maintain child state when collapsed
  final bool maintainState;

  const ExpanderProps({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.showIcon = true,
    this.contentPadding,
    this.maintainState = true,
  });
}
