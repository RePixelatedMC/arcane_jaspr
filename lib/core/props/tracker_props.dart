enum TrackerLevel {
  fine,
  warning,
  critical,
  unknown,
}

/// Tracker cell data.
class TrackerData {
  final String? tooltip;
  final TrackerLevel level;
  final double? value;
  final String? label;

  const TrackerData({
    this.tooltip,
    required this.level,
    this.value,
    this.label,
  });
}

/// Uptime day data.
class UptimeDay {
  final DateTime date;
  final double uptime;
  final int incidents;

  const UptimeDay({
    required this.date,
    required this.uptime,
    this.incidents = 0,
  });
}

/// Tracker component properties.
class TrackerProps {
  final List<TrackerData> data;
  final int columns;
  final int cellSize;
  final int gap;
  final bool showTooltips;
  final bool showLegend;
  final Map<TrackerLevel, String>? levelColors;
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

/// Uptime tracker component properties.
class UptimeTrackerProps {
  final List<UptimeDay> days;
  final int barHeight;
  final int barWidth;
  final int gap;
  final bool showDates;
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
