import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

/// An expandable/collapsible component.
class ArcaneExpander extends StatelessComponent {
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

  const ArcaneExpander({
    required this.header,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.leading,
    this.showIcon = true,
    this.contentPadding,
    this.maintainState = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.expander(ExpanderProps(
      header: header,
      child: child,
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      leading: leading,
      showIcon: showIcon,
      contentPadding: contentPadding,
      maintainState: maintainState,
    ));
  }
}
