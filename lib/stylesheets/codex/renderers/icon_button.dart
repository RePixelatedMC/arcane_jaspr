import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/icon_button_props.dart';

/// Codex Icon Button renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Intense neon glows with pulsing effect
/// - Glowing borders that react on hover
/// - Cyberpunk-inspired gradients
/// - OLED-optimized colors
class CodexIconButton extends StatelessComponent {
  final IconButtonProps props;

  const CodexIconButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    // Codex Neon icon button sizes - larger with more presence
    final (String dimension, String iconSize) = switch (props.size) {
      IconButtonSize.small => ('36px', '18px'),
      IconButtonSize.medium => ('44px', '22px'),
      IconButtonSize.large => ('52px', '26px'),
    };

    // Codex Neon variant styles with intense glows
    final Map<String, String> variantStyles = switch (props.variant) {
      IconButtonVariant.primary => {
        'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--primary-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.15)',
      },
      IconButtonVariant.secondary => {
        'background': 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 80%, var(--primary)) 100%)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid rgba(var(--border-rgb), 0.3)',
        'box-shadow': '0 0 10px rgba(var(--secondary-rgb), 0.2)',
      },
      IconButtonVariant.outline => {
        'background': 'transparent',
        'color': 'var(--primary)',
        'border': '1px solid var(--primary)',
        'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2), inset 0 0 15px rgba(var(--primary-rgb), 0.05)',
      },
      IconButtonVariant.ghost => {
        'background': 'transparent',
        'color': 'var(--foreground)',
        'border': '1px solid transparent',
        'box-shadow': 'none',
      },
      IconButtonVariant.destructive => {
        'background': 'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #ff0066) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--destructive-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--destructive-rgb), 0.4), 0 0 40px rgba(var(--destructive-rgb), 0.15)',
      },
      IconButtonVariant.success => {
        'background': 'linear-gradient(135deg, var(--success) 0%, color-mix(in srgb, var(--success) 70%, #00ffaa) 100%)',
        'color': '#ffffff',
        'border': '1px solid rgba(var(--success-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--success-rgb), 0.4), 0 0 40px rgba(var(--success-rgb), 0.15)',
      },
      IconButtonVariant.warning => {
        'background': 'linear-gradient(135deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 70%, #ffaa00) 100%)',
        'color': '#000000',
        'border': '1px solid rgba(var(--warning-rgb), 0.5)',
        'box-shadow': '0 0 20px rgba(var(--warning-rgb), 0.4), 0 0 40px rgba(var(--warning-rgb), 0.15)',
      },
    };

    return dom.button(
      classes: 'codex-icon-button codex-neon ${isDisabled ? 'disabled' : ''}',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        if (props.tooltip != null) 'title': props.tooltip!,
        if (props.tooltip != null) 'aria-label': props.tooltip!,
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': dimension,
        'height': dimension,
        'flex-shrink': '0',
        // Codex Neon: larger radius with glow-friendly shape
        'border-radius': 'var(--radius)',
        ...variantStyles,
        'font-weight': 'var(--font-weight-medium)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        if (isDisabled) 'pointer-events': 'none',
        'opacity': isDisabled ? '0.4' : '1',
        'position': 'relative',
        'overflow': 'hidden',
        // Neon transition
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.2s ease-out',
      }),
      events: {
        'click': (event) {
          if (!isDisabled && props.onPressed != null) {
            props.onPressed!();
          }
        },
      },
      [
        if (props.loading)
          _buildSpinner(iconSize)
        else
          dom.div(
            styles: dom.Styles(raw: {
              'width': iconSize,
              'height': iconSize,
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'filter': 'drop-shadow(0 0 4px currentColor)',
            }),
            [props.icon],
          ),
      ],
    );
  }

  Component _buildSpinner(String size) {
    return dom.span(
      classes: 'codex-icon-button-spinner',
      styles: dom.Styles(raw: {
        'display': 'inline-block',
        'width': size,
        'height': size,
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '50%',
        'animation': 'arcane-spin 0.6s linear infinite',
        'box-shadow': '0 0 8px currentColor',
      }),
      [],
    );
  }
}
