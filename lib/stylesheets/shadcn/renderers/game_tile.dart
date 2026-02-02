import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/game_tile_props.dart';

/// ShadCN Game Tile renderer.
///
/// Supports multiple variants:
/// - `compact`: Small selection tile with centered icon
/// - `card`: Full card layout with image, badges, and CTA
/// - `hero`: Larger featured tile
class ShadcnGameTile extends StatefulComponent {
  final GameTileProps props;

  const ShadcnGameTile(this.props, {super.key});

  @override
  State<ShadcnGameTile> createState() => _ShadcnGameTileState();
}

class _ShadcnGameTileState extends State<ShadcnGameTile> {
  bool _isHovered = false;

  @override
  Component build(BuildContext context) {
    final GameTileProps props = component.props;

    // Route to appropriate variant
    return switch (props.variant) {
      GameTileVariant.compact => _buildCompactTile(props),
      GameTileVariant.card => _buildCardTile(props),
      GameTileVariant.hero => _buildCardTile(props),
    };
  }

  /// Builds the compact selection tile (original style).
  Component _buildCompactTile(GameTileProps props) {
    return dom.button(
      classes: 'arcane-game-tile ${props.selected ? 'selected' : ''} ${props.popular ? 'popular' : ''}',
      type: dom.ButtonType.button,
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': 'var(--space-4)',
        'padding': '1.5rem',
        'background-color': props.selected ? 'color-mix(in srgb, var(--accent) 10%, transparent)' : 'var(--card)',
        'border': '2px solid ${props.selected ? 'var(--accent)' : 'var(--border)'}',
        'border-radius': 'var(--arcane-radius-sm)',
        'cursor': 'pointer',
        'transition': 'all var(--arcane-transition)',
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
              'font-size': 'var(--font-size-xs)',
              'font-weight': 'var(--font-weight-semibold)',
              'text-transform': 'uppercase',
              'color': 'var(--accent-foreground)',
              'background-color': 'var(--accent)',
              'border-radius': 'var(--arcane-radius-full)',
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
            'border-radius': 'var(--arcane-radius-sm)',
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
                  'font-size': 'var(--font-size-xl)',
                  'color': 'var(--muted-foreground)',
                  'font-weight': 'var(--font-weight-bold)',
                }),
                [Component.text(props.name.isNotEmpty ? props.name[0].toUpperCase() : '?')],
              ),
          ],
        ),

        // Name
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': 'var(--font-size-base)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': props.selected ? 'var(--accent)' : 'var(--foreground)',
            'text-align': 'center',
          }),
          [Component.text(props.name)],
        ),

        // Subtitle
        if (props.subtitle != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.subtitle!)],
          ),

        // Popular indicator
        if (props.popular && props.badge == null)
          const dom.div(
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--space-1)',
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--warning)',
            }),
            [Component.text('Popular')],
          ),
      ],
    );
  }

  /// Builds the card-style tile.
  Component _buildCardTile(GameTileProps props) {
    final String tileHeight = props.height ?? (props.variant == GameTileVariant.hero ? '480px' : '420px');

    final List<Component> children = [
      _buildImageSection(props),
      _buildInfoSection(props),
    ];

    if (props.href != null) {
      return dom.a(
        classes: 'arcane-game-tile arcane-game-tile--card',
        href: props.href!,
        styles: dom.Styles(raw: {
          'position': 'relative',
          'display': 'flex',
          'flex-direction': 'column',
          'background-color': 'var(--card)',
          'border-radius': 'var(--arcane-radius-md)',
          'overflow': 'hidden',
          'border': '1px solid var(--border)',
          'transition': 'all var(--arcane-transition)',
          'cursor': 'pointer',
          'text-decoration': 'none',
          'height': tileHeight,
        }),
        events: {
          'mouseenter': (_) => setState(() => _isHovered = true),
          'mouseleave': (_) => setState(() => _isHovered = false),
        },
        children,
      );
    }

    return dom.div(
      classes: 'arcane-game-tile arcane-game-tile--card',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--card)',
        'border-radius': 'var(--arcane-radius-md)',
        'overflow': 'hidden',
        'border': '1px solid var(--border)',
        'transition': 'all var(--arcane-transition)',
        'cursor': props.onTap != null ? 'pointer' : 'default',
        'height': tileHeight,
      }),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
        if (props.onTap != null) 'click': (_) => props.onTap!(),
      },
      children,
    );
  }

  Component _buildImageSection(GameTileProps props) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
        'height': '70%',
        'overflow': 'hidden',
        'background-color': 'var(--muted)',
      }),
      [
        if (props.iconUrl != null)
          dom.img(
            src: props.iconUrl!,
            alt: props.name,
            styles: const dom.Styles(raw: {
              'width': '100%',
              'height': '100%',
              'object-fit': 'cover',
              'transition': 'transform var(--arcane-transition)',
            }),
          ),

        const dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'top': '0',
            'left': '0',
            'right': '0',
            'bottom': '0',
            'background': 'linear-gradient(to bottom, transparent 50%, var(--card) 100%)',
            'pointer-events': 'none',
          }),
          [],
        ),

        if (props.isNew) _buildNewBadge(),
        if (props.popular && !props.isNew) _buildPopularBadge(),

        if (props.showPlatformIcons && props.platforms.isNotEmpty)
          dom.div(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '12px',
              'right': '12px',
              'display': 'flex',
              'gap': 'var(--space-1)',
            }),
            [
              for (final GamePlatform platform in props.platforms)
                _buildPlatformIcon(platform),
            ],
          ),
      ],
    );
  }

  Component _buildInfoSection(GameTileProps props) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'padding': 'var(--space-4)',
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'space-between',
        'height': '30%',
      }),
      [
        dom.div(
          [
            dom.h3(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-base)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--foreground)',
                'margin': '0',
              }),
              [Component.text(props.name)],
            ),
            if (props.subtitle != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'display': 'block',
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': 'var(--space-1)',
                }),
                [Component.text(props.subtitle!)],
              ),
          ],
        ),

        if (props.ctaText != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'gap': 'var(--space-2)',
              'padding': 'var(--space-2) var(--space-3)',
              'background-color': 'transparent',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--arcane-radius-sm)',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--muted-foreground)',
              'transition': 'all var(--arcane-transition)',
            }),
            [
              Component.text(props.ctaText!),
              ArcaneIcon.arrowRight(size: IconSize.sm),
            ],
          ),
      ],
    );
  }

  Component _buildNewBadge() {
    return dom.div(
      styles: const dom.Styles(raw: {
        'position': 'absolute',
        'top': '12px',
        'left': '12px',
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--space-1)',
        'padding': '0.25rem 0.5rem',
        'background-color': 'color-mix(in srgb, var(--info) 20%, var(--card))',
        'border': '1px solid var(--info)',
        'border-radius': 'var(--arcane-radius-full)',
        'font-size': 'var(--font-size-xs)',
        'font-weight': 'var(--font-weight-semibold)',
        'color': 'var(--info)',
      }),
      [
        ArcaneIcon.sparkles(size: IconSize.xs),
        const Component.text('NEW'),
      ],
    );
  }

  Component _buildPopularBadge() {
    return dom.div(
      styles: const dom.Styles(raw: {
        'position': 'absolute',
        'top': '12px',
        'left': '12px',
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--space-1)',
        'padding': '0.25rem 0.5rem',
        'background-color': 'color-mix(in srgb, var(--warning) 20%, var(--card))',
        'border': '1px solid var(--warning)',
        'border-radius': 'var(--arcane-radius-full)',
        'font-size': 'var(--font-size-xs)',
        'font-weight': 'var(--font-weight-semibold)',
        'color': 'var(--warning)',
      }),
      [
        ArcaneIcon.star(size: IconSize.xs),
        const Component.text('POPULAR'),
      ],
    );
  }

  Component _buildPlatformIcon(GamePlatform platform) {
    final Component icon = switch (platform) {
      GamePlatform.pc => ArcaneIcon.monitor(size: IconSize.xs),
      GamePlatform.xbox => ArcaneIcon.xbox(size: IconSize.xs),
      GamePlatform.playstation => ArcaneIcon.playstation(size: IconSize.xs),
      GamePlatform.crossplay => ArcaneIcon.crossplay(size: IconSize.xs),
      GamePlatform.mobile => ArcaneIcon.smartphone(size: IconSize.xs),
    };

    return dom.div(
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '24px',
        'height': '24px',
        'background-color': 'color-mix(in srgb, var(--background) 85%, transparent)',
        'border-radius': 'var(--arcane-radius-xs)',
        'color': 'var(--muted-foreground)',
      }),
      [icon],
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
        'gap': 'var(--space-8)',
      }),
      [
        if (props.title != null || props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': 'var(--space-2)',
            }),
            [
              if (props.title != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-xl)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.title!)],
                ),
              if (props.description != null)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
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
        'border-radius': 'var(--arcane-radius-sm)',
        'overflow': 'hidden',
        'transition': 'all var(--arcane-transition)',
        if (props.onTap != null) 'cursor': 'pointer',
      }),
      events: {
        if (props.onTap != null) 'click': (e) => props.onTap!(),
      },
      [
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
            const dom.div(
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'inset': '0',
                'background': 'linear-gradient(to top, var(--card) 0%, transparent 100%)',
              }),
              [],
            ),
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
                    'border-radius': 'var(--arcane-radius-sm)',
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
                          'font-size': 'var(--font-size-lg)',
                          'color': 'var(--muted-foreground)',
                          'font-weight': 'var(--font-weight-bold)',
                        }),
                        [Component.text(props.name.isNotEmpty ? props.name[0].toUpperCase() : '?')],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),

        dom.div(
          styles: const dom.Styles(raw: {
            'padding': '2rem 1.5rem 1.5rem',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--space-4)',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'space-between',
              }),
              [
                dom.div(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-lg)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.name)],
                ),
                if (props.status != null)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--success)',
                    }),
                    [Component.text(props.status!)],
                  ),
              ],
            ),

            if (props.description != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'line-height': '1.5',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.description!)],
              ),

            if (props.features != null && props.features!.isNotEmpty)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': 'var(--space-2)',
                  'margin-top': '0.25rem',
                }),
                [
                  for (final feature in props.features!)
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'padding': '0.25rem 0.5rem',
                        'font-size': 'var(--font-size-xs)',
                        'color': 'var(--muted-foreground)',
                        'background-color': 'var(--muted)',
                        'border-radius': 'var(--arcane-radius-xs)',
                      }),
                      [Component.text(feature)],
                    ),
                ],
              ),

            if (props.ctaText != null)
              dom.button(
                type: dom.ButtonType.button,
                styles: const dom.Styles(raw: {
                  'margin-top': '0.5rem',
                  'padding': '0.5rem 1.5rem',
                  'font-size': 'var(--font-size-sm)',
                  'font-weight': 'var(--font-weight-medium)',
                  'color': 'var(--accent-foreground)',
                  'background-color': 'var(--accent)',
                  'border': 'none',
                  'border-radius': 'var(--arcane-radius-sm)',
                  'cursor': 'pointer',
                  'transition': 'all var(--arcane-transition)',
                }),
                [Component.text(props.ctaText!)],
              ),
          ],
        ),
      ],
    );
  }
}

