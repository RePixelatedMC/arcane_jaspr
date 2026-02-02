import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/game_tile_props.dart';

/// Codex GameTile renderer.
///
/// Supports multiple variants:
/// - `compact`: Small selection tile with centered icon
/// - `card`: Full card layout with image, badges, and CTA
/// - `hero`: Larger featured tile
class CodexGameTile extends StatefulComponent {
  final GameTileProps props;

  const CodexGameTile(this.props, {super.key});

  @override
  State<CodexGameTile> createState() => _CodexGameTileState();
}

class _CodexGameTileState extends State<CodexGameTile> {
  bool _isHovered = false;

  @override
  Component build(BuildContext context) {
    final GameTileProps props = component.props;

    // Route to appropriate variant
    return switch (props.variant) {
      GameTileVariant.compact => _buildCompactTile(props),
      GameTileVariant.card => _buildCardTile(props),
      GameTileVariant.hero => _buildCardTile(props), // Hero uses card layout with larger size
    };
  }

  /// Builds the compact selection tile (original style).
  Component _buildCompactTile(GameTileProps props) {
    final bool isSelected = props.selected;

    return dom.div(
      classes:
          'codex-game-tile ${isSelected ? 'selected' : ''} ${_isHovered ? 'hovered' : ''}',
      styles: dom.Styles(raw: {
        'width': '200px',
        'position': 'relative',
        'overflow': 'hidden',
        'border-radius': 'var(--radius)',
        'background-color': 'var(--card)',
        'border': isSelected
            ? '2px solid var(--primary)'
            : '1px solid var(--border)',
        'cursor': 'pointer',
        'transition': 'all var(--arcane-transition-slow)',
        'padding': '1rem',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '0.75rem',
        if (isSelected || _isHovered)
          'box-shadow': '0 0 20px rgba(var(--primary-rgb), 0.2)',
        if (_isHovered && props.showHoverEffects) 'transform': 'scale(1.02)',
      }),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
        if (props.onTap != null) 'click': (_) => props.onTap!(),
      },
      [
        // Icon/Image
        if (props.icon != null)
          props.icon!
        else if (props.iconUrl != null)
          dom.img(
            src: props.iconUrl!,
            alt: props.name,
            styles: const dom.Styles(raw: {
              'width': '64px',
              'height': '64px',
              'border-radius': 'var(--radius)',
              'object-fit': 'cover',
            }),
          )
        else
          dom.div(
            styles: const dom.Styles(raw: {
              'width': '64px',
              'height': '64px',
              'border-radius': 'var(--radius)',
              'background-color': 'var(--muted)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [ArcaneIcon.gamepad(size: IconSize.lg)],
          ),

        // Title
        dom.h3(
          classes: 'codex-game-tile-title',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
            'text-align': 'center',
          }),
          [Component.text(props.name)],
        ),

        // Subtitle
        if (props.subtitle != null)
          dom.span(
            classes: 'codex-game-tile-subtitle',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
              'text-align': 'center',
            }),
            [Component.text(props.subtitle!)],
          ),

