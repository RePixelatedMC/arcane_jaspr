import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, FontStyle, StyleRule, Display, Position, Overflow, Cursor, Visibility, FlexWrap, WhiteSpace;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';
import '../../util/appearance/colors.dart';
import '../../util/style_types/index.dart';

/// A flexible flow layout component that wraps children.
class ArcaneFlow extends StatelessComponent {
  /// The child components
  final List<Component> children;

  /// Main axis alignment
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// Wrap alignment
  final WrapAlignment wrapAlignment;

  /// Gap between children
  final double gap;

  /// Row gap (overrides gap for rows)
  final double? rowGap;

  /// Column gap (overrides gap for columns)
  final double? columnGap;

  /// Whether to reverse the direction
  final bool reverse;

  const ArcaneFlow({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.wrapAlignment = WrapAlignment.start,
    this.gap = 8,
    this.rowGap,
    this.columnGap,
    this.reverse = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.flow(FlowProps(
      children: children,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      wrapAlignment: wrapAlignment,
      gap: gap,
      rowGap: rowGap,
      columnGap: columnGap,
      reverse: reverse,
    ));
  }
}

/// A row layout component (horizontal flex)
///
/// Supports both legacy numeric gap and new enum-based Gap:
/// ```dart
/// // Legacy (still works)
/// ArcaneRow(gap: 16, children: [...])
///
/// // New enum-based (preferred)
/// ArcaneRow(gapSize: Gap.md, children: [...])
///
/// // With full style customization
/// ArcaneRow(
///   gapSize: Gap.md,
///   style: ArcaneStyleData(
///     padding: PaddingPreset.md,
///     background: Background.card,
///   ),
///   children: [...],
/// )
/// ```
class ArcaneRow extends StatelessComponent {
  final List<Component> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  /// Legacy numeric gap (use gapSize for enum-based)
  final double gap;

  /// Enum-based gap (takes precedence over gap)
  final Gap? gapSize;

  /// Additional style customization
  final ArcaneStyleData? style;

  const ArcaneRow({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.gap = 0,
    this.gapSize,
    this.style,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // For simple cases without style, use renderer
    if (style == null && gapSize == null) {
      return context.renderers.row(RowProps(
        children: children,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        gap: gap,
      ));
    }

    // Build base styles for complex cases
    final Map<String, String> baseStyles = {
      'display': 'flex',
      'flex-direction': 'row',
      'justify-content': mainAxisAlignment.css,
      'align-items': crossAxisAlignment.css,
      if (mainAxisSize == MainAxisSize.max) 'width': '100%',
    };

    // Apply gap (enum takes precedence)
    if (gapSize != null) {
      baseStyles['gap'] = gapSize!.css;
    } else if (gap > 0) {
      baseStyles['gap'] = '${gap}px';
    }

    // Merge with custom style if provided
    if (style != null) {
      baseStyles.addAll(style!.toMap());
    }

    return div(
      classes: 'arcane-row',
      styles: Styles(raw: baseStyles),
      children,
    );
  }
}

/// A column layout component (vertical flex)
///
/// Supports both legacy numeric gap and new enum-based Gap:
/// ```dart
/// // Legacy (still works)
/// ArcaneColumn(gap: 16, children: [...])
///
/// // New enum-based (preferred)
/// ArcaneColumn(gapSize: Gap.md, children: [...])
///
/// // With full style customization
/// ArcaneColumn(
///   gapSize: Gap.md,
///   style: ArcaneStyleData(
///     padding: PaddingPreset.md,
///     background: Background.card,
///   ),
///   children: [...],
/// )
/// ```
class ArcaneColumn extends StatelessComponent {
  final List<Component> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  /// Legacy numeric gap (use gapSize for enum-based)
  final double gap;

  /// Enum-based gap (takes precedence over gap)
  final Gap? gapSize;

  /// Additional style customization
  final ArcaneStyleData? style;

