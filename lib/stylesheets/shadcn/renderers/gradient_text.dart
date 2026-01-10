import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/gradient_text_props.dart';

/// ShadCN Gradient Text renderer.
class ShadcnGradientText extends StatelessComponent {
  final GradientTextProps props;

  const ShadcnGradientText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.span(
      classes: 'arcane-gradient-text',
      styles: dom.Styles(raw: {
        'font-size': props.fontSize,
        'font-weight': props.fontWeight,
        'background': props.buildGradient(),
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': 'transparent',
      }),
      [Component.text(props.content)],
    );
  }
}

/// ShadCN Animated Gradient Text renderer.
class ShadcnAnimatedGradientText extends StatelessComponent {
  final AnimatedGradientTextProps props;

  const ShadcnAnimatedGradientText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.span(
      classes: 'arcane-animated-gradient-text',
      styles: dom.Styles(raw: {
        'font-size': props.fontSize,
        'font-weight': props.fontWeight,
        'background':
            'linear-gradient(135deg, var(--success) 0%, var(--info) 25%, var(--accent) 50%, var(--destructive) 75%, var(--success) 100%)',
        'background-size': '200% 200%',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': 'transparent',
        'animation': 'arcane-gradient-shift 5s ease infinite',
      }),
      [Component.text(props.content)],
    );
  }
}

/// ShadCN Glow Text renderer.
class ShadcnGlowText extends StatelessComponent {
  final GlowTextProps props;

  const ShadcnGlowText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final color = props.glowColor ?? 'var(--primary)';
    final intensity = props.intensity;

    return dom.span(
      classes: 'arcane-glow-text',
      styles: dom.Styles(raw: {
        'font-size': props.fontSize,
        'font-weight': props.fontWeight,
        'color': color,
        'text-shadow':
            '0 0 ${10 * intensity}px $color, 0 0 ${20 * intensity}px $color, 0 0 ${40 * intensity}px ${color}60',
      }),
      [Component.text(props.content)],
    );
  }
}

/// ShadCN Outline Text renderer.
class ShadcnOutlineText extends StatelessComponent {
  final OutlineTextProps props;

  const ShadcnOutlineText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final stroke = props.strokeColor ?? 'var(--primary)';
    final fill = props.fillColor ?? 'transparent';

    return dom.span(
      classes: 'arcane-outline-text',
      styles: dom.Styles(raw: {
        'font-size': props.fontSize,
        'font-weight': props.fontWeight,
        '-webkit-text-stroke': '${props.strokeWidth}px $stroke',
        'color': fill,
      }),
      [Component.text(props.content)],
    );
  }
}
