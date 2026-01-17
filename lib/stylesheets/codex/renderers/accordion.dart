import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/accordion_props.dart';

/// Codex Accordion renderer.
///
/// Uses native HTML details/summary elements for reliable expand/collapse
/// behavior that works in SSR environments without JavaScript hydration issues.
///
/// Implements the Codex design language:
/// - Clean card-based items with subtle borders
/// - Accent-colored chevron buttons
/// - Smooth CSS transitions
class CodexAccordion extends StatelessComponent {
  final AccordionProps props;

  const CodexAccordion(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-accordion faq-container',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.75rem',
          'width': '100%',
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
              'padding': '1.25rem',
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
                  'font-size': '0.9375rem',
                  'font-weight': '500',
                  'color': 'var(--foreground)',
                  'line-height': '1.5',
                },
              ),
              [Component.text(item.title)],
            ),
            // Chevron button
            dom.div(
              classes: 'faq-chevron',
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'border-radius': '6px',
                  'background': 'rgba(var(--primary-rgb, 5, 150, 105), 0.1)',
                  'color': 'var(--primary)',
                  'flex-shrink': '0',
                  'transition': 'transform 0.2s ease, background 0.2s ease',
                },
              ),
              [
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'font-size': '0.75rem',
                      'line-height': '1',
                    },
                  ),
                  [const Component.text('\u25BC')],
                ),
              ],
            ),
          ],
        ),
        // Content (shown when open)
        dom.div(
          styles: const dom.Styles(
            raw: {
              'padding': '0 1.25rem 1.25rem 1.25rem',
              'border-top': '1px solid rgba(255, 255, 255, 0.06)',
            },
          ),
          [
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'padding-top': '1.25rem',
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.75',
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
