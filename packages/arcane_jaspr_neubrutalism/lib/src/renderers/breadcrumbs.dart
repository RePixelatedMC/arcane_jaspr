import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/breadcrumbs_props.dart';

/// Neubrutalism Breadcrumbs renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger size options
/// - Accent-colored links
/// - More spacing between items
class NeubrutalismBreadcrumbs extends StatelessComponent {
  final BreadcrumbsProps props;

  const NeubrutalismBreadcrumbs(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Neubrutalism size-specific styles
    final (String fontSize, String gap) = switch (props.size) {
      BreadcrumbSizeVariant.sm => ('0.75rem', '0.5rem'),
      BreadcrumbSizeVariant.md => (
        '0.875rem',
        '0.625rem',
      ), // Neubrutalism: slightly more gap
      BreadcrumbSizeVariant.lg => ('1rem', '0.75rem'),
    };

    return dom.nav(
      classes: 'neubrutalism-breadcrumbs',
      attributes: {'aria-label': 'Breadcrumb'},
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': gap,
          'font-size': fontSize,
        },
      ),
      [
        for (var i = 0; i < props.items.length; i++) ...[
          _buildItem(props.items[i], i, i == props.items.length - 1),
          if (i < props.items.length - 1) _buildSeparator(),
        ],
      ],
    );
  }

  Component _buildItem(BreadcrumbItemProps item, int index, bool isLast) {
    final bool isClickable = item.href != null || props.onItemClick != null;

    final List<Component> children = [
      if (index == 0 && props.showHomeIcon)
        Component.element(
          tag: 'svg',
          attributes: {
            'width': '14',
            'height': '14',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
            'aria-hidden': 'true',
          },
          styles: const dom.Styles(raw: {'margin-right': '0.4rem'}),
          children: [
            Component.element(
              tag: 'path',
              attributes: {'d': 'M3 12l9-9 9 9'},
              children: const [],
            ),
            Component.element(
              tag: 'path',
              attributes: {'d': 'M5 10v10h14V10'},
              children: const [],
            ),
          ],
        )
      else if (item.icon != null) ...[
        item.icon!,
        const dom.span(styles: dom.Styles(raw: {'width': '0.375rem'}), []),
      ],
      Component.text(item.label),
    ];

    if (item.href != null && !isLast) {
      return dom.a(
        href: item.href!,
        classes: 'neubrutalism-breadcrumb-link',
        styles: const dom.Styles(
          raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'color': 'var(--muted-foreground)',
            'text-decoration': 'none',
            'transition': 'color 200ms ease',
          },
        ),
        children,
      );
    }

    if (props.onItemClick != null && !isLast) {
      return dom.button(
        classes: 'neubrutalism-breadcrumb-button',
        styles: const dom.Styles(
          raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'background': 'transparent',
            'border': 'none',
            'padding': '0',
            'color': 'var(--muted-foreground)',
            'cursor': 'pointer',
            'font': 'inherit',
            'transition': 'color 200ms ease',
          },
        ),
        events: {'click': (_) => props.onItemClick!(item, index)},
        children,
      );
    }

    // Last item or non-clickable
    return dom.span(
      classes: 'neubrutalism-breadcrumb-current',
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'color': isLast ? 'var(--nb-accent, var(--primary))' : 'var(--muted-foreground)',
          'font-weight': isLast ? 'var(--font-weight-semibold)' : '400',
          if (!isClickable && !isLast) 'cursor': 'default',
        },
      ),
      children,
    );
  }

  Component _buildSeparator() {
    if (props.customSeparator != null) {
      return props.customSeparator!;
    }

    final String separator = switch (props.separator) {
      BreadcrumbSeparatorStyle.slash => '/',
      BreadcrumbSeparatorStyle.chevron =>
        '\u203A',
      BreadcrumbSeparatorStyle.arrow => '\u2192',
      BreadcrumbSeparatorStyle.dot => '\u2022',
    };

    return dom.span(
      classes: 'neubrutalism-breadcrumb-separator neubrutalism-breadcrumbs-separator',
      styles: const dom.Styles(
        raw: {
          'color': 'var(--foreground)',
          'opacity': '0.6',
          'font-weight': '900',
          'user-select': 'none',
        },
      ),
      [Component.text(separator)],
    );
  }
}
