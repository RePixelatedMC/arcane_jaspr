import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/card_props.dart';

class CodexCard extends StatelessComponent {
  final CardProps props;

  const CodexCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final content = props.children ?? [props.child!];

    final baseStyles = <String, String>{
      'border-radius': props.borderRadius ?? 'var(--radius)',
      'color': 'var(--card-foreground)',
      if (props.padding != null) 'padding': props.padding! else 'padding': '2rem',
      if (props.fillWidth) 'width': '100%',
      if (props.onTap != null) 'cursor': 'pointer',
      'transition':
          'border-color 0.2s ease, box-shadow 0.2s ease, background-color 0.2s ease, transform 0.2s ease',
    };

    final variantStyles = switch (props.variant) {
      CardVariant.elevated => <String, String>{
          'background-color': props.backgroundColor ?? 'var(--card)',
          'border': '1px solid var(--codex-accent-border)',
          'box-shadow':
              '0 12px 28px color-mix(in srgb, var(--primary) 12%, transparent)',
        },
      CardVariant.flat => <String, String>{
          'background-color': props.backgroundColor ?? 'var(--card)',
          'border': '1px solid var(--border)',
          'box-shadow': 'none',
        },
      CardVariant.outlined => <String, String>{
          'background-color': props.backgroundColor ?? 'transparent',
          'border': '1px solid var(--codex-accent-border)',
          'box-shadow': 'none',
        },
      CardVariant.ghost => <String, String>{
          'background-color': 'transparent',
          'border': 'none',
          'box-shadow': 'none',
        },
      CardVariant.glass => <String, String>{
          'background-color': 'rgba(10, 10, 10, 0.85)',
          'border': '1px solid var(--codex-accent-border)',
          'box-shadow':
              '0 10px 24px color-mix(in srgb, var(--primary) 10%, transparent)',
          'backdrop-filter': 'blur(12px)',
          '-webkit-backdrop-filter': 'blur(12px)',
        },
      CardVariant.interactive => <String, String>{
          'background-color': props.backgroundColor ?? 'var(--card)',
          'border': '1px solid var(--border)',
          'box-shadow': 'none',
        },
    };

    final allStyles = {...baseStyles, ...variantStyles};

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: 'codex-card clickable',
        attributes: {'data-variant': props.variant.name},
        styles: dom.Styles(raw: {
          ...allStyles,
          'text-align': 'inherit',
          'font': 'inherit',
        }),
        events: {'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: 'codex-card',
      attributes: {'data-variant': props.variant.name},
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
