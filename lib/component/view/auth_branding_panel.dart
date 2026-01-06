import 'package:jaspr/jaspr.dart';

import '../../core/props/auth_branding_panel_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/auth_branding_panel_props.dart';

/// Branding panel content for split-screen auth layouts.
///
/// Displays logo, tagline, feature list, and optional testimonial
/// with a dark gaming-themed design.
class AuthBrandingPanel extends StatelessComponent {
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

  const AuthBrandingPanel({
    super.key,
    this.logoUrl,
    required this.tagline,
    this.description,
    this.features,
    this.testimonialQuote,
    this.testimonialAuthor,
    this.testimonialTitle,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.authBrandingPanel(AuthBrandingPanelProps(
      logoUrl: logoUrl,
      tagline: tagline,
      description: description,
      features: features,
      testimonialQuote: testimonialQuote,
      testimonialAuthor: testimonialAuthor,
      testimonialTitle: testimonialTitle,
    ));
  }
}
