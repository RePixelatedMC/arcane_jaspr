import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/status_indicator_props.dart';

/// Codex Status Indicator renderer.
///
/// Implements the Codex design language:
/// - Status-specific colors with glow
/// - Pulse animation for active states
class CodexStatusIndicator extends StatelessComponent {
  final StatusIndicatorProps props;

  const CodexStatusIndicator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (String color, String glow) = _getStatusStyles(props.status);
    final String dotSize = props.size ?? '10px';

    return dom.div(
      classes: 'codex-status-indicator codex-status-${props.status.name}',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-2)',
      }),
      [
        // Dot
        dom.div(
          classes: 'codex-status-dot ${props.pulse ? 'pulse' : ''}',
          styles: dom.Styles(raw: {
            'width': dotSize,
            'height': dotSize,
            'border-radius': '50%',
            'background-color': color,
            'box-shadow': glow,
            'flex-shrink': '0',
            if (props.pulse) 'animation': 'codex-pulse 2s ease-in-out infinite',
          }),
          [],
        ),

        // Label
        if (props.label != null)
          dom.span(
            classes: 'codex-status-label',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }

  (String color, String glow) _getStatusStyles(StatusType status) {
    return switch (status) {
      StatusType.online => (
          'var(--codex-success)',
          '0 0 8px rgba(22, 101, 52, 0.5)'
        ),
      StatusType.offline => ('var(--muted-foreground)', 'none'),
      StatusType.busy => (
          'var(--codex-destructive)',
          '0 0 8px rgba(153, 27, 27, 0.5)'
        ),
      StatusType.away => (
          'var(--codex-warning)',
          '0 0 8px rgba(146, 64, 14, 0.5)'
        ),
      StatusType.success => (
          'var(--codex-success)',
          '0 0 8px rgba(22, 101, 52, 0.5)'
        ),
      StatusType.error => (
          'var(--codex-destructive)',
          '0 0 8px rgba(153, 27, 27, 0.5)'
        ),
      StatusType.warning => (
          'var(--codex-warning)',
          '0 0 8px rgba(146, 64, 14, 0.5)'
        ),
      StatusType.info => ('var(--codex-info)', '0 0 8px rgba(30, 64, 175, 0.5)'),
    };
  }
}

/// Codex Simple Status Badge renderer.
class CodexSimpleStatusBadge extends StatelessComponent {
  final SimpleStatusBadgeProps props;

  const CodexSimpleStatusBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (String color, String glow) = _getStatusStyles(props.status);

    return dom.div(
      classes: 'codex-simple-status-badge codex-status-${props.status.name}',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-2)',
        'padding': '0.375rem 0.75rem',
        'background-color': 'var(--secondary)',
        'border-radius': 'var(--radius-full)',
      }),
      [
        // Dot
        dom.div(
          classes: 'codex-status-badge-dot',
          styles: dom.Styles(raw: {
            'width': '8px',
            'height': '8px',
            'border-radius': '50%',
            'background-color': color,
            'box-shadow': glow,
            'flex-shrink': '0',
          }),
          [],
        ),

        // Label
        dom.span(
          classes: 'codex-status-badge-label',
          styles: const dom.Styles(raw: {
            'font-size': '0.8125rem',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--foreground)',
          }),
          [Component.text(props.label)],
        ),
      ],
    );
  }

  (String color, String glow) _getStatusStyles(StatusType status) {
    return switch (status) {
      StatusType.online => (
          'var(--codex-success)',
          '0 0 6px rgba(22, 101, 52, 0.5)'
        ),
      StatusType.offline => ('var(--muted-foreground)', 'none'),
      StatusType.busy => (
          'var(--codex-destructive)',
          '0 0 6px rgba(153, 27, 27, 0.5)'
        ),
      StatusType.away => (
          'var(--codex-warning)',
          '0 0 6px rgba(146, 64, 14, 0.5)'
        ),
      StatusType.success => (
          'var(--codex-success)',
          '0 0 6px rgba(22, 101, 52, 0.5)'
        ),
      StatusType.error => (
          'var(--codex-destructive)',
          '0 0 6px rgba(153, 27, 27, 0.5)'
        ),
      StatusType.warning => (
          'var(--codex-warning)',
          '0 0 6px rgba(146, 64, 14, 0.5)'
        ),
      StatusType.info => ('var(--codex-info)', '0 0 6px rgba(30, 64, 175, 0.5)'),
    };
  }
}
