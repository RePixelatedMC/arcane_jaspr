import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// A visual separator/divider component.
class ArcaneSeparator extends StatelessComponent {
  final SeparatorOrientation orientation;
  final String? label;
  final Component? icon;
  final String? color;
  final bool decorative;

  const ArcaneSeparator({
    this.orientation = SeparatorOrientation.horizontal,
    this.label,
    this.icon,
    this.color,
    this.decorative = true,
    super.key,
  });

  const ArcaneSeparator.vertical({
    this.color,
    this.decorative = true,
    super.key,
  })  : orientation = SeparatorOrientation.vertical,
        label = null,
        icon = null;

  const ArcaneSeparator.withLabel({
    required String this.label,
    this.color,
    this.decorative = false,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        icon = null;

  const ArcaneSeparator.withIcon({
    required Component this.icon,
    this.color,
    this.decorative = false,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        label = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.separator(SeparatorProps(
      orientation: orientation,
      label: label,
      icon: icon,
      color: color,
      decorative: decorative,
    ));
  }
}
