import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/button_props.dart';

import 'control_styles.dart';

/// ShadCN Button renderer.
///
/// Outputs the exact HTML structure and CSS classes from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/button
class ShadcnButton extends StatelessComponent {
  final ButtonProps props;

  const ShadcnButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    // ShadCN base classes (from cva buttonVariants)
    // inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md
    // text-sm font-medium ring-offset-background transition-colors
    // focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2
    // disabled:pointer-events-none disabled:opacity-50
    // [&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0
    final Map<String, String> baseStyles = ShadcnControlStyles.buttonBase(
      isDisabled,
    );

    // Variant-specific styles
    final Map<String, String> variantStyles = switch (props.variant) {
      ButtonVariant.primary => {
        'background-color': 'var(--primary)',
        'color': 'var(--primary-foreground)',
        'border': 'none',
      },
      ButtonVariant.destructive => {
        'background-color': 'var(--destructive)',
        'color': 'var(--destructive-foreground)',
        'border': 'none',
      },
      ButtonVariant.outline => {
        'background-color': 'var(--background)',
        'color': 'var(--foreground)',
        'border': '1px solid var(--input)',
      },
      ButtonVariant.secondary => {
        'background-color': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border': 'none',
      },
      ButtonVariant.ghost => {
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': 'none',
      },
      ButtonVariant.link => {
        'background-color': 'transparent',
        'color': 'var(--primary)',
        'border': 'none',
        'text-underline-offset': '4px',
        'padding': '0',
        'height': 'auto',
      },
      ButtonVariant.success => {
        'background-color': 'var(--success, #22c55e)',
        'color': 'var(--success-foreground, #ffffff)',
        'border': 'none',
      },
      ButtonVariant.warning => {
        'background-color': 'var(--warning, #f59e0b)',
        'color': 'var(--warning-foreground, #000000)',
        'border': 'none',
      },
      ButtonVariant.info => {
        'background-color': 'var(--info, #3b82f6)',
        'color': 'var(--info-foreground, #ffffff)',
        'border': 'none',
      },
      ButtonVariant.accent => {
        'background-color': 'var(--accent)',
        'color': 'var(--accent-foreground)',
        'border': 'none',
      },
    };

    // Size-specific styles
    final Map<String, String> sizeStyles = ShadcnControlStyles.buttonSize(
      props.size,
    );

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
      children.add(
        dom.span(
          styles: dom.Styles(
            raw: {
              'margin-left': '0.25rem',
              'transition': 'transform var(--transition)',
            },
          ),
          [ArcaneIcon.arrowRight(size: IconSize.sm)],
        ),
      );
    }

    // Render as anchor if href is provided, otherwise as button
    final Map<String, String> baseAttributes =
        ShadcnControlStyles.buttonAttributes(props, isDisabled);

    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'arcane-button',
        href: props.href!,
        attributes: {
          if (isDisabled) 'aria-disabled': 'true',
          ...baseAttributes,
        },
        styles: dom.Styles(raw: {...allStyles, 'text-decoration': 'none'}),
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
      classes: 'arcane-button',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        ...baseAttributes,
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

  /// Build loading spinner matching ShadCN style
  Component _buildSpinner() {
    return const dom.span(
      styles: dom.Styles(
        raw: {
          'display': 'inline-block',
          'width': '1rem',
          'height': '1rem',
          'border': '2px solid currentColor',
          'border-right-color': 'transparent',
          'border-radius': '50%',
          'animation': 'arcane-spin 0.75s linear infinite',
        },
      ),
      [],
    );
  }
}
