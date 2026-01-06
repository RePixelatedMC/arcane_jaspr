/// Text alignment for section header
enum SectionHeaderAlign {
  left,
  center,
  right,
}

/// Properties for section header components.
class SectionHeaderProps {
  /// Small uppercase label above the heading (optional)
  final String? label;

  /// Main heading text
  final String heading;

  /// Description text below the heading (optional)
  final String? description;

  /// Text alignment
  final SectionHeaderAlign align;

  /// Maximum width for description text
  final String? descriptionMaxWidth;

  /// Bottom margin for the header container
  final String? marginBottom;

  /// Custom label color (defaults to accent)
  final String? labelColor;

  /// Custom heading color (defaults to onBackground)
  final String? headingColor;

  /// Custom description color (defaults to muted)
  final String? descriptionColor;

  const SectionHeaderProps({
    this.label,
    required this.heading,
    this.description,
    this.align = SectionHeaderAlign.center,
    this.descriptionMaxWidth,
    this.marginBottom,
    this.labelColor,
    this.headingColor,
    this.descriptionColor,
  });
}
