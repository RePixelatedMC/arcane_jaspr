import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Button panel component properties.
class ButtonPanelProps {
  final List<Component> children;
  final MainAxisAlignment mainAxisAlignment;
  final double gap;
  final bool responsive;
  final EdgeInsets? padding;

  const ButtonPanelProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.end,
    this.gap = 8,
    this.responsive = true,
    this.padding,
  });
}

/// Toolbar component properties.
class ToolbarProps {
  final List<Component> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double gap;
  final EdgeInsets? padding;

  const ToolbarProps({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.gap = 8,
    this.padding,
  });
}

/// Button group component properties.
class ButtonGroupProps {
  final List<Component> children;
  final bool vertical;
  final double gap;

  const ButtonGroupProps({
    required this.children,
    this.vertical = false,
    this.gap = 0,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for button panel components.
mixin ButtonPanelRendererContract {
  Component buttonPanel(ButtonPanelProps props);
  Component toolbar(ToolbarProps props);
  Component buttonGroup(ButtonGroupProps props);
}
