import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/timeline_props.dart';

/// ShadCN Timeline renderer.
class ShadcnTimeline extends StatelessComponent {
  final TimelineProps props;

  const ShadcnTimeline(this.props, {super.key});

  String get _indicatorSize => switch (props.size) {
        TimelineSize.sm => '24px',
        TimelineSize.md => '32px',
        TimelineSize.lg => '40px',
      };

  String get _connectorWidth => switch (props.size) {
        TimelineSize.sm => '2px',
        TimelineSize.md => '2px',
        TimelineSize.lg => '3px',
      };

  String get _iconSize => switch (props.size) {
        TimelineSize.sm => '0.75rem',
        TimelineSize.md => '0.875rem',
        TimelineSize.lg => '1rem',
      };

  @override
  Component build(BuildContext context) {
    return switch (props.layout) {
      TimelineLayout.vertical => _buildVertical(),
      TimelineLayout.horizontal => _buildHorizontal(),
      TimelineLayout.alternating => _buildAlternating(),
    };
  }

  Component _buildVertical() {
    return dom.div(
      classes: 'arcane-timeline arcane-timeline-vertical',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildVerticalItem(props.items[i], i),
      ],
    );
  }

  Component _buildVerticalItem(TimelineItemData item, int index) {
    final isLast = index == props.items.length - 1;
    final colors = _getStatusColors(item.status);

    return dom.div(
      classes: 'arcane-timeline-item',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '1.5rem',
        'position': 'relative',
        'padding-bottom': isLast ? '0' : '2rem',
      }),
      [
        // Indicator column
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            _buildIndicator(item, colors),
            if (props.showConnectors && !isLast)
              dom.div(
                classes: 'arcane-timeline-connector',
                styles: dom.Styles(raw: {
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
        dom.div(
          styles: const dom.Styles(raw: {
            'flex': '1',
            'padding-top': '4px',
          }),
          [_buildContent(item, colors)],
        ),
      ],
    );
  }

  Component _buildHorizontal() {
    return dom.div(
      classes: 'arcane-timeline arcane-timeline-horizontal',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'width': '100%',
        'overflow-x': 'auto',
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildHorizontalItem(props.items[i], i),
      ],
    );
  }

  Component _buildHorizontalItem(TimelineItemData item, int index) {
    final isLast = index == props.items.length - 1;
    final colors = _getStatusColors(item.status);

    return dom.div(
      classes: 'arcane-timeline-item',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'flex': isLast ? '0 0 auto' : '1',
        'min-width': '120px',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            _buildIndicator(item, colors),
            if (props.showConnectors && !isLast)
              dom.div(
                classes: 'arcane-timeline-connector',
                styles: dom.Styles(raw: {
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
        dom.div(
          styles: const dom.Styles(raw: {
            'margin-top': '1rem',
            'text-align': 'center',
            'padding-right': '1rem',
          }),
          [_buildContent(item, colors, centered: true)],
        ),
      ],
    );
  }

  Component _buildAlternating() {
    return dom.div(
      classes: 'arcane-timeline arcane-timeline-alternating',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'position': 'relative',
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildAlternatingItem(props.items[i], i),
      ],
    );
  }

  Component _buildAlternatingItem(TimelineItemData item, int index) {
    final isLast = index == props.items.length - 1;
    final isEven = index % 2 == 0;
    final colors = _getStatusColors(item.status);

    return dom.div(
      classes: 'arcane-timeline-item',
      styles: dom.Styles(raw: {
        'display': 'grid',
        'grid-template-columns': '1fr auto 1fr',
        'gap': '1.5rem',
        'position': 'relative',
        'padding-bottom': isLast ? '0' : '2rem',
      }),
      [
        // Left content
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'flex',
            'justify-content': 'flex-end',
            'padding-top': '4px',
            'visibility': isEven ? 'visible' : 'hidden',
          }),
          [if (isEven) _buildContent(item, colors, alignEnd: true)],
        ),
        // Center indicator
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'position': 'relative',
          }),
          [
            _buildIndicator(item, colors),
            if (props.showConnectors && !isLast)
              dom.div(
                classes: 'arcane-timeline-connector',
                styles: dom.Styles(raw: {
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
        // Right content
        dom.div(
          styles: dom.Styles(raw: {
            'padding-top': '4px',
            'visibility': !isEven ? 'visible' : 'hidden',
          }),
          [if (!isEven) _buildContent(item, colors)],
        ),
      ],
    );
  }

  Component _buildIndicator(TimelineItemData item, Map<String, String> colors) {
    final isFilled = item.status == TimelineStatus.complete ||
        item.status == TimelineStatus.current;

    return dom.div(
      classes:
          'arcane-timeline-indicator arcane-timeline-indicator-${item.status.name}',
      styles: dom.Styles(raw: {
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
        if (item.icon != null)
          item.icon!
        else if (item.status == TimelineStatus.complete)
          dom.span([Component.text('\u2713')])
        else if (item.status == TimelineStatus.error)
          dom.span([Component.text('\u2715')])
        else if (item.status == TimelineStatus.current)
          dom.div(
            styles: dom.Styles(raw: {
              'width': '8px',
              'height': '8px',
              'border-radius': '9999px',
              'background': colors['text']!,
            }),
            [],
          )
        else
          dom.div(
            styles: const dom.Styles(raw: {
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
    TimelineItemData item,
    Map<String, String> colors, {
    bool centered = false,
    bool alignEnd = false,
  }) {
    final textAlign =
        centered ? 'center' : (alignEnd ? 'right' : 'left');

    return dom.div(
      classes: 'arcane-timeline-content',
      styles: dom.Styles(raw: {'text-align': textAlign}),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': '0.5rem',
            'margin-bottom': '0.25rem',
          }),
          [
            dom.span(
              styles: dom.Styles(raw: {
                'font-size': '1rem',
                'font-weight': '600',
                'color': item.status == TimelineStatus.pending
                    ? 'var(--muted-foreground)'
                    : 'var(--foreground)',
              }),
              [Component.text(item.title)],
            ),
            if (item.date != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(item.date!)],
              ),
          ],
        ),
        if (item.subtitle != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'margin-bottom': '0.25rem',
            }),
            [Component.text(item.subtitle!)],
          ),
        if (item.content != null)
          dom.div(
            styles: const dom.Styles(raw: {'margin-top': '0.5rem'}),
            [item.content!],
          )
        else if (item.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--muted-foreground)',
              'line-height': '1.7',
            }),
            [Component.text(item.description!)],
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
