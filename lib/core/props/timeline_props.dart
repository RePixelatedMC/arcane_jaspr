import 'package:jaspr/jaspr.dart';

enum TimelineLayout {
  vertical,
  horizontal,
  alternating,
}

enum TimelineStatus {
  default_,
  complete,
  current,
  pending,
  error,
}

enum TimelineSize {
  sm,
  md,
  lg,
}

/// Timeline item data.
class TimelineItemData {
  final String title;
  final String? subtitle;
  final String? description;
  final String? date;
  final Component? icon;
  final TimelineStatus status;
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

/// Timeline component properties.
class TimelineProps {
  final List<TimelineItemData> items;
  final TimelineLayout layout;
  final TimelineSize size;
  final bool showConnectors;

  const TimelineProps({
    required this.items,
    this.layout = TimelineLayout.vertical,
    this.size = TimelineSize.md,
    this.showConnectors = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for timeline components.
mixin TimelineRendererContract {
  Component timeline(TimelineProps props);
}
