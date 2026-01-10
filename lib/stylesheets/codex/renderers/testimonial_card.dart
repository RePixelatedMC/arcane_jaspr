import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/testimonial_card_props.dart';

/// Codex TestimonialCard renderer.
class CodexTestimonialCard extends StatelessComponent {
  final TestimonialCardProps props;

  const CodexTestimonialCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-testimonial-card',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1.25rem',
        'padding': '1.5rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      [
        // Rating
        if (props.rating != null)
          dom.div(
            classes: 'codex-testimonial-rating',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'gap': 'var(--space-1)',
            }),
            [
              for (int i = 0; i < 5; i++)
                dom.span(
                  styles: dom.Styles(raw: {
                    'color': i < props.rating!
                        ? 'var(--primary)'
                        : 'var(--muted-foreground)',
                    'font-size': 'var(--font-size-base)',
                  }),
                  [Component.text(i < props.rating! ? '*' : 'o')],
                ),
            ],
          ),

        // Quote
        dom.blockquote(
          classes: 'codex-testimonial-quote',
          styles: const dom.Styles(raw: {
            'font-size': '0.9375rem',
            'line-height': '1.6',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [
            if (props.showQuotes)
              const dom.span(
                styles: dom.Styles(raw: {
                  'color': 'var(--primary)',
                  'font-size': 'var(--font-size-2xl)',
                  'line-height': '0',
                  'vertical-align': 'bottom',
                  'margin-right': '0.25rem',
                }),
                [Component.text('"')],
              ),
            Component.text(props.quote),
            if (props.showQuotes)
              const dom.span(
                styles: dom.Styles(raw: {
                  'color': 'var(--primary)',
                  'font-size': 'var(--font-size-2xl)',
                  'line-height': '0',
                  'vertical-align': 'bottom',
                  'margin-left': '0.25rem',
                }),
                [Component.text('"')],
              ),
          ],
        ),

        // Author
        dom.div(
          classes: 'codex-testimonial-author',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.75rem',
          }),
          [
            // Avatar
            if (props.avatarUrl != null)
              dom.img(
                src: props.avatarUrl!,
                classes: 'codex-testimonial-avatar',
                styles: const dom.Styles(raw: {
                  'width': '40px',
                  'height': '40px',
                  'border-radius': '50%',
                  'object-fit': 'cover',
                }),
              )
            else
              dom.div(
                classes: 'codex-testimonial-avatar-placeholder',
                styles: const dom.Styles(raw: {
                  'width': '40px',
                  'height': '40px',
                  'border-radius': '50%',
                  'background-color': 'var(--primary)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'color': '#ffffff',
                  'font-weight': 'var(--font-weight-semibold)',
                  'font-size': 'var(--font-size-base)',
                }),
                [Component.text(props.authorName.substring(0, 1).toUpperCase())],
              ),

            // Info
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '0.125rem',
              }),
              [
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.authorName)],
                ),
                if (props.authorTitle != null || props.authorCompany != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.8125rem',
                      'color': 'var(--muted-foreground)',
                    }),
                    [
                      Component.text([
                        if (props.authorTitle != null) props.authorTitle!,
                        if (props.authorTitle != null &&
                            props.authorCompany != null)
                          ' at ',
                        if (props.authorCompany != null) props.authorCompany!,
                      ].join('')),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}