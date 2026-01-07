import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/timeline_props.dart';

/// Codex Timeline renderer.
///
/// Implements the Codex design language:
/// - Accent-colored connectors and active states
/// - Larger spacing
/// - Glow effects on active items
class CodexTimeline extends StatelessComponent {
  final TimelineProps props;

  const CodexTimeline(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes
    final (String dotSize, String fontSize, String gap) = switch (props.size) {
      TimelineSize.sm => ('10px', '0.8125rem', '1rem'),
      TimelineSize.md => ('14px', '0.9375rem', '1.5rem'), // Codex: larger
      TimelineSize.lg => ('18px', '1rem', '2rem'),
    };

    if (props.layout == TimelineLayout.horizontal) {
      return _buildHorizontal(dotSize, fontSize, gap);
    }

    return _buildVertical(dotSize, fontSize, gap);
  }

  Component _buildVertical(String dotSize, String fontSize, String gap) {
    return dom.div(
      classes: 'codex-timeline codex-timeline-vertical',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': gap,
      }),
      [
        for (int i = 0; i < props.items.length; i++)
          _buildVerticalItem(
            props.items[i],
            i,
            i == props.items.length - 1,
            dotSize,
            fontSize,
            props.layout == TimelineLayout.alternating && i % 2 == 1,
          ),
      ],
    );
  }

  Component _buildVerticalItem(
    TimelineItemData item,
    int index,
    bool isLast,
    String dotSize,
    String fontSize,
    bool isRight,
  ) {
    final (String dotColor, String dotGlow) = _getStatusStyles(item.status);

    return dom.div(
      classes:
          'codex-timeline-item ${item.status.name} ${isRight ? 'right' : 'left'}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '1rem', // Codex: larger gap
        if (isRight) 'flex-direction': 'row-reverse',
      }),
      [
        // Connector line and dot
        dom.div(
          classes: 'codex-timeline-connector',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'flex-shrink': '0',
          }),
          [
            // Dot
            dom.div(
              classes: 'codex-timeline-dot',
              styles: dom.Styles(raw: {
                'width': dotSize,
                'height': dotSize,
                'border-radius': '50%',
                'background-color': dotColor,
                'box-shadow': dotGlow,
                'flex-shrink': '0',
                'z-index': '1',
              }),
              [if (item.icon != null) item.icon!],
            ),

            // Line
            if (props.showConnectors && !isLast)
              dom.div(
                classes: 'codex-timeline-line',
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'width': '2px',
                  'min-height': '2rem',
                  'background-color': 'var(--border)',
                }),
                [],
              ),
          ],
        ),

        // Content
        dom.div(
          classes: 'codex-timeline-content',
          styles: dom.Styles(raw: {
            'flex': '1',
            'padding-bottom': isLast ? '0' : '1.5rem',
            if (isRight) 'text-align': 'right',
          }),
          [
            // Date
            if (item.date != null)
              dom.div(
                classes: 'codex-timeline-date',
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'margin-bottom': '0.25rem',
                }),
                [Component.text(item.date!)],
              ),

            // Title
            dom.div(
              classes: 'codex-timeline-title',
              styles: dom.Styles(raw: {
                'font-size': fontSize,
                'font-weight': '600',
                'color': item.status == TimelineStatus.current
                    ? 'var(--codex-accent)'
                    : 'var(--foreground)',
              }),
              [Component.text(item.title)],
            ),

            // Subtitle
            if (item.subtitle != null)
              dom.div(
                classes: 'codex-timeline-subtitle',
                styles: const dom.Styles(raw: {
                  'font-size': '0.8125rem',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
                }),
                [Component.text(item.subtitle!)],
              ),

            // Description or custom content
            if (item.content != null)
              dom.div(
                classes: 'codex-timeline-custom',
                styles: const dom.Styles(raw: {
                  'margin-top': '0.75rem',
                }),
                [item.content!],
              )
            else if (item.description != null)
              dom.div(
                classes: 'codex-timeline-description',
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.6',
                  'margin-top': '0.5rem',
                }),
                [Component.text(item.description!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildHorizontal(String dotSize, String fontSize, String gap) {
    return dom.div(
      classes: 'codex-timeline codex-timeline-horizontal',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'overflow-x': 'auto',
      }),
      [
        for (int i = 0; i < props.items.length; i++)
          _buildHorizontalItem(
            props.items[i],
            i,
            i == props.items.length - 1,
            dotSize,
            fontSize,
          ),
      ],
    );
  }

  Component _buildHorizontalItem(
    TimelineItemData item,
    int index,
    bool isLast,
    String dotSize,
    String fontSize,
  ) {
    final (String dotColor, String dotGlow) = _getStatusStyles(item.status);

    return dom.div(
      classes: 'codex-timeline-item-horizontal ${item.status.name}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'min-width': '150px',
        'flex': isLast ? '0 0 auto' : '1',
      }),
      [
        // Connector row
        dom.div(
          classes: 'codex-timeline-connector-row',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'width': '100%',
          }),
          [
            // Left line
            if (index > 0 && props.showConnectors)
              dom.div(
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'height': '2px',
                  'background-color': 'var(--border)',
                }),
                [],
              )
            else
              dom.div(styles: const dom.Styles(raw: {'flex': '1'}), []),

            // Dot
            dom.div(
              classes: 'codex-timeline-dot',
              styles: dom.Styles(raw: {
                'width': dotSize,
                'height': dotSize,
                'border-radius': '50%',
                'background-color': dotColor,
                'box-shadow': dotGlow,
                'flex-shrink': '0',
              }),
              [if (item.icon != null) item.icon!],
            ),

            // Right line
            if (!isLast && props.showConnectors)
              dom.div(
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'height': '2px',
                  'background-color': 'var(--border)',
                }),
                [],
              )
            else
              dom.div(styles: const dom.Styles(raw: {'flex': '1'}), []),
          ],
        ),

        // Content
        dom.div(
          classes: 'codex-timeline-content-horizontal',
          styles: const dom.Styles(raw: {
            'text-align': 'center',
            'padding': '1rem 0.75rem',
          }),
          [
            dom.div(
              classes: 'codex-timeline-title',
              styles: dom.Styles(raw: {
                'font-size': fontSize,
                'font-weight': '600',
                'color': item.status == TimelineStatus.current
                    ? 'var(--codex-accent)'
                    : 'var(--foreground)',
              }),
              [Component.text(item.title)],
            ),
            if (item.date != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
                }),
                [Component.text(item.date!)],
              ),
          ],
        ),
      ],
    );
  }

  (String color, String glow) _getStatusStyles(TimelineStatus status) {
    return switch (status) {
      TimelineStatus.default_ => ('var(--muted)', 'none'),
      TimelineStatus.complete => (
          'var(--codex-success)',
          '0 0 8px rgba(22, 101, 52, 0.4)'
        ),
      TimelineStatus.current => (
          'var(--codex-accent)',
          'var(--codex-accent-glow-subtle)'
        ),
      TimelineStatus.pending => ('var(--border)', 'none'),
      TimelineStatus.error => (
          'var(--codex-destructive)',
          '0 0 8px rgba(153, 27, 27, 0.4)'
        ),
    };
  }
}
