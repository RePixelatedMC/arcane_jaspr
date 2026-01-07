import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/rating_stars_props.dart';

/// Star rating display component.
class ArcaneRatingStars extends StatelessComponent {
  final double rating;
  final int totalStars;
  final String size;
  final String? filledColor;
  final String? emptyColor;
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
