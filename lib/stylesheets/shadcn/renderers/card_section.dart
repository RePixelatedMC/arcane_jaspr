import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/card_section_props.dart';

/// ShadCN Card Section renderer.
class ShadcnCardSection extends StatelessComponent {
  final CardSectionProps props;

  const ShadcnCardSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveGap = props.gap ?? '0.75rem';

    final Component? headerWidget = props.headerComponent ??
        (props.header != null
            ? dom.div(
                classes: 'arcane-card-section-header',
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'space-between',
                  'gap': 'var(--arcane-space-4)',
                  'margin-bottom': effectiveGap,
                }),
                [
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--arcane-font-size-sm)',
                      'font-weight': 'var(--arcane-font-weight-semibold)',
                      'color': 'var(--muted-foreground)',
                      'text-transform': 'uppercase',
                      'letter-spacing': '0.05em',
                    }),
                    [Component.text(props.header!)],
                  ),
                  if (props.trailing != null && props.trailing!.isNotEmpty)
                    dom.div(
                      styles: const dom.Styles(raw: {
                        'display': 'flex',
                        'gap': 'var(--arcane-space-2)',
                      }),
                      props.trailing!,
                    ),
                ],
              )
            : null);

    return dom.div(
      classes: 'arcane-card-section',
      styles: dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border-radius': props.radius ?? 'var(--radius)',
        'border': '1px solid var(--border)',
        'padding': props.padding ?? '1rem',
      }),
      [
        if (headerWidget != null) headerWidget,
        dom.div(
          classes: 'arcane-card-section-content',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': effectiveGap,
          }),
          props.children,
        ),
      ],
    );
  }
}

/// ShadCN List Card renderer.
class ShadcnListCard extends StatelessComponent {
  final ListCardProps props;

  const ShadcnListCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-list-card',
      styles: dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border-radius': props.radius ?? 'var(--radius)',
        'border': '1px solid var(--border)',
        'overflow': 'hidden',
      }),
      [
        if (props.header != null)
          dom.div(
            classes: 'arcane-list-card-header',
            styles: const dom.Styles(raw: {
              'padding': '1rem 1.5rem',
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': 'var(--arcane-font-weight-semibold)',
              'color': 'var(--muted-foreground)',
              'border-bottom': '1px solid var(--border)',
              'background-color': 'var(--muted)',
            }),
            [Component.text(props.header!)],
          ),
        for (var i = 0; i < props.children.length; i++) ...[
          props.children[i],
          if (props.divided && i < props.children.length - 1)
            const dom.div(
              styles: dom.Styles(raw: {
                'height': '1px',
                'background-color': 'var(--border)',
                'margin': '0 1.5rem',
              }),
              [],
            ),
        ],
      ],
    );
  }
}