import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/section_header_props.dart';

/// A reusable section header with label, heading, and description.
class ArcaneSectionHeader extends StatelessComponent {
  final String? label;
  final String heading;
  final String? description;
  final SectionHeaderAlign align;
  final String? descriptionMaxWidth;
  final String? marginBottom;
  final String? labelColor;
  final String? headingColor;
  final String? descriptionColor;

  const ArcaneSectionHeader({
    this.label,
    required this.heading,
    this.description,
    this.align = SectionHeaderAlign.center,
    this.descriptionMaxWidth,
    this.marginBottom,
    this.labelColor,
    this.headingColor,
    this.descriptionColor,
    super.key,
  });

  const ArcaneSectionHeader.left({
    this.label,
    required this.heading,
    this.description,
    this.descriptionMaxWidth,
    this.marginBottom,
    this.labelColor,
    this.headingColor,
    this.descriptionColor,
    super.key,
  }) : align = SectionHeaderAlign.left;

  const ArcaneSectionHeader.center({
    this.label,
    required this.heading,
    this.description,
    this.descriptionMaxWidth,
    this.marginBottom,
    this.labelColor,
    this.headingColor,
    this.descriptionColor,
    super.key,
  }) : align = SectionHeaderAlign.center;

  @override
  Component build(BuildContext context) {
    return context.renderers.sectionHeader(SectionHeaderProps(
      label: label,
      heading: heading,
      description: description,
      align: align,
      descriptionMaxWidth: descriptionMaxWidth,
      marginBottom: marginBottom,
      labelColor: labelColor,
      headingColor: headingColor,
      descriptionColor: descriptionColor,
    ));
  }
}