        // Badge
        if (props.badge != null)
          dom.span(
            classes: 'codex-game-tile-badge',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'right': '0.5rem',
              'padding': '0.125rem 0.5rem',
              'font-size': '0.625rem',
              'font-weight': 'var(--font-weight-semibold)',
              'text-transform': 'uppercase',
              'color': 'var(--primary)',
              'background-color': 'rgba(var(--primary-rgb), 0.1)',
              'border-radius': 'var(--arcane-radius-full)',
            }),
            [Component.text(props.badge!)],
          ),

        // Popular indicator
        if (props.popular && !props.isNew)
          dom.div(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'left': '0.5rem',
            }),
            [ArcaneIcon.star(size: IconSize.sm)],
          ),

        // Selection indicator
        if (isSelected)
          dom.div(
            classes: 'codex-game-tile-selected-indicator',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0.5rem',
              'right': '0.5rem',
              'width': '20px',
              'height': '20px',
              'border-radius': '50%',
              'background-color': 'var(--primary)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': '#ffffff',
            }),
            [ArcaneIcon.check(size: IconSize.xs)],
          ),
      ],
    );
  }

  /// Builds the card-style tile (QualityNode style).
  Component _buildCardTile(GameTileProps props) {
    final String tileHeight = props.height ?? (props.variant == GameTileVariant.hero ? '480px' : '420px');

    final List<Component> children = [
      // Image Container (70% of height)
      _buildImageSection(props),
      // Info Section (30% of height)
      _buildInfoSection(props),
    ];

    // Build class list - use CSS classes for hover/animation effects
    final List<String> classes = [
      'codex-game-tile',
      'codex-game-tile--card',
      if (props.showHoverEffects) 'codex-game-tile--interactive',
      if (props.showHoverEffects) 'codex-game-tile--animated',
    ];
    final String classString = classes.join(' ');

    // Build animation delay style if provided
    final Map<String, String> baseStyles = {
      'position': 'relative',
      'display': 'flex',
      'flex-direction': 'column',
      'background-color': 'var(--card)',
      'border-radius': 'var(--radius-xl)',
      'overflow': 'hidden',
      'border': '1px solid color-mix(in srgb, var(--foreground) 8%, transparent)',
      'text-decoration': 'none',
      'height': tileHeight,
      if (props.animationDelayMs != null)
        'animation-delay': '${props.animationDelayMs}ms',
    };

    // Wrap in link if href is provided
    if (props.href != null) {
      return dom.a(
        classes: classString,
        href: props.href!,
        styles: dom.Styles(raw: {
          ...baseStyles,
          'cursor': 'pointer',
        }),
        children,
      );
    }

    // Otherwise use a div with onTap
    return dom.div(
      classes: classString,
      styles: dom.Styles(raw: {
        ...baseStyles,
        'cursor': props.onTap != null ? 'pointer' : 'default',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      children,
    );
  }

  /// Builds the image section of the card tile.
  Component _buildImageSection(GameTileProps props) {
    return dom.div(
      classes: 'codex-game-tile-image-container',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
        'height': '70%',
        'overflow': 'hidden',
        'background-color': 'color-mix(in srgb, var(--foreground) 5%, var(--card))',
      }),
      [
        // Game Image
        if (props.iconUrl != null)
          dom.img(
            classes: 'codex-game-tile-image',
            src: props.iconUrl!,
            alt: props.name,
            styles: const dom.Styles(raw: {
              'width': '100%',
              'height': '100%',
              'object-fit': 'cover',
              'transition': 'transform var(--arcane-transition)',
            }),
          ),

        // Gradient Overlay
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

        // NEW Badge
        if (props.isNew) _buildNewBadge(),

        // POPULAR Badge (only if not new)
        if (props.popular && !props.isNew) _buildPopularBadge(),

        // Platform Icons
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

  /// Builds the info section of the card tile.
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
        // Title & Subtitle
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

        // CTA Button
        if (props.ctaText != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'gap': 'var(--space-2)',
              'padding': 'var(--space-2) var(--space-3)',
              'background-color': 'transparent',
              'border': '1px solid color-mix(in srgb, var(--foreground) 12%, transparent)',
              'border-radius': 'var(--radius-md)',
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

  /// Builds the NEW badge.
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
        'border': '2px solid var(--info)',
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

  /// Builds the POPULAR badge.
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
        'border': '2px solid var(--warning)',
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

  /// Builds a platform icon with tooltip.
  Component _buildPlatformIcon(GamePlatform platform) {
    final Component icon = switch (platform) {
      GamePlatform.pc => ArcaneIcon.monitor(size: IconSize.xs),
      GamePlatform.xbox => ArcaneIcon.xbox(size: IconSize.xs),
      GamePlatform.playstation => ArcaneIcon.playstation(size: IconSize.xs),
      GamePlatform.crossplay => ArcaneIcon.crossplay(size: IconSize.xs),
      GamePlatform.mobile => ArcaneIcon.smartphone(size: IconSize.xs),
    };

    final String tooltip = switch (platform) {
      GamePlatform.pc => 'PC',
      GamePlatform.xbox => 'Xbox',
      GamePlatform.playstation => 'PlayStation',
      GamePlatform.crossplay => 'Crossplay',
      GamePlatform.mobile => 'Mobile',
    };

    return dom.div(
      classes: 'codex-platform-icon',
      attributes: {'data-tooltip': tooltip},
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '24px',
        'height': '24px',
        'background-color': 'color-mix(in srgb, var(--background) 85%, transparent)',
        'border-radius': 'var(--radius-sm)',
        'color': 'var(--muted-foreground)',
      }),
      [icon],
    );
  }
}

/// Codex GameSelector renderer.
class CodexGameSelector extends StatelessComponent {
  final GameSelectorProps props;

  const CodexGameSelector(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-game-selector',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat(${props.columns}, 1fr)',
        'gap': '${props.gap}px',
      }),
      [
        // Title
        if (props.title != null)
          dom.h2(
            styles: const dom.Styles(raw: {
              'grid-column': '1 / -1',
              'font-size': 'var(--font-size-xl)',
              'font-weight': 'var(--font-weight-semibold)',
              'color': 'var(--foreground)',
              'margin': '0 0 0.5rem 0',
            }),
            [Component.text(props.title!)],
          ),

        // Description
        if (props.description != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'grid-column': '1 / -1',
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 1rem 0',
            }),
            [Component.text(props.description!)],
          ),

        // Game tiles
        for (final game in props.games) CodexGameTile(game),
      ],
    );
  }
}

