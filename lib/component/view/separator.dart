import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

/// A visual separator/divider component.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/separator
///
/// Creates a horizontal or vertical line to separate content.
///
/// Usage:
/// ```dart
/// ArcaneSeparator()
/// ArcaneSeparator.vertical()
/// ArcaneSeparator(label: 'OR')
/// ```
class ArcaneSeparator extends StatelessComponent {
  /// Orientation of the separator
  final SeparatorOrientation orientation;

  /// Optional label text in the middle
  final String? label;

  /// Optional icon in the middle
  final Component? icon;

  /// Custom color (overrides default)
  final String? color;

  /// Whether to use decorative role (no semantic meaning)
  final bool decorative;

  const ArcaneSeparator({
    this.orientation = SeparatorOrientation.horizontal,
    this.label,
    this.icon,
    this.color,
    this.decorative = true,
    super.key,
  });

  /// Creates a vertical separator
  const ArcaneSeparator.vertical({
    this.color,
    this.decorative = true,
    super.key,
  })  : orientation = SeparatorOrientation.vertical,
        label = null,
        icon = null;

  /// Creates a separator with a label
  const ArcaneSeparator.withLabel({
    required String this.label,
    this.color,
    this.decorative = false,
    super.key,
  })  : orientation = SeparatorOrientation.horizontal,
        icon = null;

  /// Creates a separator with an icon
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
