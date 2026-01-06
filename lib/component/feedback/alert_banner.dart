import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../core/theme_provider.dart';

export '../../core/props/alert_banner_props.dart';

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
    this.variant = AlertBannerVariant.info,
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
  }) : variant = AlertBannerVariant.info;

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
  }) : variant = AlertBannerVariant.success;

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
  }) : variant = AlertBannerVariant.warning;

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
  }) : variant = AlertBannerVariant.error;

  @override
  Component build(BuildContext context) {
    return context.renderers.alertBanner(AlertBannerProps(
      message: message,
      title: title,
      variant: variant,
      icon: icon,
      action: action,
      dismissible: dismissible,
      onDismiss: onDismiss,
      filled: filled,
    ));
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
            [Component.text('${value.round()}%')],
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
            [Component.text(label!)],
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
