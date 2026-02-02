import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/game_tile_props.dart';

/// A game tile component for game server selection.
///
/// Supports multiple variants:
/// - Default (compact): Small selection tile with centered icon
/// - Card: Full card layout with image, badges, and CTA
/// - Hero: Larger featured tile
class ArcaneGameTile extends StatelessComponent {
  final String name;
  final String? iconUrl;
  final Component? icon;
  final bool selected;
  final void Function()? onTap;
  final bool popular;
  final String? badge;
  final String? subtitle;
  final bool isNew;
  final List<GamePlatform> platforms;
  final String? href;
  final bool showHoverEffects;
  final bool showPlatformIcons;
  final String? ctaText;
  final String? height;
  final GameTileVariant variant;
  final int? animationDelayMs;

  const ArcaneGameTile({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    this.isNew = false,
    this.platforms = const [],
    this.href,
    this.showHoverEffects = true,
    this.showPlatformIcons = true,
    this.ctaText,
    this.height,
    this.variant = GameTileVariant.compact,
    this.animationDelayMs,
    super.key,
  });

  /// Creates a card-style game tile with image and info sections.
  /// This is the style used in game grids with large images.
  const ArcaneGameTile.card({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    this.isNew = false,
    this.platforms = const [],
    this.href,
    this.showHoverEffects = true,
    this.showPlatformIcons = true,
    this.ctaText = 'Get Started',
    this.height = '420px',
    this.animationDelayMs,
    super.key,
  }) : variant = GameTileVariant.card;

  /// Creates a hero-style game tile (larger card variant).
  const ArcaneGameTile.hero({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
    this.isNew = false,
    this.platforms = const [],
    this.href,
    this.showHoverEffects = true,
    this.showPlatformIcons = true,
    this.ctaText = 'Get Started',
    this.height = '480px',
    this.animationDelayMs,
    super.key,
  }) : variant = GameTileVariant.hero;

  @override
  Component build(BuildContext context) {
    return context.renderers.gameTile(GameTileProps(
      name: name,
      iconUrl: iconUrl,
      icon: icon,
      selected: selected,
      onTap: onTap,
      popular: popular,
      badge: badge,
      subtitle: subtitle,
      isNew: isNew,
      platforms: platforms,
      href: href,
      showHoverEffects: showHoverEffects,
      showPlatformIcons: showPlatformIcons,
      ctaText: ctaText,
      height: height,
      variant: variant,
      animationDelayMs: animationDelayMs,
    ));
  }
}

/// A grid of game tiles.
class ArcaneGameSelector extends StatelessComponent {
  final List<GameTileProps> games;
  final int columns;
  final double gap;
  final String? title;
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
    return context.renderers.gameSelector(GameSelectorProps(
      games: games,
      columns: columns,
      gap: gap,
      title: title,
      description: description,
    ));
  }
}

/// A game card with more details.
class ArcaneGameCard extends StatelessComponent {
  final String name;
  final String? description;
  final String? iconUrl;
  final Component? icon;
  final String? backgroundUrl;
  final String? status;
  final List<String>? features;
  final void Function()? onTap;
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
    return context.renderers.gameCard(GameCardProps(
      name: name,
      description: description,
      iconUrl: iconUrl,
      icon: icon,
      backgroundUrl: backgroundUrl,
      status: status,
      features: features,
      onTap: onTap,
      ctaText: ctaText,
    ));
  }
}

/// A horizontal game navigation link with icon, name, and optional badge.
///
/// Features custom accent color theming for glows, gradients, and borders.
/// Commonly used in headers or navigation sections for featured games.
class ArcaneGameLink extends StatelessComponent {
  /// Game name to display.
  final String name;

  /// Link destination.
  final String href;

  /// Accent color for theming (CSS color value).
  /// Used for gradient backgrounds, glows, and borders.
  final String accentColor;

  /// URL to the game icon image.
  final String? iconUrl;

  /// Custom icon component (alternative to iconUrl).
  final Component? icon;

  /// Optional badge text (e.g., "NEW", "POPULAR").
  final String? badge;

  /// Whether to use compact/mini sizing.
  final bool mini;

  const ArcaneGameLink({
    required this.name,
    required this.href,
    required this.accentColor,
    this.iconUrl,
    this.icon,
    this.badge,
    this.mini = false,
    super.key,
  });

  /// Creates a mini (compact) game link.
  const ArcaneGameLink.mini({
    required this.name,
    required this.href,
    required this.accentColor,
    this.iconUrl,
    this.icon,
    this.badge,
    super.key,
  }) : mini = true;

  @override
  Component build(BuildContext context) {
    return context.renderers.gameLink(GameLinkProps(
      name: name,
      href: href,
      accentColor: accentColor,
      iconUrl: iconUrl,
      icon: icon,
      badge: badge,
      mini: mini,
    ));
  }
}
