import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

export '../../core/props/toggle_switch_props.dart'
    show ToggleSwitchSize, ToggleSwitchVariant;

import '../../core/props/toggle_switch_props.dart';
import '../../core/theme_provider.dart';

/// A toggle switch component.
///
/// The actual rendering is delegated to the current stylesheet's renderer,
/// ensuring consistent API regardless of which design system is active.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneToggleSwitch(
///   value: true,
///   onChanged: (value) => print(value),
/// )
/// ```
///
/// ## With Label
///
/// ```dart
/// ArcaneToggleSwitch(
///   value: isEnabled,
///   label: 'Enable notifications',
///   onChanged: (value) => setState(() => isEnabled = value),
/// )
/// ```
///
/// ## Variants
///
/// ```dart
/// ArcaneToggleSwitch.primary(value: true, label: 'Primary')
/// ArcaneToggleSwitch.success(value: true, label: 'Success')
/// ArcaneToggleSwitch.warning(value: true, label: 'Warning')
/// ArcaneToggleSwitch.error(value: true, label: 'Error')
/// ```
class ArcaneToggleSwitch extends StatelessComponent {
  /// Whether the switch is on
  final bool value;

  /// Callback when the switch is toggled
  final void Function(bool)? onChanged;

  /// Whether the switch is disabled
  final bool disabled;

  /// Size of the switch
  final ToggleSwitchSize size;

  /// Color variant
  final ToggleSwitchVariant variant;

  /// Optional label text
  final String? label;

  /// Whether to show the label on the left side
  final bool labelLeft;

  /// Creates a toggle switch.
  ///
  /// Use [onChanged] or [onToggle] for value change handling.
  const ArcaneToggleSwitch({
    required this.value,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.variant = ToggleSwitchVariant.primary,
    this.label,
    this.labelLeft = false,
    super.key,
  }) : onChanged = onChanged ?? onToggle;

  /// Primary toggle
  const ArcaneToggleSwitch.primary({
    required this.value,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.label,
    this.labelLeft = false,
    super.key,
  })  : onChanged = onChanged ?? onToggle,
        variant = ToggleSwitchVariant.primary;

  /// Success toggle
  const ArcaneToggleSwitch.success({
    required this.value,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.label,
    this.labelLeft = false,
    super.key,
  })  : onChanged = onChanged ?? onToggle,
        variant = ToggleSwitchVariant.success;

  /// Warning toggle
  const ArcaneToggleSwitch.warning({
    required this.value,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.label,
    this.labelLeft = false,
    super.key,
  })  : onChanged = onChanged ?? onToggle,
        variant = ToggleSwitchVariant.warning;

  /// Error toggle
  const ArcaneToggleSwitch.error({
    required this.value,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    this.disabled = false,
    this.size = ToggleSwitchSize.medium,
    this.label,
    this.labelLeft = false,
    super.key,
  })  : onChanged = onChanged ?? onToggle,
        variant = ToggleSwitchVariant.error;

  @override
  Component build(BuildContext context) {
    // Delegate to the current stylesheet's toggle switch renderer
    return context.renderers.toggleSwitch(ToggleSwitchProps(
      value: value,
      onChanged: onChanged,
      disabled: disabled,
      size: size,
      variant: variant,
      label: label,
      labelLeft: labelLeft,
    ));
  }
}

/// A toggle button group (like pricing monthly/yearly) matching shadcn/ui tabs styling
/// Reference: https://ui.shadcn.com/docs/components/toggle-group
///
/// ShadCN Toggle Group / Tabs:
/// - Container: inline-flex h-10, rounded-md, bg-muted, p-1
/// - Items: rounded-sm (4px), px-3 py-1.5, text-sm font-medium
/// - Active: bg-background, text-foreground, shadow-sm
/// - Inactive: text-muted-foreground, hover:bg-muted hover:text-muted-foreground
class ArcaneToggleButtonGroup extends StatelessComponent {
  /// The available options
  final List<String> options;

  /// The currently selected index
  final int selectedIndex;

  /// Callback when selection changes
  final void Function(int)? onChanged;

  /// Size of the toggle group
  final ToggleSwitchSize size;

  const ArcaneToggleButtonGroup({
    required this.options,
    required this.selectedIndex,
    this.onChanged,
    this.size = ToggleSwitchSize.medium,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // ShadCN sizes
    final (height, paddingH, paddingV, fontSize) = switch (size) {
      ToggleSwitchSize.small => ('36px', '10px', '6px', '14px'), // h-9
      ToggleSwitchSize.medium => ('40px', '12px', '6px', '14px'), // h-10 (shadcn default)
      ToggleSwitchSize.large => ('44px', '20px', '8px', '14px'), // h-11
    };

    return dom.div(
      classes: 'arcane-toggle-button-group',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'height': height,
        // ShadCN: p-1
        'padding': '4px',
        // ShadCN: bg-muted
        'background-color': 'var(--muted)',
        // ShadCN: rounded-md
        'border-radius': '0.375rem',
        'gap': '0',
      }),
      [
        for (var i = 0; i < options.length; i++)
          dom.button(
            classes: 'arcane-toggle-button ${i == selectedIndex ? 'active' : ''}',
            attributes: {'type': 'button'},
            styles: dom.Styles(raw: {
              // ShadCN: px-3 py-1.5
              'padding': '$paddingV $paddingH',
              // ShadCN: text-sm font-medium
              'font-size': fontSize,
              'font-weight': '500',
              'border': 'none',
              // ShadCN: rounded-sm
              'border-radius': '0.125rem',
              // ShadCN: data-[state=active]:bg-background, data-[state=active]:shadow-sm
              'background-color':
                  i == selectedIndex ? 'var(--background)' : 'transparent',
              // ShadCN: data-[state=active]:text-foreground, text-muted-foreground
              'color': i == selectedIndex
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'cursor': 'pointer',
              // ShadCN: transition-all
              'transition': 'all 150ms ease',
              'white-space': 'nowrap',
              // ShadCN: data-[state=active]:shadow-sm
              if (i == selectedIndex) 'box-shadow': '0 1px 2px 0 rgb(0 0 0 / 0.05)',
            }),
            events: {
              'click': (event) {
                if (onChanged != null && i != selectedIndex) {
                  onChanged!(i);
                }
              },
            },
            [dom.text(options[i])],
          ),
      ],
    );
  }
}