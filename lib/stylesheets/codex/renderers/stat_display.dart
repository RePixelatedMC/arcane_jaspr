import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/stat_display_props.dart';

/// Codex StatDisplay renderer.
class CodexStatDisplay extends StatelessComponent {
  final StatDisplayProps props;

  const CodexStatDisplay(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isVertical = props.layout == StatDisplayLayout.vertical;

    return dom.div(
      classes: 'codex-stat-display',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': isVertical ? 'column' : 'row',
        'gap': isVertical ? '0.25rem' : '0.5rem',
        'align-items': isVertical ? 'flex-start' : 'baseline',
        if (props.textAlign != null) 'text-align': props.textAlign!,
      }),
      [
        // Value (first in vertical, second in horizontal)
        if (isVertical) ...[
          dom.span(
            classes: 'codex-stat-value',
            styles: dom.Styles(raw: {
              'font-size': props.valueFontSize ?? '2rem',
              'font-weight': '700',
              'color': props.valueColor ?? 'var(--foreground)',
            }),
            [Component.text(props.value)],
          ),
          dom.span(
            classes: 'codex-stat-label',
            styles: dom.Styles(raw: {
              'font-size': props.labelFontSize ?? '0.75rem',
              'font-weight': '500',
              'text-transform': 'uppercase',
              'letter-spacing': '0.05em',
              'color': props.labelColor ?? 'var(--muted-foreground)',
            }),
            [Component.text(props.label)],
          ),
        ] else ...[
          dom.span(
            classes: 'codex-stat-value',
            styles: dom.Styles(raw: {
              'font-size': props.valueFontSize ?? '1.5rem',
              'font-weight': '700',
              'color': props.valueColor ?? 'var(--foreground)',
            }),
            [Component.text(props.value)],
          ),
          dom.span(
            classes: 'codex-stat-label',
            styles: dom.Styles(raw: {
              'font-size': props.labelFontSize ?? '0.875rem',
              'color': props.labelColor ?? 'var(--muted-foreground)',
            }),
            [Component.text(props.label)],
          ),
        ],
      ],
    );
  }
}

/// Codex StatRow renderer.
class CodexStatRow extends StatelessComponent {
  final StatRowProps props;

  const CodexStatRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-stat-row',
      styles: dom.Styles(raw: {
        'display': 'flex',
        if (props.wrap) 'flex-wrap': 'wrap',
        'gap': props.gap ?? '2rem',
        if (props.justifyContent != null) 'justify-content': props.justifyContent!,
      }),
      props.stats,
    );
  }
}
