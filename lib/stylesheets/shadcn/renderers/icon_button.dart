import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/icon_button_props.dart';

/// ShadCN Icon Button renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/button (size="icon" variant)
///
/// ShadCN Button (icon):
/// - Base: inline-flex items-center justify-content rounded-md
/// - Size: h-10 w-10 (40px) for default, h-9 w-9 (36px) for sm, h-11 w-11 (44px) for lg
/// - Variants: default, destructive, outline, secondary, ghost, link
/// - Focus: ring-2 ring-ring ring-offset-2
/// - Disabled: pointer-events-none opacity-50
class ShadcnIconButton extends StatelessComponent {
  final IconButtonProps props;

  const ShadcnIconButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    // ShadCN button icon sizes
    // Default: h-10 w-10 (40px), sm: h-9 w-9 (36px), lg: h-11 w-11 (44px)
    final (String dimension, String iconSize) = switch (props.size) {
      IconButtonSize.small => ('28px', '14px'),
      IconButtonSize.medium => ('36px', '18px'), // ShadCN: h-9 w-9
      IconButtonSize.large => ('44px', '22px'), // ShadCN: h-11 w-11
    };

    // Variant styles
    final Map<String, String> variantStyles = switch (props.variant) {
      IconButtonVariant.primary => {
          'background-color': 'var(--primary)',
          'color': 'var(--primary-foreground)',
          'border': 'none',
        },
      IconButtonVariant.secondary => {
          'background-color': 'var(--secondary)',
          'color': 'var(--secondary-foreground)',
          'border': 'none',
        },
      IconButtonVariant.outline => {
          'background-color': 'transparent',
          'color': 'var(--foreground)',
          'border': '1px solid var(--input)',
        },
      IconButtonVariant.ghost => {
          'background-color': 'transparent',
          'color': 'var(--foreground)',
          'border': 'none',
        },
      IconButtonVariant.destructive => {
          'background-color': 'var(--destructive)',
          'color': 'var(--destructive-foreground)',
          'border': 'none',
        },
      IconButtonVariant.success => {
          'background-color': 'var(--success, #22c55e)',
          'color': 'var(--success-foreground, #ffffff)',
          'border': 'none',
        },
      IconButtonVariant.warning => {
          'background-color': 'var(--warning, #f59e0b)',
          'color': 'var(--warning-foreground, #ffffff)',
          'border': 'none',
        },
    };

    return dom.button(
      classes: 'arcane-icon-button ${isDisabled ? 'disabled' : ''}',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        if (props.tooltip != null) 'title': props.tooltip!,
        if (props.tooltip != null) 'aria-label': props.tooltip!,
      },
      styles: dom.Styles(raw: {
        // ShadCN: inline-flex items-center justify-center
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        // Square sizing for icon button
        'width': dimension,
        'height': dimension,
        'flex-shrink': '0',
        // ShadCN: rounded-md
        'border-radius': '0.375rem',
        // Variant-specific styles
        ...variantStyles,
        // ShadCN: font-medium
        'font-weight': '500',
        // Cursor and interaction
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        // ShadCN: disabled:pointer-events-none disabled:opacity-50
        if (isDisabled) 'pointer-events': 'none',
        'opacity': isDisabled ? '0.5' : '1',
        // ShadCN: transition-colors
        'transition': 'color 150ms ease, background-color 150ms ease, border-color 150ms ease',
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
            }),
            [props.icon],
          ),
      ],
    );
  }

  Component _buildSpinner(String size) {
    return dom.span(
      classes: 'arcane-icon-button-spinner',
      styles: dom.Styles(raw: {
        'display': 'inline-block',
        'width': size,
        'height': size,
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '9999px',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}
