import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/status_badge_props.dart';

/// Codex Status Badge renderer.
class CodexStatusBadge extends StatelessComponent {
  final StatusBadgeProps props;

  const CodexStatusBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final color = _getStatusColor();
    final indicatorSize = _getIndicatorSize();
    final padding = _getPadding();
    final fontSize = _getFontSize();

    final effectiveBackground =
        props.background ?? 'rgba(${_getStatusRgb()}, 0.1)';
    final effectiveBorder =
        props.borderColor ?? 'rgba(${_getStatusRgb()}, 0.25)';

    return dom.div(
      classes: 'codex-status-badge codex-status-${props.status.name}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.625rem',
        'padding': padding,
        'background': effectiveBackground,
        'border': '1px solid $effectiveBorder',
        'border-radius': 'var(--radius)',
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
      }),
      [
        dom.span(
          classes: 'codex-status-indicator',
          styles: dom.Styles(raw: {
            'width': indicatorSize,
            'height': indicatorSize,
            'border-radius': '50%',
            'background': props.indicatorColor ?? color,
            if (props.showGlow) 'box-shadow': '0 0 10px ${props.indicatorColor ?? color}',
            if (props.showPulse) 'animation': 'arcane-pulse 2s ease-in-out infinite',
          }),
          [],
        ),
        dom.span(
          classes: 'codex-status-label',
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'font-weight': props.size == StatusBadgeSize.sm ? '400' : '500',
            'color': props.size == StatusBadgeSize.sm
                ? (props.indicatorColor ?? color)
                : 'var(--foreground)',
          }),
          [Component.text(props.label)],
        ),
      ],
    );
  }

  String _getStatusColor() {
    switch (props.status) {
      case StatusType.success:
      case StatusType.online:
        return 'var(--success)';
      case StatusType.warning:
      case StatusType.away:
        return 'var(--warning)';
      case StatusType.error:
      case StatusType.busy:
        return 'var(--destructive)';
      case StatusType.info:
        return 'var(--info)';
      case StatusType.offline:
        return 'var(--muted-foreground)';
    }
  }

  String _getStatusRgb() {
    switch (props.status) {
      case StatusType.success:
      case StatusType.online:
        return '22, 101, 52';
      case StatusType.warning:
      case StatusType.away:
        return '146, 64, 14';
      case StatusType.error:
      case StatusType.busy:
        return '153, 27, 27';
      case StatusType.info:
        return '30, 64, 175';
      case StatusType.offline:
        return '115, 115, 115';
    }
  }

  String _getIndicatorSize() {
    switch (props.size) {
      case StatusBadgeSize.sm:
        return '8px';
      case StatusBadgeSize.md:
        return '10px';
      case StatusBadgeSize.lg:
        return '12px';
    }
  }

  String _getPadding() {
    switch (props.size) {
      case StatusBadgeSize.sm:
        return '0.375rem 0.75rem';
      case StatusBadgeSize.md:
        return '0.375rem 1.25rem';
      case StatusBadgeSize.lg:
        return '0.625rem 1.75rem';
    }
  }

  String _getFontSize() {
    switch (props.size) {
      case StatusBadgeSize.sm:
        return '0.75rem';
      case StatusBadgeSize.md:
        return '0.875rem';
      case StatusBadgeSize.lg:
        return '1rem';
    }
  }
}
