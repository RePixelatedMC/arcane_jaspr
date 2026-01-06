import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/tile_props.dart';

/// A list tile component for displaying items in a list.
class ArcaneTile extends StatelessComponent {
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

  /// Click handler
  final void Function()? onTap;

  /// Whether the tile is selected
  final bool selected;

  /// Whether the tile is disabled
  final bool disabled;

  /// Custom padding
  final EdgeInsets? padding;

  /// Whether to use dense layout
  final bool dense;

  const ArcaneTile({
    this.title,
    this.titleWidget,
    this.subtitle,
    this.subtitleWidget,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.padding,
    this.dense = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.tile(TileProps(
      title: title,
      titleWidget: titleWidget,
      subtitle: subtitle,
      subtitleWidget: subtitleWidget,
      leading: leading,
      trailing: trailing,
      selected: selected,
      disabled: disabled,
      dense: dense,
      onTap: onTap,
      padding: padding?.padding,
    ));
  }
}

/// A navigation tile for sidebar or list navigation
class ArcaneNavTile extends StatelessComponent {
  final String label;
  final Component? icon;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;
  final String? badge;

  const ArcaneNavTile({
    required this.label,
    this.icon,
    this.onTap,
    this.selected = false,
    this.disabled = false,
    this.badge,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.navTile(NavTileProps(
      label: label,
      icon: icon,
      selected: selected,
      disabled: disabled,
      badge: badge,
      onTap: onTap,
    ));
  }
}
