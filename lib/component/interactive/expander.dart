import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

/// Expandable/collapsible component.
class ArcaneExpander extends StatelessComponent {
  final Component header;
  final Component child;
  final bool initiallyExpanded;
  final void Function(bool expanded)? onExpansionChanged;
  final Component? leading;
  final bool showIcon;
  final EdgeInsets? contentPadding;
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
