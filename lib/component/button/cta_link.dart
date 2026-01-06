import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// CTA link button style variants
enum CtaLinkVariant {
  /// Solid accent background
  primary,

  /// Outline/border style
  secondary,

  /// Text-only, no background or border
  ghost,

  /// Gradient background (uses accentGradient)
  accent,
}

/// CTA link button size
enum CtaLinkSize {
  /// Small: compact padding
  sm,

  /// Medium: default size
  md,

  /// Large: prominent CTA
  lg,
}

/// A call-to-action link styled as a button.
///
/// Provides multiple variants for different visual hierarchies:
/// - `primary`: Solid accent background, high prominence
/// - `secondary`: Outline style, medium prominence
/// - `ghost`: Text only, low prominence
/// - `accent`: Gradient background, highest prominence
///
/// ```dart
/// ArcaneCtaLink.primary(
///   label: 'Get Started',
///   href: '/signup',
///   showArrow: true,
/// )
///
/// ArcaneCtaLink.secondary(
///   label: 'Learn More',
///   href: '/about',
/// )
/// ```
class ArcaneCtaLink extends StatelessComponent {
  /// The button label text
  final String label;

  /// The link href
  final String href;

  /// Whether to show an arrow after the label
  final bool showArrow;

  /// The button variant
  final CtaLinkVariant variant;

  /// The button size
  final CtaLinkSize size;

  /// Custom background (overrides variant default)
  final String? background;

  /// Custom border (overrides variant default)
  final String? border;

  /// Additional raw CSS styles
  final Map<String, String>? raw;

  const ArcaneCtaLink({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.variant = CtaLinkVariant.primary,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  });

  /// Primary CTA with solid accent background
  const ArcaneCtaLink.primary({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.primary;

  /// Secondary CTA with outline style
  const ArcaneCtaLink.secondary({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.secondary;

  /// Ghost CTA with text-only style
  const ArcaneCtaLink.ghost({
    required this.label,
    required this.href,
    this.showArrow = false,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.ghost;

  /// Accent CTA with gradient background
  const ArcaneCtaLink.accent({
    required this.label,
    required this.href,
    this.showArrow = true,
    this.size = CtaLinkSize.md,
    this.background,
    this.border,
    this.raw,
    super.key,
  }) : variant = CtaLinkVariant.accent;

  @override
  Component build(BuildContext context) {
    final padding = _getPadding();
    final fontSize = _getFontSize();
    final styles = _getVariantStyles();

    return a(
      href: href,
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': padding,
        'border-radius': '0.375rem',
        'font-size': fontSize,
        'font-weight': '500',
        'text-decoration': 'none',
        'transition': 'all 150ms ease',
        'cursor': 'pointer',
        ...styles,
        ...?raw,
      }),
      [
        Component.text(label),
        if (showArrow) const Component.text(' \u2192'),
      ],
    );
  }

  String _getPadding() {
    switch (size) {
      case CtaLinkSize.sm:
        return '0.25rem 0.5rem';
      case CtaLinkSize.md:
        return '0.5rem 1.5rem';
      case CtaLinkSize.lg:
        return '1rem 2rem';
    }
  }

  String _getFontSize() {
    switch (size) {
      case CtaLinkSize.sm:
        return '0.75rem';
      case CtaLinkSize.md:
        return '0.875rem';
      case CtaLinkSize.lg:
        return '1rem';
    }
  }

  Map<String, String> _getVariantStyles() {
    switch (variant) {
      case CtaLinkVariant.primary:
        return {
          'background': background ?? 'var(--accent)',
          'color': 'var(--accent-foreground)',
          'border': border ?? 'none',
        };
      case CtaLinkVariant.secondary:
        return {
          'background': background ?? 'transparent',
          'color': 'var(--foreground)',
          'border': border ?? '1px solid var(--border)',
        };
      case CtaLinkVariant.ghost:
        return {
          'background': background ?? 'transparent',
          'color': 'var(--muted-foreground)',
          'border': border ?? 'none',
        };
      case CtaLinkVariant.accent:
        return {
          'background': background ?? 'linear-gradient(135deg, var(--accent) 0%, hsl(199 89% 48%) 100%)',
          'color': 'var(--foreground)',
          'border': border ?? 'none',
        };
    }
  }
}