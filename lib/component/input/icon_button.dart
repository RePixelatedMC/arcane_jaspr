import 'package:arcane_jaspr/aliases.dart';

export '../../core/props/icon_button_props.dart'
    show ComponentSize, ColorVariant, StyleVariant;

/// An icon-only button component.
class ArcaneIconButton extends StatelessComponent {
  final Component icon;
  final void Function()? onPressed;
  final ColorVariant color;
  final StyleVariant style;
  final ComponentSize size;
  final bool disabled;
  final bool loading;
  final String? tooltip;

  const ArcaneIconButton({
    required this.icon,
    this.onPressed,
    this.color = ColorVariant.secondary,
    this.style = StyleVariant.ghost,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  });

  const ArcaneIconButton.primary({
    required this.icon,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : color = ColorVariant.primary,
        style = StyleVariant.solid;

  const ArcaneIconButton.ghost({
    required this.icon,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : color = ColorVariant.secondary,
        style = StyleVariant.ghost;

  const ArcaneIconButton.outline({
    required this.icon,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : color = ColorVariant.secondary,
        style = StyleVariant.outline;

  const ArcaneIconButton.destructive({
    required this.icon,
    this.onPressed,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : color = ColorVariant.destructive,
        style = StyleVariant.solid;

  @override
  Component build(BuildContext context) {
    return context.renderers.iconButton(IconButtonProps(
      icon: icon,
      onPressed: onPressed,
      color: color,
      style: style,
      size: size,
      disabled: disabled,
      loading: loading,
      tooltip: tooltip,
    ));
  }
}
