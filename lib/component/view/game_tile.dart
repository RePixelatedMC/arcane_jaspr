import 'package:jaspr/jaspr.dart';

import '../../core/props/game_tile_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/game_tile_props.dart';

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
    return context.renderers.gameTile(GameTileProps(
      name: name,
      iconUrl: iconUrl,
      icon: icon,
      selected: selected,
      onTap: onTap,
      popular: popular,
      badge: badge,
      subtitle: subtitle,
    ));
  }
}

/// A grid of game tiles
class ArcaneGameSelector extends StatelessComponent {
  /// Game tile props
  final List<GameTileProps> games;

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
    return context.renderers.gameSelector(GameSelectorProps(
      games: games,
      columns: columns,
      gap: gap,
      title: title,
      description: description,
    ));
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
