import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/status_indicator_props.dart';

/// ShadCN Status Indicator renderer.
class ShadcnStatusIndicator extends StatelessComponent {
  final StatusIndicatorProps props;

  const ShadcnStatusIndicator(this.props, {super.key});

  String get _color {
    return switch (props.status) {
      StatusType.online || StatusType.success => 'var(--success)',
      StatusType.offline => 'var(--muted-foreground)',
      StatusType.busy || StatusType.error => 'var(--destructive)',
      StatusType.away || StatusType.warning => 'var(--warning)',
      StatusType.info => 'var(--info)',
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
        'gap': 'var(--space-2)',
      }),
      [
        // Dot
        dom.div(
          classes: 'arcane-status-dot',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': effectiveSize,
            'height': effectiveSize,
            'border-radius': 'var(--arcane-radius-full)',
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
                  'border-radius': 'var(--arcane-radius-full)',
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
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}

