import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/game_tile_props.dart';

/// ShadCN Game Tile renderer.
class ShadcnGameTile extends StatelessComponent {
  final GameTileProps props;

  const ShadcnGameTile(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.button(
      classes: 'arcane-game-tile ${props.selected ? 'selected' : ''} ${props.popular ? 'popular' : ''}',
      type: dom.ButtonType.button,
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '1rem',
        'padding': '1.5rem',
        'background-color': props.selected ? 'hsl(var(--accent) / 0.1)' : 'var(--card)',
        'border': '2px solid ${props.selected ? 'var(--accent)' : 'var(--border)'}',
        'border-radius': '0.375rem',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      events: {
        if (props.onTap != null) 'click': (e) => props.onTap!(),
      },
      [
        // Badge
        if (props.badge != null)
          dom.div(
            classes: 'arcane-game-tile-badge',
            styles: const dom.Styles(raw: {
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
            [Component.text(props.badge!)],
          ),

        // Icon
        dom.div(
          classes: 'arcane-game-tile-icon',
          styles: const dom.Styles(raw: {
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
            if (props.icon != null)
              props.icon!
            else if (props.iconUrl != null)
              dom.img(
                src: props.iconUrl!,
                alt: props.name,
                styles: const dom.Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'object-fit': 'contain',
                }),
              )
            else
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '1.25rem',
                  'color': 'var(--muted-foreground)',
                  'font-weight': '700',
                }),
                [Component.text(props.name.isNotEmpty ? props.name[0].toUpperCase() : '?')],
              ),
          ],
        ),

        // Name
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': '1rem',
            'font-weight': '600',
            'color': props.selected ? 'var(--accent)' : 'var(--foreground)',
            'text-align': 'center',
          }),
          [Component.text(props.name)],
        ),

        // Subtitle
        if (props.subtitle != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.subtitle!)],
          ),

        // Popular indicator
        if (props.popular && props.badge == null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.25rem',
              'font-size': '0.75rem',
              'color': 'hsl(38 92% 50%)',
            }),
            [Component.text('Popular')],
          ),
      ],
    );
  }
}

/// ShadCN Game Selector renderer.
class ShadcnGameSelector extends StatelessComponent {
  final GameSelectorProps props;

  const ShadcnGameSelector(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-game-selector',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '2rem',
      }),
      [
        if (props.title != null || props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': '0.5rem',
            }),
            [
              if (props.title != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '1.25rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns': 'repeat(${props.columns}, 1fr)',
            'gap': '${props.gap}px',
          }),
          [
            for (final game in props.games)
              ShadcnGameTile(game),
          ],
        ),
      ],
    );
  }
}

/// ShadCN Game Card renderer.
class ShadcnGameCard extends StatelessComponent {
  final GameCardProps props;

  const ShadcnGameCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-game-card',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.375rem',
        'overflow': 'hidden',
        'transition': 'all 150ms ease',
        if (props.onTap != null) 'cursor': 'pointer',
      }),
      events: {
        if (props.onTap != null) 'click': (e) => props.onTap!(),
      },
      [
        // Background/header
        dom.div(
          classes: 'arcane-game-card-header',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'height': '120px',
            'background-color': 'var(--muted)',
            if (props.backgroundUrl != null) 'background-image': 'url(${props.backgroundUrl})',
            'background-size': 'cover',
            'background-position': 'center',
          }),
          [
            // Overlay
            dom.div(
              styles: const dom.Styles(raw: {
                'position': 'absolute',
                'inset': '0',
                'background': 'linear-gradient(to top, var(--card) 0%, transparent 100%)',
              }),
              [],
            ),
            // Icon overlay
            dom.div(
              styles: const dom.Styles(raw: {
                'position': 'absolute',
                'bottom': '-24px',
                'left': '20px',
              }),
              [
                dom.div(
                  styles: const dom.Styles(raw: {
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
                    if (props.icon != null)
                      props.icon!
                    else if (props.iconUrl != null)
                      dom.img(
                        src: props.iconUrl!,
                        alt: props.name,
                        styles: const dom.Styles(raw: {
                          'width': '32px',
                          'height': '32px',
                          'object-fit': 'contain',
                        }),
                      )
                    else
                      dom.span(
                        styles: const dom.Styles(raw: {
                          'font-size': '1.125rem',
                          'color': 'var(--muted-foreground)',
                          'font-weight': '700',
                        }),
                        [Component.text(props.name.isNotEmpty ? props.name[0].toUpperCase() : '?')],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Content
        dom.div(
          styles: const dom.Styles(raw: {
            'padding': '2rem 1.5rem 1.5rem',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '1rem',
          }),
          [
            // Name and status
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'space-between',
              }),
              [
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': '1.125rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.name)],
                ),
                if (props.status != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': '0.75rem',
                      'color': 'hsl(142 76% 36%)',
                    }),
                    [Component.text(props.status!)],
                  ),
              ],
            ),

            // Description
            if (props.description != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'line-height': '1.5',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.description!)],
              ),

            // Features
            if (props.features != null && props.features!.isNotEmpty)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': '0.5rem',
                  'margin-top': '0.25rem',
                }),
                [
                  for (final feature in props.features!)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'padding': '0.25rem 0.5rem',
                        'font-size': '0.75rem',
                        'color': 'var(--muted-foreground)',
                        'background-color': 'var(--muted)',
                        'border-radius': '0.25rem',
                      }),
                      [Component.text(feature)],
                    ),
                ],
              ),

            // CTA
            if (props.ctaText != null)
              dom.button(
                type: dom.ButtonType.button,
                styles: const dom.Styles(raw: {
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
                [Component.text(props.ctaText!)],
              ),
          ],
        ),
      ],
    );
  }
}
