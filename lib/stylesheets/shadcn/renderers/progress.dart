import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/progress_props.dart';

/// ShadCN Progress renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/progress
class ShadcnProgress extends StatelessComponent {
  final ProgressProps props;

  const ShadcnProgress(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Clamp value between 0 and 1
    final clampedValue = props.value.clamp(0.0, 1.0);
    final percentage = (clampedValue * 100).round();

    // Size-specific height
    final height = switch (props.size) {
      ProgressSize.small => '0.25rem', // 4px
      ProgressSize.medium => '0.5rem', // 8px - ShadCN default is h-4 but that's too tall
      ProgressSize.large => '0.75rem', // 12px
    };

    // Variant-specific indicator color
    final indicatorColor = props.indicatorColor ?? switch (props.variant) {
      ProgressVariant.primary => 'var(--primary)',
      ProgressVariant.success => 'var(--success, #22c55e)',
      ProgressVariant.warning => 'var(--warning, #f59e0b)',
      ProgressVariant.error => 'var(--destructive)',
      ProgressVariant.info => 'var(--info, #3b82f6)',
    };

    final trackColor = props.trackColor ?? 'var(--secondary)';

    // ShadCN Progress: relative h-4 w-full overflow-hidden rounded-full bg-secondary
    return dom.div(
      classes: 'arcane-progress',
      attributes: {
        'role': 'progressbar',
        'aria-valuemin': '0',
        'aria-valuemax': '100',
        'aria-valuenow': '$percentage',
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
        'height': height,
        'overflow': 'hidden',
        'border-radius': '9999px', // rounded-full
        'background-color': trackColor,
      }),
      [
        // ShadCN Progress indicator: h-full w-full flex-1 bg-primary transition-all
        dom.div(
          classes: 'arcane-progress-indicator ${props.indeterminate ? 'indeterminate' : ''}',
          styles: dom.Styles(raw: {
            'height': '100%',
            'background-color': indicatorColor,
            'border-radius': '9999px',
            'transition': 'width 200ms ease',
            if (props.indeterminate) ...{
              'width': '50%',
              'animation': 'arcane-progress-indeterminate 1.5s ease-in-out infinite',
            } else ...{
              'width': '${percentage}%',
            },
          }),
          [],
        ),
      ],
    );
  }
}
