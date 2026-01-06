import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/meter_props.dart';

/// ShadCN Meter renderer.
///
/// Progress meter/gauge component with multiple styles.
class ShadcnMeter extends StatelessComponent {
  final MeterProps props;

  const ShadcnMeter(this.props, {super.key});

  String get _adaptiveColor {
    final pct = props.percentage;
    if (props.high != null && pct >= props.high!) {
      return 'var(--destructive)';
    }
    if (props.low != null && pct <= props.low!) {
      return 'var(--destructive)';
    }
    if (pct >= 80) {
      return 'var(--warning, #f59e0b)';
    }
    return 'var(--success, #22c55e)';
  }

  String get _barColor => switch (props.color) {
        MeterColorVariant.primary => 'var(--primary)',
        MeterColorVariant.success => 'var(--success, #22c55e)',
        MeterColorVariant.warning => 'var(--warning, #f59e0b)',
        MeterColorVariant.error => 'var(--destructive)',
        MeterColorVariant.adaptive => _adaptiveColor,
      };

  (String height, String fontSize) get _sizeStyles => switch (props.size) {
        MeterSizeVariant.sm => ('6px', '0.75rem'),
        MeterSizeVariant.md => ('10px', '0.875rem'),
        MeterSizeVariant.lg => ('16px', '1rem'),
      };

  @override
  Component build(BuildContext context) {
    final (height, fontSize) = _sizeStyles;

    if (props.style == MeterStyleVariant.circular) {
      return _buildCircularMeter(fontSize);
    }

    return dom.div(
      classes: 'arcane-meter',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
        'width': '100%',
      }),
      [
        // Header with label and value
        if (props.label != null || props.showValue)
          dom.div(
            classes: 'arcane-meter-header',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
              'font-size': fontSize,
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--foreground)',
                    'font-weight': '500',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  styles: dom.Styles(raw: {
                    'color': _barColor,
                    'font-weight': '600',
                  }),
                  [Component.text('${props.value.toStringAsFixed(0)}${props.valueSuffix ?? ''}')],
                ),
            ],
          ),

        // Meter bar
        if (props.style == MeterStyleVariant.segmented)
          _buildSegmentedMeter(height)
        else
          _buildBarMeter(height),
      ],
    );
  }

  Component _buildBarMeter(String height) {
    final isGradient = props.style == MeterStyleVariant.gradient;

    return dom.div(
      classes: 'arcane-meter-track',
      styles: dom.Styles(raw: {
        'width': '100%',
        'height': height,
        'background-color': 'var(--muted)',
        'border-radius': '9999px',
        'overflow': 'hidden',
      }),
      [
        dom.div(
          classes: 'arcane-meter-fill',
          styles: dom.Styles(raw: {
            'width': '${props.percentage}%',
            'height': '100%',
            'background': isGradient
                ? 'linear-gradient(90deg, var(--success, #22c55e) 0%, var(--warning, #f59e0b) 50%, var(--destructive) 100%)'
                : _barColor,
            'border-radius': '9999px',
            'transition': 'width 0.3s ease',
          }),
          [],
        ),
      ],
    );
  }

  Component _buildSegmentedMeter(String height) {
    final activeSegments = (props.percentage / 100 * props.segments).ceil();

    return dom.div(
      classes: 'arcane-meter-segments',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'gap': '3px',
        'width': '100%',
      }),
      [
        for (var i = 0; i < props.segments; i++)
          dom.div(
            classes: 'arcane-meter-segment',
            styles: dom.Styles(raw: {
              'flex': '1',
              'height': height,
              'background-color': i < activeSegments ? _barColor : 'var(--muted)',
              'border-radius': '2px',
              'transition': 'background-color 0.3s ease',
            }),
            [],
          ),
      ],
    );
  }

  Component _buildCircularMeter(String fontSize) {
    const circleSize = 80;
    const strokeWidth = 8;
    final circumference = 2 * 3.14159 * ((circleSize - strokeWidth) / 2);
    final dashOffset = circumference * (1 - props.percentage / 100);

    return dom.div(
      classes: 'arcane-meter-circular',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': '0.5rem',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'position': 'relative',
            'width': '${circleSize}px',
            'height': '${circleSize}px',
          }),
          [
            // SVG circle
            Component.element(
              tag: 'svg',
              attributes: {
                'width': '$circleSize',
                'height': '$circleSize',
                'viewBox': '0 0 $circleSize $circleSize',
              },
              styles: const dom.Styles(raw: {
                'transform': 'rotate(-90deg)',
              }),
              children: [
                // Background circle
                Component.element(
                  tag: 'circle',
                  attributes: {
                    'cx': '${circleSize / 2}',
                    'cy': '${circleSize / 2}',
                    'r': '${(circleSize - strokeWidth) / 2}',
                    'fill': 'none',
                    'stroke': 'var(--muted)',
                    'stroke-width': '$strokeWidth',
                  },
                  children: const [],
                ),
                // Progress circle
                Component.element(
                  tag: 'circle',
                  attributes: {
                    'cx': '${circleSize / 2}',
                    'cy': '${circleSize / 2}',
                    'r': '${(circleSize - strokeWidth) / 2}',
                    'fill': 'none',
                    'stroke': _barColor,
                    'stroke-width': '$strokeWidth',
                    'stroke-linecap': 'round',
                    'stroke-dasharray': '$circumference',
                    'stroke-dashoffset': '$dashOffset',
                  },
                  styles: const dom.Styles(raw: {
                    'transition': 'stroke-dashoffset 0.3s ease',
                  }),
                  children: const [],
                ),
              ],
            ),
            // Center value
            if (props.showValue)
              dom.div(
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'top': '50%',
                  'left': '50%',
                  'transform': 'translate(-50%, -50%)',
                  'font-size': fontSize,
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                }),
                [Component.text('${props.value.toStringAsFixed(0)}${props.valueSuffix ?? ''}')],
              ),
          ],
        ),
        if (props.label != null)
          dom.span(
            styles: dom.Styles(raw: {
              'font-size': fontSize,
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}
