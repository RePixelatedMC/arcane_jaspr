import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/timeline_props.dart';

/// Timeline item data (alias for convenience)
class ArcaneTimelineItem {
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

  const ArcaneTimelineItem({
    required this.title,
    this.subtitle,
    this.description,
    this.date,
    this.icon,
    this.status = TimelineStatus.default_,
    this.content,
  });

  /// Convert to TimelineItemData for the renderer
  TimelineItemData toData() => TimelineItemData(
        title: title,
        subtitle: subtitle,
        description: description,
        date: date,
        icon: icon,
        status: status,
        content: content,
      );
}

/// A timeline component for displaying chronological events or process steps.
///
/// Supports vertical, horizontal, and alternating layouts.
///
/// ```dart
/// ArcaneTimeline(
///   items: [
///     ArcaneTimelineItem(
///       title: 'Step 1',
///       description: 'First step',
///       status: TimelineStatus.complete,
///     ),
///     ArcaneTimelineItem(
///       title: 'Step 2',
///       description: 'Current step',
///       status: TimelineStatus.current,
///     ),
///   ],
/// )
/// ```
class ArcaneTimeline extends StatelessComponent {
  /// Timeline items
  final List<ArcaneTimelineItem> items;

  /// Layout type
  final TimelineLayout layout;

  /// Size
  final TimelineSize size;

  /// Whether to show connector lines
  final bool showConnectors;

  const ArcaneTimeline({
    required this.items,
    this.layout = TimelineLayout.vertical,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  });

  /// Vertical layout timeline
  const ArcaneTimeline.vertical({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.vertical;

  /// Horizontal layout timeline
  const ArcaneTimeline.horizontal({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.horizontal;

  /// Alternating layout timeline
  const ArcaneTimeline.alternating({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.alternating;

  @override
  Component build(BuildContext context) {
    return context.renderers.timeline(TimelineProps(
      items: items.map((item) => item.toData()).toList(),
      layout: layout,
      size: size,
      showConnectors: showConnectors,
    ));
  }
}

/// Alias for ArcaneTimeline
typedef ATimeline = ArcaneTimeline;
