import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/spec_row_props.dart';

/// Codex SpecRow renderer.
///
/// Displays a label-value pair with space-between layout.
/// Used in pricing cards for specifications.
class CodexSpecRow extends StatelessComponent {
  final SpecRowProps props;

  const CodexSpecRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String fontSize = props.fontSize ?? 'var(--font-size-sm)';
    final String labelColor = props.labelColor ?? 'var(--muted-foreground)';
    final String valueColor = props.valueColor ??
        (props.highlight ? 'var(--primary)' : 'var(--foreground)');

    return dom.div(
      classes: 'codex-spec-row',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
      }),
      [
        // Label
        dom.span(
          classes: 'codex-spec-row-label',
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'color': labelColor,
          }),
          [Component.text(props.label)],
        ),
        // Value
        dom.span(
          classes: 'codex-spec-row-value',
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'font-weight': 'var(--font-weight-semibold)',
            'color': valueColor,
          }),
          [Component.text(props.value)],
        ),
      ],
    );
  }
}
