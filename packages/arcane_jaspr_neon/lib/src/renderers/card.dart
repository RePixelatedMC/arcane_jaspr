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
        'background': props.backgroundColor ??
            'linear-gradient(160deg, color-mix(in srgb, var(--neon-accent-cool) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow': 'var(--neon-shadow-md), var(--neon-inset)',
      },
      CardVariant.flat => <String, String>{
        'background': props.backgroundColor ??
            'color-mix(in srgb, var(--card) 78%, transparent)',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow': 'var(--neon-inset)',
      },
      CardVariant.outlined => <String, String>{
        'background':
            props.backgroundColor ?? 'transparent',
        'border':
            '1px solid color-mix(in srgb, var(--neon-accent-cool) 30%, var(--neon-panel-border))',
        'box-shadow': 'var(--neon-inset)',
      },
      CardVariant.ghost => <String, String>{
        'background-color': 'transparent',
        'border': 'none',
        'box-shadow': 'none',
      },
      CardVariant.glass => <String, String>{
        'background':
            'linear-gradient(160deg, color-mix(in srgb, var(--neon-accent-cool) 8%, transparent), color-mix(in srgb, var(--card) 60%, transparent))',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow':
            'var(--neon-shadow-lg), inset 0 1px 0 color-mix(in srgb, var(--foreground) 8%, transparent)',
        'backdrop-filter': 'blur(16px) saturate(1.18)',
        '-webkit-backdrop-filter': 'blur(16px) saturate(1.18)',
      },
      CardVariant.interactive => <String, String>{
        'background': props.backgroundColor ??
            'linear-gradient(160deg, color-mix(in srgb, var(--neon-accent) 6%, transparent), color-mix(in srgb, var(--card) 82%, transparent))',
        'border': '1px solid var(--neon-panel-border)',
        'box-shadow': 'var(--neon-shadow-md), var(--neon-inset)',
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
