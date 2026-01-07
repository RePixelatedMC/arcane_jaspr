import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/surface_card_props.dart';

/// Codex SurfaceCard renderer.
class CodexSurfaceCard extends StatelessComponent {
  final SurfaceCardProps props;

  const CodexSurfaceCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String background = _getBackground();
    final String shadow = _getShadow();
    final String borderRadius = props.borderRadius ?? 'var(--radius)';
    final String padding = props.padding ?? '1.5rem';

    return dom.div(
      classes: 'codex-surface-card codex-surface-${props.effect.name}',
      styles: dom.Styles(raw: {
        'background': background,
        'border-radius': borderRadius,
        'padding': padding,
        if (props.showBorder) 'border': '1px solid var(--border)',
        if (shadow != 'none') 'box-shadow': shadow,
        if (props.effect == SurfaceEffect.blur ||
            props.effect == SurfaceEffect.frosted ||
            props.effect == SurfaceEffect.glass)
          'backdrop-filter': 'blur(${props.blurAmount}px)',
        if (props.effect == SurfaceEffect.blur ||
            props.effect == SurfaceEffect.frosted ||
            props.effect == SurfaceEffect.glass)
          '-webkit-backdrop-filter': 'blur(${props.blurAmount}px)',
      }),
      [props.child],
    );
  }

  String _getBackground() {
    if (props.backgroundColor != null) {
      return props.backgroundColor!;
    }

    return switch (props.effect) {
      SurfaceEffect.none => 'var(--card)',
      SurfaceEffect.blur =>
        'rgba(var(--card-rgb, 10, 10, 10), ${props.backgroundOpacity})',
      SurfaceEffect.frosted =>
        'rgba(255, 255, 255, ${props.backgroundOpacity * 0.1})',
      SurfaceEffect.gradient => _getGradient(),
      SurfaceEffect.glass =>
        'rgba(var(--card-rgb, 10, 10, 10), ${props.backgroundOpacity * 0.5})',
      SurfaceEffect.ice =>
        'linear-gradient(135deg, rgba(255, 255, 255, 0.1) 0%, rgba(200, 220, 255, 0.05) 100%)',
    };
  }

  String _getGradient() {
    if (props.gradientColors != null && props.gradientColors!.length >= 2) {
      return 'linear-gradient(${props.gradientAngle}deg, ${props.gradientColors!.join(', ')})';
    }
    return 'linear-gradient(${props.gradientAngle}deg, var(--card) 0%, var(--secondary) 100%)';
  }

  String _getShadow() {
    return switch (props.shadow) {
      SurfaceShadow.none => 'none',
      SurfaceShadow.sm => 'var(--arcane-shadow-sm)',
      SurfaceShadow.md => 'var(--arcane-shadow)',
      SurfaceShadow.lg => 'var(--arcane-shadow-md)',
      SurfaceShadow.xl => 'var(--arcane-shadow-lg)',
    };
  }
}

/// Codex ThumbHashCard renderer.
class CodexThumbHashCard extends StatelessComponent {
  final ThumbHashCardProps props;

  const CodexThumbHashCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String borderRadius = props.borderRadius ?? 'var(--radius)';
    final String padding = props.padding ?? '1.5rem';

    return dom.div(
      classes: 'codex-thumbhash-card',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'border-radius': borderRadius,
        'overflow': 'hidden',
      }),
      [
        // Background placeholder (would need JS to decode thumbhash)
        dom.div(
          classes: 'codex-thumbhash-background',
          styles: const dom.Styles(raw: {
            'position': 'absolute',
            'inset': '0',
            'background': 'var(--secondary)',
          }),
          [],
        ),

        // Overlay for text readability
        if (props.overlayOpacity > 0)
          dom.div(
            classes: 'codex-thumbhash-overlay',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background': 'rgba(0, 0, 0, ${props.overlayOpacity})',
            }),
            [],
          ),

        // Content
        dom.div(
          classes: 'codex-thumbhash-content',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'padding': padding,
          }),
          [props.child],
        ),
      ],
    );
  }
}
