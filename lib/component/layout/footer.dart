import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/footer_props.dart';

typedef ArcaneFooterLinkGroup = FooterLinkGroup;
typedef ArcaneFooterLink = FooterLink;

/// A website footer component.
class ArcaneFooter extends StatelessComponent {
  final Component? logo;
  final String? description;
  final List<FooterLinkGroup> linkGroups;
  final List<Component>? socialLinks;
  final String? copyright;
  final List<FooterLink>? bottomLinks;
  final bool showNewsletter;
  final String newsletterPlaceholder;
  final String newsletterButtonText;
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

/// Social icon link component.
class ArcaneSocialIcon extends StatelessComponent {
  final Component icon;
  final String? href;
  final void Function()? onTap;
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
