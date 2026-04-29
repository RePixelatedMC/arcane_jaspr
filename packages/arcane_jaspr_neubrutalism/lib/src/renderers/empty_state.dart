import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/empty_state_props.dart';

/// Neubrutalism Empty State renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger spacing
/// - Card variant with subtle border
/// - Accent-colored icon
class NeubrutalismEmptyState extends StatelessComponent {
  final EmptyStateProps props;

  const NeubrutalismEmptyState(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Neubrutalism sizes
    final (
      String iconSize,
      String titleSize,
      String descSize,
      String gap,
    ) = switch (props.size) {
      EmptyStateSizeVariant.sm => ('48px', '1rem', '0.8125rem', '0.75rem'),
      EmptyStateSizeVariant.md => (
        '64px',
        '1.25rem',
        '0.875rem',
        '1rem',
      ), // Neubrutalism: larger
      EmptyStateSizeVariant.lg => ('80px', '1.5rem', '1rem', '1.25rem'),
    };

    final Component content = dom.div(
      classes: 'neubrutalism-empty-state-content',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': props.style == EmptyStateStyleVariant.compact
              ? 'row'
              : 'column',
          'align-items': 'center',
          'text-align': props.style == EmptyStateStyleVariant.compact
              ? 'left'
              : 'center',
          'gap': gap,
          if (props.style == EmptyStateStyleVariant.compact)
            'text-align': 'left',
        },
      ),
      [
        if (props.icon != null)
          dom.div(
            classes: 'neubrutalism-empty-state-icon',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': iconSize,
                'height': iconSize,
                'padding': '0.5rem',
                'box-sizing': 'border-box',
                'background': 'var(--nb-paper-soft, var(--card))',
                'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
                'border-radius': '0',
                'box-shadow':
                    'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
                'color': 'var(--nb-accent, var(--primary))',
                'flex-shrink': '0',
                'filter': 'none',
              },
            ),
            [props.icon!],
          ),

        // Text content
        dom.div(
          classes: 'neubrutalism-empty-state-text',
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': 'var(--space-2)',
            },
          ),
          [
            // Title
            dom.h3(
              classes: 'neubrutalism-empty-state-title',
              styles: dom.Styles(
                raw: {
                  'font-family': 'var(--font-heading)',
                  'font-size': titleSize,
                  'font-weight': '900',
                  'letter-spacing': '-0.01em',
                  'color': 'var(--foreground)',
                  'margin': '0',
                },
              ),
              [Component.text(props.title)],
            ),

            // Description
            if (props.description != null)
              dom.p(
                classes: 'neubrutalism-empty-state-description',
                styles: dom.Styles(
                  raw: {
                    'font-size': descSize,
                    'font-weight': '600',
                    'color': 'var(--muted-foreground)',
                    'margin': '0',
                    'max-width': '420px',
                    'line-height': '1.5',
                  },
                ),
                [Component.text(props.description!)],
              ),
          ],
        ),

        // Actions
        if (props.action != null || props.secondaryAction != null)
          dom.div(
            classes: 'neubrutalism-empty-state-actions',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                'gap': '0.75rem', // Neubrutalism: more gap
                'margin-top': props.style == EmptyStateStyleVariant.compact
                    ? '0'
                    : '0.75rem',
                if (props.style == EmptyStateStyleVariant.compact)
                  'margin-left': 'auto',
              },
            ),
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
        classes: 'neubrutalism-empty-state neubrutalism-empty-state-card',
        styles: const dom.Styles(
          raw: {
            'padding': '2.5rem',
            'background': 'var(--nb-paper, var(--card))',
            'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
            'border-radius': '0',
            'box-shadow':
                'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          },
        ),
        [content],
      );
    }

    return dom.div(
      classes: 'neubrutalism-empty-state',
      styles: dom.Styles(
        raw: {
          'padding': props.style == EmptyStateStyleVariant.compact
              ? '1rem'
              : '2rem', // Neubrutalism: more padding
        },
      ),
      [content],
    );
  }
}
