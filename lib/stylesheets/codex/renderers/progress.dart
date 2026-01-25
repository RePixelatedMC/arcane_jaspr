import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/progress_props.dart';

/// Codex Progress Bar renderer.
///
/// Implements the Codex design language:
/// - Larger track heights (1.25x)
/// - Accent-colored indicator with subtle glow
/// - Larger border radius
class CodexProgress extends StatelessComponent {
  final ProgressProps props;

  const CodexProgress(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double clampedValue = props.value.clamp(0.0, 1.0);
    final double percentage = clampedValue * 100;

    // Codex track heights - 1.25x larger
    final String trackHeight = switch (props.size) {
      ComponentSize.small => '4px', // vs ShadCN 2px
      ComponentSize.medium => '6px', // vs ShadCN 4px
      ComponentSize.large => '10px', // vs ShadCN 8px
    };

    // Codex variant colors with accent as primary
    final (String indicatorColor, String? glowColor) = switch (props.variant) {
      ProgressVariant.primary => (
          props.indicatorColor ?? 'var(--primary)',
          '0 0 15px rgba(var(--primary-rgb), 0.2)',
        ),
      ProgressVariant.success => (
          props.indicatorColor ?? 'var(--success)',
          '0 0 10px rgba(var(--success-rgb), 0.25)',
        ),
      ProgressVariant.warning => (
          props.indicatorColor ?? 'var(--warning)',
          null,
        ),
      ProgressVariant.error => (
          props.indicatorColor ?? 'var(--destructive)',
          '0 0 10px rgba(var(--destructive-rgb), 0.25)',
        ),
      ProgressVariant.info => (
          props.indicatorColor ?? 'var(--info)',
          '0 0 10px rgba(var(--info-rgb), 0.25)',
        ),
    };

    return dom.div(
      classes: 'codex-progress',
      styles: const dom.Styles(raw: {
        'width': '100%',
      }),
      [
        // Progress track
        dom.div(
          classes: 'codex-progress-track',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': '100%',
            'height': trackHeight,
            'background-color': props.trackColor ?? 'var(--muted)',
            'border-radius': 'var(--arcane-radius-full)',
            'overflow': 'hidden',
          }),
          [
            // Progress indicator
            if (props.indeterminate)
              dom.div(
                classes: 'codex-progress-indicator indeterminate',
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'top': '0',
                  'left': '0',
                  'height': '100%',
                  'width': '40%',
                  'background-color': indicatorColor,
                  'border-radius': 'var(--arcane-radius-full)',
                  if (glowColor != null) 'box-shadow': glowColor,
                  'animation': 'codex-progress-indeterminate 1.5s ease-in-out infinite',
                }),
                [],
              )
            else
              dom.div(
                classes: 'codex-progress-indicator',
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'top': '0',
                  'left': '0',
                  'height': '100%',
                  'width': '$percentage%',
                  'background-color': indicatorColor,
                  'border-radius': 'var(--arcane-radius-full)',
                  if (glowColor != null) 'box-shadow': glowColor,
                  'transition': 'width 0.3s ease-out',
                }),
                [],
              ),
          ],
        ),

        // Value display
        if (props.showValue)
          dom.div(
            classes: 'codex-progress-value',
            styles: const dom.Styles(raw: {
              'margin-top': '0.5rem',
              'font-size': 'var(--font-size-xs)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--muted-foreground)',
              'text-align': 'right',
              'font-variant-numeric': 'tabular-nums',
            }),
            [Component.text('${percentage.toStringAsFixed(0)}%')],
          ),
      ],
    );
  }
}

/// Codex Circular Progress renderer.
class CodexCircularProgress extends StatelessComponent {
  final CircularProgressProps props;

  const CodexCircularProgress(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final double clampedValue = props.value.clamp(0.0, 1.0);
    final int percentage = (clampedValue * 100).round();

    final String size = props.size ?? '64px'; // Codex: slightly larger default
    final String strokeWidth = props.strokeWidth ?? '6px'; // Codex: thicker stroke
    final String fillColor = props.fillColor ?? 'var(--primary)';
    final String trackColor = props.trackColor ?? 'var(--muted)';

    return dom.div(
      classes: 'codex-circular-progress',
      attributes: {
        'role': 'progressbar',
        'aria-valuemin': '0',
        'aria-valuemax': '100',
        'aria-valuenow': '$percentage',
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': size,
        'height': size,
      }),
      [
        // Progress ring using conic gradient (CSS-based approach)
        dom.div(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'width': '100%',
            'height': '100%',
            'border-radius': 'var(--arcane-radius-full)',
            'background':
                'conic-gradient($fillColor 0deg ${clampedValue * 360}deg, $trackColor ${clampedValue * 360}deg 360deg)',
            'mask':
                'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
            '-webkit-mask':
                'radial-gradient(farthest-side, transparent calc(100% - $strokeWidth), #fff calc(100% - $strokeWidth))',
            // Codex: subtle glow
            'filter': 'drop-shadow(0 0 6px $fillColor)',
            'transition': 'all 0.3s ease-out',
          }),
          [],
        ),

        // Center content
        if (props.showPercentage || props.label != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            [
              if (props.showPercentage)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'font-variant-numeric': 'tabular-nums',
                  }),
                  [Component.text('$percentage%')],
                ),
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.625rem',
                    'color': 'var(--muted-foreground)',
                    'margin-top': '0.125rem',
                  }),
                  [Component.text(props.label!)],
                ),
            ],
          ),
      ],
    );
  }
}

/// Codex Loading Spinner renderer.
class CodexLoadingSpinner extends StatelessComponent {
  final LoadingSpinnerProps props;

  const CodexLoadingSpinner(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String size = props.size ?? '24px'; // Codex: slightly larger
    final String color = props.color ?? 'var(--primary)';

    return dom.span(
      classes: 'codex-loading-spinner',
      styles: dom.Styles(raw: {
        'display': 'inline-block',
        'width': size,
        'height': size,
        'border': '3px solid var(--muted)',
        'border-top-color': color,
        'border-radius': 'var(--arcane-radius-full)',
        'animation': 'arcane-spin 0.75s linear infinite',
        // Codex: subtle glow
        'box-shadow': '0 0 8px $color',
      }),
      [],
    );
  }
}
