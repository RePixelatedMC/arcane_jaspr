import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/icon_button_props.dart';

/// Codex Icon Button renderer.
///
/// Implements the Codex design language:
/// - Larger sizes (1.25x)
/// - Accent-colored variants with subtle glow
/// - Larger border radius
class CodexIconButton extends StatelessComponent {
  final IconButtonProps props;

  const CodexIconButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    // Codex icon button sizes - larger than ShadCN
    final (String dimension, String iconSize) = switch (props.size) {
      IconButtonSize.small => ('32px', '16px'), // vs ShadCN 28px
      IconButtonSize.medium => ('40px', '20px'), // vs ShadCN 36px
      IconButtonSize.large => ('48px', '24px'), // vs ShadCN 44px
    };

    // Codex variant styles with accent colors and glows
    final Map<String, String> variantStyles = switch (props.variant) {
      IconButtonVariant.primary => {
          'background-color': 'var(--primary)',
          'color': '#ffffff',
          'border': 'none',
          'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2)',
        },
      IconButtonVariant.secondary => {
          'background-color': 'var(--secondary)',
          'color': 'var(--secondary-foreground)',
          'border': '1px solid var(--border)',
        },
      IconButtonVariant.outline => {
          'background-color': 'transparent',
          'color': 'var(--primary)',
          'border': '1px solid var(--primary)',
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
          'box-shadow': '0 0 15px rgba(var(--destructive-rgb), 0.25)',
        },
      IconButtonVariant.success => {
          'background-color': 'var(--success)',
          'color': 'var(--success-foreground)',
          'border': 'none',
          'box-shadow': '0 0 15px rgba(var(--success-rgb), 0.25)',
        },
      IconButtonVariant.warning => {
          'background-color': 'var(--warning)',
          'color': 'var(--warning-foreground)',
          'border': 'none',
        },
    };

    return dom.button(
      classes: 'codex-icon-button ${isDisabled ? 'disabled' : ''}',
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
        // Codex: larger radius
        'border-radius': 'var(--radius-md)', // 10px vs ShadCN 6px
        ...variantStyles,
        'font-weight': 'var(--font-weight-medium)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        if (isDisabled) 'pointer-events': 'none',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all var(--transition)',
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
      classes: 'codex-icon-button-spinner',
      styles: dom.Styles(raw: {
        'display': 'inline-block',
        'width': size,
        'height': size,
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': 'var(--arcane-radius-full)',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}
