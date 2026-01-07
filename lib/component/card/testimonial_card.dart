import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/testimonial_card_props.dart';

/// A testimonial/quote card component (Supabase-style)
class ArcaneTestimonialCard extends StatelessComponent {
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

  const ArcaneTestimonialCard({
    required this.quote,
    required this.authorName,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.rating,
    this.showQuotes = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.testimonialCard(TestimonialCardProps(
      quote: quote,
      authorName: authorName,
      authorTitle: authorTitle,
      authorCompany: authorCompany,
      avatarUrl: avatarUrl,
      rating: rating,
      showQuotes: showQuotes,
    ));
  }
}

/// Rating stars component
class ArcaneRatingStarsSimple extends StatelessComponent {
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

  const ArcaneRatingStarsSimple({
    required this.rating,
    this.maxStars = 5,
    this.size = 16,
    this.interactive = false,
    this.onRatingChanged,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.ratingStarsSimple(RatingStarsSimpleProps(
      rating: rating,
      maxStars: maxStars,
      size: size,
      interactive: interactive,
      onRatingChanged: onRatingChanged,
    ));
  }
}
