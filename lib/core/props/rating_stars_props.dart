/// Properties for rating stars components.
class RatingStarsProps {
  /// Rating value (0.0 to totalStars)
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

  const RatingStarsProps({
    required this.rating,
    this.totalStars = 5,
    this.size = '20px',
    this.filledColor,
    this.emptyColor,
    this.showValue = false,
  });
}
