import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/arrow_link_props.dart';

/// ShadCN Arrow Link renderer.
class ShadcnArrowLink extends StatelessComponent {
  final ArrowLinkProps props;

  const ShadcnArrowLink(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String fontSize = switch (props.size) {
      ArrowLinkSize.xs => '0.75rem',
      ArrowLinkSize.sm => '0.875rem',
      ArrowLinkSize.md => '1rem',
      ArrowLinkSize.lg => '1.125rem',
    };

    final IconSize iconSize = switch (props.size) {
      ArrowLinkSize.xs => IconSize.xs,
      ArrowLinkSize.sm => IconSize.sm,
      ArrowLinkSize.md => IconSize.sm,
      ArrowLinkSize.lg => IconSize.md,
    };

    final String color = props.accent ? 'var(--primary)' : 'var(--muted-foreground)';

    final List<Component> content = [
      if (props.showArrow && props.arrowBefore) ArcaneIcon.arrowLeft(size: iconSize),
      Component.text(props.label),
      if (props.showArrow && !props.arrowBefore) ArcaneIcon.arrowRight(size: iconSize),
    ];

    final Map<String, String> styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.5rem',
      'font-size': fontSize,
      'color': color,
      'text-decoration': 'none',
      'cursor': 'pointer',
      'transition': 'all 150ms ease',
    };

    if (props.href != null) {
      return dom.a(
        classes: 'arcane-arrow-link',
        href: props.href!,
        styles: dom.Styles(raw: styles),
        content,
      );
    }

    if (props.onTap != null) {
      return dom.button(
        classes: 'arcane-arrow-link',
        attributes: {'type': 'button'},
        styles: dom.Styles(raw: {
          ...styles,
          'background': 'none',
          'border': 'none',
          'padding': '0',
        }),
        events: {'click': (_) => props.onTap!()},
        content,
      );
    }

    // Fallback to span if no interaction
    return dom.span(
      classes: 'arcane-arrow-link',
      styles: dom.Styles(raw: styles),
      content,
    );
  }
}
