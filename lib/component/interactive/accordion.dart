import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// Accordion item data model.
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

/// Collapsible accordion component.
class ArcaneAccordion extends StatefulComponent {
  final List<ArcaneAccordionItem> items;
  final bool allowMultiple;
  final bool bordered;

  const ArcaneAccordion({
    required this.items,
    this.allowMultiple = false,
    this.bordered = false,
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
    final List<AccordionItemProps> itemProps = component.items
        .map((item) => AccordionItemProps(
              title: item.title,
              content: item.content,
              customContent: item.customContent,
            ))
        .toList();

    return context.renderers.accordion(AccordionProps(
      items: itemProps,
      openItems: _openItems,
      onToggle: _toggleItem,
      allowMultiple: component.allowMultiple,
      bordered: component.bordered,
    ));
  }
}

/// FAQ accordion with question/answer pairs.
class ArcaneFaqAccordion extends StatelessComponent {
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
