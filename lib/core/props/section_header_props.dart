enum SectionHeaderAlign {
  left,
  center,
  right,
}

/// Section header component properties.
class SectionHeaderProps {
  final String? label;
  final String heading;
  final String? description;
  final SectionHeaderAlign align;
  final String? descriptionMaxWidth;
  final String? marginBottom;
  final String? labelColor;
  final String? headingColor;
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
