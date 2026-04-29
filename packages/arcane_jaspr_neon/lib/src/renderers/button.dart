import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/button_props.dart';

import 'control_styles.dart';

class NeonButton extends StatelessComponent {
  final ButtonProps props;

  const NeonButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    bool isDisabled = props.disabled || props.loading;

    Map<String, String> baseStyles = NeonControlStyles.buttonBase(
      isDisabled,
    );

    Map<String, String> variantStyles = switch (props.variant) {
      ButtonVariant.primary => {
        'background':
            'linear-gradient(150deg, var(--neon-accent) 0%, color-mix(in srgb, var(--neon-accent) 78%, var(--neon-accent-cool)) 100%)',
        'color': 'var(--neon-on-accent)',
        'border':
            '1px solid color-mix(in srgb, var(--neon-accent) 70%, #12151C)',
        'box-shadow':
            '0 6px 18px color-mix(in srgb, var(--neon-accent) 28%, transparent), inset 0 1px 0 color-mix(in srgb, var(--neon-on-accent) 22%, transparent)',
      },
      ButtonVariant.destructive => {
        'background':
            'linear-gradient(150deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 80%, #12151C) 100%)',
        'color': '#ffffff',
        'border':
            '1px solid color-mix(in srgb, var(--destructive) 60%, #12151C)',
        'box-shadow':
            '0 6px 18px color-mix(in srgb, var(--destructive) 26%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)',
      },
      ButtonVariant.outline => {
        'background':
            'color-mix(in srgb, var(--neon-accent) 4%, transparent)',
        'color': 'var(--foreground)',
        'border':
            '1px solid color-mix(in srgb, var(--neon-accent-cool) 32%, var(--neon-control-border))',
        'box-shadow': 'var(--neon-inset)',
      },
      ButtonVariant.secondary => {
        'background':
            'color-mix(in srgb, var(--neon-accent-cool) 6%, var(--neon-surface-2))',
        'color': 'var(--secondary-foreground)',
        'border':
            '1px solid color-mix(in srgb, var(--neon-accent-cool) 18%, var(--neon-control-border))',
        'box-shadow': 'var(--neon-inset)',
      },
      ButtonVariant.ghost => {
        'background': 'transparent',
        'color': 'var(--foreground)',
        'border':
            '1px solid color-mix(in srgb, var(--foreground) 6%, transparent)',
      },
      ButtonVariant.link => {
        'background': 'transparent',
        'color': 'var(--neon-accent)',
        'border': 'none',
        'text-decoration': 'none',
        'text-underline-offset': '4px',
        'padding': '0',
        'height': 'auto',
        'box-shadow': 'none',
      },
      ButtonVariant.success => {
        'background':
            'linear-gradient(150deg, var(--success) 0%, color-mix(in srgb, var(--success) 78%, #12151C) 100%)',
        'color': '#ffffff',
        'border': '1px solid color-mix(in srgb, var(--success) 58%, #12151C)',
        'box-shadow':
            '0 6px 18px color-mix(in srgb, var(--success) 24%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)',
      },
      ButtonVariant.warning => {
        'background':
            'linear-gradient(150deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 78%, #12151C) 100%)',
        'color': '#0b0b0b',
        'border': '1px solid color-mix(in srgb, var(--warning) 60%, #12151C)',
        'box-shadow':
            '0 6px 18px color-mix(in srgb, var(--warning) 24%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 22%, transparent)',
      },
      ButtonVariant.info => {
        'background':
            'linear-gradient(150deg, var(--info) 0%, color-mix(in srgb, var(--info) 78%, #12151C) 100%)',
        'color': '#ffffff',
        'border': '1px solid color-mix(in srgb, var(--info) 60%, #12151C)',
        'box-shadow':
            '0 6px 18px color-mix(in srgb, var(--info) 24%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)',
      },
      ButtonVariant.accent => {
        'background':
            'linear-gradient(150deg, var(--neon-accent-hot) 0%, var(--neon-accent) 100%)',
        'color': 'var(--neon-on-accent)',
        'border':
            '1px solid color-mix(in srgb, var(--neon-accent-hot) 62%, #12151C)',
        'box-shadow':
            '0 6px 20px color-mix(in srgb, var(--neon-accent-hot) 28%, transparent), inset 0 1px 0 color-mix(in srgb, var(--neon-on-accent) 22%, transparent)',
      },
    };

    Map<String, String> sizeStyles = NeonControlStyles.buttonSize(
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
            raw: {
              'margin-left': '0.25rem',
              'transition': 'transform 0.2s ease',
            },
          ),
          [ArcaneIcon.arrowRight(size: IconSize.sm)],
        ),
      );
    }

    Map<String, String> baseAttributes =
        NeonControlStyles.buttonAttributes(props, isDisabled);
    final Map<String, String> actionAttrs = interactionAttrs(props.action);

    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'neon-button',
        href: props.href!,
        attributes: {
          if (isDisabled) 'aria-disabled': 'true',
          ...baseAttributes,
          ...actionAttrs,
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
      classes: 'neon-button',
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        ...baseAttributes,
        ...actionAttrs,
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
