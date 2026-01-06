import 'package:jaspr/jaspr.dart';

import '../../core/props/rating_stars_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/rating_stars_props.dart';

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
    return context.renderers.ratingStars(RatingStarsProps(
      rating: rating,
      totalStars: totalStars,
      size: size,
      filledColor: filledColor,
      emptyColor: emptyColor,
      showValue: showValue,
    ));
  }
}
