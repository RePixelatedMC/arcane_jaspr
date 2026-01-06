import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/tracker_props.dart';

/// A dense status grid for time-series or health indicators.
///
/// Similar to GitHub's contribution graph or uptime status grids.
///
/// ```dart
/// ArcaneTracker(
///   data: List.generate(90, (i) => TrackerData(
///     level: TrackerLevel.fine,
///     tooltip: 'Day ${i + 1}: 100% uptime',
///   )),
/// )
/// ```
class ArcaneTracker extends StatelessComponent {
  /// List of tracker data points
  final List<TrackerData> data;

  /// Number of columns (items per row)
  final int columns;

  /// Cell size in pixels
  final int cellSize;

  /// Gap between cells in pixels
  final int gap;

  /// Whether to show tooltips on hover
  final bool showTooltips;

  /// Whether to show a legend
  final bool showLegend;

  /// Custom colors for levels
  final Map<TrackerLevel, String>? levelColors;

  /// Callback when a cell is clicked
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

  /// Creates a week-based tracker (7 columns)
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

  /// Creates a month-based tracker
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

/// Uptime tracker showing percentage bars
///
/// ```dart
/// ArcaneUptimeTracker(
///   days: [
///     UptimeDay(date: DateTime.now(), uptime: 100),
///     UptimeDay(date: DateTime.now().subtract(Duration(days: 1)), uptime: 99.5),
///   ],
/// )
/// ```
class ArcaneUptimeTracker extends StatelessComponent {
  /// List of uptime data by day
  final List<UptimeDay> days;

  /// Height of bars in pixels
  final int barHeight;

  /// Width of each bar in pixels
  final int barWidth;

  /// Gap between bars
  final int gap;

  /// Whether to show date labels
  final bool showDates;

  /// Whether to show percentage on hover
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
