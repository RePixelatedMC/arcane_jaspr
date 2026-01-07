/// Auth branding panel component properties.
class AuthBrandingPanelProps {
  final String? logoUrl;
  final String tagline;
  final String? description;
  final List<String>? features;
  final String? testimonialQuote;
  final String? testimonialAuthor;
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
