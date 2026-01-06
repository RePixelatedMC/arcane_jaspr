import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/status_indicator_props.dart';

/// ShadCN Status Indicator renderer.
class ShadcnStatusIndicator extends StatelessComponent {
  final StatusIndicatorProps props;

  const ShadcnStatusIndicator(this.props, {super.key});

  String get _color {
    return switch (props.status) {
      StatusType.online || StatusType.success => 'hsl(142 76% 36%)',
      StatusType.offline => 'var(--muted-foreground)',
      StatusType.busy || StatusType.error => 'var(--destructive)',
      StatusType.away || StatusType.warning => 'hsl(38 92% 50%)',
      StatusType.info => 'hsl(199 89% 48%)',
    };
  }

  @override
  Component build(BuildContext context) {
    final effectiveSize = props.size ?? '10px';
    final color = _color;
    final shouldPulse = props.pulse && (props.status == StatusType.online || props.status == StatusType.success);

    return dom.div(
      classes: 'arcane-status-indicator',
      attributes: {
        'role': 'status',
        'aria-label': props.label ?? props.status.name,
      },
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
      }),
      [
        // Dot
        dom.div(
          classes: 'arcane-status-dot',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': effectiveSize,
            'height': effectiveSize,
            'border-radius': '9999px',
            'background': color,
            'flex-shrink': '0',
          }),
          [
            if (shouldPulse)
              dom.div(
                classes: 'arcane-status-pulse',
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'inset': '-2px',
                  'border-radius': '9999px',
                  'background': color,
                  'opacity': '0.4',
                  'animation': 'arcane-pulse 2s infinite',
                }),
                [],
              ),
          ],
        ),
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}

/// ShadCN Status Badge renderer.
class ShadcnStatusBadge extends StatelessComponent {
  final SimpleStatusBadgeProps props;

  const ShadcnStatusBadge(this.props, {super.key});

  (String, String) get _colors {
    return switch (props.status) {
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

    return dom.span(
      classes: 'arcane-status-badge',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'padding': '0.25rem 0.625rem',
        'border-radius': 'var(--radius)',
        'background': bgColor,
        'color': color,
        'font-size': '0.75rem',
        'font-weight': '500',
        'line-height': '1',
      }),
      [
        dom.div(
          styles: dom.Styles(raw: {
            'width': '6px',
            'height': '6px',
            'border-radius': '9999px',
            'background': color,
          }),
          [],
        ),
        Component.text(props.label),
      ],
    );
  }
}
