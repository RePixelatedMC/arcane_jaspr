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
        'gap': 'var(--space-4)',
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
                  'background': props.iconBackground ?? 'color-mix(in srgb, var(--primary) 10%, transparent)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': 'var(--font-size-lg)',
                }),
                [Component.text(props.icon!)],
              ),
            if (props.trend != null)
              dom.div(
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': 'var(--space-1)',
                  'padding': '0.25rem 0.5rem',
                  'border-radius': 'var(--radius)',
                  'background': props.trendPositive
                      ? 'color-mix(in srgb, var(--success) 10%, transparent)'
                      : 'color-mix(in srgb, var(--destructive) 10%, transparent)',
                  'color': props.trendPositive
                      ? 'var(--success)'
                      : 'var(--destructive)',
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-medium)',
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
              'font-weight': 'var(--font-weight-bold)',
              'color': 'var(--foreground)',
              'line-height': '1.2',
            }),
            [Component.text(props.value)],
          ),
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.25rem',
            }),
            [Component.text(props.label)],
          ),
        ]),
        if (props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
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
