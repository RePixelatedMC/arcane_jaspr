import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/arrow_link_props.dart';

/// Codex Arrow Link renderer.
///
/// Supports two variants:
/// - `inline`: Simple text link with arrow
/// - `pill`: Button-like link with background, border, and hover effects
class CodexArrowLink extends StatefulComponent {
  final ArrowLinkProps props;

  const CodexArrowLink(this.props, {super.key});

  @override
  State<CodexArrowLink> createState() => _CodexArrowLinkState();
}

class _CodexArrowLinkState extends State<CodexArrowLink> {
  bool _isHovered = false;

  @override
  Component build(BuildContext context) {
    final ArrowLinkProps props = component.props;

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

    // Build content based on variant
    if (props.variant == ArrowLinkVariant.pill) {
      return _buildPillVariant(props, fontSize, iconSize, color);
    }

    return _buildInlineVariant(props, fontSize, iconSize, color);
  }

  /// Builds the inline text link variant.
  Component _buildInlineVariant(
    ArrowLinkProps props,
    String fontSize,
    IconSize iconSize,
    String color,
  ) {
    final List<Component> content = [
      if (props.showArrow && props.arrowBefore) ArcaneIcon.arrowLeft(size: iconSize),
      Component.text(props.label),
      if (props.showArrow && !props.arrowBefore) ArcaneIcon.arrowRight(size: iconSize),
    ];

    final Map<String, String> styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': 'var(--space-2)',
      'font-size': fontSize,
      'color': color,
      'text-decoration': 'none',
      'cursor': 'pointer',
      'transition': 'all var(--arcane-transition)',
    };

    if (props.href != null) {
      return dom.a(
        classes: 'codex-arrow-link',
        href: props.href!,
        styles: dom.Styles(raw: styles),
        content,
      );
    }

    if (props.onTap != null) {
      return dom.button(
        classes: 'codex-arrow-link',
        attributes: const {'type': 'button'},
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
      classes: 'codex-arrow-link',
      styles: dom.Styles(raw: styles),
      content,
    );
  }

  /// Builds the pill button variant with hover effects.
  Component _buildPillVariant(
    ArrowLinkProps props,
    String fontSize,
    IconSize iconSize,
    String color,
  ) {
    final String padding = switch (props.size) {
      ArrowLinkSize.xs => 'var(--space-2) var(--space-3)',
      ArrowLinkSize.sm => 'var(--space-3) var(--space-4)',
      ArrowLinkSize.md => 'var(--space-3) var(--space-5)',
      ArrowLinkSize.lg => 'var(--space-4) var(--space-6)',
    };

    // Build arrow with animation wrapper if animateArrow is true
    Component? arrowComponent;
    if (props.showArrow) {
      final Component arrow = props.arrowBefore
          ? ArcaneIcon.arrowLeft(size: iconSize)
          : ArcaneIcon.arrowRight(size: iconSize);

      if (props.animateArrow) {
        final String transform = _isHovered
            ? (props.arrowBefore ? 'translateX(-4px)' : 'translateX(4px)')
            : 'translateX(0)';

        arrowComponent = dom.span(
          styles: dom.Styles(raw: {
            'display': 'inline-flex',
            'transition': 'transform var(--arcane-transition)',
            'transform': transform,
          }),
          [arrow],
        );
      } else {
        arrowComponent = arrow;
      }
    }

    final List<Component> content = [
      if (props.showArrow && props.arrowBefore) arrowComponent!,
      Component.text(props.label),
      if (props.showArrow && !props.arrowBefore) arrowComponent!,
    ];

    final Map<String, String> styles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'gap': 'var(--space-2)',
      'padding': padding,
      'font-size': fontSize,
      'font-weight': 'var(--font-weight-semibold)',
      'color': color,
      'text-decoration': 'none',
      'cursor': 'pointer',
      'border-radius': 'var(--radius-lg)',
      'background': _isHovered
          ? 'color-mix(in srgb, $color 15%, transparent)'
          : 'color-mix(in srgb, $color 8%, transparent)',
      'border': _isHovered
          ? '1px solid color-mix(in srgb, $color 30%, transparent)'
          : '1px solid color-mix(in srgb, $color 15%, transparent)',
      'transition': 'all var(--arcane-transition)',
    };

    final Map<String, void Function(Object)> hoverEvents = {
      'mouseenter': (_) => setState(() => _isHovered = true),
      'mouseleave': (_) => setState(() => _isHovered = false),
    };

    if (props.href != null) {
      return dom.a(
        classes: 'codex-arrow-link codex-arrow-link--pill',
        href: props.href!,
        styles: dom.Styles(raw: styles),
        events: hoverEvents,
        content,
      );
    }

    if (props.onTap != null) {
      return dom.button(
        classes: 'codex-arrow-link codex-arrow-link--pill',
        attributes: const {'type': 'button'},
        styles: dom.Styles(raw: styles),
        events: {
          ...hoverEvents,
          'click': (_) => props.onTap!(),
        },
        content,
      );
    }

    // Fallback to span if no interaction
    return dom.span(
      classes: 'codex-arrow-link codex-arrow-link--pill',
      styles: dom.Styles(raw: styles),
      events: hoverEvents,
      content,
    );
  }
}
