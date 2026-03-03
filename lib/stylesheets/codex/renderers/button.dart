import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/button_props.dart';

class CodexButton extends StatelessComponent {
  final ButtonProps props;

  const CodexButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    final Map<String, String> baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': '0.625rem',
      'white-space': 'nowrap',
      'border-radius': 'var(--radius)',
      'font-size': 'var(--font-size-sm)',
      'font-weight': 'var(--font-weight-semibold)',
      'line-height': '1.25rem',
      'outline': 'none',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.45' : '1',
      'user-select': 'none',
      '-webkit-user-select': 'none',
      'position': 'relative',
      'transition':
          'color 0.2s ease, background-color 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease, transform 0.2s ease',
      'box-shadow': '0 1px 0 rgba(255,255,255,0.02) inset',
    };

    final Map<String, String> variantStyles = switch (props.variant) {
      ButtonVariant.primary => {
        'background':
            'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 72%, #065f46) 100%)',
        'color': '#ffffff',
        'border': '1px solid color-mix(in srgb, var(--primary) 62%, #000000)',
        'box-shadow':
            '0 8px 24px color-mix(in srgb, var(--primary) 24%, transparent), inset 0 1px 0 rgba(255, 255, 255, 0.14)',
      },
      ButtonVariant.destructive => {
        'background':
            'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #7f1d1d) 100%)',
        'color': '#ffffff',
        'border': '1px solid color-mix(in srgb, var(--destructive) 58%, #000000)',
        'box-shadow':
            '0 8px 22px color-mix(in srgb, var(--destructive) 20%, transparent), inset 0 1px 0 rgba(255, 255, 255, 0.12)',
      },
      ButtonVariant.outline => {
        'background': 'color-mix(in srgb, var(--primary) 4%, var(--background))',
        'color': 'var(--foreground)',
        'border': '1px solid var(--codex-accent-border)',
      },
      ButtonVariant.secondary => {
        'background': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid color-mix(in srgb, var(--border) 70%, transparent)',
      },
      ButtonVariant.ghost => {
        'background': 'transparent',
        'color': 'var(--foreground)',
        'border': '1px solid transparent',
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
        'background': 'var(--codex-accent-gradient)',
        'color': '#ffffff',
        'border': '1px solid var(--codex-accent-border)',
        'box-shadow':
            '0 10px 24px color-mix(in srgb, var(--primary) 24%, transparent), inset 0 1px 0 rgba(255,255,255,0.14)',
      },
    };

    final Map<String, String> sizeStyles = switch (props.size) {
      ButtonSize.sm => {
        'height': '2.375rem',
        'padding': '0 1rem',
        'font-size': '0.8125rem',
      },
      ButtonSize.md => {
        'height': '2.75rem',
        'padding': '0.625rem 1.25rem',
      },
      ButtonSize.lg => {
        'height': '3.125rem',
        'padding': '0 1.75rem',
        'font-size': '0.9375rem',
      },
      ButtonSize.iconSm => {
        'height': '2.375rem',
        'width': '2.375rem',
        'padding': '0',
      },
      ButtonSize.iconMd => {
        'height': '2.75rem',
        'width': '2.75rem',
        'padding': '0',
      },
      ButtonSize.iconLg => {
        'height': '3.125rem',
        'width': '3.125rem',
        'padding': '0',
      },
    };

    final Map<String, String> allStyles = {
      ...baseStyles,
      ...variantStyles,
      ...sizeStyles,
      if (props.fullWidth) 'width': '100%',
    };

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

    if (props.showArrow && !props.loading) {
      children.add(
        dom.span(
          styles: const dom.Styles(raw: {
            'margin-left': '0.25rem',
            'transition': 'transform 0.2s ease',
          }),
          [ArcaneIcon.arrowRight(size: IconSize.sm)],
        ),
      );
    }

    final Map<String, String> baseAttributes = {
      'data-state': props.loading ? 'loading' : 'idle',
      'data-disabled': '$isDisabled',
      'data-variant': props.variant.name,
      'data-size': props.size.name,
      ...?props.attributes,
    };

    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: 'codex-button',
        href: props.href!,
        attributes: {
          if (isDisabled) 'aria-disabled': 'true',
          ...baseAttributes,
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
      styles: dom.Styles(raw: {
        'display': 'inline-block',
        'width': '1rem',
        'height': '1rem',
        'border': '2px solid currentColor',
        'border-right-color': 'transparent',
        'border-radius': '50%',
        'animation': 'arcane-spin 0.75s linear infinite',
      }),
      [],
    );
  }
}
