/// Testimonial card component properties.
class TestimonialCardProps {
  final String quote;
  final String authorName;
  final String? authorTitle;
  final String? authorCompany;
  final String? avatarUrl;
  final int? rating;
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

/// Simple rating stars component properties.
class RatingStarsSimpleProps {
  final double rating;
  final int maxStars;
  final double size;
  final bool interactive;
  final void Function(int)? onRatingChanged;

  const RatingStarsSimpleProps({
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.interactive = false,
    this.onRatingChanged,
  });
}
