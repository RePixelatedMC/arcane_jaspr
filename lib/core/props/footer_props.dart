import 'package:jaspr/jaspr.dart';

/// A footer link group
class FooterLinkGroup {
  final String title;
  final List<FooterLink> links;

  const FooterLinkGroup({
    required this.title,
    required this.links,
  });
}

/// A footer link
class FooterLink {
  final String label;
  final String? href;
  final void Function()? onTap;
  final bool external;

  /// Optional icon before the label
  final String? icon;

  const FooterLink({
    required this.label,
    this.href,
    this.onTap,
    this.external = false,
    this.icon,
  });
}

/// Properties for footer components.
class FooterProps {
  /// Logo component
  final Component? logo;

  /// Description/tagline
  final String? description;

  /// Link groups (columns)
  final List<FooterLinkGroup> linkGroups;

  /// Social media icons/links
  final List<Component>? socialLinks;

  /// Copyright text
  final String? copyright;

  /// Bottom links (privacy, terms, etc.)
  final List<FooterLink>? bottomLinks;

  /// Whether to show a newsletter form
  final bool showNewsletter;

  /// Newsletter placeholder
  final String newsletterPlaceholder;

  /// Newsletter submit text
  final String newsletterButtonText;

  /// Newsletter callback
  final void Function(String)? onNewsletterSubmit;

  const FooterProps({
    this.logo,
    this.description,
    required this.linkGroups,
    this.socialLinks,
    this.copyright,
    this.bottomLinks,
    this.showNewsletter = false,
    this.newsletterPlaceholder = 'Enter your email',
    this.newsletterButtonText = 'Subscribe',
    this.onNewsletterSubmit,
  });
}

/// Properties for footer social icon components.
class FooterSocialIconProps {
  /// Icon component or text
  final Component icon;

  /// Link URL
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Aria label for accessibility
  final String label;

  const FooterSocialIconProps({
    required this.icon,
    required this.label,
    this.href,
    this.onTap,
  });
}
