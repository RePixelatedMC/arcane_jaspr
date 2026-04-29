import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/button_props.dart';

import 'control_styles.dart';

class NeubrutalismButton extends StatelessComponent {
  final ButtonProps props;

  const NeubrutalismButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    bool isDisabled = props.disabled || props.loading;

    Map<String, String> baseStyles = NeubrutalismControlStyles.buttonBase(
      isDisabled,
    );

    Map<String, String> variantStyles = switch (props.variant) {
      ButtonVariant.primary => <String, String>{
        'background-color': 'var(--nb-accent, var(--primary))',
        'color': 'var(--nb-ink, #000)',
      },
      ButtonVariant.destructive => <String, String>{
        'background-color': 'var(--destructive)',
        'color': '#FFFFFF',
      },
      ButtonVariant.outline => <String, String>{
        'background-color': 'var(--nb-paper, #fff)',
        'color': 'var(--foreground)',
      },
      ButtonVariant.secondary => <String, String>{
        'background-color': 'var(--nb-accent-cool, var(--secondary))',
        'color': 'var(--nb-ink, #000)',
      },
      ButtonVariant.ghost => <String, String>{
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': 'none',
        'box-shadow': 'none',
      },
      ButtonVariant.link => <String, String>{
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': 'none',
        'box-shadow': 'none',
        'text-decoration': 'underline',
        'text-decoration-thickness': '2px',
        'text-underline-offset': '4px',
        'padding': '0',
        'height': 'auto',
      },
      ButtonVariant.success => <String, String>{
        'background-color': 'var(--success, #22c55e)',
        'color': 'var(--nb-ink, #000)',
      },
      ButtonVariant.warning => <String, String>{
        'background-color': 'var(--warning, #facc15)',
        'color': 'var(--nb-ink, #000)',
      },
      ButtonVariant.info => <String, String>{
        'background-color': 'var(--info, #3b82f6)',
        'color': '#FFFFFF',
      },
      ButtonVariant.accent => <String, String>{
        'background-color': 'var(--nb-accent-hot, var(--primary))',
        'color': 'var(--nb-ink, #000)',
      },
    };

    Map<String, String> sizeStyles = NeubrutalismControlStyles.buttonSize(
      props.size,
    );

    Map<String, String> allStyles = <String, String>{
      ...baseStyles,
      ...variantStyles,
      ...sizeStyles,
      if (props.fullWidth) 'width': '100%',
    };

    List<Component> children = <Component>[];

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

    if (props.showArrow && !props.loading) {
      children.add(
        dom.span(
          styles: const dom.Styles(
            raw: <String, String>{
              'margin-left': '0.25rem',
              'transition': 'transform 0.2s ease',
            },
          ),
          <Component>[ArcaneIcon.arrowRight(size: IconSize.sm)],
        ),
      );
    }

    Map<String, String> baseAttributes =
        NeubrutalismControlStyles.buttonAttributes(props, isDisabled);
    final Map<String, String> actionAttrs = interactionAttrs(props.action);

    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'neubrutalism-button',
        href: props.href!,
        attributes: <String, String>{
          if (isDisabled) 'aria-disabled': 'true',
          ...baseAttributes,
          ...actionAttrs,
        },
        styles: dom.Styles(
            raw: <String, String>{...allStyles, 'text-decoration': 'none'}),
        events: <String, EventCallback>{
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
      classes: 'neubrutalism-button',
      attributes: <String, String>{
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        ...baseAttributes,
        ...actionAttrs,
      },
      styles: dom.Styles(raw: allStyles),
      events: <String, EventCallback>{
        'click': (event) {
          if (!isDisabled && props.onPressed != null) {
            props.onPressed!();
          }
        },
      },
      children,
    );
  }

  Component _buildSpinner() {
    return const dom.span(
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-block',
          'width': '1rem',
          'height': '1rem',
          'border': '2px solid currentColor',
          'border-right-color': 'transparent',
          'border-radius': '50%',
          'animation': 'arcane-spin 0.75s linear infinite',
        },
      ),
      <Component>[],
    );
  }
}
