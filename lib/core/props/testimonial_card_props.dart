/// Props for testimonial card component.
class TestimonialCardProps {
  /// The testimonial quote text
  final String quote;

  /// Author name
  final String authorName;

  /// Author title/role
  final String? authorTitle;

  /// Author company
  final String? authorCompany;

  /// Author avatar URL
  final String? avatarUrl;

  /// Star rating (0-5, null to hide)
  final int? rating;

  /// Whether to show quotation marks
  final bool showQuotes;

  const TestimonialCardProps({
    required this.quote,
    required this.authorName,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.rating,
    this.showQuotes = true,
  });
}

/// Props for simple rating stars component.
class RatingStarsSimpleProps {
  /// Rating value (0-5)
  final double rating;

  /// Maximum stars
  final int maxStars;

  /// Star size
  final double size;

  /// Whether the rating is interactive
  final bool interactive;

  /// Callback when rating changes (for interactive mode)
  final void Function(int)? onRatingChanged;

  const RatingStarsSimpleProps({
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.interactive = false,
    this.onRatingChanged,
  });
}
