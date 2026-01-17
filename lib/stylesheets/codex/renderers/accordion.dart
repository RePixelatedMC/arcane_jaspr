import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/accordion_props.dart';

/// Codex Accordion renderer.
///
/// Implements the Codex design language:
/// - Larger padding
/// - Accent-colored when open
/// - Smooth animations
///
/// This is a StatefulComponent that manages its own open/closed state internally,
/// ensuring proper event handling in SSR environments.
class CodexAccordion extends StatefulComponent {
  final AccordionProps props;

  const CodexAccordion(this.props, {super.key});

  @override
  State<CodexAccordion> createState() => _CodexAccordionState();
}

class _CodexAccordionState extends State<CodexAccordion> {
  late Set<int> _openItems;

  @override
  void initState() {
    super.initState();
    // Initialize with the provided open items from props
    _openItems = Set<int>.from(component.props.openItems);
  }

  void _toggleItem(int index) {
    setState(() {
      if (_openItems.contains(index)) {
        _openItems.remove(index);
      } else {
        if (!component.props.allowMultiple) {
          _openItems.clear();
        }
        _openItems.add(index);
      }
    });
    // Also call the external callback if provided
    component.props.onToggle?.call(index);
  }

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-accordion ${component.props.bordered ? 'bordered' : ''}',
      styles: dom.Styles(raw: {
        'width': '100%',
        if (component.props.bordered) ...{
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius)',
          'overflow': 'hidden',
        },
      }),
      [
        for (int i = 0; i < component.props.items.length; i++)
          _buildItem(component.props.items[i], i, i == component.props.items.length - 1),
      ],
    );
  }

  Component _buildItem(AccordionItemProps item, int index, bool isLast) {
    final bool isOpen = _openItems.contains(index);

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
            'font-weight': 'var(--font-weight-medium)',
            'color': isOpen ? 'var(--primary)' : 'var(--foreground)',
            'text-align': 'left',
            'cursor': 'pointer',
            'transition': 'all var(--transition)',
          }),
          events: {
            'click': (_) => _toggleItem(index),
          },
          [
            Component.text(item.title),
            dom.span(
              styles: dom.Styles(raw: {
                'font-size': 'var(--font-size-xs)',
                'color': isOpen ? 'var(--primary)' : 'var(--muted-foreground)',
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
                      'font-size': 'var(--font-size-sm)',
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
