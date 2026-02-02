import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/cta_card_props.dart';

/// Codex CTA Card renderer.
///
/// A card with a dashed border, centered content, and a call-to-action button.
/// Uses CSS classes for animations defined in codex_stylesheet.dart.
class CodexCTACard extends StatelessComponent {
  final CTACardProps props;

  const CodexCTACard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Build class list - use CSS classes for hover/animation effects
    final List<String> classes = [
      'codex-cta-card',
      'codex-game-tile--cta',
      if (props.showHoverEffects) 'codex-game-tile--animated',
    ];
    final String classString = classes.join(' ');

    final Map<String, String> baseStyles = {
      'position': 'relative',
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'justify-content': 'center',
      'background-color': 'var(--card)',
      'border-radius': 'var(--radius-xl)',
      'overflow': 'hidden',
      'text-decoration': 'none',
      'height': props.height,
      if (props.animationDelayMs != null)
        'animation-delay': '${props.animationDelayMs}ms',
    };

    final List<Component> children = [
      // Icon container
      if (props.icon != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '72px',
            'height': '72px',
            'background': 'color-mix(in srgb, var(--primary) 10%, transparent)',
            'border-radius': 'var(--arcane-radius-full)',
            'margin-bottom': 'var(--space-6)',
            'color': 'var(--primary)',
          }),
          [props.icon!],
        ),

      // Title
      dom.h3(
        styles: const dom.Styles(raw: {
          'font-size': 'var(--font-size-lg)',
          'font-weight': 'var(--font-weight-semibold)',
          'color': 'var(--foreground)',
          'margin': '0 0 var(--space-2) 0',
          'text-align': 'center',
        }),
        [Component.text(props.title)],
      ),

      // Description
      if (props.description != null)
        dom.p(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
            'text-align': 'center',
            'padding': '0 var(--space-6)',
            'margin': '0 0 var(--space-6) 0',
          }),
          [Component.text(props.description!)],
        ),

      // CTA Button
      dom.div(
        classes: 'codex-cta-card-button',
        styles: const dom.Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': 'var(--space-2) var(--space-3)',
          'background': 'color-mix(in srgb, var(--primary) 10%, transparent)',
          'border': '1px solid color-mix(in srgb, var(--primary) 30%, transparent)',
          'border-radius': 'var(--radius-md)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'color': 'var(--primary)',
          'transition': 'all var(--arcane-transition-fast)',
        }),
        [
          Component.text(props.ctaText),
          ArcaneIcon.arrowRight(size: IconSize.sm),
        ],
      ),
    ];

    // Wrap in link if href is provided
    if (props.href != null) {
      return dom.a(
        classes: classString,
        href: props.href!,
        styles: dom.Styles(raw: {
          ...baseStyles,
          'cursor': 'pointer',
        }),
        children,
      );
    }

    // Otherwise use a div with onTap
    return dom.div(
      classes: classString,
      styles: dom.Styles(raw: {
        ...baseStyles,
        'cursor': props.onTap != null ? 'pointer' : 'default',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      children,
    );
  }
}
