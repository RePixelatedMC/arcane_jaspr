import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/separator_props.dart';

/// Codex Separator renderer.
///
/// Implements the Codex design language:
/// - Subtle border color matching the dark theme
/// - Optional label with accent styling
class CodexSeparator extends StatelessComponent {
  final SeparatorProps props;

  const CodexSeparator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String color = props.color ?? 'var(--border)';

    // Simple separator without label
    if (props.label == null && props.icon == null) {
      return dom.div(
        classes: 'codex-separator',
        attributes: {
          'role': props.decorative ? 'none' : 'separator',
          if (!props.decorative) 'aria-orientation': props.orientation.name,
        },
        styles: dom.Styles(raw: switch (props.orientation) {
          SeparatorOrientation.horizontal => {
              'width': '100%',
              'height': '1px',
              'background-color': color,
            },
          SeparatorOrientation.vertical => {
              'width': '1px',
              'height': '100%',
              'background-color': color,
            },
        }),
        [],
      );
    }

    // Separator with label or icon (horizontal only makes sense)
    return dom.div(
      classes: 'codex-separator-with-label',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'width': '100%',
        'gap': '1rem', // Codex: more gap
      }),
      [
        // Left line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': '1px',
            'background-color': color,
          }),
          [],
        ),

        // Label or icon
        if (props.icon != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'color': 'var(--muted-foreground)',
              'flex-shrink': '0',
            }),
            [props.icon!],
          )
        else if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '0.75rem',
              'font-weight': '500',
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
            'height': '1px',
            'background-color': color,
          }),
          [],
        ),
      ],
    );
  }
}
