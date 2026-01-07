import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/meter_props.dart'
    show MeterStyleVariant, MeterColorVariant, MeterSizeVariant, MeterProps;

typedef MeterStyle = MeterStyleVariant;
typedef MeterColor = MeterColorVariant;
typedef MeterSize = MeterSizeVariant;

/// Progress meter/gauge component displaying a value within a range.
class ArcaneMeter extends StatelessComponent {
  final double value;
  final double min;
  final double max;
  final double? low;
  final double? high;
  final double? optimum;
  final String? label;
  final bool showValue;
  final String? valueSuffix;
  final MeterStyle style;
  final MeterColor color;
  final MeterSize size;
  final int segments;

  const ArcaneMeter({
    required this.value,
    this.min = 0,
    this.max = 100,
    this.low,
    this.high,
    this.optimum,
    this.label,
    this.showValue = true,
    this.valueSuffix,
    this.style = MeterStyle.bar,
    this.color = MeterColor.primary,
    this.size = MeterSize.md,
    this.segments = 10,
    super.key,
  });

  const ArcaneMeter.storage({
    required this.value,
    this.max = 100,
    this.label = 'Storage',
    this.showValue = true,
    this.size = MeterSize.md,
    super.key,
  })  : min = 0,
        low = null,
        high = 80,
        optimum = null,
        valueSuffix = '%',
        style = MeterStyle.bar,
        color = MeterColor.adaptive,
        segments = 10;

  const ArcaneMeter.battery({
    required this.value,
    this.label,
    this.showValue = true,
    this.size = MeterSize.md,
    super.key,
  })  : min = 0,
        max = 100,
        low = 20,
        high = null,
        optimum = null,
        valueSuffix = '%',
        style = MeterStyle.segmented,
        color = MeterColor.adaptive,
        segments = 5;

  MeterStyleVariant get _propsStyle => switch (style) {
        MeterStyle.bar => MeterStyleVariant.bar,
        MeterStyle.gradient => MeterStyleVariant.gradient,
        MeterStyle.segmented => MeterStyleVariant.segmented,
        MeterStyle.circular => MeterStyleVariant.circular,
      };

  MeterColorVariant get _propsColor => switch (color) {
        MeterColor.primary => MeterColorVariant.primary,
        MeterColor.success => MeterColorVariant.success,
        MeterColor.warning => MeterColorVariant.warning,
        MeterColor.error => MeterColorVariant.error,
        MeterColor.adaptive => MeterColorVariant.adaptive,
      };

  MeterSizeVariant get _propsSize => switch (size) {
        MeterSize.sm => MeterSizeVariant.sm,
        MeterSize.md => MeterSizeVariant.md,
        MeterSize.lg => MeterSizeVariant.lg,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.meter(MeterProps(
      value: value,
      min: min,
      max: max,
      low: low,
      high: high,
      optimum: optimum,
      label: label,
      showValue: showValue,
      valueSuffix: valueSuffix,
      style: _propsStyle,
      color: _propsColor,
      size: _propsSize,
      segments: segments,
    ));
  }
}
