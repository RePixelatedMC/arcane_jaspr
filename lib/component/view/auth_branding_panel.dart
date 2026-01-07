import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/auth_branding_panel_props.dart';

/// Branding panel content for split-screen auth layouts.
class AuthBrandingPanel extends StatelessComponent {
  final String? logoUrl;
  final String tagline;
  final String? description;
  final List<String>? features;
  final String? testimonialQuote;
  final String? testimonialAuthor;
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
