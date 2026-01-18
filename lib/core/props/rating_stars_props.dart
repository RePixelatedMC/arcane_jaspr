import 'package:jaspr/jaspr.dart';

/// Rating stars component properties.
class RatingStarsProps {
  final double rating;
  final int totalStars;
  final String size;
  final String? filledColor;
  final String? emptyColor;
  final bool showValue;

  const RatingStarsProps({
    required this.rating,
    this.totalStars = 5,
    this.size = '20px',
    this.filledColor,
    this.emptyColor,
    this.showValue = false,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for rating stars components.
mixin RatingStarsRendererContract {
  Component ratingStars(RatingStarsProps props);
}