/// Codex GameCard renderer.
class CodexGameCard extends StatelessComponent {
  final GameCardProps props;

  const CodexGameCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-game-card',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': 'var(--space-4)',
        'padding': '1rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      [
        // Thumbnail
        if (props.icon != null)
          props.icon!
        else if (props.iconUrl != null)
          dom.div(
            classes: 'codex-game-card-thumbnail',
            styles: dom.Styles(raw: {
              'width': '80px',
              'height': '80px',
              'flex-shrink': '0',
              'border-radius': 'var(--radius)',
              'overflow': 'hidden',
              'background-image': 'url(${props.iconUrl})',
              'background-size': 'cover',
              'background-position': 'center',
            }),
            [],
          ),

        // Info
        dom.div(
          classes: 'codex-game-card-info',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--space-1)',
          }),
          [
            // Title
            dom.h3(
              classes: 'codex-game-card-title',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-base)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': 'var(--foreground)',
                'margin': '0',
              }),
              [Component.text(props.name)],
            ),

            // Description
            if (props.description != null)
              dom.p(
                classes: 'codex-game-card-description',
                styles: const dom.Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': 'var(--muted-foreground)',
                  'margin': '0',
                  'line-height': '1.4',
                }),
                [Component.text(props.description!)],
              ),

            // Status
            if (props.status != null)
              dom.span(
                classes: 'codex-game-card-status',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--primary)',
                }),
                [Component.text(props.status!)],
              ),

            // Features
            if (props.features != null && props.features!.isNotEmpty)
              dom.div(
                classes: 'codex-game-card-features',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'flex-wrap': 'wrap',
                  'gap': 'var(--space-1)',
                  'margin-top': '0.5rem',
                }),
                [
                  for (final feature in props.features!)
                    dom.span(
                      classes: 'codex-game-card-feature',
                      styles: const dom.Styles(raw: {
                        'padding': '0.125rem 0.5rem',
                        'font-size': '0.6875rem',
                        'font-weight': 'var(--font-weight-medium)',
                        'color': 'var(--primary)',
                        'background-color':
                            'rgba(var(--primary-rgb), 0.1)',
                        'border-radius': 'var(--arcane-radius-full)',
                      }),
                      [Component.text(feature)],
                    ),
                ],
              ),

            // CTA
            if (props.ctaText != null)
              dom.button(
                classes: 'codex-game-card-cta',
                styles: const dom.Styles(raw: {
                  'margin-top': '0.5rem',
                  'padding': '0.5rem 1rem',
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--primary-foreground)',
                  'background-color': 'var(--primary)',
                  'border': 'none',
                  'border-radius': 'var(--radius)',
                  'cursor': 'pointer',
                }),
                [Component.text(props.ctaText!)],
              ),
          ],
        ),
      ],
    );
  }
}

