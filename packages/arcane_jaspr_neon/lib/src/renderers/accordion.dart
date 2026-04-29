import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/accordion_props.dart';

/// Neon Accordion renderer.
///
/// Uses native HTML details/summary elements for reliable expand/collapse
/// behavior that works in SSR environments without JavaScript hydration issues.
///
/// Implements the Neon design language:
/// - Clean card-based items with subtle borders
/// - Accent-colored chevron buttons
/// - Smooth CSS transitions
///
/// Supports two variants:
/// - `standard`: Basic accordion with toggle icons
/// - `faq`: FAQ-style with category badges and accent colors
class NeonAccordion extends StatelessComponent {
  final AccordionProps props;

  const NeonAccordion(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-accordion faq-container',
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
    final String accentColor =
        item.accentColor ?? props.defaultAccentColor ?? 'var(--neon-accent)';
    final bool showCategory =
        props.variant == AccordionVariant.faq && item.category != null;

    return Component.element(
      tag: 'details',
      attributes: {if (defaultOpen) 'open': ''},
      styles: const dom.Styles(
        raw: {
          'background': 'var(--neon-panel-surface)',
          'border': '1px solid var(--neon-panel-border)',
          'clip-path': 'var(--neon-clip-md)',
          'box-shadow':
              'var(--neon-shadow-sm), inset 0 1px 0 var(--neon-inset)',
          'overflow': 'hidden',
        },
      ),
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
              'padding': '1.125rem 1.25rem',
              'cursor': 'pointer',
              'list-style': 'none',
              '-webkit-user-select': 'none',
              'user-select': 'none',
              'transition': 'background 140ms ease',
            },
          ),
          children: [
            // Title text
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'flex-grow': '1',
                  'font-family': 'var(--font-heading)',
                  'font-size': '0.9375rem',
                  'font-weight': 'var(--font-weight-semibold)',
                  'letter-spacing': '0.02em',
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
                // Category badge (FAQ variant only) — chamfered
                if (showCategory)
                  dom.span(
                    styles: dom.Styles(
                      raw: {
                        'font-family': 'var(--font-heading)',
                        'font-size': '0.625rem',
                        'font-weight': 'var(--font-weight-semibold)',
                        'color': accentColor,
                        'background':
                            'color-mix(in srgb, $accentColor 14%, transparent)',
                        'border':
                            '1px solid color-mix(in srgb, $accentColor 38%, transparent)',
                        'clip-path': 'var(--neon-clip-xs)',
                        'padding': '0.25rem 0.625rem',
                        'text-transform': 'uppercase',
                        'letter-spacing': '0.08em',
                      },
                    ),
                    [Component.text(item.category!)],
                  ),
                // Chevron button — chamfered
                dom.div(
                  classes: 'faq-chevron',
                  styles: dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'width': '28px',
                      'height': '28px',
                      'clip-path': 'var(--neon-clip-xs)',
                      'background':
                          'color-mix(in srgb, $accentColor 12%, transparent)',
                      'border':
                          '1px solid color-mix(in srgb, $accentColor 28%, transparent)',
                      'color': accentColor,
                      'flex-shrink': '0',
                      'transition': 'transform 200ms ease, background 200ms ease',
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
                  '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
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
              [item.customContent ?? Component.text(item.content)],
            ),
          ],
        ),
      ],
    );
  }
}