/// ShadCN GameLink renderer.
///
/// A horizontal navigation link with icon, name, and optional badge.
/// Features custom accent color theming.
class ShadcnGameLink extends StatefulComponent {
  final GameLinkProps props;

  const ShadcnGameLink(this.props, {super.key});

  @override
  State<ShadcnGameLink> createState() => _ShadcnGameLinkState();
}

class _ShadcnGameLinkState extends State<ShadcnGameLink> {
  bool _isHovered = false;

  @override
  Component build(BuildContext context) {
    final GameLinkProps props = component.props;
    final String accent = props.accentColor;
    final bool mini = props.mini;
    final String iconSize = mini ? '32px' : '48px';

    return dom.a(
      classes: 'arcane-game-link ${mini ? 'arcane-game-link--mini' : ''}',
      href: props.href,
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': mini ? 'var(--space-2)' : 'var(--space-3)',
        'padding': mini ? 'var(--space-2)' : 'var(--space-3)',
        'border-radius': 'var(--arcane-radius-md)',
        'text-decoration': 'none',
        'position': 'relative',
        'overflow': 'hidden',
        'background-color': _isHovered
            ? 'color-mix(in srgb, $accent 10%, transparent)'
            : 'color-mix(in srgb, $accent 5%, transparent)',
        'border': _isHovered
            ? '1px solid color-mix(in srgb, $accent 30%, transparent)'
            : '1px solid var(--border)',
        'transition': 'all var(--arcane-transition)',
      }),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
      },
      [
        // Icon container
        dom.div(
          styles: dom.Styles(raw: {
            'width': iconSize,
            'height': iconSize,
            'border-radius': 'var(--arcane-radius-sm)',
            'overflow': 'hidden',
            'border': _isHovered
                ? '2px solid color-mix(in srgb, $accent 50%, transparent)'
                : '2px solid color-mix(in srgb, $accent 25%, transparent)',
            'flex-shrink': '0',
            'transition': 'all var(--arcane-transition)',
          }),
          [
            if (props.icon != null)
              props.icon!
            else if (props.iconUrl != null)
              dom.img(
                src: props.iconUrl!,
                alt: props.name,
                styles: const dom.Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              )
            else
              dom.div(
                styles: const dom.Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'background-color': 'var(--muted)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                }),
                [ArcaneIcon.gamepad(size: mini ? IconSize.sm : IconSize.md)],
              ),
          ],
        ),

        // Name and badge
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'flex': '1',
            'gap': 'var(--space-1)',
          }),
          [
            dom.span(
              styles: dom.Styles(raw: {
                'font-size': mini ? 'var(--font-size-xs)' : 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.name)],
            ),
            if (props.badge != null)
              dom.span(
                styles: dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-medium)',
                  'color': accent,
                  'letter-spacing': '0.05em',
                }),
                [Component.text(props.badge!)],
              ),
          ],
        ),

        // Chevron
        dom.div(
          styles: dom.Styles(raw: {
            'color': _isHovered ? accent : 'var(--muted-foreground)',
            'transition': 'all var(--arcane-transition)',
            'flex-shrink': '0',
            'transform': _isHovered ? 'translateX(2px)' : 'translateX(0)',
          }),
          [ArcaneIcon.chevronRight(size: mini ? IconSize.xs : IconSize.sm)],
        ),
      ],
    );
  }
}