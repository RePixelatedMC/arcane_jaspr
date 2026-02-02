import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
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
///
/// Supports two variants:
/// - `standard`: Basic accordion with toggle icons
/// - `faq`: FAQ-style with category badges and accent colors
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
    // Use item's accent color, fallback to default, or fallback to primary
    final String accentColor =
        item.accentColor ?? props.defaultAccentColor ?? 'var(--primary)';
    final bool showCategory =
        props.variant == AccordionVariant.faq && item.category != null;

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
            // Category badge and chevron container
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '0.75rem',
                  'flex-shrink': '0',
                },
              ),
              [
                // Category badge (FAQ variant only)
                if (showCategory)
                  dom.span(
                    styles: dom.Styles(
                      raw: {
                        'font-size': '0.6875rem',
                        'font-weight': '500',
                        'color': accentColor,
                        'background': '${accentColor}12',
                        'border-radius': '9999px',
                        'padding': '0.25rem 0.625rem',
                        'text-transform': 'uppercase',
                        'letter-spacing': '0.025em',
                      },
                    ),
                    [Component.text(item.category!)],
                  ),
                // Chevron button
                dom.div(
                  classes: 'faq-chevron',
                  styles: dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'width': '28px',
                      'height': '28px',
                      'border-radius': '6px',
                      'background': '${accentColor}10',
                      'color': accentColor,
                      'flex-shrink': '0',
                      'transition': 'transform 0.2s ease, background 0.2s ease',
                    },
                  ),
                  [ArcaneIcon.chevronDown(size: IconSize.sm)],
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
              'border-top':
                  '1px solid color-mix(in srgb, var(--foreground) 6%, transparent)',
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
