import 'package:arcane_jaspr/aliases.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/props/icon_button_props.dart';
import '../../core/theme_provider.dart';
import 'button.dart';

// Re-export for backwards compatibility
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

  /// Style preset (preferred)
  final IconButtonStyle? style;

  /// Button variant (legacy - use style instead)
  @Deprecated('Use style parameter with IconButtonStyle presets instead')
  final ButtonVariant? variant;

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
    this.style,
    @Deprecated('Use style parameter instead') this.variant,
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
  })  : style = IconButtonStyle.primary,
        variant = null;

  /// Ghost icon button (default minimal style)
  const ArcaneIconButton.ghost({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.ghost,
        variant = null;

  /// Outline icon button
  const ArcaneIconButton.outline({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.outline,
        variant = null;

  /// Destructive icon button
  const ArcaneIconButton.destructive({
    required this.icon,
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.tooltip,
    super.key,
  })  : style = IconButtonStyle.destructive,
        variant = null;

  /// Convert legacy variant to IconButtonVariant for props
  IconButtonVariant _variantToVariant(ButtonVariant v) {
    return switch (v) {
      ButtonVariant.primary => IconButtonVariant.primary,
      ButtonVariant.secondary => IconButtonVariant.secondary,
      ButtonVariant.outline => IconButtonVariant.outline,
      ButtonVariant.ghost => IconButtonVariant.ghost,
      ButtonVariant.destructive => IconButtonVariant.destructive,
      ButtonVariant.success => IconButtonVariant.success,
      ButtonVariant.warning => IconButtonVariant.warning,
      ButtonVariant.info => IconButtonVariant.primary, // Map info to primary
      ButtonVariant.link => IconButtonVariant.ghost,
    };
  }

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
    // Resolve variant from style or legacy variant
    final IconButtonVariant effectiveVariant = style != null
        ? _styleToVariant(style!)
        : (variant != null ? _variantToVariant(variant!) : IconButtonVariant.ghost);

    // Delegate to the current stylesheet's icon button renderer
    return context.renderers.iconButton(IconButtonProps(
      icon: icon,
      onPressed: onPressed,
      variant: effectiveVariant,
      size: size,
      disabled: disabled,
      loading: loading,
      tooltip: tooltip,
    ));
  }
}

/// A close button (X icon)
class ArcaneCloseButton extends StatelessComponent {
  final void Function()? onPressed;
  final IconButtonSize size;
  final IconButtonStyle? style;

  const ArcaneCloseButton({
    this.onPressed,
    this.size = IconButtonSize.medium,
    this.style,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneIconButton(
      icon: _buildCloseIcon(),
      onPressed: onPressed,
      style: style ?? IconButtonStyle.ghost,
      size: size,
      tooltip: 'Close',
    );
  }

  Component _buildCloseIcon() {
    return dom.span(
      styles: const dom.Styles(raw: {
        'font-size': '1.25em',
        'line-height': '1',
      }),
      [Component.text('\u00D7')],
    );
  }
}