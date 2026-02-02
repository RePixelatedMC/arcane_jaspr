import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/cta_card_props.dart';

/// A CTA (Call-to-Action) card component.
///
/// Displays a card with a dashed border, centered content with an icon,
/// title, description, and a call-to-action button. Used for "request"
/// cards, "suggest" cards, or any action-oriented card in a grid.
class ArcaneCTACard extends StatelessComponent {
  /// Icon to display at the top of the card.
  final Component? icon;

  /// Main title/heading text.
  final String title;

  /// Description text below the title.
  final String? description;

  /// CTA button text.
  final String ctaText;

  /// Link destination (for anchor-based CTAs).
  final String? href;

  /// Callback for click events.
  final void Function()? onTap;

  /// Custom height for the card.
  final String height;

  /// Animation delay in milliseconds for staggered grid animations.
  final int? animationDelayMs;

  /// Whether to show hover effects.
  final bool showHoverEffects;

  const ArcaneCTACard({
    this.icon,
    required this.title,
    this.description,
    required this.ctaText,
    this.href,
    this.onTap,
    this.height = '420px',
    this.animationDelayMs,
    this.showHoverEffects = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.ctaCard(CTACardProps(
      icon: icon,
      title: title,
      description: description,
      ctaText: ctaText,
      href: href,
      onTap: onTap,
      height: height,
      animationDelayMs: animationDelayMs,
      showHoverEffects: showHoverEffects,
    ));
  }
}
