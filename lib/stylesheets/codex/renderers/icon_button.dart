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
      ComponentSize.sm => ('36px', '18px'),
      ComponentSize.md => ('44px', '22px'),
      ComponentSize.lg => ('52px', '26px'),
    };

    // Get color-specific values with Codex neon effects
    final (String bgColor, String fgColor, String glowColor, String borderColor) = switch (props.color) {
      ColorVariant.primary => (
        'var(--primary)',
        'var(--primary-foreground)',
        '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.15)',
        'rgba(var(--primary-rgb), 0.5)',
      ),
      ColorVariant.secondary => (
        'var(--secondary)',
        'var(--secondary-foreground)',
        '0 0 10px rgba(var(--secondary-rgb), 0.2)',
        'rgba(var(--border-rgb), 0.3)',
      ),
      ColorVariant.destructive => (
        'var(--destructive)',
        'var(--destructive-foreground)',
        '0 0 20px rgba(var(--destructive-rgb), 0.4), 0 0 40px rgba(var(--destructive-rgb), 0.15)',
        'rgba(var(--destructive-rgb), 0.5)',
      ),
      ColorVariant.success => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #ffffff)',
        '0 0 20px rgba(var(--success-rgb), 0.4), 0 0 40px rgba(var(--success-rgb), 0.15)',
        'rgba(var(--success-rgb), 0.5)',
      ),
      ColorVariant.warning => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #000000)',
        '0 0 20px rgba(var(--warning-rgb), 0.4), 0 0 40px rgba(var(--warning-rgb), 0.15)',
        'rgba(var(--warning-rgb), 0.5)',
      ),
      ColorVariant.info => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #ffffff)',
        '0 0 20px rgba(var(--info-rgb), 0.4), 0 0 40px rgba(var(--info-rgb), 0.15)',
        'rgba(var(--info-rgb), 0.5)',
      ),
    };

    // Codex Neon style variant styles
    final Map<String, String> variantStyles = switch (props.style) {
      StyleVariant.solid => {
        'background': 'linear-gradient(135deg, $bgColor 0%, color-mix(in srgb, $bgColor 70%, #ff00ff) 100%)',
        'color': fgColor,
        'border': '1px solid $borderColor',
        'box-shadow': glowColor,
      },
      StyleVariant.outline => {
        'background': 'transparent',
        'color': bgColor,
        'border': '1px solid $bgColor',
        'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2), inset 0 0 15px rgba(var(--primary-rgb), 0.05)',
      },
      StyleVariant.ghost => {
        'background': 'transparent',
        'color': bgColor,
        'border': '1px solid transparent',
        'box-shadow': 'none',
      },
      StyleVariant.link => {
        'background': 'transparent',
        'color': bgColor,
        'border': '1px solid transparent',
        'box-shadow': 'none',
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
