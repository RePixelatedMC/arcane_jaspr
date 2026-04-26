import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/card_props.dart';

class NeonCard extends StatelessComponent {
  final CardProps props;

  const NeonCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    List<Component> content = props.children ?? <Component>[props.child!];

    Map<String, String> baseStyles = <String, String>{
      'border-radius': props.borderRadius ?? 'var(--neon-radius-panel)',
      'clip-path': 'var(--neon-panel-clip)',
      'color': 'var(--card-foreground)',
      if (props.padding != null)
        'padding': props.padding!
      else
        'padding': '2rem',
      if (props.fillWidth) 'width': '100%',
      if (props.onTap != null) 'cursor': 'pointer',
      'position': 'relative',
      'overflow': 'hidden',
      'isolation': 'isolate',
      'transition':
          'border-color 0.18s ease, box-shadow 0.18s ease, background-color 0.18s ease, transform 0.18s ease, filter 0.18s ease',
    };

    Map<String, String> variantStyles = switch (props.variant) {
      CardVariant.elevated => <String, String>{
        'background':
            props.backgroundColor ?? 'radial-gradient(circle at 12% 0%, color-mix(in srgb, var(--neon-cyan) 12%, transparent), transparent 14rem), linear-gradient(135deg, color-mix(in srgb, var(--primary) 6%, transparent), color-mix(in srgb, var(--card) 78%, transparent)), linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 4%, transparent) 1px, transparent 1px)',
        'background-size': 'auto, auto, 20px 20px',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow':
            'var(--neon-panel-shadow), var(--neon-inset-highlight)',
        'backdrop-filter': 'blur(14px)',
        '-webkit-backdrop-filter': 'blur(14px)',
      },
      CardVariant.flat => <String, String>{
        'background':
            props.backgroundColor ?? 'linear-gradient(135deg, color-mix(in srgb, var(--foreground) 3%, transparent), color-mix(in srgb, var(--card) 72%, transparent))',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow': 'var(--neon-inset-highlight)',
      },
      CardVariant.outlined => <String, String>{
        'background':
            props.backgroundColor ?? 'linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 4%, transparent), color-mix(in srgb, var(--background) 48%, transparent))',
        'border': '1px solid var(--neon-accent-border)',
        'box-shadow':
            '0 0 0 1px color-mix(in srgb, var(--neon-cyan) 7%, transparent), var(--neon-inset-highlight)',
      },
      CardVariant.ghost => <String, String>{
        'background-color': 'transparent',
        'border': 'none',
        'box-shadow': 'none',
      },
      CardVariant.glass => <String, String>{
        'background':
            'radial-gradient(circle at 15% 0%, color-mix(in srgb, var(--neon-cyan) 18%, transparent), transparent 12rem), linear-gradient(135deg, rgba(255,255,255,0.12), rgba(255,255,255,0.03) 34%, rgba(5,12,16,0.76)), color-mix(in srgb, var(--card) 62%, transparent)',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow':
            '0 22px 60px rgba(0, 0, 0, 0.36), 0 0 34px color-mix(in srgb, var(--neon-cyan) 18%, transparent), inset 0 1px 0 rgba(255,255,255,0.18)',
        'backdrop-filter': 'blur(22px) saturate(1.28)',
        '-webkit-backdrop-filter': 'blur(22px) saturate(1.28)',
      },
      CardVariant.interactive => <String, String>{
        'background':
            props.backgroundColor ?? 'radial-gradient(circle at top right, color-mix(in srgb, var(--neon-magenta) 10%, transparent), transparent 12rem), linear-gradient(135deg, color-mix(in srgb, var(--primary) 8%, transparent), color-mix(in srgb, var(--card) 74%, transparent)), linear-gradient(color-mix(in srgb, var(--primary) 4%, transparent) 1px, transparent 1px)',
        'background-size': 'auto, auto, 18px 18px',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow':
            '0 12px 34px rgba(0, 0, 0, 0.22), var(--neon-inset-highlight)',
      },
    };

    Map<String, String> allStyles = <String, String>{
      ...baseStyles,
      ...variantStyles,
    };

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: 'neon-card clickable',
        attributes: {'data-variant': props.variant.name},
        styles: dom.Styles(
          raw: {...allStyles, 'text-align': 'inherit', 'font': 'inherit'},
        ),
        events: {'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: 'neon-card',
      attributes: {'data-variant': props.variant.name},
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
