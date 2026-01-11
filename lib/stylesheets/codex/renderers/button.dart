import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';

/// Codex Button renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Intense neon glows with animated pulse
/// - Gradient backgrounds with neon color shifts
/// - Glowing borders and text shadows
/// - Cyberpunk-inspired hover effects
/// - OLED-optimized colors with high contrast
class CodexButton extends StatelessComponent {
  final ButtonProps props;

  const CodexButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    // Codex Neon base styles - cyberpunk aesthetic
    final Map<String, String> baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': '0.75rem',
      'white-space': 'nowrap',
      'border-radius': 'var(--radius)',
      'font-size': 'var(--font-size-sm)',
      'font-weight': 'var(--font-weight-semibold)',
      'letter-spacing': '0.025em',
      'text-transform': 'uppercase',
      'line-height': '1.25rem',
      'outline': 'none',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.4' : '1',
      'user-select': 'none',
      '-webkit-user-select': 'none',
      'position': 'relative',
      'overflow': 'hidden',
      // Neon transition with glow pulse
      'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.2s ease-out',
    };

    // Codex Neon variant styles - intense glows and gradients
    final Map<String, String> variantStyles = switch (props.variant) {
      ButtonVariant.primary => {
        'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--primary-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
        'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
      },
      ButtonVariant.destructive => {
        'background': 'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #ff0066) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--destructive-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--destructive-rgb), 0.4), 0 0 40px rgba(var(--destructive-rgb), 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
        'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
      },
      ButtonVariant.outline => {
        'background': 'transparent',
        'color': 'var(--primary)',
        'border': '1px solid var(--primary)',
        'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2), inset 0 0 20px rgba(var(--primary-rgb), 0.05)',
        'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.5)',
      },
      ButtonVariant.secondary => {
        'background': 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 80%, var(--primary)) 100%)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid rgba(var(--border-rgb), 0.3)',
        'box-shadow': '0 0 10px rgba(var(--secondary-rgb), 0.2)',
      },
      ButtonVariant.ghost => {
        'background': 'transparent',
        'color': 'var(--foreground)',
        'border': '1px solid transparent',
        'box-shadow': 'none',
      },
      ButtonVariant.link => {
        'background': 'transparent',
        'color': 'var(--primary)',
        'border': 'none',
        'text-decoration': 'none',
        'text-underline-offset': '4px',
        'padding': '0',
        'height': 'auto',
        'text-shadow': '0 0 10px rgba(var(--primary-rgb), 0.3)',
        'box-shadow': 'none',
      },
      ButtonVariant.success => {
        'background': 'linear-gradient(135deg, var(--success) 0%, color-mix(in srgb, var(--success) 70%, #00ffaa) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--success-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--success-rgb), 0.4), 0 0 40px rgba(var(--success-rgb), 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
        'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
      },
      ButtonVariant.warning => {
        'background': 'linear-gradient(135deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 70%, #ffaa00) 100%)',
        'color': '#000000',
        'border': '1px solid rgba(var(--warning-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--warning-rgb), 0.4), 0 0 40px rgba(var(--warning-rgb), 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.2)',
        'text-shadow': '0 0 5px rgba(0, 0, 0, 0.3)',
      },
      ButtonVariant.info => {
        'background': 'linear-gradient(135deg, var(--info) 0%, color-mix(in srgb, var(--info) 70%, #00ffff) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--info-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--info-rgb), 0.4), 0 0 40px rgba(var(--info-rgb), 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.1)',
        'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
      },
      ButtonVariant.accent => {
        'background': 'linear-gradient(135deg, var(--primary) 0%, #ff00ff 50%, #00ffff 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(255, 255, 255, 0.2)',
        'box-shadow': '0 0 25px rgba(var(--primary-rgb), 0.5), 0 0 50px rgba(255, 0, 255, 0.2), inset 0 1px 0 rgba(255, 255, 255, 0.2)',
        'text-shadow': '0 0 15px rgba(255, 255, 255, 0.8)',
        'animation': 'codex-neon-pulse 2s ease-in-out infinite',
      },
    };

    // Codex Neon size styles - larger with more presence
    final Map<String, String> sizeStyles = switch (props.size) {
      ButtonSize.small => {
        'height': '2.5rem',
        'padding': '0 1.25rem',
        'font-size': '0.75rem',
      },
      ButtonSize.medium => {
        'height': '3rem',
        'padding': '0.75rem 1.5rem',
      },
      ButtonSize.large => {
        'height': '3.5rem',
        'padding': '0 2.5rem',
        'font-size': '0.875rem',
      },
      ButtonSize.icon => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
      ButtonSize.iconSmall => {
        'height': '2.5rem',
        'width': '2.5rem',
        'padding': '0',
      },
      ButtonSize.iconLarge => {
        'height': '3.5rem',
        'width': '3.5rem',
        'padding': '0',
      },
    };

    // Combine all styles
    final Map<String, String> allStyles = {
      ...baseStyles,
      ...variantStyles,
      ...sizeStyles,
      if (props.fullWidth) 'width': '100%',
    };

    // Build button content
    final List<Component> children = [];

    if (props.loading) {
      children.add(_buildSpinner());
    } else if (props.icon != null) {
      children.add(props.icon!);
    }

    if (props.label != null) {
      children.add(Component.text(props.label!));
    }

    if (props.child != null) {
      children.add(props.child!);
    }

    if (props.trailing != null && !props.loading) {
      children.add(props.trailing!);
    }

    // Add arrow indicator if showArrow is true
    if (props.showArrow && !props.loading) {
      children.add(dom.span(
        styles: const dom.Styles(raw: {
          'margin-left': '0.5rem',
          'transition': 'transform 0.3s ease',
          'display': 'inline-block',
        }),
        [Component.text('\u2192')],
      ));
    }

    // Render as anchor if href is provided, otherwise as button
    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'codex-button codex-neon',
        href: props.href!,
        attributes: {
          if (isDisabled) 'aria-disabled': 'true',
          ...?props.attributes,
        },
        styles: dom.Styles(raw: {
          ...allStyles,
          'text-decoration': 'none',
        }),
        events: {
          if (props.onPressed != null)
            'click': (event) {
              if (!isDisabled) {
                props.onPressed!();
              }
            },
        },
        children,
      );
    }

    return dom.button(
      id: props.id,
      classes: 'codex-button codex-neon',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        ...?props.attributes,
      },
      styles: dom.Styles(raw: allStyles),
      events: {
        'click': (event) {
          if (!isDisabled && props.onPressed != null) {
            props.onPressed!();
          }
        },
      },
      children,
    );
  }

  /// Build loading spinner with neon glow
  Component _buildSpinner() {
    return dom.span(
      styles: const dom.Styles(raw: {
        'display': 'inline-block',
        'width': '1.25rem',
        'height': '1.25rem',
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '50%',
        'animation': 'arcane-spin 0.6s linear infinite',
        'box-shadow': '0 0 10px currentColor',
      }),
      [],
    );
  }
}
