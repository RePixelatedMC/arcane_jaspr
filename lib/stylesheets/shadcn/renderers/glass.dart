import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/glass_props.dart';

/// ShadCN Glass renderer.
class ShadcnGlass extends StatelessComponent {
  final GlassProps props;

  const ShadcnGlass(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveRadius = props.radius ?? 'var(--radius)';
    final opacityPercent = (props.opacity * 100).toInt();

    return dom.div(
      classes: 'arcane-glass',
      styles: dom.Styles(raw: {
        'background-color': 'color-mix(in srgb, var(--card) $opacityPercent%, transparent)',
        'backdrop-filter': 'blur(${props.blur}px)',
        '-webkit-backdrop-filter': 'blur(${props.blur}px)',
        'border-radius': effectiveRadius,
        if (props.padding != null) 'padding': props.padding!,
        if (props.border) 'border': '1px solid color-mix(in srgb, var(--border) 50%, transparent)',
        'box-shadow': 'var(--arcane-shadow-md)',
      }),
      [props.child],
    );
  }
}

/// ShadCN Glass Card renderer.
class ShadcnGlassCard extends StatelessComponent {
  final GlassCardProps props;

  const ShadcnGlassCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveRadius = props.radius ?? 'var(--radius)';
    final effectivePadding = props.padding ?? '1rem';
    final opacityPercent = (props.opacity * 100).toInt();

    final glassContent = dom.div(
      classes: 'arcane-glass',
      styles: dom.Styles(raw: {
        'background-color': 'color-mix(in srgb, var(--card) $opacityPercent%, transparent)',
        'backdrop-filter': 'blur(${props.blur}px)',
        '-webkit-backdrop-filter': 'blur(${props.blur}px)',
        'border-radius': effectiveRadius,
        'padding': effectivePadding,
        if (props.border) 'border': '1px solid color-mix(in srgb, var(--border) 50%, transparent)',
        'box-shadow': 'var(--arcane-shadow-md)',
      }),
      [props.child],
    );

    if (props.onTap != null) {
      return dom.div(
        classes: 'arcane-glass-card',
        styles: const dom.Styles(raw: {
          'cursor': 'pointer',
          'transition': 'transform var(--arcane-transition)',
        }),
        events: {
          'click': (event) => props.onTap!(),
        },
        [glassContent],
      );
    } else {
      return glassContent;
    }
  }
}

/// ShadCN Gradient Glass renderer.
class ShadcnGradientGlass extends StatelessComponent {
  final GradientGlassProps props;

  const ShadcnGradientGlass(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveRadius = props.radius ?? 'var(--radius)';
    final start = props.gradientStart ?? 'var(--primary)';
    final end = props.gradientEnd ?? 'var(--accent)';
    final opacityPercent = (props.opacity * 100).toInt();

    return dom.div(
      classes: 'arcane-gradient-glass',
      styles: dom.Styles(raw: {
        'background': 'linear-gradient(${props.direction}, color-mix(in srgb, $start $opacityPercent%, transparent), color-mix(in srgb, $end $opacityPercent%, transparent))',
        'backdrop-filter': 'blur(${props.blur}px)',
        '-webkit-backdrop-filter': 'blur(${props.blur}px)',
        'border-radius': effectiveRadius,
        if (props.padding != null) 'padding': props.padding!,
        'border': '1px solid color-mix(in srgb, var(--border) 30%, transparent)',
      }),
      [props.child],
    );
  }
}
