import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/breadcrumbs_props.dart';

/// ShadCN-style breadcrumbs component
/// Reference: https://ui.shadcn.com/docs/components/breadcrumb
class ShadcnBreadcrumbs extends StatelessComponent {
  final BreadcrumbsProps props;

  const ShadcnBreadcrumbs(this.props, {super.key});

  String get _separatorText => switch (props.separator) {
        BreadcrumbSeparatorStyle.slash => '/',
        BreadcrumbSeparatorStyle.chevron => '\u{203A}', // Single right-pointing angle quotation mark
        BreadcrumbSeparatorStyle.arrow => '\u{2192}', // Right arrow
        BreadcrumbSeparatorStyle.dot => '\u{2022}', // Bullet
      };

  (String fontSize, String gap, String padding) get _sizeStyles =>
      switch (props.size) {
        BreadcrumbSizeVariant.sm => ('12px', '4px', '2px 4px'),
        BreadcrumbSizeVariant.md => ('14px', '8px', '4px 8px'),
        BreadcrumbSizeVariant.lg => ('16px', '16px', '6px 12px'),
      };

  @override
  Component build(BuildContext context) {
    final (fontSize, gap, _) = _sizeStyles;

    // ShadCN Breadcrumb
    return dom.nav(
      classes: 'arcane-breadcrumb',
      attributes: {'aria-label': 'Breadcrumb'},
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
      }),
      [
        // ShadCN BreadcrumbList
        dom.ol(
          classes: 'arcane-breadcrumb-list',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': '6px',
            'list-style': 'none',
            'margin': '0',
            'padding': '0',
            'font-size': fontSize,
            'color': 'var(--muted-foreground)',
            'word-break': 'break-word',
          }),
          [
            for (var i = 0; i < props.items.length; i++) ...[
              // ShadCN BreadcrumbItem
              dom.li(
                classes: 'arcane-breadcrumb-item',
                styles: const dom.Styles(raw: {
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'gap': '6px',
                }),
                [
                  _buildBreadcrumbItem(
                      props.items[i], i, i == props.items.length - 1),
                ],
              ),
              // ShadCN BreadcrumbSeparator
              if (i < props.items.length - 1)
                dom.li(
                  classes: 'arcane-breadcrumb-separator',
                  attributes: {
                    'role': 'presentation',
                    'aria-hidden': 'true',
                  },
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'color': 'var(--muted-foreground)',
                    'user-select': 'none',
                  }),
                  [props.customSeparator ?? Component.text(_separatorText)],
                ),
            ],
          ],
        ),
      ],
    );
  }

  Component _buildBreadcrumbItem(
      BreadcrumbItemProps item, int index, bool isLast) {
    final content = dom.span(
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--space-1)',
      }),
      [
        if (item.icon != null) item.icon!,
        if (props.showHomeIcon && index == 0 && item.icon == null)
          const dom.span(
            styles: dom.Styles(raw: {'font-size': '1.1em'}),
            [Component.text('\u{2302}')], // Home symbol
          ),
        Component.text(item.label),
      ],
    );

    if (isLast || item.href == null) {
      // ShadCN BreadcrumbPage
      return dom.span(
        classes: 'arcane-breadcrumb-page',
        attributes: {'aria-current': 'page'},
        styles: const dom.Styles(raw: {
          'color': 'var(--foreground)',
          'font-weight': 'var(--font-weight-normal)',
        }),
        [content],
      );
    }

    // ShadCN BreadcrumbLink
    return dom.a(
      classes: 'arcane-breadcrumb-link',
      href: item.href!,
      styles: const dom.Styles(raw: {
        'color': 'var(--muted-foreground)',
        'text-decoration': 'none',
        'transition': 'color var(--transition)',
      }),
      events: props.onItemClick != null
          ? {
              'click': (event) {
                props.onItemClick!(item, index);
              }
            }
          : null,
      [content],
    );
  }
}