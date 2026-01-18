import 'package:jaspr/jaspr.dart';

/// Game tile component properties.
class GameTileProps {
  final String name;
  final String? iconUrl;
  final Component? icon;
  final bool selected;
  final void Function()? onTap;
  final bool popular;
  final String? badge;
  final String? subtitle;

  const GameTileProps({
    required this.name,
    this.iconUrl,
    this.icon,
    this.selected = false,
    this.onTap,
    this.popular = false,
    this.badge,
    this.subtitle,
  });
}

/// Game selector component properties.
class GameSelectorProps {
  final List<GameTileProps> games;
  final int columns;
  final double gap;
  final String? title;
  final String? description;

  const GameSelectorProps({
    required this.games,
    this.columns = 4,
    this.gap = 16,
    this.title,
    this.description,
  });
}

/// Game card component properties.
class GameCardProps {
  final String name;
  final String? description;
  final String? iconUrl;
  final Component? icon;
  final String? backgroundUrl;
  final String? status;
  final List<String>? features;
  final void Function()? onTap;
  final String? ctaText;

  const GameCardProps({
    required this.name,
    this.description,
    this.iconUrl,
    this.icon,
    this.backgroundUrl,
    this.status,
    this.features,
    this.onTap,
    this.ctaText,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for game tile components.
mixin GameTileRendererContract {
  Component gameTile(GameTileProps props);
  Component gameSelector(GameSelectorProps props);
  Component gameCard(GameCardProps props);
}
