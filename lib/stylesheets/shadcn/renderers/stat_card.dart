import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/stat_card_props.dart';

/// ShadCN Stat Card renderer.
class ShadcnStatCard extends StatelessComponent {
  final StatCardProps props;

  const ShadcnStatCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-stat-card',
      styles: const dom.Styles(raw: {
        'background': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'padding': '1.5rem',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1rem',
      }),
      [
        // Header with icon and trend
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'justify-content': 'space-between',
            'align-items': 'flex-start',
          }),
          [
            if (props.icon != null)
              dom.div(
                styles: dom.Styles(raw: {
                  'width': '40px',
                  'height': '40px',
                  'border-radius': 'var(--radius)',
                  'background': props.iconBackground ?? 'hsl(var(--primary) / 0.1)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': '1.125rem',
                }),
                [Component.text(props.icon!)],
              ),
            if (props.trend != null)
              dom.div(
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '0.25rem',
                  'padding': '0.25rem 0.5rem',
                  'border-radius': 'var(--radius)',
                  'background': props.trendPositive
                      ? 'hsl(142 76% 36% / 0.1)'
                      : 'hsl(var(--destructive) / 0.1)',
                  'color': props.trendPositive
                      ? 'hsl(142 76% 36%)'
                      : 'var(--destructive)',
                  'font-size': '0.75rem',
                  'font-weight': '500',
                }),
                [
                  Component.text(props.trendPositive ? '↑' : '↓'),
                  Component.text(props.trend!),
                ],
              ),
          ],
        ),
        // Value and label
        dom.div([
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '1.75rem',
              'font-weight': '700',
              'color': 'var(--foreground)',
              'line-height': '1.2',
            }),
            [Component.text(props.value)],
          ),
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.25rem',
            }),
            [Component.text(props.label)],
          ),
        ]),
        if (props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'padding-top': '0.75rem',
              'border-top': '1px solid var(--border)',
            }),
            [Component.text(props.description!)],
          ),
      ],
    );
  }
}

/// ShadCN Stat Card Row renderer.
class ShadcnStatCardRow extends StatelessComponent {
  final StatCardRowProps props;

  const ShadcnStatCardRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-stat-card-row',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat(${props.columns}, 1fr)',
        'gap': props.gap ?? '1.5rem',
      }),
      props.cards,
    );
  }
}
