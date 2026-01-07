import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/tracker_props.dart';

/// Dense status grid for time-series or health indicators.
class ArcaneTracker extends StatelessComponent {
  final List<TrackerData> data;
  final int columns;
  final int cellSize;
  final int gap;
  final bool showTooltips;
  final bool showLegend;
  final Map<TrackerLevel, String>? levelColors;
  final void Function(int index, TrackerData data)? onCellTap;

  const ArcaneTracker({
    required this.data,
    this.columns = 12,
    this.cellSize = 12,
    this.gap = 3,
    this.showTooltips = true,
    this.showLegend = false,
    this.levelColors,
    this.onCellTap,
    super.key,
  });

  const ArcaneTracker.weekly({
    required this.data,
    this.cellSize = 14,
    this.gap = 3,
    this.showTooltips = true,
    this.showLegend = true,
    this.levelColors,
    this.onCellTap,
    super.key,
  }) : columns = 7;

  const ArcaneTracker.monthly({
    required this.data,
    this.cellSize = 12,
    this.gap = 2,
    this.showTooltips = true,
    this.showLegend = true,
    this.levelColors,
    this.onCellTap,
    super.key,
  }) : columns = 31;

  @override
  Component build(BuildContext context) {
    return context.renderers.tracker(TrackerProps(
      data: data,
      columns: columns,
      cellSize: cellSize,
      gap: gap,
      showTooltips: showTooltips,
      showLegend: showLegend,
      levelColors: levelColors,
      onCellTap: onCellTap,
    ));
  }
}

/// Uptime tracker showing percentage bars.
class ArcaneUptimeTracker extends StatelessComponent {
  final List<UptimeDay> days;
  final int barHeight;
  final int barWidth;
  final int gap;
  final bool showDates;
  final bool showPercentage;

  const ArcaneUptimeTracker({
    required this.days,
    this.barHeight = 32,
    this.barWidth = 4,
    this.gap = 2,
    this.showDates = false,
    this.showPercentage = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.uptimeTracker(UptimeTrackerProps(
      days: days,
      barHeight: barHeight,
      barWidth: barWidth,
      gap: gap,
      showDates: showDates,
      showPercentage: showPercentage,
    ));
  }
}
