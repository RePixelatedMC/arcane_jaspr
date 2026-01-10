import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/button_props.dart';

/// Codex Button renderer.
///
/// Implements the Codex design language:
/// - 1.25x spacing compared to ShadCN (more breathing room)
/// - Subtle accent-colored glows on primary variant
/// - Larger border radius (14px)
/// - OLED-optimized colors
class CodexButton extends StatelessComponent {
  final ButtonProps props;

  const CodexButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    // Codex base styles - more breathing room than ShadCN
    final Map<String, String> baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': '0.625rem', // 10px (vs ShadCN 8px)
      'white-space': 'nowrap',
      'border-radius': 'var(--radius)', // 14px
      'font-size': 'var(--arcane-font-size-sm)',
      'font-weight': 'var(--arcane-font-weight-medium)',
      'line-height': '1.25rem',
      'transition': 'all var(--transition)',
      'outline': 'none',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.5' : '1',
      'user-select': 'none',
      '-webkit-user-select': 'none',
    };

    // Codex variant styles - accent-driven with subtle glows
    final Map<String, String> variantStyles = switch (props.variant) {
      ButtonVariant.primary => {
        'background-color': 'var(--codex-accent)',
        'color': '#ffffff',
        'border': 'none',
        'box-shadow': 'var(--codex-accent-glow-medium)',
      },
      ButtonVariant.destructive => {
        'background-color': 'var(--destructive)',
        'color': 'var(--destructive-foreground)',
        'border': 'none',
        'box-shadow': '0 0 20px rgba(var(--destructive-rgb), 0.3)',
      },
      ButtonVariant.outline => {
        'background-color': 'transparent',
        'color': 'var(--codex-accent)',
        'border': '1px solid var(--codex-accent-border)',
      },
      ButtonVariant.secondary => {
        'background-color': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid var(--border)',
      },
      ButtonVariant.ghost => {
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': 'none',
      },
      ButtonVariant.link => {
        'background-color': 'transparent',
        'color': 'var(--codex-accent)',
        'border': 'none',
        'text-decoration': 'underline',
        'text-underline-offset': '4px',
        'padding': '0',
        'height': 'auto',
      },
      ButtonVariant.success => {
        'background-color': 'var(--success)',
        'color': 'var(--success-foreground)',
        'border': 'none',
        'box-shadow': '0 0 20px rgba(var(--success-rgb), 0.3)',
      },
      ButtonVariant.warning => {
        'background-color': 'var(--warning)',
        'color': 'var(--warning-foreground)',
        'border': 'none',
        'box-shadow': '0 0 20px rgba(var(--warning-rgb), 0.25)',
      },
      ButtonVariant.info => {
        'background-color': 'var(--info)',
        'color': 'var(--info-foreground)',
        'border': 'none',
        'box-shadow': '0 0 20px rgba(var(--info-rgb), 0.3)',
      },
      ButtonVariant.accent => {
        'background': 'var(--codex-accent-gradient)',
        'color': '#ffffff',
        'border': 'none',
        'box-shadow': 'var(--codex-accent-glow-medium)',
      },
    };

    // Codex size styles - 1.25x ShadCN for more breathing room
    final Map<String, String> sizeStyles = switch (props.size) {
      ButtonSize.small => {
        'height': '2.5rem', // 40px (vs ShadCN 36px)
        'padding': '0 1rem', // 16px (vs ShadCN 12px)
      },
      ButtonSize.medium => {
        'height': '3rem', // 48px (vs ShadCN 40px)
        'padding': '0.625rem 1.25rem', // 10px 20px (vs ShadCN 8px 16px)
      },
      ButtonSize.large => {
        'height': '3.5rem', // 56px (vs ShadCN 44px)
        'padding': '0 2.5rem', // 40px (vs ShadCN 32px)
      },
      ButtonSize.icon => {
        'height': '3rem', // 48px (vs ShadCN 40px)
        'width': '3rem',
        'padding': '0',
      },
      ButtonSize.iconSmall => {
        'height': '2.5rem', // 40px (vs ShadCN 36px)
        'width': '2.5rem',
        'padding': '0',
      },
      ButtonSize.iconLarge => {
        'height': '3.5rem', // 56px (vs ShadCN 44px)
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
      children.add(const dom.span(
        styles: dom.Styles(raw: {
          'margin-left': '0.25rem',
          'transition': 'transform var(--arcane-transition)',
        }),
        [Component.text('\u2192')],
      ));
    }

    // Render as anchor if href is provided, otherwise as button
    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'codex-button',
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
      classes: 'codex-button',
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

  /// Build loading spinner with accent glow
  Component _buildSpinner() {
    return const dom.span(
      styles: dom.Styles(raw: {
        'display': 'inline-block',
        'width': '1.125rem', // Slightly larger than ShadCN
        'height': '1.125rem',
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '50%',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}