  const ArcaneColumn({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.mainAxisSize = MainAxisSize.max,
    this.gap = 0,
    this.gapSize,
    this.style,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // For simple cases without style, use renderer
    if (style == null && gapSize == null) {
      return context.renderers.column(ColumnProps(
        children: children,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        gap: gap,
      ));
    }

    // Build base styles for complex cases
    final Map<String, String> baseStyles = {
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': mainAxisAlignment.css,
      'align-items': crossAxisAlignment.css,
      if (mainAxisSize == MainAxisSize.max) 'height': '100%',
    };

    // Apply gap (enum takes precedence)
    if (gapSize != null) {
      baseStyles['gap'] = gapSize!.css;
    } else if (gap > 0) {
      baseStyles['gap'] = '${gap}px';
    }

    // Merge with custom style if provided
    if (style != null) {
      baseStyles.addAll(style!.toMap());
    }

    return div(
      classes: 'arcane-column',
      styles: Styles(raw: baseStyles),
      children,
    );
  }
}

/// A flexible spacer component
class ArcaneSpacer extends StatelessComponent {
  final int flex;

  const ArcaneSpacer({this.flex = 1, super.key});

  @override
  Component build(BuildContext context) {
    return context.renderers.spacer(SpacerProps(flex: flex));
  }
}

/// A center alignment component
class ArcaneCenter extends StatelessComponent {
  final Component child;

  const ArcaneCenter({required this.child, super.key});

  @override
  Component build(BuildContext context) {
    return context.renderers.center(CenterProps(child: child));
  }
}

/// An expanded component that fills available space
class ArcaneExpanded extends StatelessComponent {
  final Component child;
  final int flex;

  const ArcaneExpanded({required this.child, this.flex = 1, super.key});

  @override
  Component build(BuildContext context) {
    return context.renderers.expanded(ExpandedProps(child: child, flex: flex));
  }
}

/// A padding wrapper component
class ArcanePadding extends StatelessComponent {
  final EdgeInsets padding;
  final Component child;

  const ArcanePadding({
    required this.padding,
    required this.child,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.paddingWrapper(PaddingWrapperProps(
      padding: padding,
      child: child,
    ));
  }
}

/// A sized box component
class ArcaneSizedBox extends StatelessComponent {
  final double? width;
  final double? height;
  final Component? child;

  const ArcaneSizedBox({this.width, this.height, this.child, super.key});

  const ArcaneSizedBox.shrink({super.key})
      : width = 0,
        height = 0,
        child = null;

  const ArcaneSizedBox.expand({super.key})
      : width = double.infinity,
        height = double.infinity,
        child = null;

  @override
  Component build(BuildContext context) {
    return context.renderers.sizedBox(SizedBoxProps(
      width: width,
      height: height,
      child: child,
    ));
  }
}

/// A container component with styling options
class ArcaneContainer extends StatelessComponent {
  final Component? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final Color? color;
  final ArcaneBoxDecoration? decoration;
  final Alignment? alignment;

  const ArcaneContainer({
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.color,
    this.decoration,
    this.alignment,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final Map<String, String> styles = {};

    if (padding != null) styles['padding'] = padding!.padding;
    if (margin != null) styles['margin'] = margin!.margin;
    if (width != null) styles['width'] = '${width}px';
    if (height != null) styles['height'] = '${height}px';
    if (color != null) styles['background-color'] = color!.css;

    if (decoration != null) {
      if (decoration!.color != null) {
        styles['background-color'] = decoration!.color!.css;
      }
      if (decoration!.borderRadius != null) {
        styles['border-radius'] = decoration!.borderRadius!.css;
      }
      if (decoration!.border != null) {
        styles['border'] = decoration!.border!.css;
      }
      if (decoration!.boxShadow != null) {
        styles['box-shadow'] = decoration!.boxShadow!.map((shadow) => shadow.css).join(', ');
      }
    }

    if (alignment != null) {
      styles['display'] = 'flex';
      styles['justify-content'] = alignment!.cssJustifyContent;
      styles['align-items'] = alignment!.cssAlignItems;
    }

    return div(
      classes: 'arcane-container',
      styles: Styles(raw: styles),
      child != null ? [child!] : [],
    );
  }
}

/// Box decoration for ArcaneContainer
class ArcaneBoxDecoration {
  final Color? color;
  final BorderRadius? borderRadius;
  final ArcaneBorder? border;
  final List<BoxShadow>? boxShadow;

  const ArcaneBoxDecoration({
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
  });
}

/// Border for ArcaneBoxDecoration
class ArcaneBorder {
  final Color color;
  final double width;
  final String style;

  const ArcaneBorder({
    required this.color,
    this.width = 1,
    this.style = 'solid',
  });

  const ArcaneBorder.all({
    required this.color,
    this.width = 1,
  }) : style = 'solid';

  String get css => '${width}px $style ${color.css}';
}
