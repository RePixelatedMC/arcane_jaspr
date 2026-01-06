/// Severity level for tracker cells
enum TrackerLevel {
  /// All fine / healthy
  fine,

  /// Warning state
  warning,

  /// Critical / error state
  critical,

  /// Unknown / no data
  unknown,
}

/// Data for a single tracker cell
class TrackerData {
  /// Tooltip text to show on hover
  final String? tooltip;

  /// Severity level
  final TrackerLevel level;

  /// Optional value for the cell
  final double? value;

  /// Optional label
  final String? label;

  const TrackerData({
    this.tooltip,
    required this.level,
    this.value,
    this.label,
  });
}

/// Data for a single day in uptime tracker
class UptimeDay {
  /// The date
  final DateTime date;

  /// Uptime percentage (0-100)
  final double uptime;

  /// Optional incidents for this day
  final int incidents;

  const UptimeDay({
    required this.date,
    required this.uptime,
    this.incidents = 0,
  });
}

/// Properties for tracker components.
class TrackerProps {
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

  const TrackerProps({
    required this.data,
    this.columns = 12,
    this.cellSize = 12,
    this.gap = 3,
    this.showTooltips = true,
    this.showLegend = false,
    this.levelColors,
    this.onCellTap,
  });
}

/// Properties for uptime tracker components.
class UptimeTrackerProps {
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

  const UptimeTrackerProps({
    required this.days,
    this.barHeight = 32,
    this.barWidth = 4,
    this.gap = 2,
    this.showDates = false,
    this.showPercentage = true,
  });
}
