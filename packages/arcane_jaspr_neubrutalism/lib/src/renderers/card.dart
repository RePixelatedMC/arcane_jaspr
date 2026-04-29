import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/card_props.dart';

class NeubrutalismCard extends StatelessComponent {
  final CardProps props;

  const NeubrutalismCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    List<Component> content = props.children ?? <Component>[props.child!];

    Map<String, String> baseStyles = <String, String>{
      'border-radius': props.borderRadius ?? 'var(--nb-radius-soft, 4px)',
      'color': 'var(--card-foreground)',
      if (props.padding != null)
        'padding': props.padding!
      else
        'padding': '1.5rem',
      if (props.fillWidth) 'width': '100%',
      if (props.onTap != null) 'cursor': 'pointer',
      'position': 'relative',
      'transition':
          'transform 120ms cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 120ms cubic-bezier(0.2, 0.8, 0.2, 1)',
    };

    Map<String, String> variantStyles = switch (props.variant) {
      CardVariant.elevated => <String, String>{
        'background-color':
            props.backgroundColor ?? 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      CardVariant.flat => <String, String>{
        'background-color':
            props.backgroundColor ?? 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'box-shadow': 'none',
      },
      CardVariant.outlined => <String, String>{
        'background-color': props.backgroundColor ?? 'transparent',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'box-shadow': 'none',
      },
      CardVariant.ghost => <String, String>{
        'background-color': 'transparent',
        'border': 'none',
        'box-shadow': 'none',
      },
      CardVariant.glass => <String, String>{
        'background-color':
            props.backgroundColor ?? 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'box-shadow': 'var(--nb-shadow-lg, 7px 7px 0 0 var(--nb-shadow-color, #000))',
      },
      CardVariant.interactive => <String, String>{
        'background-color':
            props.backgroundColor ?? 'var(--nb-paper, var(--card))',
        'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
        'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
    };

    Map<String, String> allStyles = <String, String>{
      ...baseStyles,
      ...variantStyles,
    };

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: 'neubrutalism-card clickable',
        attributes: <String, String>{'data-variant': props.variant.name},
        styles: dom.Styles(
          raw: <String, String>{
            ...allStyles,
            'text-align': 'inherit',
            'font': 'inherit',
          },
        ),
        events: <String, EventCallback>{'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: 'neubrutalism-card',
      attributes: <String, String>{'data-variant': props.variant.name},
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
