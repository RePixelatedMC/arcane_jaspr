import 'package:jaspr/jaspr.dart';

enum SeparatorOrientation {
  horizontal,
  vertical,
}

/// Separator component properties.
class SeparatorProps {
  final SeparatorOrientation orientation;
  final String? label;
  final Component? icon;
  final String? color;
  final bool decorative;

  const SeparatorProps({
    this.orientation = SeparatorOrientation.horizontal,
    this.label,
    this.icon,
    this.color,
    this.decorative = true,
  });

  SeparatorProps copyWith({
    SeparatorOrientation? orientation,
    String? label,
    Component? icon,
    String? color,
    bool? decorative,
  }) {
    return SeparatorProps(
      orientation: orientation ?? this.orientation,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      decorative: decorative ?? this.decorative,
    );
  }
}