/// Codex GameLink renderer.
///
/// A horizontal navigation link with icon, name, and optional badge.
/// Features custom accent color theming for glows, gradients, and borders.
class CodexGameLink extends StatefulComponent {
  final GameLinkProps props;

  const CodexGameLink(this.props, {super.key});

  @override
  State<CodexGameLink> createState() => _CodexGameLinkState();
}

class _CodexGameLinkState extends State<CodexGameLink> {
  bool _isHovered = false;

  @override
  Component build(BuildContext context) {
    final GameLinkProps props = component.props;
    final String accent = props.accentColor;
    final bool mini = props.mini;
    final String iconSize = mini ? '32px' : '48px';
    final String glowSize = mini ? '40px' : '60px';

    return dom.a(
      classes: 'codex-game-link ${mini ? 'codex-game-link--mini' : ''}',
      href: props.href,
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': mini ? 'var(--space-2)' : 'var(--space-3)',
        'padding': mini ? 'var(--space-2)' : 'var(--space-3)',
        'border-radius': 'var(--radius-lg)',
        'text-decoration': 'none',
        'position': 'relative',
        'overflow': 'hidden',
        'background': _isHovered
            ? 'linear-gradient(135deg, color-mix(in srgb, $accent 15%, transparent), color-mix(in srgb, $accent 5%, transparent))'
            : 'linear-gradient(135deg, color-mix(in srgb, $accent 8%, transparent), color-mix(in srgb, $accent 2%, transparent))',
        'border': _isHovered
            ? '1px solid color-mix(in srgb, $accent 40%, transparent)'
            : '1px solid color-mix(in srgb, $accent 15%, transparent)',
        'transition': 'all var(--arcane-transition)',
        'box-shadow': _isHovered
            ? '0 0 25px color-mix(in srgb, $accent 20%, transparent)'
            : 'none',
      }),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
      },
      [
        // Glow effect
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'left': '0',
            'top': '50%',
            'width': glowSize,
            'height': glowSize,
            'border-radius': 'var(--arcane-radius-full)',
            'background-color': accent,
            'opacity': _isHovered ? '0.15' : '0.08',
            'transform': 'translate(-30%, -50%)',
            'filter': 'blur(25px)',
            'pointer-events': 'none',
          }),
          [],
        ),

        // Icon container
        dom.div(
          styles: dom.Styles(raw: {
            'width': iconSize,
            'height': iconSize,
            'border-radius': 'var(--radius-md)',
            'overflow': 'hidden',
            'border': _isHovered
                ? '2px solid color-mix(in srgb, $accent 70%, transparent)'
                : '2px solid color-mix(in srgb, $accent 35%, transparent)',
            'flex-shrink': '0',
            'transition': 'all var(--arcane-transition)',
            'box-shadow': _isHovered
                ? '0 0 15px color-mix(in srgb, $accent 35%, transparent)'
                : '0 0 8px color-mix(in srgb, $accent 15%, transparent)',
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
                  'font-size': 'var(--font-size-xxs)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': accent,
                  'letter-spacing': '0.05em',
                  'text-shadow': '0 0 8px $accent',
                }),
                [Component.text(props.badge!)],
              ),
          ],
        ),

        // Chevron
        dom.div(
          styles: dom.Styles(raw: {
            'color': accent,
            'opacity': _isHovered ? '1' : '0.5',
            'transition': 'all var(--arcane-transition)',
            'flex-shrink': '0',
            'transform': _isHovered ? 'translateX(3px)' : 'translateX(0)',
          }),
          [ArcaneIcon.chevronRight(size: mini ? IconSize.xs : IconSize.sm)],
        ),
      ],
    );
  }
}