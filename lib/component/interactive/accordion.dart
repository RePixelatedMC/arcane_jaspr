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
///
/// This is a StatelessComponent that delegates state management to the renderer,
/// ensuring proper event handling in SSR environments.
class ArcaneAccordion extends StatelessComponent {
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
  Component build(BuildContext context) {
    // Determine which items should be open by default
    final Set<int> defaultOpenItems = {};
    for (int i = 0; i < items.length; i++) {
      if (items[i].defaultOpen) {
        defaultOpenItems.add(i);
      }
    }

    final List<AccordionItemProps> itemProps = items
        .map((item) => AccordionItemProps(
              title: item.title,
              content: item.content,
              customContent: item.customContent,
            ))
        .toList();

    return context.renderers.accordion(AccordionProps(
      items: itemProps,
      openItems: defaultOpenItems,
      allowMultiple: allowMultiple,
      bordered: bordered,
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
