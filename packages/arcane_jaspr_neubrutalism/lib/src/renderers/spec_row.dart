import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/spec_row_props.dart';

/// Neubrutalism SpecRow renderer.
///
/// Displays a label-value pair with space-between layout.
/// Used in pricing cards for specifications.
class NeubrutalismSpecRow extends StatelessComponent {
  final SpecRowProps props;

  const NeubrutalismSpecRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String fontSize = props.fontSize ?? 'var(--font-size-sm)';
    final String labelColor = props.labelColor ?? 'var(--muted-foreground)';
    final String valueColor =
        props.valueColor ??
        (props.highlight ? 'var(--nb-accent, var(--primary))' : 'var(--foreground)');

    return dom.div(
      classes: 'neubrutalism-spec-row',
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'justify-content': 'space-between',
          'align-items': 'center',
        },
      ),
      [
        // Label
        dom.span(
          classes: 'neubrutalism-spec-row-label',
          styles: dom.Styles(raw: {'font-size': fontSize, 'color': labelColor}),
          [Component.text(props.label)],
        ),
        // Value
        dom.span(
          classes: 'neubrutalism-spec-row-value',
          styles: dom.Styles(
            raw: {
              'font-size': fontSize,
              'font-weight': 'var(--font-weight-semibold)',
              'color': valueColor,
            },
          ),
          [Component.text(props.value)],
        ),
      ],
    );
  }
}
