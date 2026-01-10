import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/accordion_props.dart';

/// ShadCN Accordion renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/accordion
///
/// ShadCN Accordion:
/// - AccordionItem: border-b
/// - AccordionTrigger: flex flex-1 items-center justify-between py-4 font-medium transition-all hover:underline [&[data-state=open]>svg]:rotate-180
/// - AccordionContent: overflow-hidden text-sm transition-all data-[state=closed]:animate-accordion-up data-[state=open]:animate-accordion-down
class ShadcnAccordion extends StatelessComponent {
  final AccordionProps props;

  const ShadcnAccordion(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-accordion',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        if (props.bordered) 'border': '1px solid var(--border)',
        if (props.bordered) 'border-radius': 'var(--arcane-radius-md)',
        'overflow': 'hidden',
      }),
      [
        for (int i = 0; i < props.items.length; i++)
          _buildItem(i, props.items[i]),
      ],
    );
  }

  Component _buildItem(int index, AccordionItemProps item) {
    final bool isOpen = props.openItems.contains(index);
    final bool isLast = index == props.items.length - 1;

    return dom.div(
      classes: 'arcane-accordion-item ${isOpen ? 'open' : ''}',
      styles: dom.Styles(raw: {
        // ShadCN: border-b (each item has bottom border, except last)
        if (!isLast) 'border-bottom': '1px solid var(--border)',
      }),
      [
        // ShadCN AccordionTrigger
        dom.button(
          classes: 'arcane-accordion-trigger',
          attributes: {
            'type': 'button',
            'aria-expanded': isOpen.toString(),
          },
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex': '1',
            'align-items': 'center',
            'justify-content': 'space-between',
            'width': '100%',
            // ShadCN: py-4 (16px)
            'padding': '16px 0',
            'background': 'none',
            'border': 'none',
            'text-align': 'left',
            // ShadCN: font-medium
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--foreground)',
            'cursor': 'pointer',
            // ShadCN: transition-all
            'transition': 'all var(--arcane-transition-slow)',
          }),
          events: {
            'click': (e) {
              if (props.onToggle != null) {
                props.onToggle!(index);
              }
            },
          },
          [
            dom.span([Component.text(item.title)]),
            // ShadCN chevron that rotates
            dom.span(
              classes: 'arcane-accordion-chevron',
              styles: dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '16px',
                'height': '16px',
                'color': 'var(--muted-foreground)',
                // ShadCN: [&[data-state=open]>svg]:rotate-180
                'transform': isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                // ShadCN: transition-transform duration-200
                'transition': 'transform var(--arcane-transition-slow)',
                'flex-shrink': '0',
              }),
              [const Component.text('\u25BC')], // Down arrow
            ),
          ],
        ),

        // ShadCN AccordionContent
        dom.div(
          classes: 'arcane-accordion-panel',
          styles: dom.Styles(raw: {
            'overflow': 'hidden',
            // Simple show/hide for now
            'display': isOpen ? 'block' : 'none',
          }),
          [
            dom.div(
              classes: 'arcane-accordion-content',
              styles: const dom.Styles(raw: {
                // ShadCN: pb-4 pt-0
                'padding-bottom': '16px',
                // ShadCN: text-sm
                'font-size': 'var(--arcane-font-size-sm)',
                'line-height': '1.625',
                'color': 'var(--muted-foreground)',
              }),
              [
                if (item.customContent != null)
                  item.customContent!
                else
                  Component.text(item.content),
              ],
            ),
          ],
        ),
      ],
    );
  }
}