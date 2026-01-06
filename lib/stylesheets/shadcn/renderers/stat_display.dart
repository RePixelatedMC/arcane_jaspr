import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/stat_display_props.dart';

/// ShadCN Stat Display renderer.
class ShadcnStatDisplay extends StatelessComponent {
  final StatDisplayProps props;

  const ShadcnStatDisplay(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveValueColor = props.valueColor ?? 'var(--primary)';
    final effectiveLabelColor = props.labelColor ?? 'var(--muted-foreground)';
    final effectiveValueSize = props.valueFontSize ?? '1.5rem';
    final effectiveLabelSize = props.labelFontSize ?? '0.875rem';
    final effectiveAlign = props.textAlign ?? 'center';

    if (props.layout == StatDisplayLayout.horizontal) {
      return dom.div(
        classes: 'arcane-stat-display arcane-stat-display-horizontal',
        styles: dom.Styles(raw: {
          'display': 'flex',
          'align-items': 'baseline',
          'gap': '0.5rem',
          'text-align': effectiveAlign,
        }),
        [
          dom.span(
            styles: dom.Styles(raw: {
              'font-size': effectiveValueSize,
              'font-weight': '700',
              'color': effectiveValueColor,
            }),
            [Component.text(props.value)],
          ),
          dom.span(
            styles: dom.Styles(raw: {
              'font-size': effectiveLabelSize,
              'color': effectiveLabelColor,
            }),
            [Component.text(props.label)],
          ),
        ],
      );
    }

    return dom.div(
      classes: 'arcane-stat-display arcane-stat-display-vertical',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': effectiveAlign == 'center' ? 'center' : 'flex-start',
        'text-align': effectiveAlign,
      }),
      [
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': effectiveValueSize,
            'font-weight': '700',
            'color': effectiveValueColor,
            'margin-bottom': '0.25rem',
          }),
          [Component.text(props.value)],
        ),
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': effectiveLabelSize,
            'color': effectiveLabelColor,
          }),
          [Component.text(props.label)],
        ),
      ],
    );
  }
}

/// ShadCN Stat Row renderer.
class ShadcnStatRow extends StatelessComponent {
  final StatRowProps props;

  const ShadcnStatRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-stat-row',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': props.gap ?? '3rem',
        'justify-content': props.justifyContent ?? 'center',
        'align-items': 'flex-start',
        if (props.wrap) 'flex-wrap': 'wrap',
      }),
      props.stats,
    );
  }
}
