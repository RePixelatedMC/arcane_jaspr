import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

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

/// Timeline item data
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
}

/// Timeline size options
enum TimelineSize {
  sm,
  md,
  lg,
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

  String get _indicatorSize => switch (size) {
        TimelineSize.sm => '24px',
        TimelineSize.md => '32px',
        TimelineSize.lg => '40px',
      };

  String get _connectorWidth => switch (size) {
        TimelineSize.sm => '2px',
        TimelineSize.md => '2px',
        TimelineSize.lg => '3px',
      };

  String get _iconSize => switch (size) {
        TimelineSize.sm => '0.75rem',
        TimelineSize.md => '0.875rem',
        TimelineSize.lg => '1rem',
      };

  @override
  Component build(BuildContext context) {
    return switch (layout) {
      TimelineLayout.vertical => _buildVertical(),
      TimelineLayout.horizontal => _buildHorizontal(),
      TimelineLayout.alternating => _buildAlternating(),
    };
  }

  Component _buildVertical() {
    return div(
      classes: 'arcane-timeline arcane-timeline-vertical',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < items.length; i++) _buildVerticalItem(items[i], i),
      ],
    );
  }

  Component _buildVerticalItem(ArcaneTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final colors = _getStatusColors(item.status);

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'flex',
        'gap': '1.5rem',
        'position': 'relative',
        'padding-bottom': isLast ? '0' : '2rem',
      }),
      [
        // Indicator and connector column
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            // Indicator
            _buildIndicator(item, colors),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-timeline-connector',
                styles: Styles(raw: {
                  'width': _connectorWidth,
                  'flex': '1',
                  'min-height': '1.5rem',
                  'background': item.status == TimelineStatus.complete
                      ? colors['line']!
                      : 'var(--border)',
                  'position': 'absolute',
                  'top': _indicatorSize,
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Content column
        div(
          styles: const Styles(raw: {
            'flex': '1',
            'padding-top': '4px',
          }),
          [
            _buildContent(item, colors),
          ],
        ),
      ],
    );
  }

  Component _buildHorizontal() {
    return div(
      classes: 'arcane-timeline arcane-timeline-horizontal',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
        'overflow-x': 'auto',
      }),
      [
        for (var i = 0; i < items.length; i++) _buildHorizontalItem(items[i], i),
      ],
    );
  }

  Component _buildHorizontalItem(ArcaneTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final colors = _getStatusColors(item.status);

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
        'min-width': '120px',
      }),
      [
        // Indicator row with connectors
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            _buildIndicator(item, colors),
            // Connector line
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-timeline-connector',
                styles: Styles(raw: {
                  'flex': '1',
                  'height': _connectorWidth,
                  'background': item.status == TimelineStatus.complete
                      ? colors['line']!
                      : 'var(--border)',
                  'margin': '0 0.5rem',
                }),
                [],
              ),
          ],
        ),
        // Content below
        div(
          styles: const Styles(raw: {
            'margin-top': '1rem',
            'text-align': 'center',
            'padding-right': '1rem',
          }),
          [
            _buildContent(item, colors, centered: true),
          ],
        ),
      ],
    );
  }

  Component _buildAlternating() {
    return div(
      classes: 'arcane-timeline arcane-timeline-alternating',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildAlternatingItem(items[i], i),
      ],
    );
  }

  Component _buildAlternatingItem(ArcaneTimelineItem item, int index) {
    final isLast = index == items.length - 1;
    final isEven = index % 2 == 0;
    final colors = _getStatusColors(item.status);

    return div(
      classes: 'arcane-timeline-item',
      styles: Styles(raw: {
        'display': 'grid',
        'grid-template-columns': '1fr auto 1fr',
        'gap': '1.5rem',
        'position': 'relative',
        'padding-bottom': isLast ? '0' : '2rem',
      }),
      [
        // Left content (shows on even indexes)
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'justify-content': 'flex-end',
            'padding-top': '4px',
            'visibility': isEven ? 'visible' : 'hidden',
          }),
          [
            if (isEven) _buildContent(item, colors, alignEnd: true),
          ],
        ),
        // Center indicator column
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            _buildIndicator(item, colors),
            if (showConnectors && !isLast)
              div(
                classes: 'arcane-timeline-connector',
                styles: Styles(raw: {
                  'width': _connectorWidth,
                  'flex': '1',
                  'min-height': '1.5rem',
                  'background': item.status == TimelineStatus.complete
                      ? colors['line']!
                      : 'var(--border)',
                  'position': 'absolute',
                  'top': _indicatorSize,
                  'bottom': '0',
                }),
                [],
              ),
          ],
        ),
        // Right content (shows on odd indexes)
        div(
          styles: Styles(raw: {
            'padding-top': '4px',
            'visibility': !isEven ? 'visible' : 'hidden',
          }),
          [
            if (!isEven) _buildContent(item, colors),
          ],
        ),
      ],
    );
  }

  Component _buildIndicator(
      ArcaneTimelineItem item, Map<String, String> colors) {
    final hasCustomIcon = item.icon != null;
    final isFilled =
        item.status == TimelineStatus.complete ||
        item.status == TimelineStatus.current;

    return div(
      classes: 'arcane-timeline-indicator arcane-timeline-indicator-${item.status.name}',
      styles: Styles(raw: {
        'width': _indicatorSize,
        'height': _indicatorSize,
        'border-radius': '9999px',
        'background': isFilled ? colors['bg']! : 'var(--background)',
        'border': '2px solid ${colors['border']!}',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'font-size': _iconSize,
        'font-weight': '600',
        'color': isFilled ? colors['text']! : colors['border']!,
        'flex-shrink': '0',
        'z-index': '1',
        'transition': 'all 150ms ease',
      }),
      [
        if (hasCustomIcon)
          item.icon!
        else if (item.status == TimelineStatus.complete)
          span([text('✓')])
        else if (item.status == TimelineStatus.error)
          span([text('✕')])
        else if (item.status == TimelineStatus.current)
          div(
            styles: Styles(raw: {
              'width': '8px',
              'height': '8px',
              'border-radius': '9999px',
              'background': colors['text']!,
            }),
            [],
          )
        else
          div(
            styles: const Styles(raw: {
              'width': '8px',
              'height': '8px',
              'border-radius': '9999px',
              'background': 'var(--border)',
            }),
            [],
          ),
      ],
    );
  }

  Component _buildContent(
    ArcaneTimelineItem item,
    Map<String, String> colors, {
    bool centered = false,
    bool alignEnd = false,
  }) {
    final textAlign = centered
        ? 'center'
        : alignEnd
            ? 'right'
            : 'left';

    return div(
      classes: 'arcane-timeline-content',
      styles: Styles(raw: {
        'text-align': textAlign,
      }),
      [
        // Title row with date
        div(
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': '0.5rem',
            'margin-bottom': '0.25rem',
          }),
          [
            span(
              styles: Styles(raw: {
                'font-size': '1rem',
                'font-weight': '600',
                'color': item.status == TimelineStatus.pending
                    ? 'var(--muted-foreground)'
                    : 'var(--foreground)',
              }),
              [text(item.title)],
            ),
            if (item.date != null)
              span(
                styles: const Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                }),
                [text(item.date!)],
              ),
          ],
        ),
        // Subtitle
        if (item.subtitle != null)
          div(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'margin-bottom': '0.25rem',
            }),
            [text(item.subtitle!)],
          ),
        // Description or custom content
        if (item.content != null)
          div(
            styles: const Styles(raw: {
              'margin-top': '0.5rem',
            }),
            [item.content!],
          )
        else if (item.description != null)
          div(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'line-height': '1.7',
            }),
            [text(item.description!)],
          ),
      ],
    );
  }

  Map<String, String> _getStatusColors(TimelineStatus status) {
    return switch (status) {
      TimelineStatus.complete => {
          'bg': 'hsl(142 76% 36%)',
          'border': 'hsl(142 76% 36%)',
          'text': 'var(--background)',
          'line': 'hsl(142 76% 36%)',
        },
      TimelineStatus.current => {
          'bg': 'var(--accent)',
          'border': 'var(--accent)',
          'text': 'var(--background)',
          'line': 'var(--accent)',
        },
      TimelineStatus.pending => {
          'bg': 'transparent',
          'border': 'var(--border)',
          'text': 'var(--muted-foreground)',
          'line': 'var(--border)',
        },
      TimelineStatus.error => {
          'bg': 'var(--destructive)',
          'border': 'var(--destructive)',
          'text': 'var(--background)',
          'line': 'var(--destructive)',
        },
      TimelineStatus.default_ => {
          'bg': 'transparent',
          'border': 'var(--border)',
          'text': 'var(--muted-foreground)',
          'line': 'var(--border)',
        },
    };
  }
}

/// Alias for ArcaneTimeline
typedef ATimeline = ArcaneTimeline;
