import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/testimonial_card_props.dart';

/// Testimonial/quote card with author attribution and optional rating.
class ArcaneTestimonialCard extends StatelessComponent {
  final String quote;
  final String authorName;
  final String? authorTitle;
  final String? authorCompany;
  final String? avatarUrl;
  final int? rating;
  final bool showQuotes;
  final bool showRatingBadge;
  final bool showAccentBorder;
  final String? accentColor;

  const ArcaneTestimonialCard({
    required this.quote,
    required this.authorName,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.rating,
    this.showQuotes = true,
    this.showRatingBadge = false,
    this.showAccentBorder = false,
    this.accentColor,
    super.key,
  });

  /// Creates a rating-styled testimonial card with accent border and rating badge.
  const ArcaneTestimonialCard.rated({
    required this.quote,
    required this.authorName,
    required this.rating,
    this.authorTitle,
    this.authorCompany,
    this.avatarUrl,
    this.showQuotes = true,
    this.accentColor,
    super.key,
  })  : showRatingBadge = true,
        showAccentBorder = true;

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
      showRatingBadge: showRatingBadge,
      showAccentBorder: showAccentBorder,
      accentColor: accentColor,
    ));
  }
}

/// Rating stars display component.
class ArcaneRatingStarsSimple extends StatelessComponent {
  final double rating;
  final int maxStars;
  final double size;
  final bool interactive;
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
