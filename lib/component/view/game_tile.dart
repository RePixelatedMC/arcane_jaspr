import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/game_tile_props.dart';

/// A game tile component for game server selection.
class ArcaneGameTile extends StatelessComponent {
  final String name;
  final String? iconUrl;
  final Component? icon;
  final bool selected;
  final void Function()? onTap;
  final bool popular;
  final String? badge;
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
