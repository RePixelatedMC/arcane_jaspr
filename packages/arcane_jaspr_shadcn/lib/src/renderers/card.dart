import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/card_props.dart';

/// ShadCN Card renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/card
class ShadcnCard extends StatelessComponent {
  final CardProps props;

  const ShadcnCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Resolve content
    final content = props.children ?? [props.child!];

    // ShadCN Card: rounded-lg border bg-card text-card-foreground shadow-sm
    final baseStyles = <String, String>{
      'border-radius': props.borderRadius ?? '0.5rem', // rounded-lg
      'color': 'var(--card-foreground)',
      if (props.padding != null)
        'padding': props.padding!
      else
        'padding': '1.5rem', // p-6
      if (props.fillWidth) 'width': '100%',
      if (props.onTap != null) 'cursor': 'pointer',
    };

    // Variant-specific styles
    final variantStyles = switch (props.variant) {
      CardVariant.elevated => <String, String>{
        'background-color': props.backgroundColor ?? 'var(--card)',
        'border': '1px solid var(--border)',
        'box-shadow': 'var(--shadow-xs)', // shadow-sm
      },
      CardVariant.flat => <String, String>{
        'background-color': props.backgroundColor ?? 'var(--card)',
        'border': '1px solid var(--border)',
        'box-shadow': 'none',
      },
      CardVariant.outlined => <String, String>{
        'background-color': props.backgroundColor ?? 'var(--background)',
        'border': '1px solid var(--border)',
        'box-shadow': 'none',
      },
      CardVariant.ghost => <String, String>{
        'background-color': 'transparent',
        'border': 'none',
        'box-shadow': 'none',
      },
      CardVariant.glass => <String, String>{
        'background-color': 'color-mix(in srgb, var(--card) 80%, transparent)',
        'border': '1px solid var(--border)',
        'box-shadow': 'var(--shadow-xs)',
        'backdrop-filter': 'blur(8px)',
        '-webkit-backdrop-filter': 'blur(8px)',
      },
      CardVariant.interactive => <String, String>{
        'background-color': props.backgroundColor ?? 'var(--card)',
        'border': '1px solid var(--border)',
        'box-shadow': 'var(--shadow-xs)',
        'transition': 'all var(--transition)',
      },
    };

    final allStyles = {...baseStyles, ...variantStyles};

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: 'arcane-card clickable',
        attributes: {'data-variant': props.variant.name},
        styles: dom.Styles(
          raw: {
            ...allStyles,
            // Reset button styles
            'text-align': 'inherit',
            'font': 'inherit',
          },
        ),
        events: {'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: 'arcane-card',
      attributes: {'data-variant': props.variant.name},
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
