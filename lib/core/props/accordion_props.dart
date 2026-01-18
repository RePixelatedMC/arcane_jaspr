import 'package:jaspr/jaspr.dart';

/// Accordion item data.
class AccordionItemProps {
  final String title;
  final String content;
  final Component? customContent;

  const AccordionItemProps({
    required this.title,
    this.content = '',
    this.customContent,
  });
}

/// Accordion component properties.
class AccordionProps {
  final List<AccordionItemProps> items;
  final Set<int> openItems;
  final void Function(int index)? onToggle;
  final bool allowMultiple;
  final bool bordered;

  const AccordionProps({
    required this.items,
    required this.openItems,
    this.onToggle,
    this.allowMultiple = false,
    this.bordered = false,
  });

  AccordionProps copyWith({
    List<AccordionItemProps>? items,
    Set<int>? openItems,
    void Function(int index)? onToggle,
    bool? allowMultiple,
    bool? bordered,
  }) {
    return AccordionProps(
      items: items ?? this.items,
      openItems: openItems ?? this.openItems,
      onToggle: onToggle ?? this.onToggle,
      allowMultiple: allowMultiple ?? this.allowMultiple,
      bordered: bordered ?? this.bordered,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for accordion components.
mixin AccordionRendererContract {
  /// Renders an accordion with collapsible sections.
  Component accordion(AccordionProps props);
}
