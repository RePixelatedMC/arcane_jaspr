import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/surface_card_props.dart';

/// ShadCN Surface Card renderer.
class ShadcnSurfaceCard extends StatelessComponent {
  final SurfaceCardProps props;

  const ShadcnSurfaceCard(this.props, {super.key});

  String get _backgroundStyle {
    final effectiveBgColor = props.backgroundColor ?? 'var(--card)';

    return switch (props.effect) {
      SurfaceEffect.none => effectiveBgColor,
      SurfaceEffect.blur => 'hsl(from $effectiveBgColor h s l / ${props.backgroundOpacity})',
      SurfaceEffect.frosted => 'hsl(from $effectiveBgColor h s l / ${props.backgroundOpacity})',
      SurfaceEffect.glass => 'linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0.05) 100%)',
      SurfaceEffect.ice => 'linear-gradient(135deg, rgba(200,220,255,${props.backgroundOpacity * 0.3}) 0%, rgba(180,200,255,${props.backgroundOpacity * 0.2}) 100%)',
      SurfaceEffect.gradient => props.gradientColors != null && props.gradientColors!.length >= 2
          ? 'linear-gradient(${props.gradientAngle}deg, ${props.gradientColors!.join(', ')})'
          : 'linear-gradient(${props.gradientAngle}deg, var(--primary), var(--primary))',
    };
  }

  String? get _backdropFilter {
    if (props.effect == SurfaceEffect.none || props.effect == SurfaceEffect.gradient) {
      return null;
    }

    final blur = switch (props.effect) {
      SurfaceEffect.blur => props.blurAmount,
      SurfaceEffect.frosted => props.blurAmount * 1.2,
      SurfaceEffect.glass => props.blurAmount * 1.5,
      SurfaceEffect.ice => props.blurAmount * 0.8,
      _ => 0.0,
    };

    return 'blur(${blur}px)';
  }

  String get _shadowStyle => switch (props.shadow) {
    SurfaceShadow.none => 'none',
    SurfaceShadow.sm => '0 1px 2px 0 rgb(0 0 0 / 0.05)',
    SurfaceShadow.md => '0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)',
    SurfaceShadow.lg => '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
    SurfaceShadow.xl => '0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)',
  };

  @override
  Component build(BuildContext context) {
    final backdropFilter = _backdropFilter;

    return dom.div(
      classes: 'arcane-surface-card arcane-surface-${props.effect.name}',
      styles: dom.Styles(raw: {
        'background': _backgroundStyle,
        'border-radius': props.borderRadius ?? 'var(--radius)',
        'padding': props.padding ?? '1.5rem',
        if (props.showBorder) 'border': '1px solid var(--border)',
        'box-shadow': _shadowStyle,
        if (backdropFilter != null) 'backdrop-filter': backdropFilter,
        if (backdropFilter != null) '-webkit-backdrop-filter': backdropFilter,
        'transition': 'all 150ms ease',
      }),
      [props.child],
    );
  }
}

/// ShadCN ThumbHash Card renderer.
class ShadcnThumbHashCard extends StatelessComponent {
  final ThumbHashCardProps props;

  const ShadcnThumbHashCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-thumbhash-card',
      attributes: {
        'data-thumbhash': props.hash,
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'border-radius': props.borderRadius ?? 'var(--radius)',
        'overflow': 'hidden',
        'background': 'linear-gradient(135deg, var(--muted) 0%, var(--card) 100%)',
      }),
      [
        // Overlay for text readability
        if (props.overlayOpacity > 0)
          dom.div(
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background': 'rgba(0,0,0,${props.overlayOpacity})',
              'pointer-events': 'none',
            }),
            [],
          ),

        // Content
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'padding': props.padding ?? '1.5rem',
          }),
          [props.child],
        ),
      ],
    );
  }
}
