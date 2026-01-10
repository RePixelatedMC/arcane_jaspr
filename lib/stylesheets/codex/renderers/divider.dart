import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/divider_props.dart';

/// Codex Divider renderer.
///
/// Implements the Codex design language:
/// - Subtle color for OLED screens
/// - Optional label with more spacing
class CodexDivider extends StatelessComponent {
  final DividerProps props;

  const CodexDivider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex variant colors
    final (String color, String thickness) = switch (props.variant) {
      DividerVariant.standard => ('var(--border)', '1px'),
      DividerVariant.subtle => ('var(--muted)', '1px'),
      DividerVariant.bold => ('var(--border)', '2px'),
    };

    final String margin = props.margin != null
        ? '${props.margin}px'
        : '1rem'; // Codex: larger default margin

    // Vertical divider
    if (props.orientation == DividerOrientation.vertical) {
      return dom.div(
        classes: 'codex-divider codex-divider-vertical',
        styles: dom.Styles(raw: {
          'width': thickness,
          'height': props.height != null ? '${props.height}px' : '100%',
          'margin': '0 $margin',
          'background-color': color,
          if (props.dashed) 'background':
              'repeating-linear-gradient(to bottom, $color 0px, $color 4px, transparent 4px, transparent 8px)',
          if (props.dashed) 'background-color': 'transparent',
        }),
        [],
      );
    }

    // Horizontal divider without label
    if (props.label == null) {
      return dom.div(
        classes: 'codex-divider codex-divider-horizontal',
        styles: dom.Styles(raw: {
          'width': '100%',
          'height': thickness,
          'margin': '$margin 0',
          'background-color': color,
          if (props.dashed) 'background':
              'repeating-linear-gradient(to right, $color 0px, $color 4px, transparent 4px, transparent 8px)',
          if (props.dashed) 'background-color': 'transparent',
        }),
        [],
      );
    }

    // Horizontal divider with label
    return dom.div(
      classes: 'codex-divider codex-divider-with-label',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'width': '100%',
        'margin': '$margin 0',
        'gap': 'var(--space-4)', // Codex: more gap
      }),
      [
        // Left line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': thickness,
            'background-color': color,
            if (props.dashed) 'background':
                'repeating-linear-gradient(to right, $color 0px, $color 4px, transparent 4px, transparent 8px)',
            if (props.dashed) 'background-color': 'transparent',
          }),
          [],
        ),

        // Label
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-xs)',
            'font-weight': 'var(--font-weight-medium)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
            'color': 'var(--muted-foreground)',
            'flex-shrink': '0',
          }),
          [Component.text(props.label!)],
        ),

        // Right line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': thickness,
            'background-color': color,
            if (props.dashed) 'background':
                'repeating-linear-gradient(to right, $color 0px, $color 4px, transparent 4px, transparent 8px)',
            if (props.dashed) 'background-color': 'transparent',
          }),
          [],
        ),
      ],
    );
  }
}
