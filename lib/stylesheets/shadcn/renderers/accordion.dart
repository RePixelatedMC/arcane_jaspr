import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/accordion_props.dart';

/// ShadCN Accordion renderer.
///
/// Uses native HTML details/summary elements for reliable expand/collapse
/// behavior that works in SSR environments without JavaScript hydration issues.
///
/// Reference: https://ui.shadcn.com/docs/components/accordion
class ShadcnAccordion extends StatelessComponent {
  final AccordionProps props;

  const ShadcnAccordion(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-accordion faq-container',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.75rem',
          'width': '100%',
          if (props.bordered) 'border': '1px solid var(--border)',
          if (props.bordered) 'border-radius': 'var(--arcane-radius-md)',
          if (props.bordered) 'overflow': 'hidden',
        },
      ),
      [
        for (int i = 0; i < props.items.length; i++)
          _buildItem(props.items[i], i, props.openItems.contains(i)),
      ],
    );
  }

  Component _buildItem(AccordionItemProps item, int index, bool defaultOpen) {
    return Component.element(
      tag: 'details',
      attributes: {
        if (defaultOpen) 'open': '',
      },
      children: [
        // Summary (clickable header)
        Component.element(
          tag: 'summary',
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'gap': '1rem',
              'padding': '1rem 1.25rem',
              'cursor': 'pointer',
              'list-style': 'none',
              '-webkit-user-select': 'none',
              'user-select': 'none',
            },
          ),
          children: [
            // Title text
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'flex-grow': '1',
                  'font-size': 'var(--font-size-sm)',
                  'font-weight': 'var(--font-weight-medium)',
                  'color': 'var(--foreground)',
                  'line-height': '1.5',
                },
              ),
              [Component.text(item.title)],
            ),
            // Chevron
            const dom.div(
              classes: 'faq-chevron',
              styles: dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '16px',
                  'height': '16px',
                  'color': 'var(--muted-foreground)',
                  'flex-shrink': '0',
                  'transition': 'transform 0.2s ease',
                },
              ),
              [
                dom.span(
                  styles: dom.Styles(
                    raw: {
                      'font-size': '0.625rem',
                      'line-height': '1',
                    },
                  ),
                  [Component.text('\u25BC')],
                ),
              ],
            ),
          ],
        ),
        // Content (shown when open)
        dom.div(
          styles: const dom.Styles(
            raw: {
              'padding': '0 1.25rem 1rem 1.25rem',
              'border-top': '1px solid rgba(255, 255, 255, 0.06)',
            },
          ),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'padding-top': '1rem',
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.625',
                },
              ),
              [
                item.customContent ?? Component.text(item.content),
              ],
            ),
          ],
        ),
      ],
    );
  }
}