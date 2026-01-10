import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/stat_card_props.dart';

/// Codex Stat Card renderer.
class CodexStatCard extends StatelessComponent {
  final StatCardProps props;

  const CodexStatCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-stat-card',
      styles: const dom.Styles(raw: {
        'background': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'padding': '2rem',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1.25rem',
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
                  'width': '48px',
                  'height': '48px',
                  'border-radius': 'var(--radius)',
                  'background': props.iconBackground ?? 'rgba(var(--primary-rgb), 0.15)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': 'var(--font-size-xl)',
                }),
                [Component.text(props.icon!)],
              ),
            if (props.trend != null)
              dom.div(
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': 'var(--space-2)',
                  'padding': '0.375rem 0.75rem',
                  'border-radius': 'var(--radius)',
                  'background': props.trendPositive
                      ? 'rgba(var(--success-rgb, 22, 101, 52), 0.15)'
                      : 'rgba(var(--destructive-rgb, 153, 27, 27), 0.15)',
                  'color': props.trendPositive
                      ? 'var(--success)'
                      : 'var(--destructive)',
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-medium)',
                }),
                [
                  Component.text(props.trendPositive ? '\u2191' : '\u2193'),
                  Component.text(props.trend!),
                ],
              ),
          ],
        ),
        // Value and label
        dom.div([
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '2rem',
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
              'margin-top': '0.5rem',
            }),
            [Component.text(props.label)],
          ),
        ]),
        if (props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
              'padding-top': '1rem',
              'border-top': '1px solid var(--border)',
            }),
            [Component.text(props.description!)],
          ),
      ],
    );
  }
}

/// Codex Stat Card Row renderer.
class CodexStatCardRow extends StatelessComponent {
  final StatCardRowProps props;

  const CodexStatCardRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-stat-card-row',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat(${props.columns}, 1fr)',
        'gap': props.gap ?? '2rem',
      }),
      props.cards,
    );
  }
}
