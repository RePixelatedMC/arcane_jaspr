import 'package:arcane_jaspr/aliases.dart';

export '../../core/props/icon_button_props.dart'
    show IconButtonSize, IconButtonVariant;

/// Style presets for icon buttons.
enum IconButtonStyle {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  success,
  warning,
}

/// An icon-only button component.
class ArcaneIconButton extends StatelessComponent {
  final Component icon;
  final void Function()? onPressed;
  final IconButtonStyle style;
  final IconButtonSize size;
  final bool disabled;
  final bool loading;
  final String? tooltip;

  const ArcaneIconButton({
    required this.icon,
    this.onPressed,
    this.style = IconButtonStyle.ghost,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  });

  const ArcaneIconButton.primary({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.primary;

  const ArcaneIconButton.ghost({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.ghost;

  const ArcaneIconButton.outline({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.outline;

  const ArcaneIconButton.destructive({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.destructive;

  IconButtonVariant _styleToVariant(IconButtonStyle s) {
    return switch (s) {
      IconButtonStyle.primary => IconButtonVariant.primary,
      IconButtonStyle.secondary => IconButtonVariant.secondary,
      IconButtonStyle.outline => IconButtonVariant.outline,
      IconButtonStyle.ghost => IconButtonVariant.ghost,
      IconButtonStyle.destructive => IconButtonVariant.destructive,
      IconButtonStyle.success => IconButtonVariant.success,
      IconButtonStyle.warning => IconButtonVariant.warning,
    };
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.iconButton(IconButtonProps(
      icon: icon,
      onPressed: onPressed,
      variant: _styleToVariant(style),
      size: size,
      disabled: disabled,
      loading: loading,
      tooltip: tooltip,
    ));
  }
}
