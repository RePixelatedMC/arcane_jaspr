import 'package:arcane_jaspr/aliases.dart';
import 'package:jaspr/dom.dart' as dom;


export '../../core/props/icon_button_props.dart'
    show IconButtonSize, IconButtonVariant;

/// Style presets for icon buttons.
///
/// Maps to IconButtonVariant internally.
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
///
/// Use style presets for cleaner code:
/// ```dart
/// ArcaneIconButton(
///   icon: Icon(Icons.close),
///   style: IconButtonStyle.ghost,
/// )
/// ```
class ArcaneIconButton extends StatelessComponent {
  /// The icon to display
  final Component icon;

  /// Click handler
  final void Function()? onPressed;

  /// Style preset
  final IconButtonStyle style;

  /// Button size
  final IconButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  /// Optional tooltip text
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

  /// Primary icon button
  const ArcaneIconButton.primary({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.primary;

  /// Ghost icon button (default minimal style)
  const ArcaneIconButton.ghost({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.ghost;

  /// Outline icon button
  const ArcaneIconButton.outline({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.outline;

  /// Destructive icon button
  const ArcaneIconButton.destructive({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  }) : style = IconButtonStyle.destructive;

  /// Close button (X icon) - ghost style by default
  ///
  /// ```dart
  /// ArcaneIconButton.close(onPressed: () => closeDialog())
  /// ```
  const factory ArcaneIconButton.close({
    void Function()? onPressed,
    IconButtonSize size,
    IconButtonStyle style,
    Key? key,
  }) = _ArcaneCloseButton;

  /// Convert IconButtonStyle to IconButtonVariant for props
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

/// Internal implementation for ArcaneIconButton.close()
class _ArcaneCloseButton extends ArcaneIconButton {
  const _ArcaneCloseButton({
    super.onPressed,
    super.size,
    IconButtonStyle style = IconButtonStyle.ghost,
    super.key,
  }) : super(
          icon: const _CloseIcon(),
          style: style,
          tooltip: 'Close',
        );
}

/// Close icon (X character)
class _CloseIcon extends StatelessComponent {
  const _CloseIcon();

  @override
  Component build(BuildContext context) {
    return const dom.span(
      styles: dom.Styles(raw: {
        'font-size': '1.25em',
        'line-height': '1',
      }),
      [Component.text('\u00D7')],
    );
  }
}