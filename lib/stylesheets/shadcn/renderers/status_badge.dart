import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/status_badge_props.dart';

/// ShadCN Status Badge renderer.
class ShadcnStatusBadge extends StatelessComponent {
  final StatusBadgeProps props;

  const ShadcnStatusBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final color = _getStatusColor();
    final indicatorSize = _getIndicatorSize();
    final padding = _getPadding();
    final fontSize = _getFontSize();

    final effectiveBackground =
        props.background ?? 'color-mix(in srgb, $color 10%, transparent)';
    final effectiveBorder =
        props.borderColor ?? 'color-mix(in srgb, $color 25%, transparent)';

    return dom.div(
      classes: 'arcane-status-badge arcane-status-${props.status.name}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-2)',
        'padding': padding,
        'background': effectiveBackground,
        'border': '1px solid $effectiveBorder',
        'border-radius': 'var(--radius)',
      }),
      [
        dom.span(
          classes: 'arcane-status-indicator',
          styles: dom.Styles(raw: {
            'width': indicatorSize,
            'height': indicatorSize,
            'border-radius': '50%',
            'background': props.indicatorColor ?? color,
            if (props.showGlow) 'box-shadow': '0 0 8px ${props.indicatorColor ?? color}',
            if (props.showPulse) 'animation': 'arcane-pulse 2s ease-in-out infinite',
          }),
          [],
        ),
        dom.span(
          classes: 'arcane-status-label',
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

  String _getIndicatorSize() {
    switch (props.size) {
      case StatusBadgeSize.sm:
        return '6px';
      case StatusBadgeSize.md:
        return '8px';
      case StatusBadgeSize.lg:
        return '10px';
    }
  }

  String _getPadding() {
    switch (props.size) {
      case StatusBadgeSize.sm:
        return '0.25rem 0.5rem';
      case StatusBadgeSize.md:
        return '0.25rem 1rem';
      case StatusBadgeSize.lg:
        return '0.5rem 1.5rem';
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
