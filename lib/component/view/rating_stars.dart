import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Star rating display component
class ArcaneRatingStars extends StatelessComponent {
  /// Rating value (0.0 to 5.0)
  final double rating;

  /// Total number of stars
  final int totalStars;

  /// Star size
  final String size;

  /// Color when filled
  final String? filledColor;

  /// Color when empty
  final String? emptyColor;

  /// Whether to show the numeric value
  final bool showValue;

  const ArcaneRatingStars({
    required this.rating,
    this.totalStars = 5,
    this.size = '20px',
    this.filledColor,
    this.emptyColor,
    this.showValue = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final String effectiveFilledColor = filledColor ?? 'hsl(38 92% 50%)';
    final String effectiveEmptyColor = emptyColor ?? 'var(--muted)';

    return div(
      classes: 'arcane-rating-stars',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.25rem',
      }),
      [
        for (var i = 0; i < totalStars; i++) _buildStar(i, effectiveFilledColor, effectiveEmptyColor),
        if (showValue)
          span(
            styles: const Styles(raw: {
              'margin-left': '0.5rem',
              'color': 'var(--foreground)',
              'font-weight': '600',
              'font-size': '0.875rem',
            }),
            [text(rating.toStringAsFixed(1))],
          ),
      ],
    );
  }

  Component _buildStar(int index, String filledColor, String emptyColor) {
    final double fill = rating - index;
    String color;
    if (fill >= 1) {
      color = filledColor;
    } else if (fill > 0) {
      // Partial fill - use gradient
      color = filledColor;
    } else {
      color = emptyColor;
    }

    return span(
      styles: Styles(raw: {
        'font-size': size,
        'color': color,
        'line-height': '1',
      }),
      [text('★')],
    );
  }
}
