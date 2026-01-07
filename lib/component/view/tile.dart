import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/tile_props.dart';

/// A list tile component for displaying items in a list.
class ArcaneTile extends StatelessComponent {
  final String? title;
  final Component? titleWidget;
  final String? subtitle;
  final Component? subtitleWidget;
  final Component? leading;
  final Component? trailing;
  final void Function()? onTap;
  final bool selected;
  final bool disabled;
  final EdgeInsets? padding;
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

/// A navigation tile for sidebar or list navigation.
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
