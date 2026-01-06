import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Alert/banner variants for ArcaneAlertBanner
enum AlertBannerVariant {
  info,
  success,
  warning,
  error,
  neutral,
}

/// An alert/banner component (Supabase-style)
class ArcaneAlertBanner extends StatelessComponent {
  /// Alert message
  final String message;

  /// Optional title
  final String? title;

  /// Alert variant
  final AlertBannerVariant variant;

  /// Optional icon
  final Component? icon;

  /// Optional action button
  final Component? action;

  /// Whether the alert is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final void Function()? onDismiss;

  /// Whether to use filled style
  final bool filled;

  const ArcaneAlertBanner({
    required this.message,
    this.title,
    this.variant = AlertVariant.info,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  });

  /// Info alert
  const ArcaneAlertBanner.info({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.info;

  /// Success alert
  const ArcaneAlertBanner.success({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.success;

  /// Warning alert
  const ArcaneAlertBanner.warning({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.warning;

  /// Error alert
  const ArcaneAlertBanner.error({
    required this.message,
    this.title,
    this.icon,
    this.action,
    this.dismissible = false,
    this.onDismiss,
    this.filled = false,
    super.key,
  }) : variant = AlertVariant.error;

  @override
  Component build(BuildContext context) {
    final (String bgColor, String borderColor, String textColor, String iconColor) = switch (variant) {
      AlertVariant.info => filled
          ? (
              'hsl(199 89% 48%)',
              'hsl(199 89% 48%)',
              'white',
              'white',
            )
          : (
              'transparent',
              'hsl(199 89% 48%)',
              'var(--foreground)',
              'hsl(199 89% 48%)',
            ),
      AlertVariant.success => filled
          ? (
              'hsl(142 76% 36%)',
              'hsl(142 76% 36%)',
              'white',
              'white',
            )
          : (
              'transparent',
              'hsl(142 76% 36%)',
              'var(--foreground)',
              'hsl(142 76% 36%)',
            ),
      AlertVariant.warning => filled
          ? (
              'hsl(38 92% 50%)',
              'hsl(38 92% 50%)',
              'black',
              'black',
            )
          : (
              'transparent',
              'hsl(38 92% 50%)',
              'var(--foreground)',
              'hsl(38 92% 50%)',
            ),
      AlertVariant.error => filled
          ? (
              'var(--destructive)',
              'var(--destructive)',
              'white',
              'white',
            )
          : (
              'transparent',
              'var(--destructive)',
              'var(--foreground)',
              'var(--destructive)',
            ),
      AlertVariant.neutral => (
          'var(--muted)',
          'var(--border)',
          'var(--foreground)',
          'var(--muted-foreground)',
        ),
    };

    final String defaultIcon = switch (variant) {
      AlertVariant.info => 'ℹ',
      AlertVariant.success => '✓',
      AlertVariant.warning => '⚠',
      AlertVariant.error => '✕',
      AlertVariant.neutral => '•',
    };

    return div(
      classes: 'arcane-alert arcane-alert-${variant.name} ${filled ? 'filled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '1rem',
        'padding': '1.5rem',
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-radius': '0.375rem',
        'color': textColor,
      }),
      [
        // Icon
        span(
          classes: 'arcane-alert-icon',
          styles: Styles(raw: {
            'flex-shrink': '0',
            'font-size': '1.125rem',
            'color': iconColor,
          }),
          [icon ?? text(defaultIcon)],
        ),

        // Content
        div(
          classes: 'arcane-alert-content',
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (title != null)
              div(
                classes: 'arcane-alert-title',
                styles: const Styles(raw: {
                  'font-weight': '600',
                  'font-size': '1rem',
                  'margin-bottom': '0.25rem',
                }),
                [text(title!)],
              ),
            div(
              classes: 'arcane-alert-message',
              styles: const Styles(raw: {
                'font-size': '0.875rem',
                'line-height': '1.625',
              }),
              [text(message)],
            ),
          ],
        ),

        // Action
        if (action != null) action!,

        // Dismiss button
        if (dismissible)
          button(
            classes: 'arcane-alert-dismiss',
            attributes: {
              'type': 'button',
              'aria-label': 'Dismiss',
            },
            styles: const Styles(raw: {
              'flex-shrink': '0',
              'padding': '0.25rem',
              'background': 'none',
              'border': 'none',
              'color': 'inherit',
              'opacity': '0.7',
              'cursor': 'pointer',
              'font-size': '1rem',
              'line-height': '1',
              'transition': 'all 150ms ease',
            }),
            events: {
              'click': (e) => onDismiss?.call(),
            },
            [text('×')],
          ),
      ],
    );
  }
}

/// A progress bar component
class ArcaneProgressBar extends StatelessComponent {
  /// Progress value (0-100)
  final double value;

  /// Whether to show indeterminate animation
  final bool indeterminate;

  /// Bar height
  final double height;

  /// Show percentage label
  final bool showLabel;

  /// Custom color
  final String? color;

  const ArcaneProgressBar({
    this.value = 0,
    this.indeterminate = false,
    this.height = 8,
    this.showLabel = false,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-progress ${indeterminate ? 'indeterminate' : ''}',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '1rem',
      }),
      [
        div(
          classes: 'arcane-progress-track',
          styles: Styles(raw: {
            'flex': '1',
            'height': '${height}px',
            'background-color': 'var(--muted)',
            'border-radius': '9999px',
            'overflow': 'hidden',
          }),
          [
            div(
              classes: 'arcane-progress-bar',
              styles: Styles(raw: {
                'height': '100%',
                'width': indeterminate ? '50%' : '${value.clamp(0, 100)}%',
                'background-color': color ?? 'var(--accent)',
                'border-radius': '9999px',
                'transition': indeterminate
                    ? 'none'
                    : 'all 200ms ease',
                if (indeterminate) 'animation': 'arcane-progress-indeterminate 1.5s ease-in-out infinite',
              }),
              [],
            ),
          ],
        ),
        if (showLabel && !indeterminate)
          span(
            classes: 'arcane-progress-label',
            styles: const Styles(raw: {
              'font-size': '0.75rem',
              'font-weight': '500',
              'color': 'var(--muted-foreground)',
              'min-width': '40px',
              'text-align': 'right',
            }),
            [text('${value.round()}%')],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-progress-indeterminate').styles(raw: {
      '0%': 'transform: translateX(-100%)',
      '100%': 'transform: translateX(200%)',
    }),
  ];
}

/// A loading spinner component
class ArcaneLoader extends StatelessComponent {
  /// Spinner size
  final double size;

  /// Custom color
  final String? color;

  /// Loading text
  final String? label;

  const ArcaneLoader({
    this.size = 24,
    this.color,
    this.label,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-loader',
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '1rem',
      }),
      [
        div(
          classes: 'arcane-loader-spinner',
          styles: Styles(raw: {
            'width': '${size}px',
            'height': '${size}px',
            'border': '2px solid var(--border)',
            'border-top-color': color ?? 'var(--accent)',
            'border-radius': '9999px',
            'animation': 'arcane-spin 0.8s linear infinite',
          }),
          [],
        ),
        if (label != null)
          span(
            classes: 'arcane-loader-text',
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
            }),
            [text(label!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-spin').styles(raw: {
      '0%': 'transform: rotate(0deg)',
      '100%': 'transform: rotate(360deg)',
    }),
  ];
}
