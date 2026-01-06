import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Callout style variants
enum CalloutStyle {
  /// Informational callout
  info,

  /// Success/positive callout
  success,

  /// Warning callout
  warning,

  /// Error/danger callout
  error,

  /// Neutral/default callout
  neutral,

  /// Tip/hint callout
  tip,

  /// Note callout
  note,
}

/// Inline callout/notice component
///
/// Use for highlighting important information inline with content.
///
/// ```dart
/// ArcaneCallout(
///   title: 'Pro Tip',
///   content: 'You can use keyboard shortcuts to speed up your workflow.',
///   style: CalloutStyle.tip,
/// )
/// ```
class ArcaneCallout extends StatelessComponent {
  /// Optional title
  final String? title;

  /// Content text
  final String? content;

  /// Child component (alternative to content)
  final Component? child;

  /// Style variant
  final CalloutStyle style;

  /// Optional icon override
  final Component? icon;

  /// Whether to show the default icon
  final bool showIcon;

  /// Whether the callout is dismissible
  final bool dismissible;

  /// Callback when dismissed
  final VoidCallback? onDismiss;

  const ArcaneCallout({
    this.title,
    this.content,
    this.child,
    this.style = CalloutStyle.info,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  });

  /// Info callout constructor
  const ArcaneCallout.info({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.info;

  /// Success callout constructor
  const ArcaneCallout.success({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.success;

  /// Warning callout constructor
  const ArcaneCallout.warning({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.warning;

  /// Error callout constructor
  const ArcaneCallout.error({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.error;

  /// Tip callout constructor
  const ArcaneCallout.tip({
    this.title,
    this.content,
    this.child,
    this.icon,
    this.showIcon = true,
    this.dismissible = false,
    this.onDismiss,
    super.key,
  }) : style = CalloutStyle.tip;

  String get _defaultIcon => switch (style) {
        CalloutStyle.info => 'i',
        CalloutStyle.success => '✓',
        CalloutStyle.warning => '⚠',
        CalloutStyle.error => '✕',
        CalloutStyle.neutral => '•',
        CalloutStyle.tip => '💡',
        CalloutStyle.note => '📝',
      };

  (String background, String border, String iconColor) get _styleColors =>
      switch (style) {
        CalloutStyle.info => (
            'hsl(199 89% 48% / 0.1)',
            'hsl(199 89% 48%)',
            'hsl(199 89% 48%)'
          ),
        CalloutStyle.success => (
            'hsl(142 76% 36% / 0.1)',
            'hsl(142 76% 36%)',
            'hsl(142 76% 36%)'
          ),
        CalloutStyle.warning => (
            'hsl(38 92% 50% / 0.1)',
            'hsl(38 92% 50%)',
            'hsl(38 92% 50%)'
          ),
        CalloutStyle.error => (
            'hsl(var(--destructive) / 0.1)',
            'var(--destructive)',
            'var(--destructive)'
          ),
        CalloutStyle.neutral => (
            'var(--muted)',
            'var(--border)',
            'var(--muted-foreground)'
          ),
        CalloutStyle.tip => (
            'hsl(var(--accent) / 0.1)',
            'var(--accent)',
            'var(--accent)'
          ),
        CalloutStyle.note => (
            'hsl(var(--primary) / 0.1)',
            'var(--primary)',
            'var(--primary)'
          ),
      };

  @override
  Component build(BuildContext context) {
    final (background, borderColor, iconColor) = _styleColors;

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'gap': '1rem',
        'padding': '1rem',
        'background': background,
        'border-left': '4px solid $borderColor',
        'border-radius': '0.375rem',
      }),
      [
        // Icon
        if (showIcon)
          div(
            styles: Styles(raw: {
              'flex-shrink': '0',
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': iconColor,
              'font-size': '1rem',
            }),
            [icon ?? text(_defaultIcon)],
          ),

        // Content
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (title != null)
              div(
                styles: const Styles(raw: {
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                  'margin-bottom': '0.25rem',
                }),
                [text(title!)],
              ),
            if (content != null)
              div(
                styles: const Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--foreground)',
                  'line-height': '1.7',
                }),
                [text(content!)],
              ),
            if (child != null) child!,
          ],
        ),

        // Dismiss button
        if (dismissible)
          button(
            type: ButtonType.button,
            styles: const Styles(raw: {
              'flex-shrink': '0',
              'width': '24px',
              'height': '24px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'border-radius': '0.125rem',
              'transition': 'all 150ms ease',
            }),
            events: {'click': (_) => onDismiss?.call()},
            [text('×')],
          ),
      ],
    );
  }
}
