import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/section_props.dart';

/// Codex Section renderer.
class CodexSection extends StatelessComponent {
  final SectionProps props;

  const CodexSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String padding = props.padding ?? (props.card ? '1.5rem' : '0');
    final String gap = props.gap ?? '1rem';

    return dom.section(
      classes: 'codex-section ${props.card ? 'codex-section-card' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': gap,
        if (props.card) 'background-color': 'var(--card)',
        if (props.card) 'border': '1px solid var(--border)',
        if (props.card) 'border-radius': 'var(--radius)',
        if (props.card) 'padding': padding,
      }),
      [
        // Header
        if (props.header != null || props.headerComponent != null)
          dom.div(
            classes: 'codex-section-header',
            styles: dom.Styles(raw: {
              if (props.showDivider) 'padding-bottom': '0.75rem',
              if (props.showDivider) 'border-bottom': '1px solid var(--border)',
              if (props.showDivider) 'margin-bottom': '0.25rem',
            }),
            [
              if (props.headerComponent != null)
                props.headerComponent!
              else
                dom.h2(
                  styles: const dom.Styles(raw: {
                    'font-size': '1.125rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                    'margin': '0',
                  }),
                  [Component.text(props.header!)],
                ),
            ],
          ),

        // Children
        ...props.children,
      ],
    );
  }
}
