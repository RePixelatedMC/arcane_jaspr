import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/meter_props.dart';

/// Codex Meter renderer.
///
/// Implements the Codex design language:
/// - Accent-colored fill with subtle glow
/// - Larger track height
/// - OLED-optimized dark background
class CodexMeter extends StatelessComponent {
  final MeterProps props;

  const CodexMeter(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes
    final String trackHeight = switch (props.size) {
      MeterSizeVariant.sm => '6px',
      MeterSizeVariant.md => '10px', // Codex: larger
      MeterSizeVariant.lg => '14px',
    };

    if (props.style == MeterStyleVariant.circular) {
      return _buildCircular(trackHeight);
    }

    if (props.style == MeterStyleVariant.segmented) {
      return _buildSegmented(trackHeight);
    }

    return _buildBar(trackHeight);
  }

  Component _buildBar(String trackHeight) {
    final String fillColor = _getFillColor();

    return dom.div(
      classes: 'codex-meter codex-meter-bar',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
        'width': '100%',
      }),
      [
        // Label row
        if (props.label != null || props.showValue)
          dom.div(
            classes: 'codex-meter-label-row',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                  }),
                  [
                    Component.text(
                        '${props.value.toStringAsFixed(0)}${props.valueSuffix ?? ''}')
                  ],
                ),
            ],
          ),

        // Track
        dom.div(
          classes: 'codex-meter-track',
          styles: dom.Styles(raw: {
            'width': '100%',
            'height': trackHeight,
            'background-color': 'var(--secondary)',
            'border-radius': 'var(--radius-full)',
            'overflow': 'hidden',
          }),
          [
            // Fill
            dom.div(
              classes: 'codex-meter-fill',
              styles: dom.Styles(raw: {
                'height': '100%',
                'width': '${props.percentage}%',
                'background-color':
                    props.style == MeterStyleVariant.gradient
                        ? 'unset'
                        : fillColor,
                if (props.style == MeterStyleVariant.gradient)
                  'background': 'linear-gradient(90deg, var(--success), var(--warning), var(--destructive))',
                'border-radius': 'var(--radius-full)',
                'transition': 'width 0.3s ease',
                'box-shadow': '0 0 8px ${fillColor}40',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildSegmented(String trackHeight) {
    final double segmentFill = props.percentage / 100 * props.segments;

    return dom.div(
      classes: 'codex-meter codex-meter-segmented',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
        'width': '100%',
      }),
      [
        // Label row
        if (props.label != null || props.showValue)
          dom.div(
            classes: 'codex-meter-label-row',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'justify-content': 'space-between',
              'align-items': 'center',
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.showValue)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                  }),
                  [
                    Component.text(
                        '${props.value.toStringAsFixed(0)}${props.valueSuffix ?? ''}')
                  ],
                ),
            ],
          ),

        // Segments
        dom.div(
          classes: 'codex-meter-segments',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'gap': '3px',
            'width': '100%',
            'height': trackHeight,
          }),
          [
            for (int i = 0; i < props.segments; i++)
              dom.div(
                classes: 'codex-meter-segment',
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'height': '100%',
                  'background-color':
                      i < segmentFill ? _getSegmentColor(i) : 'var(--secondary)',
                  'border-radius': 'var(--radius-xs)',
                  'transition': 'background-color 0.2s ease',
                  if (i < segmentFill)
                    'box-shadow': '0 0 6px ${_getSegmentColor(i)}40',
                }),
                [],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildCircular(String trackHeight) {
    final String fillColor = _getFillColor();
    final String size = switch (props.size) {
      MeterSizeVariant.sm => '64px',
      MeterSizeVariant.md => '80px',
      MeterSizeVariant.lg => '100px',
    };
    final String strokeWidth = switch (props.size) {
      MeterSizeVariant.sm => '4px',
      MeterSizeVariant.md => '6px',
      MeterSizeVariant.lg => '8px',
    };

    return dom.div(
      classes: 'codex-meter codex-meter-circular',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'gap': 'var(--space-2)',
      }),
      [
        // Circular meter using CSS conic-gradient
        dom.div(
          classes: 'codex-meter-circle',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': size,
            'height': size,
            'border-radius': '50%',
            'background': 'conic-gradient($fillColor ${props.percentage * 3.6}deg, var(--secondary) 0deg)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
          }),
          [
            // Inner circle (creates the donut)
            dom.div(
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'width': 'calc(100% - $strokeWidth * 2)',
                'height': 'calc(100% - $strokeWidth * 2)',
                'border-radius': '50%',
                'background-color': 'var(--background)',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
              }),
              [
                if (props.showValue)
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'font-size': 'var(--font-size-base)',
                      'font-weight': 'var(--font-weight-semibold)',
                      'color': 'var(--foreground)',
                    }),
                    [
                      Component.text(
                          '${props.value.toStringAsFixed(0)}${props.valueSuffix ?? '%'}')
                    ],
                  ),
              ],
            ),
          ],
        ),

        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }

  String _getFillColor() {
    if (props.color == MeterColorVariant.adaptive) {
      // Adaptive color based on value
      if (props.percentage < 33) {
        return 'var(--success)';
      } else if (props.percentage < 66) {
        return 'var(--warning)';
      } else {
        return 'var(--destructive)';
      }
    }

    return switch (props.color) {
      MeterColorVariant.primary => 'var(--primary)',
      MeterColorVariant.success => 'var(--success)',
      MeterColorVariant.warning => 'var(--warning)',
      MeterColorVariant.error => 'var(--destructive)',
      MeterColorVariant.adaptive => 'var(--primary)', // Fallback
    };
  }

  String _getSegmentColor(int index) {
    if (props.color == MeterColorVariant.adaptive) {
      final double segmentPercentage = (index + 1) / props.segments * 100;
      if (segmentPercentage < 33) {
        return 'var(--success)';
      } else if (segmentPercentage < 66) {
        return 'var(--warning)';
      } else {
        return 'var(--destructive)';
      }
    }
    return _getFillColor();
  }
}