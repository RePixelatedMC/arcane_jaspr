import 'package:jaspr/jaspr.dart';

/// Props for tile components.
class TileProps {
  /// Title text
  final String? title;

  /// Title component (overrides title string)
  final Component? titleWidget;

  /// Subtitle text
  final String? subtitle;

  /// Subtitle component (overrides subtitle string)
  final Component? subtitleWidget;

  /// Leading component (usually an icon or avatar)
  final Component? leading;

  /// Trailing component (usually an action button or info)
  final Component? trailing;

  /// Whether the tile is selected
  final bool selected;

  /// Whether the tile is disabled
  final bool disabled;

  /// Whether to use dense layout
  final bool dense;

  /// Click handler
  final void Function()? onTap;

  /// Custom padding
  final String? padding;

  const TileProps({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.selected = false,
    this.disabled = false,
    this.dense = false,
    this.onTap,
    this.padding,
  });
}

/// Props for navigation tile components.
class NavTileProps {
  /// Label text
  final String label;

  /// Optional icon
  final Component? icon;

  /// Whether the tile is selected
  final bool selected;

  /// Whether the tile is disabled
  final bool disabled;

  /// Badge text
  final String? badge;

  /// Click handler
  final void Function()? onTap;

  const NavTileProps({
    required this.label,
    this.icon,
    this.selected = false,
    this.disabled = false,
    this.badge,
    this.onTap,
  });
}
