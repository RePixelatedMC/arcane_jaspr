import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/glass_props.dart';

/// Codex Glass renderer.
///
/// Implements the Codex design language:
/// - Backdrop blur with accent-tinted border
/// - OLED-optimized semi-transparent background
class CodexGlass extends StatelessComponent {
  final GlassProps props;

  const CodexGlass(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-glass',
      styles: dom.Styles(raw: {
        'background': 'rgba(10, 10, 10, ${props.opacity})',
        'backdrop-filter': 'blur(${props.blur}px)',
        '-webkit-backdrop-filter': 'blur(${props.blur}px)',
        if (props.border) 'border': '1px solid rgba(var(--primary-rgb), 0.15)',
        'border-radius': props.radius ?? 'var(--radius)',
        if (props.padding != null) 'padding': props.padding!,
      }),
      [props.child],
    );
  }
}

/// Codex Glass Card renderer.
class CodexGlassCard extends StatelessComponent {
  final GlassCardProps props;

  const CodexGlassCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-glass-card',
      styles: dom.Styles(raw: {
        'background': 'rgba(10, 10, 10, ${props.opacity})',
        'backdrop-filter': 'blur(${props.blur}px)',
        '-webkit-backdrop-filter': 'blur(${props.blur}px)',
        if (props.border) 'border': '1px solid rgba(var(--primary-rgb), 0.15)',
        'border-radius': props.radius ?? 'var(--radius)',
        'padding': props.padding ?? '2rem', // Codex: larger padding
        if (props.onTap != null) 'cursor': 'pointer',
        'transition': 'all var(--transition)',
      }),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [props.child],
    );
  }
}

/// Codex Gradient Glass renderer.
class CodexGradientGlass extends StatelessComponent {
  final GradientGlassProps props;

  const CodexGradientGlass(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String gradientStart =
        props.gradientStart ?? 'rgba(var(--primary-rgb), ${props.opacity})';
    final String gradientEnd =
        props.gradientEnd ?? 'rgba(var(--primary-rgb), 0)';

    return dom.div(
      classes: 'codex-gradient-glass',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'background': 'linear-gradient(${props.direction}, $gradientStart, $gradientEnd)',
        'backdrop-filter': 'blur(${props.blur}px)',
        '-webkit-backdrop-filter': 'blur(${props.blur}px)',
        'border': '1px solid rgba(var(--primary-rgb), 0.1)',
        'border-radius': props.radius ?? 'var(--radius)',
        if (props.padding != null) 'padding': props.padding!,
      }),
      [props.child],
    );
  }
}
