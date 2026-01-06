import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/section_header_props.dart';

/// A reusable section header with label, heading, and description.
///
/// Common pattern for landing page sections with consistent styling:
/// - Uppercase label in accent color
/// - Large heading
/// - Muted description text
///
/// ```dart
/// ArcaneSectionHeader(
///   label: 'Features',
///   heading: 'Why Choose Us',
///   description: 'Discover what makes us different.',
/// )
/// ```
class ArcaneSectionHeader extends StatelessComponent {
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

  /// Create a left-aligned section header
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

  /// Create a center-aligned section header
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
