import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/flexi_cards_props.dart';

/// Codex FlexiCards renderer.
class CodexFlexiCards extends StatefulComponent {
  final FlexiCardsProps props;

  const CodexFlexiCards(this.props, {super.key});

  @override
  State<CodexFlexiCards> createState() => _CodexFlexiCardsState();
}

class _CodexFlexiCardsState extends State<CodexFlexiCards> {
  int? _hoveredIndex;

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-flexi-cards',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': component.props.gap,
      }),
      [
        for (int i = 0; i < component.props.items.length; i++)
          _buildCard(component.props.items[i], i),
      ],
    );
  }

  Component _buildCard(FlexiCardItem item, int index) {
    final bool isHovered = _hoveredIndex == index;
    final double flex = isHovered
        ? component.props.expandedFlex
        : component.props.collapsedFlex;

    Component card = dom.div(
      classes: 'codex-flexi-card ${isHovered ? 'hovered' : ''}',
      styles: dom.Styles(raw: {
        'flex': '$flex',
        'min-width': component.props.minCardWidth,
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '1.5rem',
        'background-color': 'var(--card)',
        'border': isHovered
            ? '1px solid var(--primary)'
            : '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'transition': 'all ${component.props.transitionDuration}ms ease',
        if (isHovered)
          'box-shadow': '0 0 20px rgba(var(--primary-rgb), 0.15)',
        if (component.props.widthPreLock != null && !isHovered)
          'width': component.props.widthPreLock!,
        if (component.props.widthPostLock != null && isHovered)
          'width': component.props.widthPostLock!,
        if (component.props.heightPreLock != null && !isHovered)
          'height': component.props.heightPreLock!,
        if (component.props.heightPostLock != null && isHovered)
          'height': component.props.heightPostLock!,
        if (item.onTap != null || item.href != null) 'cursor': 'pointer',
      }),
      events: {
        'mouseenter': (_) => setState(() => _hoveredIndex = index),
        'mouseleave': (_) => setState(() => _hoveredIndex = null),
        if (item.onTap != null) 'click': (_) => item.onTap!(),
      },
      [
        // Header
        if (item.header != null) item.header!,

        // Icon
        dom.div(
          classes: 'codex-flexi-card-icon',
          styles: const dom.Styles(raw: {
            'margin-bottom': '1rem',
          }),
          [item.icon],
        ),

        // Short text (title)
        dom.h3(
          classes: 'codex-flexi-card-title',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-base)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0 0 0.5rem 0',
          }),
          [Component.text(item.shortText)],
        ),

        // Long text (description)
        if (!component.props.expandLongTextOnHover || isHovered)
          dom.p(
            classes: 'codex-flexi-card-description',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0',
              'line-height': '1.5',
            }),
            [Component.text(item.longText)],
          ),

        // Spacer
        const dom.div(styles: dom.Styles(raw: {'flex': '1'}), []),

        // Footer
        if (item.footer != null) item.footer!,
      ],
    );

    if (item.href != null) {
      return dom.a(
        href: item.href!,
        styles: const dom.Styles(raw: {
          'text-decoration': 'none',
          'color': 'inherit',
          'display': 'flex',
        }),
        [card],
      );
    }

    return card;
  }
}

/// Codex FlexiCardsSimple renderer.
class CodexFlexiCardsSimple extends StatelessComponent {
  final FlexiCardsSimpleProps props;

  const CodexFlexiCardsSimple(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-flexi-cards-simple',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat(auto-fit, minmax(250px, 1fr))',
        'gap': props.gap,
      }),
      [
        for (final item in props.items)
          _buildCard(item),
      ],
    );
  }

  Component _buildCard(FlexiCardItem item) {
    Component card = dom.div(
      classes: 'codex-flexi-card-simple',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'padding': '1.5rem',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'transition': 'all var(--arcane-transition)',
        if (item.onTap != null || item.href != null) 'cursor': 'pointer',
      }),
      events: item.onTap != null ? {'click': (_) => item.onTap!()} : null,
      [
        // Header
        if (item.header != null) item.header!,

        // Icon
        dom.div(
          styles: const dom.Styles(raw: {
            'margin-bottom': '1rem',
          }),
          [item.icon],
        ),

        // Title
        dom.h3(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-base)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0 0 0.5rem 0',
          }),
          [Component.text(item.shortText)],
        ),

        // Description
        dom.p(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
            'margin': '0',
            'line-height': '1.5',
          }),
          [Component.text(item.longText)],
        ),

        // Footer
        if (item.footer != null) ...[
          const dom.div(styles: dom.Styles(raw: {'flex': '1', 'min-height': '1rem'}), []),
          item.footer!,
        ],
      ],
    );

    if (item.href != null) {
      return dom.a(
        href: item.href!,
        styles: const dom.Styles(raw: {
          'text-decoration': 'none',
          'color': 'inherit',
        }),
        [card],
      );
    }

    return card;
  }
}