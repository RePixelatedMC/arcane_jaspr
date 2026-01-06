import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Stat card for displaying metrics with optional trend indicator
class ArcaneStatCard extends StatelessComponent {
  /// Label text
  final String label;

  /// Value to display
  final String value;

  /// Optional icon
  final String? icon;

  /// Trend value (e.g., "+12.5%")
  final String? trend;

  /// Whether the trend is positive
  final bool trendPositive;

  /// Additional description
  final String? description;

  /// Custom icon background
  final String? iconBackground;

  const ArcaneStatCard({
    required this.label,
    required this.value,
    this.icon,
    this.trend,
    this.trendPositive = true,
    this.description,
    this.iconBackground,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-stat-card',
      styles: const Styles(raw: {
        'background': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '0.5rem',
        'padding': '2rem',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1.5rem',
      }),
      [
        // Header with icon and trend
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'justify-content': 'space-between',
            'align-items': 'flex-start',
          }),
          [
            if (icon != null)
              div(
                styles: Styles(raw: {
                  'width': '48px',
                  'height': '48px',
                  'border-radius': '0.375rem',
                  'background': iconBackground ??
                      'linear-gradient(135deg, hsl(var(--accent) / 0.2) 0%, hsl(var(--accent) / 0.1) 100%)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'font-size': '1.25rem',
                }),
                [text(icon!)],
              ),
            if (trend != null)
              div(
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '0.25rem',
                  'padding': '0.25rem 0.5rem',
                  'border-radius': '0.25rem',
                  'background': trendPositive
                      ? 'hsl(142 76% 36% / 0.15)'
                      : 'hsl(var(--destructive) / 0.15)',
                  'color': trendPositive
                      ? 'hsl(142 76% 36%)'
                      : 'var(--destructive)',
                  'font-size': '0.875rem',
                  'font-weight': '500',
                }),
                [
                  text(trendPositive ? '↑' : '↓'),
                  text(trend!),
                ],
              ),
          ],
        ),
        // Value and label
        div([
          div(
            styles: const Styles(raw: {
              'font-size': '2rem',
              'font-weight': '700',
              'color': 'var(--foreground)',
              'line-height': '1.2',
            }),
            [text(value)],
          ),
          div(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.25rem',
            }),
            [text(label)],
          ),
        ]),
        if (description != null)
          div(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'padding-top': '1rem',
              'border-top': '1px solid var(--border)',
            }),
            [text(description!)],
          ),
      ],
    );
  }
}

/// A row of stat cards
class ArcaneStatCardRow extends StatelessComponent {
  /// Stat cards to display
  final List<ArcaneStatCard> cards;

  /// Number of columns
  final int columns;

  /// Gap between cards
  final double gap;

  const ArcaneStatCardRow({
    required this.cards,
    this.columns = 4,
    this.gap = 24,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-stat-card-row',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': 'repeat($columns, 1fr)',
        'gap': '${gap}px',
      }),
      cards,
    );
  }
}
