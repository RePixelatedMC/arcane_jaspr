import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A testimonial/quote card component (Supabase-style)
class ArcaneTestimonialCard extends StatelessComponent {
  /// The testimonial quote text
  final String quote;

  /// Author name
  final String authorName;

  /// Author title/role
  final String? authorTitle;

  /// Author company
  final String? authorCompany;

  /// Author avatar URL
  final String? avatarUrl;

  /// Star rating (0-5, null to hide)
  final int? rating;

  /// Whether to show quotation marks
  final bool showQuotes;

  const ArcaneTestimonialCard({
    required this.quote,
    required this.authorName,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.rating,
    this.showQuotes = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-testimonial-card',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '2rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.75rem',
      }),
      [
        // Rating stars
        if (rating != null)
          div(
            classes: 'arcane-testimonial-rating',
            styles: const Styles(raw: {
              'display': 'flex',
              'gap': '2px',
              'margin-bottom': '1.5rem',
            }),
            [
              for (var i = 0; i < 5; i++)
                span(
                  styles: Styles(raw: {
                    'font-size': '1rem',
                    'color': i < rating!
                        ? 'hsl(38 92% 50%)'
                        : 'var(--muted-foreground)',
                  }),
                  [text('★')],
                ),
            ],
          ),

        // Quote
        div(
          classes: 'arcane-testimonial-quote',
          styles: const Styles(raw: {
            'position': 'relative',
            'font-size': '1rem',
            'line-height': '1.7',
            'color': 'var(--foreground)',
            'margin-bottom': '1.5rem',
            'flex': '1',
          }),
          [
            if (showQuotes)
              span(
                styles: const Styles(raw: {
                  'position': 'absolute',
                  'top': '-8px',
                  'left': '-4px',
                  'font-size': '2.5rem',
                  'color': 'var(--accent)',
                  'opacity': '0.3',
                  'font-family': 'Georgia, serif',
                  'line-height': '1',
                }),
                [text('"')],
              ),
            p(
              styles: Styles(raw: {
                'margin': '0',
                if (showQuotes) 'padding-left': '1.5rem',
              }),
              [text(quote)],
            ),
          ],
        ),

        // Author
        div(
          classes: 'arcane-testimonial-author',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
          }),
          [
            // Avatar
            if (avatarUrl != null)
              div(
                classes: 'arcane-testimonial-avatar',
                styles: const Styles(raw: {
                  'width': '44px',
                  'height': '44px',
                  'border-radius': '9999px',
                  'overflow': 'hidden',
                  'flex-shrink': '0',
                }),
                [
                  img(
                    src: avatarUrl!,
                    alt: authorName,
                    styles: const Styles(raw: {
                      'width': '100%',
                      'height': '100%',
                      'object-fit': 'cover',
                    }),
                  ),
                ],
              )
            else
              div(
                classes: 'arcane-testimonial-avatar-placeholder',
                styles: const Styles(raw: {
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
                [text(authorName[0].toUpperCase())],
              ),

            // Author info
            div(
              classes: 'arcane-testimonial-author-info',
              [
                div(
                  styles: const Styles(raw: {
                    'font-weight': '600',
                    'font-size': '1rem',
                    'color': 'var(--foreground)',
                  }),
                  [text(authorName)],
                ),
                if (authorTitle != null || authorCompany != null)
                  div(
                    styles: const Styles(raw: {
                      'font-size': '0.875rem',
                      'color': 'var(--muted-foreground)',
                      'margin-top': '2px',
                    }),
                    [
                      text([
                        if (authorTitle != null) authorTitle,
                        if (authorTitle != null && authorCompany != null) ' at ',
                        if (authorCompany != null) authorCompany,
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

/// Rating stars component
class ArcaneRatingStarsSimple extends StatelessComponent {
  /// Rating value (0-5)
  final double rating;

  /// Maximum stars
  final int maxStars;

  /// Star size
  final double size;

  /// Whether the rating is interactive
  final bool interactive;

  /// Callback when rating changes (for interactive mode)
  final void Function(int)? onRatingChanged;

  const ArcaneRatingStarsSimple({
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.interactive = false,
    this.onRatingChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-rating-stars',
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'gap': '2px',
      }),
      [
        for (var i = 0; i < maxStars; i++)
          span(
            classes: 'arcane-star ${i < rating ? 'filled' : 'empty'}',
            styles: Styles(raw: {
              'font-size': '${size}px',
              'color': i < rating
                  ? 'hsl(38 92% 50%)'
                  : 'var(--muted-foreground)',
              if (interactive) 'cursor': 'pointer',
              'transition': 'all 150ms ease',
            }),
            events: interactive
                ? {
                    'click': (e) => onRatingChanged?.call(i + 1),
                  }
                : null,
            [text('★')],
          ),
      ],
    );
  }
}
