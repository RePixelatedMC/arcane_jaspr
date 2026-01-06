import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A game tile component for game server selection
class ArcaneGameTile extends StatelessComponent {
  /// Game name
  final String name;

  /// Game icon/logo URL
  final String? iconUrl;

  /// Custom icon component
  final Component? icon;

  /// Whether this game is selected
  final bool selected;

  /// Click handler
  final void Function()? onTap;

  /// Whether the game is popular/featured
  final bool popular;

  /// Badge text (e.g., "New", "Beta")
  final String? badge;

  /// Description or player count
  final String? subtitle;

  const ArcaneGameTile({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-game-tile ${selected ? 'selected' : ''} ${popular ? 'popular' : ''}',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '1rem',
        'padding': '1.5rem',
        'background-color': selected ? 'hsl(var(--accent) / 0.1)' : 'var(--card)',
        'border': '2px solid ${selected ? 'var(--accent)' : 'var(--border)'}',
        'border-radius': '0.375rem',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        // Badge
        if (badge != null)
          div(
            classes: 'arcane-game-tile-badge',
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'right': '0.5rem',
              'padding': '2px 0.5rem',
              'font-size': '0.75rem',
              'font-weight': '600',
              'text-transform': 'uppercase',
              'color': 'var(--accent-foreground)',
              'background-color': 'var(--accent)',
              'border-radius': '9999px',
            }),
            [text(badge!)],
          ),

        // Icon
        div(
          classes: 'arcane-game-tile-icon',
          styles: const Styles(raw: {
            'width': '64px',
            'height': '64px',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'background-color': 'var(--muted)',
            'border-radius': '0.375rem',
            'overflow': 'hidden',
          }),
          [
            if (icon != null)
              icon!
            else if (iconUrl != null)
              img(
                src: iconUrl!,
                alt: name,
                styles: const Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'object-fit': 'contain',
                }),
              )
            else
              span(
                styles: const Styles(raw: {
                  'font-size': '1.25rem',
                  'color': 'var(--muted-foreground)',
                  'font-weight': '700',
                }),
                [text(name.isNotEmpty ? name[0].toUpperCase() : '?')],
              ),
          ],
        ),

        // Name
        div(
          styles: Styles(raw: {
            'font-size': '1rem',
            'font-weight': '600',
            'color': selected ? 'var(--accent)' : 'var(--foreground)',
            'text-align': 'center',
          }),
          [text(name)],
        ),

        // Subtitle
        if (subtitle != null)
          div(
            styles: const Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
            }),
            [text(subtitle!)],
          ),

        // Popular indicator
        if (popular && badge == null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.25rem',
              'font-size': '0.75rem',
              'color': 'hsl(38 92% 50%)',
            }),
            [text('Popular')],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-game-tile:hover').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
    }),
    css('.arcane-game-tile:focus').styles(raw: {
      'outline': 'none',
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.2)',
    }),
  ];
}

/// A grid of game tiles
class ArcaneGameSelector extends StatelessComponent {
  /// Game tiles
  final List<ArcaneGameTile> games;

  /// Number of columns
  final int columns;

  /// Gap between tiles
  final double gap;

  /// Title
  final String? title;

  /// Description
  final String? description;

  const ArcaneGameSelector({
    required this.games,
    this.columns = 4,
    this.gap = 16,
    this.title,
    this.description,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-game-selector',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '2rem',
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
                    'font-size': '1.25rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [text(title!)],
                ),
              if (description != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': '0.875rem',
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
          games,
        ),
      ],
    );
  }
}

/// A game card with more details
class ArcaneGameCard extends StatelessComponent {
  /// Game name
  final String name;

  /// Game description
  final String? description;

  /// Icon URL
  final String? iconUrl;

  /// Custom icon
  final Component? icon;

  /// Background image URL
  final String? backgroundUrl;

  /// Player count or status
  final String? status;

  /// Features list
  final List<String>? features;

  /// Click handler
  final void Function()? onTap;

  /// CTA button text
  final String? ctaText;

  const ArcaneGameCard({
    required this.name,
    this.description,
    this.iconUrl,
    this.icon,
    this.backgroundUrl,
    this.status,
    this.features,
    this.onTap,
    this.ctaText,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-game-card',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.375rem',
        'overflow': 'hidden',
        'transition': 'all 150ms ease',
        if (onTap != null) 'cursor': 'pointer',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        // Background/header
        div(
          classes: 'arcane-game-card-header',
          styles: Styles(raw: {
            'position': 'relative',
            'height': '120px',
            'background-color': 'var(--muted)',
            if (backgroundUrl != null) 'background-image': 'url($backgroundUrl)',
            'background-size': 'cover',
            'background-position': 'center',
          }),
          [
            // Overlay
            div(
              styles: const Styles(raw: {
                'position': 'absolute',
                'inset': '0',
                'background': 'linear-gradient(to top, var(--card) 0%, transparent 100%)',
              }),
              [],
            ),
            // Icon overlay
            div(
              styles: const Styles(raw: {
                'position': 'absolute',
                'bottom': '-24px',
                'left': '20px',
              }),
              [
                div(
                  styles: const Styles(raw: {
                    'width': '48px',
                    'height': '48px',
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'background-color': 'var(--card)',
                    'border': '2px solid var(--border)',
                    'border-radius': '0.375rem',
                    'overflow': 'hidden',
                  }),
                  [
                    if (icon != null)
                      icon!
                    else if (iconUrl != null)
                      img(
                        src: iconUrl!,
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
                          'font-size': '1.125rem',
                          'color': 'var(--muted-foreground)',
                          'font-weight': '700',
                        }),
                        [text(name.isNotEmpty ? name[0].toUpperCase() : '?')],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Content
        div(
          styles: const Styles(raw: {
            'padding': '2rem 1.5rem 1.5rem',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '1rem',
          }),
          [
            // Name and status
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'space-between',
              }),
              [
                div(
                  styles: const Styles(raw: {
                    'font-size': '1.125rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [text(name)],
                ),
                if (status != null)
                  span(
                    styles: const Styles(raw: {
                      'font-size': '0.75rem',
                      'color': 'hsl(142 76% 36%)',
                    }),
                    [text(status!)],
                  ),
              ],
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

            // Features
            if (features != null && features!.isNotEmpty)
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': '0.5rem',
                  'margin-top': '0.25rem',
                }),
                [
                  for (final feature in features!)
                    span(
                      styles: const Styles(raw: {
                        'padding': '0.25rem 0.5rem',
                        'font-size': '0.75rem',
                        'color': 'var(--muted-foreground)',
                        'background-color': 'var(--muted)',
                        'border-radius': '0.25rem',
                      }),
                      [text(feature)],
                    ),
                ],
              ),

            // CTA
            if (ctaText != null)
              button(
                attributes: {'type': 'button'},
                styles: const Styles(raw: {
                  'margin-top': '0.5rem',
                  'padding': '0.5rem 1.5rem',
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': 'var(--accent-foreground)',
                  'background-color': 'var(--accent)',
                  'border': 'none',
                  'border-radius': '0.375rem',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                [text(ctaText!)],
              ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-game-card:hover').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
    }),
  ];
}
