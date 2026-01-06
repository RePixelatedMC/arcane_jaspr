import 'package:jaspr/jaspr.dart';

/// Props for the GameTile component.
class GameTileProps {
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

/// Props for the GameSelector component.
class GameSelectorProps {
  /// Game tiles props
  final List<GameTileProps> games;

  /// Number of columns
  final int columns;

  /// Gap between tiles
  final double gap;

  /// Title
  final String? title;

  /// Description
  final String? description;

  const GameSelectorProps({
    required this.games,
    this.columns = 4,
    this.gap = 16,
    this.title,
    this.description,
  });
}

/// Props for the GameCard component.
class GameCardProps {
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
