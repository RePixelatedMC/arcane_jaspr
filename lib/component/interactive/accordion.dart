import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// An accordion item data model
class ArcaneAccordionItem {
  final String title;
  final String content;
  final Component? customContent;
  final bool defaultOpen;

  const ArcaneAccordionItem({
    required this.title,
    this.content = '',
    this.customContent,
    this.defaultOpen = false,
  });
}

/// An accordion/collapsible component matching shadcn/ui
/// Reference: https://ui.shadcn.com/docs/components/accordion
class ArcaneAccordion extends StatefulComponent {
  /// Accordion items
  final List<ArcaneAccordionItem> items;

  /// Whether multiple items can be open at once
  final bool allowMultiple;

  /// Whether to show outer border (shadcn default has no outer border)
  final bool bordered;

  const ArcaneAccordion({
    required this.items,
    this.allowMultiple = false,
    this.bordered = false, // ShadCN default: no outer border
    super.key,
  });

  @override
  State<ArcaneAccordion> createState() => _ArcaneAccordionState();
}

class _ArcaneAccordionState extends State<ArcaneAccordion> {
  late Set<int> _openItems;

  @override
  void initState() {
    super.initState();
    _openItems = {};
    for (int i = 0; i < component.items.length; i++) {
      if (component.items[i].defaultOpen) {
        _openItems.add(i);
      }
    }
  }

  void _toggleItem(int index) {
    setState(() {
      if (_openItems.contains(index)) {
        _openItems.remove(index);
      } else {
        if (!component.allowMultiple) {
          _openItems.clear();
        }
        _openItems.add(index);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    // Convert ArcaneAccordionItem to AccordionItemProps
    final List<AccordionItemProps> itemProps = component.items
        .map((item) => AccordionItemProps(
              title: item.title,
              content: item.content,
              customContent: item.customContent,
            ))
        .toList();

    // Delegate rendering to the current stylesheet's accordion renderer
    return context.renderers.accordion(AccordionProps(
      items: itemProps,
      openItems: _openItems,
      onToggle: _toggleItem,
      allowMultiple: component.allowMultiple,
      bordered: component.bordered,
    ));
  }
}

/// A simple FAQ accordion
class ArcaneFaqAccordion extends StatelessComponent {
  /// FAQ items as question/answer pairs
  final List<({String question, String answer})> faqs;

  const ArcaneFaqAccordion({
    required this.faqs,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneAccordion(
      items: faqs
          .map((faq) => ArcaneAccordionItem(
                title: faq.question,
                content: faq.answer,
              ))
          .toList(),
      allowMultiple: true,
    );
  }
}