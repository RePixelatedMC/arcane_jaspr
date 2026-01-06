import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/footer_props.dart';

/// A footer link group (re-export from props for convenience)
typedef ArcaneFooterLinkGroup = FooterLinkGroup;

/// A footer link (re-export from props for convenience)
typedef ArcaneFooterLink = FooterLink;

/// A website footer component (Supabase-style)
class ArcaneFooter extends StatelessComponent {
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

  const ArcaneFooter({
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
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.footer(FooterProps(
      logo: logo,
      description: description,
      linkGroups: linkGroups,
      socialLinks: socialLinks,
      copyright: copyright,
      bottomLinks: bottomLinks,
      showNewsletter: showNewsletter,
      newsletterPlaceholder: newsletterPlaceholder,
      newsletterButtonText: newsletterButtonText,
      onNewsletterSubmit: onNewsletterSubmit,
    ));
  }
}

/// Social icon link component
class ArcaneSocialIcon extends StatelessComponent {
  /// Icon component or text
  final Component icon;

  /// Link URL
  final String? href;

  /// Click handler
  final void Function()? onTap;

  /// Aria label for accessibility
  final String label;

  const ArcaneSocialIcon({
    required this.icon,
    required this.label,
    this.href,
    this.onTap,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.footerSocialIcon(FooterSocialIconProps(
      icon: icon,
      label: label,
      href: href,
      onTap: onTap,
    ));
  }
}
