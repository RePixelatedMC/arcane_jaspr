import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Animated counter display for statistics
class ArcaneAnimatedCounter extends StatelessComponent {
  /// The value to display
  final String value;

  /// Prefix (e.g., "$")
  final String? prefix;

  /// Suffix (e.g., "+", "%")
  final String? suffix;

  /// Label text
  final String? label;

  /// Font size
  final String fontSize;

  /// Custom color
  final String? color;

  /// Gradient start color (use with gradientEnd)
  final String? gradientStart;

  /// Gradient end color (use with gradientStart)
  final String? gradientEnd;

  const ArcaneAnimatedCounter({
    required this.value,
    this.prefix,
    this.suffix,
    this.label,
    this.fontSize = '48px',
    this.color,
    this.gradientStart,
    this.gradientEnd,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final bool hasGradient = gradientStart != null && gradientEnd != null;

    return div(
      classes: 'arcane-animated-counter',
      styles: const Styles(raw: {
        'text-align': 'center',
      }),
      [
        div(
          styles: Styles(raw: {
            'font-size': fontSize,
            'font-weight': '700',
            'color': hasGradient ? 'transparent' : (color ?? 'var(--foreground)'),
            'background': hasGradient
                ? 'linear-gradient(135deg, $gradientStart 0%, $gradientEnd 100%)'
                : 'none',
            '-webkit-background-clip': hasGradient ? 'text' : 'none',
            'background-clip': hasGradient ? 'text' : 'none',
            'line-height': '1.1',
          }),
          [
            if (prefix != null)
              span(
                styles: Styles(raw: {'font-size': 'calc($fontSize * 0.6)'}),
                [text(prefix!)],
              ),
            text(value),
            if (suffix != null)
              span(
                styles: Styles(raw: {'font-size': 'calc($fontSize * 0.6)'}),
                [text(suffix!)],
              ),
          ],
        ),
        if (label != null)
          div(
            styles: const Styles(raw: {
              'font-size': '1rem',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.5rem',
            }),
            [text(label!)],
          ),
      ],
    );
  }
}

/// Counter row for displaying multiple stats
class ArcaneCounterRow extends StatelessComponent {
  /// Counters to display
  final List<ArcaneAnimatedCounter> counters;

  /// Gap between counters
  final String gap;

  const ArcaneCounterRow({
    required this.counters,
    this.gap = '48px',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-counter-row',
      styles: Styles(raw: {
        'display': 'flex',
        'justify-content': 'center',
        'align-items': 'flex-start',
        'gap': gap,
        'flex-wrap': 'wrap',
      }),
      counters,
    );
  }
}

/// A metric display with label
class ArcaneMetricDisplay extends StatelessComponent {
  /// Metric value
  final String value;

  /// Metric label
  final String label;

  /// Optional icon
  final String? icon;

  /// Optional trend indicator
  final String? trend;

  /// Whether trend is positive
  final bool trendPositive;

  const ArcaneMetricDisplay({
    required this.value,
    required this.label,
    this.icon,
    this.trend,
    this.trendPositive = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-metric-display',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'gap': '0.5rem',
      }),
      [
        if (icon != null)
          div(
            styles: const Styles(raw: {
              'font-size': '1.5rem',
              'color': 'var(--accent)',
              'margin-bottom': '0.25rem',
            }),
            [text(icon!)],
          ),
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'baseline',
            'gap': '0.5rem',
          }),
          [
            span(
              styles: const Styles(raw: {
                'font-size': '1.875rem',
                'font-weight': '700',
                'color': 'var(--foreground)',
              }),
              [text(value)],
            ),
            if (trend != null)
              span(
                styles: Styles(raw: {
                  'font-size': '0.875rem',
                  'font-weight': '500',
                  'color': trendPositive ? 'hsl(142 76% 36%)' : 'var(--destructive)',
                }),
                [text('${trendPositive ? '↑' : '↓'}$trend')],
              ),
          ],
        ),
        div(
          styles: const Styles(raw: {
            'font-size': '0.875rem',
            'color': 'var(--muted-foreground)',
          }),
          [text(label)],
        ),
      ],
    );
  }
}
