import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/card_section_props.dart';

/// Codex CardSection renderer.
class CodexCardSection extends StatelessComponent {
  final CardSectionProps props;

  const CodexCardSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String padding = props.padding ?? '1.5rem';
    final String borderRadius = props.radius ?? 'var(--radius)';
    final String gap = props.gap ?? '1rem';

    return dom.div(
      classes: 'codex-card-section',
      styles: dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': borderRadius,
        'overflow': 'hidden',
      }),
      [
        // Header
        if (props.header != null || props.headerComponent != null)
          dom.div(
            classes: 'codex-card-section-header',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'padding': '1rem 1.5rem',
              'border-bottom': '1px solid var(--border)',
              'background-color': 'var(--secondary)',
            }),
            [
              if (props.headerComponent != null)
                props.headerComponent!
              else
                dom.h3(
                  styles: const dom.Styles(raw: {
                    'font-size': '1rem',
                    'font-weight': '600',
                    'color': 'var(--foreground)',
                    'margin': '0',
                  }),
                  [Component.text(props.header!)],
                ),
              if (props.trailing != null && props.trailing!.isNotEmpty)
                dom.div(
                  classes: 'codex-card-section-trailing',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'gap': '0.5rem',
                  }),
                  props.trailing!,
                ),
            ],
          ),

        // Content
        dom.div(
          classes: 'codex-card-section-content',
          styles: dom.Styles(raw: {
            'padding': padding,
            'display': 'flex',
            'flex-direction': 'column',
            'gap': gap,
          }),
          props.children,
        ),
      ],
    );
  }
}

/// Codex ListCard renderer.
class CodexListCard extends StatelessComponent {
  final ListCardProps props;

  const CodexListCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String borderRadius = props.radius ?? 'var(--radius)';

    return dom.div(
      classes: 'codex-list-card',
      styles: dom.Styles(raw: {
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': borderRadius,
        'overflow': 'hidden',
      }),
      [
        // Header
        if (props.header != null)
          dom.div(
            classes: 'codex-list-card-header',
            styles: const dom.Styles(raw: {
              'padding': '1rem 1.25rem',
              'border-bottom': '1px solid var(--border)',
              'background-color': 'var(--secondary)',
            }),
            [
              dom.h3(
                styles: const dom.Styles(raw: {
                  'font-size': '0.9375rem',
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                  'margin': '0',
                }),
                [Component.text(props.header!)],
              ),
            ],
          ),

        // Items
        dom.div(
          classes: 'codex-list-card-items',
          [
            for (int i = 0; i < props.children.length; i++) ...[
              props.children[i],
              if (props.divided && i < props.children.length - 1)
                dom.div(
                  classes: 'codex-list-card-divider',
                  styles: const dom.Styles(raw: {
                    'height': '1px',
                    'background-color': 'var(--border)',
                  }),
                  [],
                ),
            ],
          ],
        ),
      ],
    );
  }
}
