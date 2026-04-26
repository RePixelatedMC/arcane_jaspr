import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
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
            'linear-gradient(135deg, var(--primary) 0%, var(--neon-cyan) 58%, var(--neon-magenta) 140%)',
        'color': '#03110f',
        'border':
            '1px solid color-mix(in srgb, var(--neon-cyan) 64%, #000000)',
        'box-shadow':
            '0 0 0 1px color-mix(in srgb, var(--primary) 24%, transparent), 0 10px 28px color-mix(in srgb, var(--primary) 30%, transparent), 0 0 28px color-mix(in srgb, var(--neon-cyan) 18%, transparent), inset 0 1px 0 rgba(255, 255, 255, 0.24)',
      },
      ButtonVariant.destructive => {
        'background':
            'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #7f1d1d) 100%)',
        'color': '#ffffff',
        'border':
            '1px solid color-mix(in srgb, var(--destructive) 58%, #000000)',
        'box-shadow':
            '0 8px 22px color-mix(in srgb, var(--destructive) 20%, transparent), inset 0 1px 0 rgba(255, 255, 255, 0.12)',
      },
      ButtonVariant.outline => {
        'background':
            'linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 8%, transparent), color-mix(in srgb, var(--background) 78%, transparent))',
        'color': 'var(--neon-cyan)',
        'border': '1px solid var(--neon-accent-border)',
        'box-shadow':
            '0 0 0 1px color-mix(in srgb, var(--neon-cyan) 8%, transparent), 0 0 18px color-mix(in srgb, var(--primary) 10%, transparent)',
      },
      ButtonVariant.secondary => {
        'background':
            'linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 7%, transparent), var(--neon-surface-2))',
        'color': 'var(--secondary-foreground)',
        'border':
            '1px solid color-mix(in srgb, var(--neon-cyan) 24%, var(--border))',
      },
      ButtonVariant.ghost => {
        'background':
            'linear-gradient(135deg, color-mix(in srgb, var(--foreground) 4%, transparent), transparent)',
        'color': 'var(--foreground)',
        'border': '1px solid color-mix(in srgb, var(--foreground) 9%, transparent)',
      },
      ButtonVariant.link => {
        'background': 'transparent',
        'color': 'var(--primary)',
        'border': 'none',
        'text-decoration': 'none',
        'text-underline-offset': '4px',
        'padding': '0',
        'height': 'auto',
        'box-shadow': 'none',
      },
      ButtonVariant.success => {
        'background':
            'linear-gradient(135deg, var(--success) 0%, color-mix(in srgb, var(--success) 68%, #14532d) 100%)',
        'color': '#ffffff',
        'border': '1px solid color-mix(in srgb, var(--success) 55%, #000000)',
        'box-shadow':
            '0 8px 22px color-mix(in srgb, var(--success) 20%, transparent), inset 0 1px 0 rgba(255, 255, 255, 0.12)',
      },
      ButtonVariant.warning => {
        'background':
            'linear-gradient(135deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 68%, #78350f) 100%)',
        'color': '#111827',
        'border': '1px solid color-mix(in srgb, var(--warning) 58%, #000000)',
      },
      ButtonVariant.info => {
        'background':
            'linear-gradient(135deg, var(--info) 0%, color-mix(in srgb, var(--info) 68%, #1e3a8a) 100%)',
        'color': '#ffffff',
        'border': '1px solid color-mix(in srgb, var(--info) 58%, #000000)',
        'box-shadow':
            '0 8px 22px color-mix(in srgb, var(--info) 20%, transparent), inset 0 1px 0 rgba(255, 255, 255, 0.12)',
      },
      ButtonVariant.accent => {
        'background':
            'linear-gradient(135deg, var(--neon-magenta) 0%, var(--primary) 46%, var(--neon-cyan) 100%)',
        'color': '#03110f',
        'border': '1px solid var(--neon-accent-border)',
        'box-shadow':
            '0 12px 30px color-mix(in srgb, var(--neon-cyan) 28%, transparent), 0 0 24px color-mix(in srgb, var(--neon-magenta) 18%, transparent), inset 0 1px 0 rgba(255,255,255,0.22)',
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

    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'neon-button',
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
      classes: 'neon-button',
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
