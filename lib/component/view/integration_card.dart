import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// An integration/partner card (Supabase-style)
class ArcaneIntegrationCard extends StatelessComponent {
  /// Integration name
  final String name;

  /// Description
  final String? description;

  /// Logo image URL
  final String? logoUrl;

  /// Custom logo component
  final Component? logo;

  /// Link URL
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Category/tag
  final String? category;

  /// Whether it's featured
  final bool featured;

  const ArcaneIntegrationCard({
    required this.name,
    this.description,
    this.logoUrl,
    this.logo,
    this.href,
    this.onTap,
    this.category,
    this.featured = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final Component content = div(
      classes: 'arcane-integration-card ${featured ? 'featured' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1.5rem',
        'padding': '2rem',
        'background-color': 'var(--card)',
        'border': '1px solid ${featured ? 'var(--accent)' : 'var(--border)'}',
        'border-radius': '0.375rem',
        'transition': 'all 150ms ease',
        'cursor': (href != null || onTap != null) ? 'pointer' : 'default',
      }),
      [
        // Header with logo and category
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'flex-start',
            'justify-content': 'space-between',
          }),
          [
            // Logo
            div(
              classes: 'arcane-integration-logo',
              styles: const Styles(raw: {
                'width': '48px',
                'height': '48px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'background-color': 'var(--muted)',
                'border-radius': '0.375rem',
                'overflow': 'hidden',
              }),
              [
                if (logo != null)
                  logo!
                else if (logoUrl != null)
                  img(
                    src: logoUrl!,
                    alt: name,
                    styles: const Styles(raw: {
                      'width': '32px',
                      'height': '32px',
                      'object-fit': 'contain',
                    }),
                  )
                else
                  span(
                    styles: const Styles(raw: {
                      'font-size': '1.25rem',
                      'font-weight': '600',
                      'color': 'var(--muted-foreground)',
                    }),
                    [text(name.substring(0, 1).toUpperCase())],
                  ),
              ],
            ),

            // Category badge
            if (category != null)
              span(
                styles: const Styles(raw: {
                  'padding': '0.25rem 0.5rem',
                  'font-size': '0.75rem',
                  'font-weight': '500',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                  'color': 'var(--muted-foreground)',
                  'background-color': 'var(--muted)',
                  'border-radius': '9999px',
                }),
                [text(category!)],
              ),
          ],
        ),

        // Content
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.5rem',
          }),
          [
            // Name
            div(
              styles: const Styles(raw: {
                'font-size': '1rem',
                'font-weight': '600',
                'color': 'var(--foreground)',
              }),
              [text(name)],
            ),

            // Description
            if (description != null)
              div(
                styles: const Styles(raw: {
                  'font-size': '0.875rem',
                  'line-height': '1.5',
                  'color': 'var(--muted-foreground)',
                }),
                [text(description!)],
              ),
          ],
        ),

        // Learn more link
        if (href != null || onTap != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.25rem',
              'margin-top': 'auto',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--accent)',
            }),
            [
              text('Learn more'),
              span([text('→')]),
            ],
          ),
      ],
    );

    if (href != null) {
      return a(
        href: href!,
        classes: 'arcane-integration-link',
        styles: const Styles(raw: {
          'text-decoration': 'none',
          'display': 'block',
        }),
        [content],
      );
    }

    if (onTap != null) {
      return div(
        events: {'click': (e) => onTap!()},
        [content],
      );
    }

    return content;
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-integration-card:hover').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
    }),
  ];
}

/// A grid of integration cards
class ArcaneIntegrationGrid extends StatelessComponent {
  /// Integration items
  final List<ArcaneIntegrationCard> integrations;

  /// Number of columns
  final int columns;

  /// Gap between cards
  final double gap;

  /// Optional title
  final String? title;

  /// Optional description
  final String? description;

  const ArcaneIntegrationGrid({
    required this.integrations,
    this.columns = 3,
    this.gap = 24,
    this.title,
    this.description,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-integration-grid',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '3rem',
      }),
      [
        if (title != null || description != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.5rem',
            }),
            [
              if (title != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': '1.5rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [text(title!)],
                ),
              if (description != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': '1rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [text(description!)],
                ),
            ],
          ),
        div(
          styles: Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat($columns, 1fr)',
            'gap': '${gap}px',
          }),
          integrations,
        ),
      ],
    );
  }
}
