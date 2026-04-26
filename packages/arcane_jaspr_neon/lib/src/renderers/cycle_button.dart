import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/cycle_button_props.dart';

/// Neon cycle button renderer.
class NeonCycleButton<T> extends StatefulComponent {
  final CycleButtonProps<T> props;

  const NeonCycleButton(this.props);

  @override
  State<NeonCycleButton<T>> createState() => _NeonCycleButtonState<T>();
}

class _NeonCycleButtonState<T> extends State<NeonCycleButton<T>> {
  void _cycle() {
    if (component.props.disabled || component.props.onChanged == null) return;
    final int currentIndex = component.props.options.indexWhere(
      (opt) => opt.value == component.props.value,
    );
    final int nextIndex = (currentIndex + 1) % component.props.options.length;
    component.props.onChanged!(component.props.options[nextIndex].value);
  }

  @override
  Component build(BuildContext context) {
    final CycleButtonProps<T> props = component.props;
    final int currentIndex = props.options.indexWhere(
      (opt) => opt.value == props.value,
    );
    final CycleOption<T> currentOption = currentIndex >= 0
        ? props.options[currentIndex]
        : props.options.first;

    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2.25rem',
        'padding': '0 0.9rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '2.6rem',
        'padding': '0 1.1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '3rem',
        'padding': '0 1.4rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '2.6rem',
        'width': '2.6rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2.25rem',
        'width': '2.25rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
    };

    final Map<String, String> variantStyles = _variantStyles(props.variant);
    final String optionsJson = props.options
        .map((o) => o.label ?? o.value.toString())
        .join('|');

    return dom.button(
      id: props.id,
      classes: 'neon-cycle-button ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'data-state': 'idle',
        'data-disabled': '${props.disabled}',
        'data-variant': props.variant.name,
        'data-size': props.size.name,
        'data-options': optionsJson,
        'data-index': '${currentIndex >= 0 ? currentIndex : 0}',
        if (props.disabled) 'disabled': 'true',
        ...?props.attributes,
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.6rem',
          ...sizeStyles,
          'font-weight': 'var(--font-weight-medium)',
          'border-radius': 'var(--radius)',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition':
              'background 0.2s ease, border-color 0.2s ease, color 0.2s ease',
          ...variantStyles,
        },
      ),
      events: props.disabled ? null : {'click': (_) => _cycle()},
      [
        if (currentOption.icon != null) currentOption.icon!,
        if (currentOption.label != null)
          dom.span(classes: 'neon-cycle-button-label', [
            Component.text(currentOption.label!),
          ]),
        const dom.span(
          classes: 'neon-cycle-button-indicator',
          styles: dom.Styles(
            raw: {
              'font-size': '0.78em',
              'opacity': '0.65',
              'color': 'var(--neon-accent)',
            },
          ),
          [Component.text('\u21bb')],
        ),
      ],
    );
  }
}

/// Neon toggle button renderer.
class NeonToggleButton extends StatelessComponent {
  final ToggleButtonProps props;

  const NeonToggleButton(this.props);

  @override
  Component build(BuildContext context) {
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2.25rem',
        'padding': '0 0.9rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '2.6rem',
        'padding': '0 1.1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '3rem',
        'padding': '0 1.4rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '2.6rem',
        'width': '2.6rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2.25rem',
        'width': '2.25rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
    };

    return dom.button(
      id: props.id,
      classes:
          'neon-toggle-button ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'aria-pressed': '${props.value}',
        'data-state': props.value ? 'on' : 'off',
        'data-disabled': '${props.disabled}',
        if (props.disabled) 'disabled': 'true',
        ...?props.attributes,
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.6rem',
          ...sizeStyles,
          'font-weight': 'var(--font-weight-medium)',
          'border-radius': 'var(--radius)',
          'background': props.value
              ? 'color-mix(in srgb, var(--neon-accent) 16%, var(--neon-surface-2))'
              : 'var(--neon-surface-1)',
          'color': props.value ? 'var(--neon-accent)' : 'var(--foreground)',
          'border': props.value
              ? '1px solid var(--neon-accent-border)'
              : '1px solid var(--border)',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition':
              'background 0.2s ease, border-color 0.2s ease, color 0.2s ease',
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : {'click': (_) => props.onChanged!(!props.value)},
      [
        if (props.icon != null) props.icon!,
        if (props.label != null) Component.text(props.label!),
      ],
    );
  }
}

Map<String, String> _variantStyles(CycleButtonVariant variant) {
  return switch (variant) {
    CycleButtonVariant.outline => {
      'background': 'var(--neon-surface-1)',
      'color': 'var(--foreground)',
      'border': '1px solid var(--border)',
    },
    CycleButtonVariant.primary => {
      'background':
          'linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 78%, #0d1110), var(--neon-accent))',
      'color': '#ffffff',
      'border': '1px solid var(--neon-accent-border)',
    },
    CycleButtonVariant.secondary => {
      'background': 'var(--neon-surface-2)',
      'color': 'var(--foreground)',
      'border': '1px solid var(--border)',
    },
    CycleButtonVariant.ghost => {
      'background': 'transparent',
      'color': 'var(--foreground)',
      'border': '1px solid transparent',
    },
    CycleButtonVariant.destructive => {
      'background':
          'linear-gradient(180deg, color-mix(in srgb, var(--destructive) 78%, #180909), var(--destructive))',
      'color': '#ffffff',
      'border':
          '1px solid color-mix(in srgb, var(--destructive) 38%, var(--border))',
    },
  };
}
