import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/button_props.dart';

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
    final Map<String, String> baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': 'var(--space-2)', // gap-2
      'white-space': 'nowrap',
      'border-radius': 'var(--radius)', // rounded-md
      'font-size': 'var(--font-size-sm)', // text-sm
      'font-weight': 'var(--font-weight-medium)', // font-medium
      'line-height': '1.25rem',
      'transition':
          'color var(--transition), background-color var(--transition), border-color var(--transition), box-shadow var(--transition)',
      'outline': 'none',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.5' : '1',
      'user-select': 'none',
      '-webkit-user-select': 'none',
    };

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
    final Map<String, String> sizeStyles = switch (props.size) {
      ButtonSize.sm => {
        'height': '2.25rem', // h-9 (36px)
        'padding': '0 0.75rem', // px-3
      },
      ButtonSize.md => {
        'height': '2.5rem', // h-10 (40px)
        'padding': '0.5rem 1rem', // py-2 px-4
      },
      ButtonSize.lg => {
        'height': '2.75rem', // h-11 (44px)
        'padding': '0 2rem', // px-8
      },
      ButtonSize.iconSm => {
        'height': '2.25rem', // h-9
        'width': '2.25rem', // w-9
        'padding': '0',
      },
      ButtonSize.iconMd => {
        'height': '2.5rem', // h-10
        'width': '2.5rem', // w-10
        'padding': '0',
      },
      ButtonSize.iconLg => {
        'height': '2.75rem', // h-11
        'width': '2.75rem', // w-11
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
    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'arcane-button',
        href: props.href!,
        attributes: {
          if (isDisabled) 'aria-disabled': 'true',
          'data-state': props.loading ? 'loading' : 'idle',
          'data-disabled': '$isDisabled',
          'data-variant': props.variant.name,
          'data-size': props.size.name,
          ...?props.attributes,
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
        'data-state': props.loading ? 'loading' : 'idle',
        'data-disabled': '$isDisabled',
        'data-variant': props.variant.name,
        'data-size': props.size.name,
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
