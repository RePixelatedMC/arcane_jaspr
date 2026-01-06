import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Status types
enum StatusType {
  online,
  offline,
  busy,
  away,
  success,
  error,
  warning,
  info,
}

/// Status indicator dot with optional label
class ArcaneStatusIndicator extends StatelessComponent {
  final StatusType status;
  final String? label;
  final String? size;
  final bool pulse;

  const ArcaneStatusIndicator({
    required this.status,
    this.label,
    this.size,
    this.pulse = false,
    super.key,
  });

  /// Online status
  const ArcaneStatusIndicator.online({
    this.label,
    this.size,
    this.pulse = true,
    super.key,
  }) : status = StatusType.online;

  /// Offline status
  const ArcaneStatusIndicator.offline({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.offline,
        pulse = false;

  /// Busy status
  const ArcaneStatusIndicator.busy({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.busy,
        pulse = false;

  /// Away status
  const ArcaneStatusIndicator.away({
    this.label,
    this.size,
    super.key,
  })  : status = StatusType.away,
        pulse = false;

  String get _color {
    return switch (status) {
      StatusType.online || StatusType.success => 'hsl(142 76% 36%)',
      StatusType.offline => 'var(--muted-foreground)',
      StatusType.busy || StatusType.error => 'var(--destructive)',
      StatusType.away || StatusType.warning => 'hsl(38 92% 50%)',
      StatusType.info => 'hsl(199 89% 48%)',
    };
  }

  @override
  Component build(BuildContext context) {
    final effectiveSize = size ?? '10px';

    return div(
      classes: 'arcane-status-indicator',
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
      }),
      [
        // Dot
        div(
          classes: 'arcane-status-dot',
          styles: Styles(raw: {
            'position': 'relative',
            'width': effectiveSize,
            'height': effectiveSize,
            'border-radius': '9999px',
            'background': _color,
            'flex-shrink': '0',
          }),
          [
            if (pulse && (status == StatusType.online || status == StatusType.success))
              div(
                classes: 'arcane-status-pulse',
                styles: Styles(raw: {
                  'position': 'absolute',
                  'inset': '-2px',
                  'border-radius': '9999px',
                  'background': _color,
                  'opacity': '0.4',
                  'animation': 'arcane-pulse 2s infinite',
                }),
                [],
              ),
          ],
        ),
        // Label
        if (label != null)
          span(
            styles: const Styles(raw: {
              'font-size': '1rem',
              'color': 'var(--muted-foreground)',
            }),
            [text(label!)],
          ),
      ],
    );
  }
}

/// Status badge combining status indicator with text
class ArcaneStatusBadge extends StatelessComponent {
  final StatusType status;
  final String label;

  const ArcaneStatusBadge({
    required this.status,
    required this.label,
    super.key,
  });

  /// Success status badge
  const ArcaneStatusBadge.success({
    required this.label,
    super.key,
  }) : status = StatusType.success;

  /// Error status badge
  const ArcaneStatusBadge.error({
    required this.label,
    super.key,
  }) : status = StatusType.error;

  /// Warning status badge
  const ArcaneStatusBadge.warning({
    required this.label,
    super.key,
  }) : status = StatusType.warning;

  /// Info status badge
  const ArcaneStatusBadge.info({
    required this.label,
    super.key,
  }) : status = StatusType.info;

  (String, String) get _colors {
    return switch (status) {
      StatusType.online || StatusType.success =>
        ('hsl(142 76% 36%)', 'hsl(142 76% 36% / 0.15)'),
      StatusType.offline => ('var(--muted-foreground)', 'var(--muted)'),
      StatusType.busy || StatusType.error =>
        ('var(--destructive)', 'hsl(var(--destructive) / 0.15)'),
      StatusType.away || StatusType.warning =>
        ('hsl(38 92% 50%)', 'hsl(38 92% 50% / 0.15)'),
      StatusType.info => ('hsl(199 89% 48%)', 'hsl(199 89% 48% / 0.15)'),
    };
  }

  @override
  Component build(BuildContext context) {
    final (color, bgColor) = _colors;

    return span(
      classes: 'arcane-status-badge',
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.25rem',
        'padding': '0.25rem 0.5rem',
        'border-radius': '0.375rem',
        'background': bgColor,
        'color': color,
        'font-size': '0.875rem',
        'font-weight': '500',
      }),
      [
        div(
          styles: Styles(raw: {
            'width': '6px',
            'height': '6px',
            'border-radius': '9999px',
            'background': color,
          }),
          [],
        ),
        text(label),
      ],
    );
  }
}
