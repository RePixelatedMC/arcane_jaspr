import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/empty_state_props.dart';

/// Codex Empty State renderer.
///
/// Implements the Codex design language:
/// - Larger spacing
/// - Card variant with subtle border
/// - Accent-colored icon
class CodexEmptyState extends StatelessComponent {
  final EmptyStateProps props;

  const CodexEmptyState(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes
    final (String iconSize, String titleSize, String descSize, String gap) =
        switch (props.size) {
      EmptyStateSizeVariant.sm => ('48px', '1rem', '0.8125rem', '0.75rem'),
      EmptyStateSizeVariant.md => ('64px', '1.25rem', '0.875rem', '1rem'), // Codex: larger
      EmptyStateSizeVariant.lg => ('80px', '1.5rem', '1rem', '1.25rem'),
    };

    final Component content = dom.div(
      classes: 'codex-empty-state-content',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': props.style == EmptyStateStyleVariant.compact
            ? 'row'
            : 'column',
        'align-items': 'center',
        'text-align': props.style == EmptyStateStyleVariant.compact
            ? 'left'
            : 'center',
        'gap': gap,
        if (props.style == EmptyStateStyleVariant.compact) 'text-align': 'left',
      }),
      [
        // Icon or emoji
        if (props.icon != null || props.emoji != null)
          dom.div(
            classes: 'codex-empty-state-icon',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': iconSize,
              'height': iconSize,
              'color': 'var(--codex-accent)',
              'flex-shrink': '0',
            }),
            [
              props.icon ??
                  dom.span(
                    styles: dom.Styles(raw: {
                      'font-size': iconSize,
                      'line-height': '1',
                    }),
                    [Component.text(props.emoji!)],
                  ),
            ],
          ),

        // Text content
        dom.div(
          classes: 'codex-empty-state-text',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--arcane-space-2)',
          }),
          [
            // Title
            dom.h3(
              classes: 'codex-empty-state-title',
              styles: dom.Styles(raw: {
                'font-size': titleSize,
                'font-weight': 'var(--arcane-font-weight-semibold)',
                'color': 'var(--foreground)',
                'margin': '0',
              }),
              [Component.text(props.title)],
            ),

            // Description
            if (props.description != null)
              dom.p(
                classes: 'codex-empty-state-description',
                styles: dom.Styles(raw: {
                  'font-size': descSize,
                  'color': 'var(--muted-foreground)',
                  'margin': '0',
                  'max-width': '400px',
                  'line-height': '1.5',
                }),
                [Component.text(props.description!)],
              ),
          ],
        ),

        // Actions
        if (props.action != null || props.secondaryAction != null)
          dom.div(
            classes: 'codex-empty-state-actions',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'gap': '0.75rem', // Codex: more gap
              'margin-top': props.style == EmptyStateStyleVariant.compact
                  ? '0'
                  : '0.5rem',
              if (props.style == EmptyStateStyleVariant.compact)
                'margin-left': 'auto',
            }),
            [
              if (props.action != null) props.action!,
              if (props.secondaryAction != null) props.secondaryAction!,
            ],
          ),
      ],
    );

    // Wrap in card if variant is card
    if (props.style == EmptyStateStyleVariant.card) {
      return dom.div(
        classes: 'codex-empty-state codex-empty-state-card',
        styles: const dom.Styles(raw: {
          'padding': '2.5rem', // Codex: more padding
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius)',
        }),
        [content],
      );
    }

    return dom.div(
      classes: 'codex-empty-state',
      styles: dom.Styles(raw: {
        'padding': props.style == EmptyStateStyleVariant.compact
            ? '1rem'
            : '2rem', // Codex: more padding
      }),
      [content],
    );
  }
}
