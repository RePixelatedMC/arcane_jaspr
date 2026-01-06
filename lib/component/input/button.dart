import 'package:jaspr/jaspr.dart';

import '../../core/props/button_props.dart';
import '../../core/theme_provider.dart';

// Re-export for backwards compatibility
export '../../core/props/button_props.dart' show ButtonVariant, ButtonSize;

/// A styled button component.
///
/// The actual rendering is delegated to the current stylesheet's renderer,
/// ensuring consistent API regardless of which design system is active.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneButton(
///   label: 'Click Me',
///   onPressed: () => print('Clicked!'),
/// )
/// ```
///
/// ## Variants
///
/// Use named constructors for common variants:
///
/// ```dart
/// ArcaneButton.primary(label: 'Save')
/// ArcaneButton.secondary(label: 'Cancel')
/// ArcaneButton.outline(label: 'Edit')
/// ArcaneButton.ghost(label: 'More')
/// ArcaneButton.destructive(label: 'Delete')
/// ArcaneButton.link(label: 'Learn more')
/// ```
///
/// ## With Icons
///
/// ```dart
/// ArcaneButton(
///   label: 'Download',
///   icon: Icon(LucideIcons.download),
///   onPressed: () {},
/// )
/// ```
class ArcaneButton extends StatelessComponent {
  /// Button label text
  final String? label;

  /// Child component (alternative to label)
  final Component? child;

  /// Leading icon
  final Component? icon;

  /// Trailing icon
  final Component? trailing;

  /// Click handler
  final void Function()? onPressed;

  /// Button style variant
  final ButtonVariant variant;

  /// Button size
  final ButtonSize size;

  /// Whether the button is disabled
  final bool disabled;

  /// Whether the button is loading
  final bool loading;

  /// Whether to expand to full width
  final bool fullWidth;

  /// Custom HTML attributes (e.g., data-* attributes)
  final Map<String, String>? attributes;

  /// Optional ID for the button element
  final String? id;

  const ArcaneButton({
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
    this.attributes,
    this.id,
    super.key,
  });

  /// Primary button constructor
  const ArcaneButton.primary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.primary;

  /// Secondary button constructor
  const ArcaneButton.secondary({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.secondary;

  /// Outline button constructor
  const ArcaneButton.outline({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.outline;

  /// Ghost button constructor
  const ArcaneButton.ghost({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.ghost;

  /// Destructive button constructor
  const ArcaneButton.destructive({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.destructive;

  /// Warning button constructor
  const ArcaneButton.warning({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.warning;

  /// Success button constructor
  const ArcaneButton.success({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.success;

  /// Link button constructor
  const ArcaneButton.link({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.link;

  /// Info button constructor
  const ArcaneButton.info({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.attributes,
    this.id,
    super.key,
  }) : variant = ButtonVariant.info;

  @override
  Component build(BuildContext context) {
    // Delegate to the current stylesheet's button renderer
    return context.renderers.button(ButtonProps(
      label: label,
      child: child,
      icon: icon,
      trailing: trailing,
      onPressed: onPressed,
      variant: variant,
      size: size,
      disabled: disabled,
      loading: loading,
      fullWidth: fullWidth,
      id: id,
      attributes: attributes,
    ));
  }
}
