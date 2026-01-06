import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';

/// ShadCN Footer renderer.
class ShadcnFooter extends StatelessComponent {
  final FooterProps props;

  const ShadcnFooter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'footer',
      classes: 'arcane-footer',
      styles: const dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border-top': '1px solid var(--border)',
        'padding': '64px 1.5rem 1.5rem',
      }),
      children: [
        // Main footer content
        dom.div(
          classes: 'arcane-footer-main',
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
            'display': 'grid',
            'grid-template-columns': 'repeat(auto-fit, minmax(160px, 1fr))',
            'gap': '3rem',
          }),
          [
            // Brand column
            if (props.logo != null || props.description != null)
              dom.div(
                classes: 'arcane-footer-brand',
                styles: const dom.Styles(raw: {
                  'grid-column': 'span 2',
                }),
                [
                  if (props.logo != null) props.logo!,
                  if (props.description != null)
                    dom.p(
                      styles: const dom.Styles(raw: {
                        'margin': '1rem 0 0 0',
                        'font-size': '0.875rem',
                        'color': 'var(--muted-foreground)',
                        'max-width': '280px',
                        'line-height': '1.6',
                      }),
                      [Component.text(props.description!)],
                    ),
                  if (props.socialLinks != null)
                    dom.div(
                      classes: 'arcane-footer-social',
                      styles: const dom.Styles(raw: {
                        'display': 'flex',
                        'gap': '1rem',
                        'margin-top': '1.5rem',
                      }),
                      props.socialLinks!,
                    ),
                ],
              ),

            // Link groups
            for (final group in props.linkGroups)
              dom.div(
                classes: 'arcane-footer-group',
                [
                  dom.div(
                    classes: 'arcane-footer-group-title',
                    styles: const dom.Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--foreground)',
                      'margin-bottom': '1rem',
                    }),
                    [Component.text(group.title)],
                  ),
                  dom.div(
                    classes: 'arcane-footer-group-links',
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'flex-direction': 'column',
                      'gap': '0.5rem',
                    }),
                    [
                      for (final link in group.links) _buildLink(link),
                    ],
                  ),
                ],
              ),

            // Newsletter
            if (props.showNewsletter)
              dom.div(
                classes: 'arcane-footer-newsletter',
                [
                  const dom.div(
                    styles: dom.Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--foreground)',
                      'margin-bottom': '1rem',
                    }),
                    [Component.text('Subscribe to our newsletter')],
                  ),
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'gap': '0.5rem',
                    }),
                    [
                      dom.input(
                        type: dom.InputType.email,
                        attributes: {
                          'placeholder': props.newsletterPlaceholder,
                        },
                        styles: const dom.Styles(raw: {
                          'flex': '1',
                          'padding': '10px 14px',
                          'font-size': '0.875rem',
                          'background-color': 'var(--muted)',
                          'border': '1px solid var(--border)',
                          'border-radius': '0.375rem',
                          'color': 'var(--foreground)',
                          'outline': 'none',
                        }),
                      ),
                      dom.button(
                        attributes: {'type': 'submit'},
                        styles: const dom.Styles(raw: {
                          'padding': '10px 1rem',
                          'font-size': '0.875rem',
                          'font-weight': '500',
                          'background-color': 'var(--accent)',
                          'color': 'var(--accent-foreground)',
                          'border': 'none',
                          'border-radius': '0.375rem',
                          'cursor': 'pointer',
                          'transition': 'all 150ms ease',
                        }),
                        [Component.text(props.newsletterButtonText)],
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),

        // Bottom bar
        dom.div(
          classes: 'arcane-footer-bottom',
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '3rem auto 0',
            'padding-top': '1.5rem',
            'border-top': '1px solid var(--border)',
            'display': 'flex',
            'justify-content': 'space-between',
            'align-items': 'center',
            'flex-wrap': 'wrap',
            'gap': '1rem',
          }),
          [
            // Copyright
            if (props.copyright != null)
              dom.span(
                [Component.text(props.copyright!)],
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                }),
              ),

            // Bottom links
            if (props.bottomLinks != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'gap': '1.5rem',
                }),
                [
                  for (final link in props.bottomLinks!) _buildLink(link),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildLink(FooterLink link) {
    const dom.Styles linkStyles = dom.Styles(raw: {
      'font-size': '0.875rem',
      'color': 'var(--muted-foreground)',
      'text-decoration': 'none',
      'transition': 'all 150ms ease',
    });

    if (link.href != null) {
      return dom.a(
        href: link.href!,
        classes: 'arcane-footer-link',
        styles: linkStyles,
        attributes: link.external
            ? {'target': '_blank', 'rel': 'noopener noreferrer'}
            : null,
        [Component.text(link.label)],
      );
    }

    return dom.button(
      classes: 'arcane-footer-link',
      attributes: {'type': 'button'},
      styles: const dom.Styles(raw: {
        'font-size': '0.875rem',
        'color': 'var(--muted-foreground)',
        'text-decoration': 'none',
        'transition': 'all 150ms ease',
        'background': 'none',
        'border': 'none',
        'padding': '0',
        'cursor': 'pointer',
      }),
      events: {'click': (e) => link.onTap?.call()},
      [Component.text(link.label)],
    );
  }
}

/// ShadCN Footer Social Icon renderer.
class ShadcnFooterSocialIcon extends StatelessComponent {
  final FooterSocialIconProps props;

  const ShadcnFooterSocialIcon(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    const dom.Styles iconStyles = dom.Styles(raw: {
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'width': '36px',
      'height': '36px',
      'border-radius': '0.375rem',
      'color': 'var(--muted-foreground)',
      'background': 'none',
      'border': 'none',
      'cursor': 'pointer',
      'transition': 'all 150ms ease',
    });

    if (props.href != null) {
      return dom.a(
        href: props.href!,
        classes: 'arcane-social-icon',
        styles: iconStyles,
        attributes: {
          'aria-label': props.label,
          'target': '_blank',
          'rel': 'noopener noreferrer',
        },
        [props.icon],
      );
    }

    return dom.button(
      classes: 'arcane-social-icon',
      attributes: {
        'type': 'button',
        'aria-label': props.label,
      },
      styles: iconStyles,
      events: {'click': (e) => props.onTap?.call()},
      [props.icon],
    );
  }
}