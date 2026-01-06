import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Text alignment for section header
enum SectionHeaderAlign {
  left,
  center,
  right,
}

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
    final textAlign = _getTextAlign();
    final effectiveDescriptionMaxWidth = descriptionMaxWidth ?? '640px';
    final effectiveMarginBottom = marginBottom ?? '3rem';

    return div(
      styles: Styles(raw: {
        'text-align': textAlign,
        'margin-bottom': effectiveMarginBottom,
      }),
      [
        // Label
        if (label != null)
          span(
            styles: Styles(raw: {
              'display': 'inline-block',
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': labelColor ?? 'var(--accent)',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'margin-bottom': '1rem',
            }),
            [text(label!)],
          ),
        // Heading
        h2(
          styles: Styles(raw: {
            'font-family': 'ui-sans-serif, system-ui, sans-serif',
            'font-size': '2.25rem',
            'font-weight': '700',
            'color': headingColor ?? 'var(--foreground)',
            'margin': '0 0 1rem 0',
            'line-height': '1.2',
          }),
          [text(heading)],
        ),
        // Description
        if (description != null)
          p(
            styles: Styles(raw: {
              'font-size': '1.125rem',
              'color': descriptionColor ?? 'var(--muted-foreground)',
              'max-width': effectiveDescriptionMaxWidth,
              'margin': align == SectionHeaderAlign.center ? '0 auto' : '0',
              'line-height': '1.6',
            }),
            [text(description!)],
          ),
      ],
    );
  }

  String _getTextAlign() {
    switch (align) {
      case SectionHeaderAlign.left:
        return 'left';
      case SectionHeaderAlign.center:
        return 'center';
      case SectionHeaderAlign.right:
        return 'right';
    }
  }
}
