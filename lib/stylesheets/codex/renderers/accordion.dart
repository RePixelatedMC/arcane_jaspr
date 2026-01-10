import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/accordion_props.dart';

/// Codex Accordion renderer.
///
/// Implements the Codex design language:
/// - Larger padding
/// - Accent-colored when open
/// - Smooth animations
class CodexAccordion extends StatelessComponent {
  final AccordionProps props;

  const CodexAccordion(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-accordion ${props.bordered ? 'bordered' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        if (props.bordered) ...{
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius)',
          'overflow': 'hidden',
        },
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildItem(props.items[i], i, i == props.items.length - 1),
      ],
    );
  }

  Component _buildItem(AccordionItemProps item, int index, bool isLast) {
    final bool isOpen = props.openItems.contains(index);

    return dom.div(
      classes: 'codex-accordion-item ${isOpen ? 'open' : 'closed'}',
      styles: dom.Styles(raw: {
        if (!isLast) 'border-bottom': '1px solid var(--border)',
      }),
      [
        // Header/trigger
        dom.button(
          classes: 'codex-accordion-trigger',
          attributes: {
            'type': 'button',
            'aria-expanded': isOpen.toString(),
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'width': '100%',
            // Codex: larger padding
            'padding': '1rem 1.25rem',
            'background': 'transparent',
            'border': 'none',
            'font-size': '0.9375rem',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': isOpen ? 'var(--codex-accent)' : 'var(--foreground)',
            'text-align': 'left',
            'cursor': 'pointer',
            'transition': 'all var(--transition)',
          }),
          events: props.onToggle == null
              ? null
              : {'click': (_) => props.onToggle!(index)},
          [
            Component.text(item.title),
            dom.span(
              styles: dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-xs)',
                'color': isOpen ? 'var(--codex-accent)' : 'var(--muted-foreground)',
                'transition': 'transform var(--transition)',
                'transform': isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
              }),
              [const Component.text('\u25BC')], // Down arrow
            ),
          ],
        ),

        // Content (shown when open)
        if (isOpen)
          dom.div(
            classes: 'codex-accordion-content',
            styles: const dom.Styles(raw: {
              'padding': '0 1.25rem 1.25rem 1.25rem', // Codex: larger padding
            }),
            [
              item.customContent ??
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--arcane-font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'line-height': '1.6',
                    }),
                    [Component.text(item.content)],
                  ),
            ],
          ),
      ],
    );
  }
}
