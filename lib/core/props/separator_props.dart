import 'package:jaspr/jaspr.dart';

/// Separator orientation.
enum SeparatorOrientation {
  /// Horizontal line (full width)
  horizontal,

  /// Vertical line (full height)
  vertical,
}

/// Properties for separator components.
class SeparatorProps {
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

  const SeparatorProps({
    this.orientation = SeparatorOrientation.horizontal,
    this.label,
    this.icon,
    this.color,
    this.decorative = true,
  });

  /// Create a copy with modified properties
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
