import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

export '../../core/props/checkbox_props.dart' show CheckboxSize, CheckboxVariant;

import '../../core/theme_provider.dart';

/// Checkbox input component.
///
/// The actual rendering is delegated to the current stylesheet's renderer,
/// ensuring consistent API regardless of which design system is active.
///
/// ## Basic Usage
///
/// ```dart
/// ArcaneCheckbox(
///   checked: true,
///   onChanged: (value) => print(value),
/// )
/// ```
///
/// ## With Label and Description
///
/// ```dart
/// ArcaneCheckbox(
///   checked: isChecked,
///   label: 'Accept terms',
///   description: 'You agree to our terms of service.',
///   onChanged: (value) => setState(() => isChecked = value),
/// )
/// ```
///
/// ## Variants
///
/// ```dart
/// ArcaneCheckbox.primary(checked: true, label: 'Primary')
/// ArcaneCheckbox.success(checked: true, label: 'Success')
/// ArcaneCheckbox.warning(checked: true, label: 'Warning')
/// ArcaneCheckbox.error(checked: true, label: 'Error')
/// ```
class ArcaneCheckbox extends StatelessComponent {
  final bool checked;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxVariant variant;
  final bool disabled;
  final void Function(bool)? _onChanged;

  /// Creates a checkbox.
  ///
  /// Use [onChanged] or [onToggle] for value change handling.
  const ArcaneCheckbox({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.variant = CheckboxVariant.primary,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  }) : _onChanged = onChanged ?? onToggle;

  /// Primary checkbox
  const ArcaneCheckbox.primary({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  })  : _onChanged = onChanged ?? onToggle,
        variant = CheckboxVariant.primary;

  /// Success checkbox
  const ArcaneCheckbox.success({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  })  : _onChanged = onChanged ?? onToggle,
        variant = CheckboxVariant.success;

  /// Warning checkbox
  const ArcaneCheckbox.warning({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  })  : _onChanged = onChanged ?? onToggle,
        variant = CheckboxVariant.warning;

  /// Error/destructive checkbox
  const ArcaneCheckbox.error({
    required this.checked,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.disabled = false,
    void Function(bool)? onChanged,
    void Function(bool)? onToggle,
    super.key,
  })  : _onChanged = onChanged ?? onToggle,
        variant = CheckboxVariant.error;

  @override
  Component build(BuildContext context) {
    // Delegate to the current stylesheet's checkbox renderer
    return context.renderers.checkbox(CheckboxProps(
      checked: checked,
      label: label,
      description: description,
      size: size,
      variant: variant,
      disabled: disabled,
      onChanged: _onChanged,
    ));
  }
}

/// Radio button component matching shadcn/ui
/// Reference: https://ui.shadcn.com/docs/components/radio-group
///
/// ShadCN Radio:
/// - Size: h-4 w-4 (16px), rounded-full
/// - Border: border border-primary
/// - Selected: inner dot h-2.5 w-2.5 (10px), bg-primary-foreground
/// - Focus: ring-2 ring-ring ring-offset-2
class ArcaneRadio extends StatelessComponent {
  final bool selected;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxVariant variant;
  final bool disabled;
  final void Function()? _onSelected;

  /// Creates a radio button.
  ///
  /// Use [onSelected] or [onTap] for selection handling.
  const ArcaneRadio({
    required this.selected,
    this.label,
    this.description,
    this.size = CheckboxSize.medium,
    this.variant = CheckboxVariant.primary,
    this.disabled = false,
    void Function()? onSelected,
    void Function()? onTap,
    super.key,
  }) : _onSelected = onSelected ?? onTap;

  @override
  Component build(BuildContext context) {
    // ShadCN size dimensions
    // Default: h-4 w-4 (16px), inner dot h-2.5 w-2.5 (10px)
    final radioSize = switch (size) {
      CheckboxSize.small => '14px', // h-3.5
      CheckboxSize.medium => '16px', // h-4 (shadcn default)
      CheckboxSize.large => '20px', // h-5
    };

    // Inner dot is roughly 62.5% of the outer circle size
    final dotSize = switch (size) {
      CheckboxSize.small => '8px',
      CheckboxSize.medium => '10px', // h-2.5 (shadcn default)
      CheckboxSize.large => '12px',
    };

    // Get border and dot color based on variant
    final (borderColor, dotColor) = switch (variant) {
      CheckboxVariant.primary => ('var(--primary)', 'var(--primary)'),
      CheckboxVariant.success => ('var(--success)', 'var(--success)'),
      CheckboxVariant.warning => ('var(--warning)', 'var(--warning)'),
      CheckboxVariant.error => ('var(--destructive)', 'var(--destructive)'),
    };

    return dom.div(
      classes: 'arcane-radio-wrapper',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.5rem',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        // ShadCN: disabled:opacity-50 disabled:cursor-not-allowed
        'opacity': disabled ? '0.5' : '1',
        'pointer-events': disabled ? 'none' : 'auto',
      }),
      events: disabled || _onSelected == null
          ? null
          : {
              'click': (event) => _onSelected(),
            },
      [
        // Radio circle - ShadCN styling
        dom.div(
          classes: 'arcane-radio',
          styles: dom.Styles(raw: {
            'width': radioSize,
            'height': radioSize,
            // ShadCN: rounded-full
            'border-radius': '9999px',
            'background': 'transparent',
            // ShadCN: border border-primary
            'border': '1px solid $borderColor',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            // ShadCN: transition-colors
            'transition': 'color 150ms ease, background-color 150ms ease, border-color 150ms ease',
          }),
          [
            if (selected)
              dom.div(
                styles: dom.Styles(raw: {
                  'width': dotSize,
                  'height': dotSize,
                  // ShadCN: rounded-full
                  'border-radius': '9999px',
                  // ShadCN: bg-primary when checked (fill the dot with primary color)
                  'background': dotColor,
                }),
                [],
              ),
          ],
        ),
        // Label and description
        if (label != null || description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'flex': '1',
            }),
            [
              if (label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    // ShadCN: text-sm font-medium
                    'font-size': '14px',
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                    'display': 'block',
                    'line-height': '1',
                  }),
                  [Component.text(label!)],
                ),
              if (description != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    // ShadCN: text-sm text-muted-foreground
                    'font-size': '14px',
                    'color': 'var(--muted-foreground)',
                    'display': 'block',
                    'margin-top': '4px',
                  }),
                  [Component.text(description!)],
                ),
            ],
          ),
      ],
    );
  }
}