import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

enum HeadlineLevel {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
}

/// Styled headline component.
class ArcaneHeadline extends StatelessComponent {
  final String content;
  final HeadlineLevel level;
  final String? color;
  final String align;
  final String? className;
  final bool gradient;

  const ArcaneHeadline(
    this.content, {
    this.level = HeadlineLevel.h1,
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  });

  const ArcaneHeadline.h1(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h1;

  const ArcaneHeadline.h2(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h2;

  const ArcaneHeadline.h3(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h3;

  const ArcaneHeadline.h4(
    this.content, {
    this.color,
    this.align = 'left',
    this.className,
    this.gradient = false,
    super.key,
  }) : level = HeadlineLevel.h4;

  @override
  Component build(BuildContext context) {
    final (fontSize, fontWeight, lineHeight, letterSpacing) = switch (level) {
      HeadlineLevel.h1 => ('3.5rem', '700', '1.1', '-0.02em'),
      HeadlineLevel.h2 => ('2.5rem', '700', '1.2', '-0.02em'),
      HeadlineLevel.h3 => ('2rem', '600', '1.25', '-0.01em'),
      HeadlineLevel.h4 => ('1.5rem', '600', '1.3', '-0.01em'),
      HeadlineLevel.h5 => ('1.25rem', '600', '1.4', '0'),
      HeadlineLevel.h6 => ('1rem', '600', '1.5', '0'),
    };

    final baseStyles = <String, String>{
      'font-size': fontSize,
      'font-weight': fontWeight,
      'line-height': lineHeight,
      'letter-spacing': letterSpacing,
      'color': color ?? 'var(--arcane-on-background)',
      'text-align': align,
      'margin': '0',
      'padding': '0',
    };

    if (gradient) {
      baseStyles.addAll({
        'background': 'linear-gradient(to right, var(--arcane-accent), var(--arcane-accent-hover))',
        '-webkit-background-clip': 'text',
        'background-clip': 'text',
        '-webkit-text-fill-color': 'transparent',
      });
    }

    final classes = 'arcane-headline arcane-${level.name} ${className ?? ''}';
    final styles = Styles(raw: baseStyles);
    final children = [Component.text(content)];

    return switch (level) {
      HeadlineLevel.h1 => h1(classes: classes, styles: styles, children),
      HeadlineLevel.h2 => h2(classes: classes, styles: styles, children),
      HeadlineLevel.h3 => h3(classes: classes, styles: styles, children),
      HeadlineLevel.h4 => h4(classes: classes, styles: styles, children),
      HeadlineLevel.h5 => h5(classes: classes, styles: styles, children),
      HeadlineLevel.h6 => h6(classes: classes, styles: styles, children),
    };
  }
}

/// Subheadline/lead paragraph text.
class ArcaneSubheadline extends StatelessComponent {
  final String content;
  final String size;
  final String align;
  final bool muted;

  const ArcaneSubheadline(
    this.content, {
    this.size = 'lg',
    this.align = 'left',
    this.muted = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final fontSize = switch (size) {
      'sm' => '1rem',
      'md' => '1.125rem',
      'lg' => '1.25rem',
      'xl' => '1.5rem',
      _ => '1.25rem',
    };

    return p(
      classes: 'arcane-subheadline',
      styles: Styles(raw: {
        'font-size': fontSize,
        'line-height': '1.7',
        'color': muted ? 'var(--arcane-muted)' : 'var(--arcane-on-background)',
        'text-align': align,
        'margin': '0',
        'max-width': '65ch',
      }),
      [Component.text(content)],
    );
  }
}

/// Body text component.
class ArcaneBodyText extends StatelessComponent {
  final String content;
  final String size;
  final bool muted;
  final String align;

  const ArcaneBodyText(
    this.content, {
    this.size = 'base',
    this.muted = false,
    this.align = 'left',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final fontSize = switch (size) {
      'sm' => '0.875rem',
      'base' => '1rem',
      'lg' => '1.125rem',
      _ => '1rem',
    };

    return p(
      classes: 'arcane-body-text',
      styles: Styles(raw: {
        'font-size': fontSize,
        'line-height': '1.6',
        'color': muted ? 'var(--arcane-muted)' : 'var(--arcane-on-surface)',
        'text-align': align,
        'margin': '0',
      }),
      [Component.text(content)],
    );
  }
}
