import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/cta_card_props.dart';

/// Shadcn CTA Card renderer.
///
/// A minimal card with dashed border and centered content.
class ShadcnCTACard extends StatelessComponent {
  final CTACardProps props;

  const ShadcnCTACard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<Component> children = [
      // Icon
      if (props.icon != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '64px',
            'height': '64px',
            'background': 'var(--muted)',
            'border-radius': 'var(--radius)',
            'margin-bottom': 'var(--space-4)',
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
            'margin': '0 0 var(--space-4) 0',
          }),
          [Component.text(props.description!)],
        ),

      // CTA Button
      dom.span(
        styles: const dom.Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': 'var(--space-2)',
          'padding': 'var(--space-2) var(--space-3)',
          'background': 'var(--primary)',
          'border-radius': 'var(--radius)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'color': 'var(--primary-foreground)',
        }),
        [Component.text(props.ctaText)],
      ),
    ];

    // Wrap in link if href is provided
    if (props.href != null) {
      return dom.a(
        classes: 'shadcn-cta-card',
        href: props.href!,
        styles: dom.Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'justify-content': 'center',
          'background': 'var(--card)',
          'border': '2px dashed var(--border)',
          'border-radius': 'var(--radius)',
          'padding': 'var(--space-6)',
          'text-decoration': 'none',
          'height': props.height,
          'cursor': 'pointer',
          'transition': 'border-color var(--transition)',
        }),
        children,
      );
    }

    return dom.div(
      classes: 'shadcn-cta-card',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'background': 'var(--card)',
        'border': '2px dashed var(--border)',
        'border-radius': 'var(--radius)',
        'padding': 'var(--space-6)',
        'height': props.height,
        'cursor': props.onTap != null ? 'pointer' : 'default',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      children,
    );
  }
}
