/// Props for the AuthBrandingPanel component.
class AuthBrandingPanelProps {
  /// URL to the logo image
  final String? logoUrl;

  /// Main tagline text
  final String tagline;

  /// Optional description text below tagline
  final String? description;

  /// List of feature highlights with checkmarks
  final List<String>? features;

  /// Optional testimonial quote
  final String? testimonialQuote;

  /// Optional testimonial author
  final String? testimonialAuthor;

  /// Optional testimonial author title/company
  final String? testimonialTitle;

  const AuthBrandingPanelProps({
    this.logoUrl,
    required this.tagline,
    this.description,
    this.features,
    this.testimonialQuote,
    this.testimonialAuthor,
    this.testimonialTitle,
  });
}
