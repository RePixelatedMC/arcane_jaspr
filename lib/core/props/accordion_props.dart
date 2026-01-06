import 'package:jaspr/jaspr.dart';

/// Accordion item data for accordion components.
class AccordionItemProps {
  /// The title/header text for the accordion item
  final String title;

  /// Plain text content (used if customContent is null)
  final String content;

  /// Custom component content (takes precedence over content)
  final Component? customContent;

  const AccordionItemProps({
    required this.title,
    this.content = '',
    this.customContent,
  });
}

/// Properties for accordion components.
class AccordionProps {
  /// The accordion items
  final List<AccordionItemProps> items;

  /// Set of indices of currently open items
  final Set<int> openItems;

  /// Callback when an item is toggled
  final void Function(int index)? onToggle;

  /// Whether multiple items can be open at once
  final bool allowMultiple;

  /// Whether to show an outer border
  final bool bordered;

  const AccordionProps({
    required this.items,
    required this.openItems,
    this.onToggle,
    this.allowMultiple = false,
    this.bordered = false,
  });

  /// Create a copy with modified properties
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
