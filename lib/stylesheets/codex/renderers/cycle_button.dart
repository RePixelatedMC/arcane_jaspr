import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/cycle_button_props.dart';

/// Codex Cycle Button renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon variants with gradient backgrounds
/// - Animated cycle indicator with pulse effect
/// - Holographic-style button appearance
/// - Intense glow on active states
class CodexCycleButton<T> extends StatefulComponent {
  final CycleButtonProps<T> props;

  const CodexCycleButton(this.props);

  @override
  State<CodexCycleButton<T>> createState() => _CodexCycleButtonState<T>();
}

class _CodexCycleButtonState<T> extends State<CodexCycleButton<T>> {
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

    // Codex Neon size styles - larger with more presence
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2.5rem',
        'padding': '0 1.25rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '3rem',
        'padding': '0 1.5rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '3.5rem',
        'padding': '0 2.5rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2.5rem',
        'width': '2.5rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '3.5rem',
        'width': '3.5rem',
        'padding': '0',
      },
    };

    // Codex Neon variant styles with intense glows
    final Map<String, String> variantStyles = switch (props.variant) {
      CycleButtonVariant.outline => {
        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
        'color': 'var(--foreground)',
        'border': '1px solid rgba(var(--primary-rgb), 0.3)',
        'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.1)',
      },
      CycleButtonVariant.primary => {
        'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
        'color': '#ffffff',
        'border': 'none',
        'box-shadow': '0 0 25px rgba(var(--primary-rgb), 0.4), 0 0 50px rgba(var(--primary-rgb), 0.15)',
        'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
      },
      CycleButtonVariant.secondary => {
        'background': 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 80%, var(--primary)) 100%)',
        'color': 'var(--foreground)',
        'border': 'none',
        'box-shadow': '0 0 15px rgba(var(--secondary-rgb), 0.2)',
      },
      CycleButtonVariant.ghost => {
        'background': 'transparent',
        'color': 'var(--foreground)',
        'border': 'none',
        'box-shadow': 'none',
      },
      CycleButtonVariant.destructive => {
        'background': 'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #ff0066) 100%)',
        'color': '#ffffff',
        'border': 'none',
        'box-shadow': '0 0 25px rgba(var(--destructive-rgb), 0.4), 0 0 50px rgba(var(--destructive-rgb), 0.15)',
        'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
      },
    };

    // Encode options as JSON for static site JavaScript
    final optionsJson = props.options
        .map((opt) => opt.label ?? opt.value.toString())
        .toList()
        .join('|');

    return button(
      id: props.id,
      classes: 'codex-cycle-button codex-neon ${props.disabled ? 'disabled' : ''}',
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
        'gap': '0.75rem',
        ...sizeStyles,
        'font-weight': 'var(--font-weight-semibold)',
        'letter-spacing': '0.025em',
        'border-radius': 'var(--radius)',
        ...variantStyles,
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.4' : '1',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        'white-space': 'nowrap',
      }),
      events: {
        'click': (event) => _cycle(),
      },
      [
        if (currentOption.icon != null)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'filter': 'drop-shadow(0 0 4px currentColor)',
            }),
            [currentOption.icon!],
          ),
        if (currentOption.label != null)
          span(
            classes: 'codex-cycle-button-label',
            [Component.text(currentOption.label!)],
          ),
        // Neon cycle indicator
        const span(
          classes: 'codex-cycle-button-indicator',
          styles: Styles(raw: {
            'font-size': '0.7em',
            'opacity': '0.6',
            'display': 'inline-block',
            'color': 'var(--primary)',
            'text-shadow': '0 0 8px currentColor',
          }),
          [Component.text('\u21bb')],
        ),
      ],
    );
  }
}

/// Codex Toggle Button renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Intense neon glow when active
/// - Gradient background transitions
/// - Holographic-style appearance
class CodexToggleButton extends StatelessComponent {
  final ToggleButtonProps props;

  const CodexToggleButton(this.props);

  @override
  Component build(BuildContext context) {
    // Codex Neon size styles - larger with more presence
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2.5rem',
        'padding': '0 1.25rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '3rem',
        'padding': '0 1.5rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '3.5rem',
        'padding': '0 2.5rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2.5rem',
        'width': '2.5rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '3.5rem',
        'width': '3.5rem',
        'padding': '0',
      },
    };

    return button(
      id: props.id,
      classes: 'codex-toggle-button codex-neon ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
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
        'gap': '0.75rem',
        ...sizeStyles,
        'font-weight': 'var(--font-weight-semibold)',
        'letter-spacing': '0.025em',
        'border-radius': 'var(--radius)',
        'background': props.value
            ? 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)'
            : 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 80%, var(--primary)) 100%)',
        'color': props.value ? '#ffffff' : 'var(--foreground)',
        'border': props.value ? 'none' : '1px solid rgba(var(--border-rgb), 0.3)',
        // Neon glow when active
        'box-shadow': props.value
            ? '0 0 25px rgba(var(--primary-rgb), 0.4), 0 0 50px rgba(var(--primary-rgb), 0.15)'
            : '0 0 10px rgba(var(--primary-rgb), 0.05)',
        'text-shadow': props.value ? '0 0 10px rgba(255, 255, 255, 0.5)' : 'none',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.4' : '1',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
      }),
      events: {
        'click': (event) {
          if (!props.disabled && props.onChanged != null) {
            props.onChanged!(!props.value);
          }
        },
      },
      [
        if (props.icon != null)
          div(
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'filter': props.value ? 'drop-shadow(0 0 4px currentColor)' : 'none',
            }),
            [props.icon!],
          ),
        if (props.label != null) Component.text(props.label!),
      ],
    );
  }
}