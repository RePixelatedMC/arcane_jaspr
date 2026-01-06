import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Divider style variants
enum DividerVariant {
  standard,
  subtle,
  bold,
}

/// A horizontal divider component
///
/// ```dart
/// ArcaneDivider(
///   variant: DividerVariant.subtle,
/// )
/// ```
class ArcaneDivider extends StatelessComponent {
  /// Vertical margin
  final double? margin;

  /// Style variant
  final DividerVariant variant;

  /// Optional label in the middle
  final String? label;

  /// Whether to use a dashed style
  final bool dashed;

  const ArcaneDivider({
    this.margin,
    this.variant = DividerVariant.standard,
    this.label,
    this.dashed = false,
    super.key,
  });

  /// Standard divider
  const ArcaneDivider.standard({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.standard;

  /// Subtle divider
  const ArcaneDivider.subtle({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.subtle;

  /// Bold divider
  const ArcaneDivider.bold({
    this.margin,
    this.label,
    this.dashed = false,
    super.key,
  }) : variant = DividerVariant.bold;

  (String height, String color) get _variantStyles => switch (variant) {
        DividerVariant.standard => ('1px', 'var(--border)'),
        DividerVariant.subtle => ('1px', 'var(--muted)'),
        DividerVariant.bold => ('2px', 'var(--border)'),
      };

  @override
  Component build(BuildContext context) {
    final effectiveMargin = margin ?? 16;
    final (height, color) = _variantStyles;

    if (label != null) {
      return div(
        classes: 'arcane-divider with-label',
        styles: Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'margin': '${effectiveMargin}px 0',
        }),
        [
          div(
            styles: Styles(raw: {
              'flex': '1',
              'height': height,
              'background-color': color,
              if (dashed)
                'background':
                    'repeating-linear-gradient(to right, $color 0, $color 4px, transparent 4px, transparent 8px)',
            }),
            [],
          ),
          span(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'white-space': 'nowrap',
            }),
            [text(label!)],
          ),
          div(
            styles: Styles(raw: {
              'flex': '1',
              'height': height,
              'background-color': color,
              if (dashed)
                'background':
                    'repeating-linear-gradient(to right, $color 0, $color 4px, transparent 4px, transparent 8px)',
            }),
            [],
          ),
        ],
      );
    }

    return hr(
      classes: 'arcane-divider',
      styles: Styles(raw: {
        'margin': '${effectiveMargin}px 0',
        'border': 'none',
        'height': height,
        'background-color': color,
        if (dashed)
          'background':
              'repeating-linear-gradient(to right, $color 0, $color 4px, transparent 4px, transparent 8px)',
      }),
    );
  }
}

/// A vertical divider component
class ArcaneVerticalDivider extends StatelessComponent {
  /// Horizontal margin
  final double? margin;

  /// Style variant
  final DividerVariant variant;

  /// Height (null for full height)
  final double? height;

  const ArcaneVerticalDivider({
    this.margin,
    this.variant = DividerVariant.standard,
    this.height,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final effectiveMargin = margin ?? 16;
    final (width, color) = switch (variant) {
      DividerVariant.standard => ('1px', 'var(--border)'),
      DividerVariant.subtle => ('1px', 'var(--muted)'),
      DividerVariant.bold => ('2px', 'var(--border)'),
    };

    return div(
      classes: 'arcane-divider-vertical',
      styles: Styles(raw: {
        'width': width,
        'margin': '0 ${effectiveMargin}px',
        'background-color': color,
        if (height != null) 'height': '${height}px' else 'align-self': 'stretch',
      }),
      [],
    );
  }
}
