import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/cycle_button_props.dart';

/// ShadCN Cycle Button renderer.
class ShadcnCycleButton<T> extends StatefulComponent {
  final CycleButtonProps<T> props;

  const ShadcnCycleButton(this.props);

  @override
  State<ShadcnCycleButton<T>> createState() => _ShadcnCycleButtonState<T>();
}

class _ShadcnCycleButtonState<T> extends State<ShadcnCycleButton<T>> {
  void _cycle() {
    if (component.props.disabled || component.props.onChanged == null) return;

    final currentIndex = component.props.options.indexWhere((opt) => opt.value == component.props.value);
    final nextIndex = (currentIndex + 1) % component.props.options.length;
    component.props.onChanged!(component.props.options[nextIndex].value);
  }

  @override
  Component build(BuildContext context) {
    final props = component.props;
    final currentIndex = props.options.indexWhere((opt) => opt.value == props.value);
    final currentOption = currentIndex >= 0
        ? props.options[currentIndex]
        : props.options.first;

    // Get size-specific styles
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
          'height': '2rem',
          'padding': '0 0.75rem',
          'font-size': 'var(--font-size-sm)',
        },
      CycleButtonSize.medium => {
          'height': '2.5rem',
          'padding': '0 1rem',
          'font-size': 'var(--font-size-sm)',
        },
      CycleButtonSize.large => {
          'height': '2.75rem',
          'padding': '0 2rem',
          'font-size': 'var(--font-size-base)',
        },
      CycleButtonSize.icon => {
          'height': '2.5rem',
          'width': '2.5rem',
          'padding': '0',
        },
      CycleButtonSize.iconSmall => {
          'height': '2rem',
          'width': '2rem',
          'padding': '0',
        },
      CycleButtonSize.iconLarge => {
          'height': '2.75rem',
          'width': '2.75rem',
          'padding': '0',
        },
    };

    // Get variant-specific styles
    final Map<String, String> variantStyles = switch (props.variant) {
      CycleButtonVariant.outline => {
          'background-color': 'transparent',
          'color': 'var(--foreground)',
          'border': '1px solid var(--border)',
        },
      CycleButtonVariant.primary => {
          'background-color': 'var(--primary)',
          'color': 'var(--primary-foreground)',
          'border': 'none',
        },
      CycleButtonVariant.secondary => {
          'background-color': 'var(--secondary)',
          'color': 'var(--secondary-foreground)',
          'border': 'none',
        },
      CycleButtonVariant.ghost => {
          'background-color': 'transparent',
          'color': 'var(--foreground)',
          'border': 'none',
        },
      CycleButtonVariant.destructive => {
          'background-color': 'var(--destructive)',
          'color': 'var(--destructive-foreground)',
          'border': 'none',
        },
    };

    // Encode options as JSON for static site JavaScript
    final optionsJson = props.options
        .map((opt) => opt.label ?? opt.value.toString())
        .toList()
        .join('|');

    return button(
      id: props.id,
      classes: 'arcane-cycle-button ${props.disabled ? 'disabled' : ''}',
      attributes: {
        if (props.disabled) 'disabled': 'true',
        'type': 'button',
        'data-options': optionsJson,
        'data-index': '${currentIndex >= 0 ? currentIndex : 0}',
        ...?props.attributes,
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': 'var(--space-2)',
        ...sizeStyles,
        'font-weight': 'var(--font-weight-medium)',
        'border-radius': 'var(--arcane-radius-sm)',
        ...variantStyles,
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
        'white-space': 'nowrap',
      }),
      events: {
        'click': (event) => _cycle(),
      },
      [
        if (currentOption.icon != null) currentOption.icon!,
        if (currentOption.label != null)
          span(
            classes: 'arcane-cycle-button-label',
            [Component.text(currentOption.label!)],
          ),
        // Cycle indicator
        const span(
          classes: 'arcane-cycle-button-indicator',
          styles: Styles(raw: {
            'font-size': '0.75em',
            'opacity': '0.7',
            'display': 'inline-block',
          }),
          [Component.text('[cycle]')],
        ),
      ],
    );
  }
}

/// ShadCN Toggle Button renderer.
class ShadcnToggleButton extends StatelessComponent {
  final ToggleButtonProps props;

  const ShadcnToggleButton(this.props);

  @override
  Component build(BuildContext context) {
    // Get size-specific styles
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
          'height': '2rem',
          'padding': '0 0.75rem',
          'font-size': 'var(--font-size-sm)',
        },
      CycleButtonSize.medium => {
          'height': '2.5rem',
          'padding': '0 1rem',
          'font-size': 'var(--font-size-sm)',
        },
      CycleButtonSize.large => {
          'height': '2.75rem',
          'padding': '0 2rem',
          'font-size': 'var(--font-size-base)',
        },
      CycleButtonSize.icon => {
          'height': '2.5rem',
          'width': '2.5rem',
          'padding': '0',
        },
      CycleButtonSize.iconSmall => {
          'height': '2rem',
          'width': '2rem',
          'padding': '0',
        },
      CycleButtonSize.iconLarge => {
          'height': '2.75rem',
          'width': '2.75rem',
          'padding': '0',
        },
    };

    return button(
      id: props.id,
      classes: 'arcane-toggle-button ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: {
        if (props.disabled) 'disabled': 'true',
        'type': 'button',
        'aria-pressed': '${props.value}',
        ...?props.attributes,
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': 'var(--space-2)',
        ...sizeStyles,
        'font-weight': 'var(--font-weight-medium)',
        'border-radius': 'var(--arcane-radius-sm)',
        // Active: primary background, inactive: muted background with border
        'background-color': props.value ? 'var(--primary)' : 'var(--muted)',
        'color': props.value ? 'var(--primary-foreground)' : 'var(--foreground)',
        'border': props.value ? 'none' : '1px solid var(--border)',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
      }),
      events: {
        'click': (event) {
          if (!props.disabled && props.onChanged != null) {
            props.onChanged!(!props.value);
          }
        },
      },
      [
        if (props.icon != null) props.icon!,
        if (props.label != null) Component.text(props.label!),
      ],
    );
  }
}