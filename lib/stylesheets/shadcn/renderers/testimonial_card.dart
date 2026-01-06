import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/testimonial_card_props.dart';

/// ShadCN Testimonial Card renderer.
class ShadcnTestimonialCard extends StatelessComponent {
  final TestimonialCardProps props;

  const ShadcnTestimonialCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-testimonial-card',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '2rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.75rem',
      }),
      [
        // Rating stars
        if (props.rating != null)
          dom.div(
            classes: 'arcane-testimonial-rating',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'gap': '2px',
              'margin-bottom': '1.5rem',
            }),
            [
              for (var i = 0; i < 5; i++)
                dom.span(
                  styles: dom.Styles(raw: {
                    'font-size': '1rem',
                    'color': i < props.rating!
                        ? 'hsl(38 92% 50%)'
                        : 'var(--muted-foreground)',
                  }),
                  [const Component.text('\u2605')],
                ),
            ],
          ),

        // Quote
        dom.div(
          classes: 'arcane-testimonial-quote',
          styles: const dom.Styles(raw: {
            'position': 'relative',
            'font-size': '1rem',
            'line-height': '1.7',
            'color': 'var(--foreground)',
            'margin-bottom': '1.5rem',
            'flex': '1',
          }),
          [
            if (props.showQuotes)
              const dom.span(
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'top': '-8px',
                  'left': '-4px',
                  'font-size': '2.5rem',
                  'color': 'var(--accent)',
                  'opacity': '0.3',
                  'font-family': 'Georgia, serif',
                  'line-height': '1',
                }),
                [Component.text('"')],
              ),
            dom.p(
              styles: dom.Styles(raw: {
                'margin': '0',
                if (props.showQuotes) 'padding-left': '1.5rem',
              }),
              [Component.text(props.quote)],
            ),
          ],
        ),

        // Author
        dom.div(
          classes: 'arcane-testimonial-author',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
          }),
          [
            // Avatar
            if (props.avatarUrl != null)
              dom.div(
                classes: 'arcane-testimonial-avatar',
                styles: const dom.Styles(raw: {
                  'width': '44px',
                  'height': '44px',
                  'border-radius': '9999px',
                  'overflow': 'hidden',
                  'flex-shrink': '0',
                }),
                [
                  dom.img(
                    src: props.avatarUrl!,
                    alt: props.authorName,
                    styles: const dom.Styles(raw: {
                      'width': '100%',
                      'height': '100%',
                      'object-fit': 'cover',
                    }),
                  ),
                ],
              )
            else
              dom.div(
                classes: 'arcane-testimonial-avatar-placeholder',
                styles: const dom.Styles(raw: {
                  'width': '44px',
                  'height': '44px',
                  'border-radius': '9999px',
                  'background-color': 'hsl(var(--accent) / 0.1)',
                  'color': 'var(--accent)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-weight': '600',
                  'font-size': '1rem',
                  'flex-shrink': '0',
                }),
                [Component.text(props.authorName[0].toUpperCase())],
              ),

            // Author info
            dom.div(
              classes: 'arcane-testimonial-author-info',
              [
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-weight': '600',
                    'font-size': '1rem',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.authorName)],
                ),
                if (props.authorTitle != null || props.authorCompany != null)
                  dom.div(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.875rem',
                      'color': 'var(--muted-foreground)',
                      'margin-top': '2px',
                    }),
                    [
                      Component.text([
                        if (props.authorTitle != null) props.authorTitle,
                        if (props.authorTitle != null && props.authorCompany != null) ' at ',
                        if (props.authorCompany != null) props.authorCompany,
                      ].join()),
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

/// ShadCN Rating Stars Simple renderer.
class ShadcnRatingStarsSimple extends StatelessComponent {
  final RatingStarsSimpleProps props;

  const ShadcnRatingStarsSimple(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-rating-stars',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'gap': '2px',
      }),
      [
        for (var i = 0; i < props.maxStars; i++)
          dom.span(
            classes: 'arcane-star ${i < props.rating ? 'filled' : 'empty'}',
            styles: dom.Styles(raw: {
              'font-size': '${props.size}px',
              'color': i < props.rating
                  ? 'hsl(38 92% 50%)'
                  : 'var(--muted-foreground)',
              if (props.interactive) 'cursor': 'pointer',
              'transition': 'all 150ms ease',
            }),
            events: props.interactive
                ? {
                    'click': (e) => props.onRatingChanged?.call(i + 1),
                  }
                : null,
            [const Component.text('\u2605')],
          ),
      ],
    );
  }
}