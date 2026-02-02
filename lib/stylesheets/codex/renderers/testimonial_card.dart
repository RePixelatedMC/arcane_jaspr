import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/testimonial_card_props.dart';

/// Codex TestimonialCard renderer.
///
/// Supports rating-based styling with:
/// - Colored accent border at top (based on rating)
/// - Unicode star display (filled/empty)
/// - Rating badge (X/5) with accent color
class CodexTestimonialCard extends StatelessComponent {
  final TestimonialCardProps props;

  const CodexTestimonialCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String accentColor = props.effectiveAccentColor;

    return dom.div(
      classes: 'codex-testimonial-card',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1rem',
        'padding': '1.25rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        if (props.showAccentBorder && props.rating != null)
          'border-top': '2px solid $accentColor',
      }),
      [
        // Rating row (stars + optional badge)
        if (props.rating != null)
          dom.div(
            classes: 'codex-testimonial-rating',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'gap': '0.5rem',
            }),
            [
              // Stars
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'gap': '0',
                }),
                [
                  for (int i = 0; i < 5; i++)
                    dom.span(
                      styles: dom.Styles(raw: {
                        'color': i < props.rating!
                            ? 'var(--warning, #eab308)'
                            : 'var(--muted-foreground)',
                        'font-size': '0.875rem',
                      }),
                      // Unicode filled star vs empty star
                      [Component.text(i < props.rating! ? '\u2605' : '\u2606')],
                    ),
                ],
              ),
              // Rating badge (X/5)
              if (props.showRatingBadge)
                dom.span(
                  styles: dom.Styles(raw: {
                    'font-size': '0.75rem',
                    'font-weight': '600',
                    'color': accentColor,
                  }),
                  [Component.text('${props.rating}/5')],
                ),
            ],
          ),

        // Quote
        dom.blockquote(
          classes: 'codex-testimonial-quote',
          styles: const dom.Styles(raw: {
            'font-size': '0.875rem',
            'line-height': '1.7',
            'color': 'var(--muted-foreground)',
            'margin': '0',
            'flex': '1',
          }),
          [
            if (props.showQuotes)
              const dom.span(
                styles: dom.Styles(raw: {
                  'color': 'var(--primary)',
                  'font-size': '1.25rem',
                  'line-height': '0',
                  'vertical-align': 'bottom',
                  'margin-right': '0.125rem',
                }),
                [Component.text('"')],
              ),
            Component.text(props.quote),
            if (props.showQuotes)
              const dom.span(
                styles: dom.Styles(raw: {
                  'color': 'var(--primary)',
                  'font-size': '1.25rem',
                  'line-height': '0',
                  'vertical-align': 'bottom',
                  'margin-left': '0.125rem',
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
            'margin-top': 'auto',
          }),
          [
            // Avatar
            if (props.avatarUrl != null)
              dom.img(
                src: props.avatarUrl!,
                classes: 'codex-testimonial-avatar',
                styles: const dom.Styles(raw: {
                  'width': '36px',
                  'height': '36px',
                  'border-radius': '50%',
                  'object-fit': 'cover',
                }),
              )
            else
              dom.div(
                classes: 'codex-testimonial-avatar-placeholder',
                styles: const dom.Styles(raw: {
                  'width': '36px',
                  'height': '36px',
                  'border-radius': '50%',
                  'background-color': 'var(--primary)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'color': '#ffffff',
                  'font-weight': '600',
                  'font-size': '0.875rem',
                }),
                [Component.text(props.authorName.substring(0, 1).toUpperCase())],
              ),

            // Info
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'flex-direction': 'column',
                'gap': '0',
              }),
              [
                // Author name
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.75rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.authorName)],
                ),
                // Title/Company
                if (props.authorTitle != null || props.authorCompany != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.75rem',
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
