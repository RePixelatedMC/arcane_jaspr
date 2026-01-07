import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

export '../../core/props/checkbox_props.dart' show CheckboxSize, CheckboxVariant;

import '../../core/theme_provider.dart';

/// Checkbox input component.
class ArcaneCheckbox extends StatelessComponent {
  final bool checked;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxVariant variant;
  final bool disabled;
  final void Function(bool)? _onChanged;

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

/// Radio button component.
class ArcaneRadio extends StatelessComponent {
  final bool selected;
  final String? label;
  final String? description;
  final CheckboxSize size;
  final CheckboxVariant variant;
  final bool disabled;
  final void Function()? _onSelected;

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
    final radioSize = switch (size) {
      CheckboxSize.small => '14px',
      CheckboxSize.medium => '16px',
      CheckboxSize.large => '20px',
    };

    final dotSize = switch (size) {
      CheckboxSize.small => '8px',
      CheckboxSize.medium => '10px',
      CheckboxSize.large => '12px',
    };

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
        'opacity': disabled ? '0.5' : '1',
        'pointer-events': disabled ? 'none' : 'auto',
      }),
      events: disabled || _onSelected == null
          ? null
          : {
              'click': (event) => _onSelected(),
            },
      [
        dom.div(
          classes: 'arcane-radio',
          styles: dom.Styles(raw: {
            'width': radioSize,
            'height': radioSize,
            'border-radius': '9999px',
            'background': 'transparent',
            'border': '1px solid $borderColor',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'color 150ms ease, background-color 150ms ease, border-color 150ms ease',
          }),
          [
            if (selected)
              dom.div(
                styles: dom.Styles(raw: {
                  'width': dotSize,
                  'height': dotSize,
                  'border-radius': '9999px',
                  'background': dotColor,
                }),
                [],
              ),
          ],
        ),
        if (label != null || description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'flex': '1',
            }),
            [
              if (label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
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
