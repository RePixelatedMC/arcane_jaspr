import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/button_panel_props.dart';

/// A panel component for action buttons, typically used in dialogs or footers.
///
/// Provides consistent spacing and alignment for button groups.
class ArcaneButtonPanel extends StatelessComponent {
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

  const ArcaneButtonPanel({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.gap = 8,
    this.responsive = true,
    this.padding,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.buttonPanel(ButtonPanelProps(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      gap: gap,
      responsive: responsive,
      padding: padding,
    ));
  }
}

/// A toolbar component for a horizontal bar of actions
class ArcaneToolbar extends StatelessComponent {
  final List<Component> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double gap;
  final EdgeInsets? padding;

  const ArcaneToolbar({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 8,
    this.padding,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.toolbar(ToolbarProps(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      gap: gap,
      padding: padding,
    ));
  }
}

/// A group of related buttons or controls
class ArcaneButtonGroup extends StatelessComponent {
  final List<Component> children;
  final bool vertical;
  final double gap;

  const ArcaneButtonGroup({
    required this.children,
    this.vertical = false,
    this.gap = 0,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.buttonGroup(ButtonGroupProps(
      children: children,
      vertical: vertical,
      gap: gap,
    ));
  }
}
