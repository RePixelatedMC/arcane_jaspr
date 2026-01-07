import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Expander component properties.
class ExpanderProps {
  final Component header;
  final Component child;
  final bool initiallyExpanded;
  final void Function(bool expanded)? onExpansionChanged;
  final Component? leading;
  final bool showIcon;
  final EdgeInsets? contentPadding;
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
