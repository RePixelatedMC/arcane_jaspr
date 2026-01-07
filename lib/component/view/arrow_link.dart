import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/arrow_link_props.dart';

/// A simple inline text link with an arrow icon.
class ArcaneArrowLink extends StatelessComponent {
  final String label;
  final String? href;
  final void Function()? onTap;
  final ArrowLinkSize size;
  final bool showArrow;
  final bool arrowBefore;
  final bool accent;

  const ArcaneArrowLink({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    this.accent = true,
    super.key,
  });

  const ArcaneArrowLink.accent({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    super.key,
  }) : accent = true;

  const ArcaneArrowLink.muted({
    required this.label,
    this.href,
    this.onTap,
    this.size = ArrowLinkSize.sm,
    this.showArrow = true,
    this.arrowBefore = false,
    super.key,
  }) : accent = false;

  @override
  Component build(BuildContext context) {
    return context.renderers.arrowLink(ArrowLinkProps(
      label: label,
      href: href,
      size: size,
      showArrow: showArrow,
      arrowBefore: arrowBefore,
      accent: accent,
      onTap: onTap,
    ));
  }
}
