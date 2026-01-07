import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/footer_column_props.dart';

/// Renders a Codex footer column with title and links.
Component renderFooterColumn(FooterColumnProps props) {
  final effectiveTitleColor = props.titleColor ?? 'var(--foreground)';
  final effectiveLinkColor = props.linkColor ?? 'var(--muted-foreground)';
  final effectiveLinkGap = props.linkGap ?? '0.75rem';

  return dom.div(
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'flex-start',
    }),
    [
      // Title
      dom.h4(
        styles: dom.Styles(raw: {
          'font-family': 'ui-sans-serif, system-ui, sans-serif',
          'font-size': '0.875rem',
          'font-weight': '600',
          'color': effectiveTitleColor,
          'text-transform': 'uppercase',
          'letter-spacing': '0.05em',
          'margin': '0 0 1.25rem 0',
        }),
        [Component.text(props.title)],
      ),
      // Links
      ...props.links.map((link) => dom.a(
            href: link.href ?? '#',
            styles: dom.Styles(raw: {
              'display': 'block',
              'font-size': '0.875rem',
              'color': effectiveLinkColor,
              'text-decoration': 'none',
              'margin-bottom': effectiveLinkGap,
              'transition': 'color 150ms ease',
            }),
            [
              if (link.icon != null) ...[
                dom.span([Component.text(link.icon!)]),
                const Component.text(' '),
              ],
              Component.text(link.label),
            ],
          )),
    ],
  );
}

/// Renders a Codex footer brand column with logo and description.
Component renderFooterBrandColumn(FooterBrandColumnProps props) {
  return dom.div(
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'flex-start',
    }),
    [
      // Logo
      dom.div(
        styles: const dom.Styles(raw: {
          'margin-bottom': '1.25rem',
        }),
        [props.logo],
      ),
      // Description
      if (props.description != null)
        dom.p(
          styles: dom.Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
            'line-height': '1.6',
            'margin': '0 0 1.25rem 0',
            'max-width': props.descriptionMaxWidth ?? '300px',
          }),
          [Component.text(props.description!)],
        ),
      // Bottom content
      if (props.bottomContent != null) props.bottomContent!,
    ],
  );
}
