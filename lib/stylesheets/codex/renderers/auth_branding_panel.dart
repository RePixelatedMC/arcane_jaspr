import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/auth_branding_panel_props.dart';

/// Codex AuthBrandingPanel renderer.
class CodexAuthBrandingPanel extends StatelessComponent {
  final AuthBrandingPanelProps props;

  const CodexAuthBrandingPanel(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-auth-branding-panel',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'padding': '3rem',
        'height': '100%',
        'background': 'linear-gradient(135deg, var(--card) 0%, var(--background) 100%)',
      }),
      [
        // Logo
        if (props.logoUrl != null)
          dom.img(
            classes: 'codex-auth-branding-logo',
            src: props.logoUrl!,
            styles: const dom.Styles(raw: {
              'height': '48px',
              'width': 'auto',
              'object-fit': 'contain',
              'margin-bottom': '2rem',
            }),
          ),

        // Tagline
        dom.h1(
          classes: 'codex-auth-branding-tagline',
          styles: const dom.Styles(raw: {
            'font-size': '2rem',
            'font-weight': '700',
            'color': 'var(--foreground)',
            'margin': '0 0 1rem 0',
            'line-height': '1.2',
          }),
          [Component.text(props.tagline)],
        ),

        // Description
        if (props.description != null)
          dom.p(
            classes: 'codex-auth-branding-description',
            styles: const dom.Styles(raw: {
              'font-size': '1rem',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 2rem 0',
              'line-height': '1.6',
            }),
            [Component.text(props.description!)],
          ),

        // Features list
        if (props.features != null && props.features!.isNotEmpty)
          dom.ul(
            classes: 'codex-auth-branding-features',
            styles: const dom.Styles(raw: {
              'list-style': 'none',
              'padding': '0',
              'margin': '0 0 2rem 0',
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.75rem',
            }),
            [
              for (final feature in props.features!)
                dom.li(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'gap': '0.75rem',
                    'font-size': '0.9375rem',
                    'color': 'var(--foreground)',
                  }),
                  [
                    // Checkmark
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'display': 'flex',
                        'align-items': 'center',
                        'justify-content': 'center',
                        'width': '20px',
                        'height': '20px',
                        'background-color': 'rgba(var(--codex-accent-rgb), 0.15)',
                        'color': 'var(--codex-accent)',
                        'border-radius': '50%',
                        'font-size': '0.75rem',
                      }),
                      [const Component.text('[check]')],
                    ),
                    Component.text(feature),
                  ],
                ),
            ],
          ),

        // Testimonial
        if (props.testimonialQuote != null)
          dom.div(
            classes: 'codex-auth-branding-testimonial',
            styles: const dom.Styles(raw: {
              'padding': '1.5rem',
              'background-color': 'var(--secondary)',
              'border-radius': 'var(--radius)',
              'border-left': '3px solid var(--codex-accent)',
            }),
            [
              // Quote
              dom.p(
                styles: const dom.Styles(raw: {
                  'font-size': '0.9375rem',
                  'font-style': 'italic',
                  'color': 'var(--foreground)',
                  'margin': '0 0 1rem 0',
                  'line-height': '1.5',
                }),
                [Component.text('"${props.testimonialQuote}"')],
              ),

              // Author
              if (props.testimonialAuthor != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'flex-direction': 'column',
                    'gap': '0.125rem',
                  }),
                  [
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'font-size': '0.875rem',
                        'font-weight': '600',
                        'color': 'var(--foreground)',
                      }),
                      [Component.text(props.testimonialAuthor!)],
                    ),
                    if (props.testimonialTitle != null)
                      dom.span(
                        styles: const dom.Styles(raw: {
                          'font-size': '0.8125rem',
                          'color': 'var(--muted-foreground)',
                        }),
                        [Component.text(props.testimonialTitle!)],
                      ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}
