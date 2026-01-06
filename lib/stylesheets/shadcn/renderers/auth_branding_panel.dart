import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/auth_branding_panel_props.dart';

/// ShadCN Auth Branding Panel renderer.
class ShadcnAuthBrandingPanel extends StatelessComponent {
  final AuthBrandingPanelProps props;

  const ShadcnAuthBrandingPanel(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-auth-branding-panel',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'height': '100%',
      }),
      [
        // Logo
        if (props.logoUrl != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'margin-bottom': '3rem',
            }),
            [
              dom.img(
                src: props.logoUrl!,
                alt: 'Logo',
                styles: const dom.Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'border-radius': '0.5rem',
                  'object-fit': 'contain',
                }),
              ),
            ],
          ),

        // Tagline
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': '1.875rem',
            'font-weight': '700',
            'color': 'var(--foreground)',
            'margin-bottom': '0.75rem',
            'line-height': '1.25',
            'letter-spacing': '-0.025em',
          }),
          [Component.text(props.tagline)],
        ),

        // Description
        if (props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '1rem',
              'color': 'var(--muted-foreground)',
              'margin-bottom': '2rem',
              'line-height': '1.625',
            }),
            [Component.text(props.description!)],
          ),

        // Features list
        if (props.features != null && props.features!.isNotEmpty)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.75rem',
              'margin-bottom': '3rem',
            }),
            [
              for (final feature in props.features!) _buildFeatureItem(feature),
            ],
          ),

        // Testimonial
        if (props.testimonialQuote != null) _buildTestimonial(),
      ],
    );
  }

  Component _buildFeatureItem(String text) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.625rem',
      }),
      [
        // Checkmark icon
        dom.div(
          styles: const dom.Styles(raw: {
            'width': '20px',
            'height': '20px',
            'border-radius': '9999px',
            'background': 'hsl(var(--accent) / 0.2)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'margin-top': '2px',
            'color': 'var(--accent)',
          }),
          [ArcaneIcon.check(size: IconSize.xs)],
        ),
        // Feature text
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--foreground)',
            'line-height': '1.5',
          }),
          [Component.text(text)],
        ),
      ],
    );
  }

  Component _buildTestimonial() {
    return dom.div(
      styles: const dom.Styles(raw: {
        'padding': '1.5rem',
        'background': 'hsl(var(--card) / 0.5)',
        'border': '1px solid var(--border)',
        'border-radius': '0.5rem',
        'margin-top': 'auto',
      }),
      [
        // Quote
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--foreground)',
            'margin-bottom': '1rem',
            'line-height': '1.625',
            'font-style': 'italic',
          }),
          [Component.text('"${props.testimonialQuote}"')],
        ),
        // Author
        if (props.testimonialAuthor != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.625rem',
            }),
            [
              // Avatar placeholder
              dom.div(
                styles: const dom.Styles(raw: {
                  'width': '36px',
                  'height': '36px',
                  'border-radius': '9999px',
                  'background': 'linear-gradient(135deg, var(--accent) 0%, var(--info) 100%)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': '0.875rem',
                  'font-weight': '600',
                  'color': 'var(--accent-foreground)',
                }),
                [Component.text(props.testimonialAuthor![0].toUpperCase())],
              ),
              dom.div(
                [
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.875rem',
                      'font-weight': '600',
                      'color': 'var(--foreground)',
                    }),
                    [Component.text(props.testimonialAuthor!)],
                  ),
                  if (props.testimonialTitle != null)
                    dom.div(
                      styles: const dom.Styles(raw: {
                        'font-size': '0.75rem',
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