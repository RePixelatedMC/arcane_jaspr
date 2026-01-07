import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/cta_banner_props.dart';

/// Call-to-action banner with gradient background.
class ArcaneCtaBanner extends StatelessComponent {
  final String title;
  final String? subtitle;
  final Component? primaryAction;
  final Component? secondaryAction;
  final String? gradientStart;
  final String? gradientEnd;
  final String? backgroundImage;

  const ArcaneCtaBanner({
    required this.title,
    this.subtitle,
    this.primaryAction,
    this.secondaryAction,
    this.gradientStart,
    this.gradientEnd,
    this.backgroundImage,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.ctaBanner(CtaBannerProps(
      title: title,
      subtitle: subtitle,
      primaryAction: primaryAction,
      secondaryAction: secondaryAction,
      gradientStart: gradientStart,
      gradientEnd: gradientEnd,
      backgroundImage: backgroundImage,
    ));
  }
}
