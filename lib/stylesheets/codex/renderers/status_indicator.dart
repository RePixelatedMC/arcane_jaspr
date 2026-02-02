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
        'gap': 'var(--space-2)',
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
              'font-size': 'var(--font-size-sm)',
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
          'var(--success)',
          '0 0 8px rgba(22, 101, 52, 0.5)'
        ),
      StatusType.offline => ('var(--muted-foreground)', 'none'),
      StatusType.busy => (
          'var(--destructive)',
          '0 0 8px rgba(153, 27, 27, 0.5)'
        ),
      StatusType.away => (
          'var(--warning)',
          '0 0 8px rgba(146, 64, 14, 0.5)'
        ),
      StatusType.success => (
          'var(--success)',
          '0 0 8px rgba(22, 101, 52, 0.5)'
        ),
      StatusType.error => (
          'var(--destructive)',
          '0 0 8px rgba(153, 27, 27, 0.5)'
        ),
      StatusType.warning => (
          'var(--warning)',
          '0 0 8px rgba(146, 64, 14, 0.5)'
        ),
      StatusType.info => ('var(--info)', '0 0 8px rgba(30, 64, 175, 0.5)'),
    };
  }
}

