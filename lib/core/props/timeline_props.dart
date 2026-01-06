import 'package:jaspr/jaspr.dart';

/// Timeline layout options
enum TimelineLayout {
  /// Vertical layout with content on the right
  vertical,

  /// Horizontal layout
  horizontal,

  /// Alternating layout - content alternates left and right
  alternating,
}

/// Timeline item status
enum TimelineStatus {
  /// Default/neutral state
  default_,

  /// Completed step
  complete,

  /// Current/active step
  current,

  /// Pending/upcoming step
  pending,

  /// Error state
  error,
}

/// Timeline size options
enum TimelineSize {
  sm,
  md,
  lg,
}

/// Timeline item data
class TimelineItemData {
  /// Item title
  final String title;

  /// Optional subtitle (e.g., date, time)
  final String? subtitle;

  /// Optional description
  final String? description;

  /// Optional date/time string
  final String? date;

  /// Custom icon (if not provided, uses status-based default)
  final Component? icon;

  /// Item status
  final TimelineStatus status;

  /// Optional custom content (replaces description)
  final Component? content;

  const TimelineItemData({
    required this.title,
    this.subtitle,
    this.description,
    this.date,
    this.icon,
    this.status = TimelineStatus.default_,
    this.content,
  });
}

/// Properties for timeline components.
class TimelineProps {
  /// Timeline items
  final List<TimelineItemData> items;

  /// Layout type
  final TimelineLayout layout;

  /// Size
  final TimelineSize size;

  /// Whether to show connector lines
  final bool showConnectors;

  const TimelineProps({
    required this.items,
    this.layout = TimelineLayout.vertical,
    this.size = TimelineSize.md,
    this.showConnectors = true,
  });
}
