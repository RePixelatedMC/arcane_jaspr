import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/gradient_text_props.dart';

/// Codex Gradient Text renderer.
class CodexGradientText extends StatelessComponent {
  final GradientTextProps props;

  const CodexGradientText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Use full gradient if provided, otherwise build from start/end
    final String backgroundGradient;
    if (props.gradient != null) {
      backgroundGradient = props.gradient!;
    } else {
      final start = props.gradientStart ?? 'var(--primary)';
      final end = props.gradientEnd ?? 'var(--accent)';
      final angle = props.gradientAngle ?? '135deg';
      backgroundGradient = 'linear-gradient($angle, $start 0%, $end 100%)';
    }

    return dom.span(
      classes: 'codex-gradient-text',
      styles: dom.Styles(raw: {
        'font-size': props.fontSize,
        'font-weight': props.fontWeight,
        'background': backgroundGradient,
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        'color': 'transparent',
      }),
      [Component.text(props.content)],
    );
  }
}

/// Codex Animated Gradient Text renderer.
class CodexAnimatedGradientText extends StatelessComponent {
  final AnimatedGradientTextProps props;

  const CodexAnimatedGradientText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.span(
      classes: 'codex-animated-gradient-text',
      styles: dom.Styles(raw: {
        'font-size': props.fontSize,
        'font-weight': props.fontWeight,
        'background':
            'linear-gradient(135deg, var(--primary) 0%, var(--accent) 25%, var(--muted-foreground) 50%, var(--accent) 75%, var(--primary) 100%)',
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

/// Codex Glow Text renderer.
class CodexGlowText extends StatelessComponent {
  final GlowTextProps props;

  const CodexGlowText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final color = props.glowColor ?? 'var(--primary)';
    final intensity = props.intensity;

    return dom.span(
      classes: 'codex-glow-text',
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

/// Codex Outline Text renderer.
class CodexOutlineText extends StatelessComponent {
  final OutlineTextProps props;

  const CodexOutlineText(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final stroke = props.strokeColor ?? 'var(--primary)';
    final fill = props.fillColor ?? 'transparent';

    return dom.span(
      classes: 'codex-outline-text',
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
