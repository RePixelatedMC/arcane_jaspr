import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/breadcrumbs_props.dart';

/// Neon Breadcrumbs renderer.
///
/// Implements the Neon design language:
/// - Larger size options
/// - Accent-colored links
/// - More spacing between items
class NeonBreadcrumbs extends StatelessComponent {
  final BreadcrumbsProps props;

  const NeonBreadcrumbs(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Neon size-specific styles
    final (String fontSize, String gap) = switch (props.size) {
      BreadcrumbSizeVariant.sm => ('0.75rem', '0.5rem'),
      BreadcrumbSizeVariant.md => (
        '0.875rem',
        '0.625rem',
      ), // Neon: slightly more gap
      BreadcrumbSizeVariant.lg => ('1rem', '0.75rem'),
    };

    return dom.nav(
      classes: 'neon-breadcrumbs',
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
        const dom.span(
          styles: dom.Styles(raw: {'margin-right': '0.375rem'}),
          [Component.text('\u{1F3E0}')], // Home icon
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
        classes: 'neon-breadcrumb-link',
        styles: const dom.Styles(
          raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'color': 'var(--muted-foreground)',
            'text-decoration': 'none',
            'transition': 'color var(--transition)',
          },
        ),
        children,
      );
    }

    if (props.onItemClick != null && !isLast) {
      return dom.button(
        classes: 'neon-breadcrumb-button',
        styles: const dom.Styles(
          raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'background': 'transparent',
            'border': 'none',
            'padding': '0',
            'color': 'var(--muted-foreground)',
            'cursor': 'pointer',
            'transition': 'color var(--transition)',
          },
        ),
        events: {'click': (_) => props.onItemClick!(item, index)},
        children,
      );
    }

    // Last item or non-clickable
    return dom.span(
      classes: 'neon-breadcrumb-current',
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'color': isLast ? 'var(--foreground)' : 'var(--muted-foreground)',
          'font-weight': isLast ? '500' : '400',
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
        '\u203A', // Single right-pointing angle
      BreadcrumbSeparatorStyle.arrow => '\u2192', // Right arrow
      BreadcrumbSeparatorStyle.dot => '\u2022', // Bullet
    };

    return dom.span(
      classes: 'neon-breadcrumb-separator',
      styles: const dom.Styles(
        raw: {
          'color': 'var(--muted-foreground)',
          'opacity': '0.5',
          'user-select': 'none',
        },
      ),
      [Component.text(separator)],
    );
  }
}
