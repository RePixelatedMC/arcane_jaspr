import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/card_props.dart';

/// Codex Card renderer.
///
/// Implements the Codex design language:
/// - 2rem padding (vs ShadCN 1.5rem)
/// - Subtle accent-colored border glow
/// - Larger border radius (14px)
/// - OLED-optimized backgrounds
class CodexCard extends StatelessComponent {
  final CardProps props;

  const CodexCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Resolve content
    final content = props.children ?? [props.child!];

    // Codex Card: More padding and larger radius than ShadCN
    final baseStyles = <String, String>{
      'border-radius': props.borderRadius ?? 'var(--radius)', // 14px
      'color': 'var(--card-foreground)',
      // Codex uses 2rem padding (vs ShadCN 1.5rem)
      if (props.padding != null) 'padding': props.padding! else 'padding': '2rem',
      if (props.fillWidth) 'width': '100%',
      if (props.onTap != null) 'cursor': 'pointer',
      'transition': 'all var(--transition)',
    };

    // Codex variant styles - accent-driven with subtle glows
    final variantStyles = switch (props.variant) {
      CardVariant.elevated => <String, String>{
          'background-color': props.backgroundColor ?? 'var(--card)',
          'border': '1px solid var(--primary)',
          'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2)',
        },
      CardVariant.flat => <String, String>{
          'background-color': props.backgroundColor ?? 'var(--card)',
          'border': '1px solid var(--border)',
          'box-shadow': 'none',
        },
      CardVariant.outlined => <String, String>{
          'background-color': props.backgroundColor ?? 'transparent',
          'border': '1px solid var(--primary)',
          'box-shadow': 'none',
        },
      CardVariant.ghost => <String, String>{
          'background-color': 'transparent',
          'border': 'none',
          'box-shadow': 'none',
        },
      CardVariant.glass => <String, String>{
          // Codex glass: slightly accent-tinted, more blur
          'background-color': 'rgba(10, 10, 10, 0.85)',
          'border': '1px solid var(--primary)',
          'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2)',
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
        styles: dom.Styles(raw: {
          ...allStyles,
          // Reset button styles
          'text-align': 'inherit',
          'font': 'inherit',
        }),
        events: {'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: 'codex-card',
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
