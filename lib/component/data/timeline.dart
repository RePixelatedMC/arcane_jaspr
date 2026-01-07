import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/timeline_props.dart';

/// Timeline item data.
class ArcaneTimelineItem {
  final String title;
  final String? subtitle;
  final String? description;
  final String? date;
  final Component? icon;
  final TimelineStatus status;
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

/// Timeline component for displaying chronological events or process steps.
class ArcaneTimeline extends StatelessComponent {
  final List<ArcaneTimelineItem> items;
  final TimelineLayout layout;
  final TimelineSize size;
  final bool showConnectors;

  const ArcaneTimeline({
    required this.items,
    this.layout = TimelineLayout.vertical,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  });

  const ArcaneTimeline.vertical({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.vertical;

  const ArcaneTimeline.horizontal({
    required this.items,
    this.size = TimelineSize.md,
    this.showConnectors = true,
    super.key,
  }) : layout = TimelineLayout.horizontal;

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

typedef ATimeline = ArcaneTimeline;
