import 'package:jaspr/jaspr.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  link,
  success,
  warning,
  info,
  accent,
}

enum ButtonSize {
  small,
  medium,
  large,
  icon,
  iconSmall,
  iconLarge,
}

/// Button component properties.
class ButtonProps {
  final String? label;
  final Component? child;
  final Component? icon;
  final Component? trailing;
  final void Function()? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;
  final String? id;
  final Map<String, String>? attributes;

  /// If provided, renders the button as an anchor tag (`<a>`) instead of `<button>`.
  /// Useful for CTA buttons that navigate to other pages.
  final String? href;

  /// Whether to show an arrow indicator after the label.
  /// Useful for CTA buttons to indicate navigation.
  final bool showArrow;

  const ButtonProps({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.id,
    this.attributes,
    this.href,
    this.showArrow = false,
  });

  ButtonProps copyWith({
    String? label,
    Component? child,
    Component? icon,
    Component? trailing,
    void Function()? onPressed,
    ButtonVariant? variant,
    ButtonSize? size,
    bool? disabled,
    bool? loading,
    bool? fullWidth,
    String? id,
    Map<String, String>? attributes,
    String? href,
    bool? showArrow,
  }) {
    return ButtonProps(
      label: label ?? this.label,
      child: child ?? this.child,
      icon: icon ?? this.icon,
      trailing: trailing ?? this.trailing,
      onPressed: onPressed ?? this.onPressed,
      variant: variant ?? this.variant,
      size: size ?? this.size,
      disabled: disabled ?? this.disabled,
      loading: loading ?? this.loading,
      fullWidth: fullWidth ?? this.fullWidth,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      href: href ?? this.href,
      showArrow: showArrow ?? this.showArrow,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for button components.
mixin ButtonRendererContract {
  /// Render a button component.
  Component button(ButtonProps props);
}
