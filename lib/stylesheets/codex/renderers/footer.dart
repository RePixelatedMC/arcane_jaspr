import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/footer_props.dart';

/// Codex Footer renderer.
///
/// Implements the Codex design language:
/// - Dark background with subtle border
/// - Larger padding
/// - Accent-colored hover states
class CodexFooter extends StatelessComponent {
  final FooterProps props;

  const CodexFooter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.footer(
      classes: 'codex-footer',
      styles: const dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border-top': '1px solid var(--border)',
        'padding': '4rem 2rem 2rem 2rem', // Codex: larger padding
      }),
      [
        dom.div(
          classes: 'codex-footer-container',
          styles: const dom.Styles(raw: {
            'max-width': '1200px',
            'margin': '0 auto',
          }),
          [
            // Top section
            dom.div(
              classes: 'codex-footer-top',
              styles: const dom.Styles(raw: {
                'display': 'grid',
                'grid-template-columns': 'repeat(auto-fit, minmax(200px, 1fr))',
                'gap': '3rem', // Codex: larger gap
              }),
              [
                // Brand column
                if (props.logo != null || props.description != null)
                  dom.div(
                    classes: 'codex-footer-brand',
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'flex-direction': 'column',
                      'gap': 'var(--arcane-space-4)',
                    }),
                    [
                      if (props.logo != null) props.logo!,
                      if (props.description != null)
                        dom.p(
                          styles: const dom.Styles(raw: {
                            'font-size': 'var(--arcane-font-size-sm)',
                            'color': 'var(--muted-foreground)',
                            'line-height': '1.6',
                            'margin': '0',
                            'max-width': '280px',
                          }),
                          [Component.text(props.description!)],
                        ),
                      // Social links
                      if (props.socialLinks != null && props.socialLinks!.isNotEmpty)
                        dom.div(
                          classes: 'codex-footer-social',
                          styles: const dom.Styles(raw: {
                            'display': 'flex',
                            'gap': '0.75rem',
                            'margin-top': '0.5rem',
                          }),
                          props.socialLinks!,
                        ),
                    ],
                  ),

                // Link groups
                for (final group in props.linkGroups)
                  dom.div(
                    classes: 'codex-footer-group',
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'flex-direction': 'column',
                      'gap': '0.75rem',
                    }),
                    [
                      dom.h4(
                        styles: const dom.Styles(raw: {
                          'font-size': 'var(--arcane-font-size-sm)',
                          'font-weight': 'var(--arcane-font-weight-semibold)',
                          'color': 'var(--foreground)',
                          'margin': '0 0 0.5rem 0',
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                        }),
                        [Component.text(group.title)],
                      ),
                      for (final link in group.links)
                        _buildLink(link),
                    ],
                  ),

                // Newsletter
                if (props.showNewsletter)
                  dom.div(
                    classes: 'codex-footer-newsletter',
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'flex-direction': 'column',
                      'gap': '0.75rem',
                    }),
                    [
                      const dom.h4(
                        styles: dom.Styles(raw: {
                          'font-size': 'var(--arcane-font-size-sm)',
                          'font-weight': 'var(--arcane-font-weight-semibold)',
                          'color': 'var(--foreground)',
                          'margin': '0 0 0.5rem 0',
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                        }),
                        [Component.text('Newsletter')],
                      ),
                      dom.div(
                        classes: 'codex-footer-newsletter-form',
                        styles: const dom.Styles(raw: {
                          'display': 'flex',
                          'gap': 'var(--arcane-space-2)',
                        }),
                        [
                          dom.input(
                            type: dom.InputType.email,
                            attributes: {
                              'placeholder': props.newsletterPlaceholder,
                            },
                            styles: const dom.Styles(raw: {
                              'flex': '1',
                              'padding': '0.75rem 1rem',
                              'background-color': 'var(--input)',
                              'border': '1px solid var(--border)',
                              'border-radius': 'var(--radius)',
                              'color': 'var(--foreground)',
                              'font-size': 'var(--arcane-font-size-sm)',
                            }),
                          ),
                          dom.button(
                            attributes: {'type': 'submit'},
                            styles: const dom.Styles(raw: {
                              'padding': '0.75rem 1.25rem',
                              'background-color': 'var(--codex-accent)',
                              'color': '#ffffff',
                              'border': 'none',
                              'border-radius': 'var(--radius)',
                              'font-size': 'var(--arcane-font-size-sm)',
                              'font-weight': 'var(--arcane-font-weight-medium)',
                              'cursor': 'pointer',
                              'white-space': 'nowrap',
                            }),
                            [Component.text(props.newsletterButtonText)],
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),

            // Bottom section
            dom.div(
              classes: 'codex-footer-bottom',
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-wrap': 'wrap',
                'justify-content': 'space-between',
                'align-items': 'center',
                'gap': 'var(--arcane-space-4)',
                'margin-top': '3rem',
                'padding-top': '2rem',
                'border-top': '1px solid var(--border)',
              }),
              [
                // Copyright
                if (props.copyright != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.8125rem',
                      'color': 'var(--muted-foreground)',
                    }),
                    [Component.text(props.copyright!)],
                  ),

                // Bottom links
                if (props.bottomLinks != null && props.bottomLinks!.isNotEmpty)
                  dom.div(
                    classes: 'codex-footer-bottom-links',
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'flex-wrap': 'wrap',
                      'gap': 'var(--arcane-space-6)',
                    }),
                    [
                      for (final link in props.bottomLinks!) _buildLink(link),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildLink(FooterLink link) {
    return dom.a(
      classes: 'codex-footer-link',
      href: link.href ?? '#',
      attributes: {
        if (link.external) 'target': '_blank',
        if (link.external) 'rel': 'noopener noreferrer',
      },
      styles: const dom.Styles(raw: {
        'font-size': 'var(--arcane-font-size-sm)',
        'color': 'var(--muted-foreground)',
        'text-decoration': 'none',
        'transition': 'color var(--transition)',
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
      }),
      events: link.onTap == null ? null : {'click': (_) => link.onTap!()},
      [
        if (link.icon != null)
          dom.span(
            styles: const dom.Styles(raw: {'font-size': 'var(--arcane-font-size-base)'}),
            [Component.text(link.icon!)],
          ),
        Component.text(link.label),
        if (link.external)
          const dom.span(
            styles: dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'opacity': '0.6',
            }),
            [Component.text('->')],
          ),
      ],
    );
  }
}

/// Codex Footer Social Icon renderer.
class CodexFooterSocialIcon extends StatelessComponent {
  final FooterSocialIconProps props;

  const CodexFooterSocialIcon(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.a(
      classes: 'codex-footer-social-icon',
      href: props.href ?? '#',
      attributes: {
        'aria-label': props.label,
        'target': '_blank',
        'rel': 'noopener noreferrer',
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '40px', // Codex: larger
        'height': '40px',
        'border-radius': 'var(--radius)',
        'background-color': 'var(--secondary)',
        'color': 'var(--muted-foreground)',
        'text-decoration': 'none',
        'transition': 'all var(--transition)',
      }),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [props.icon],
    );
  }
}