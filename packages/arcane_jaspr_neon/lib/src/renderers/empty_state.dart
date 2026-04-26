import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/empty_state_props.dart';

/// Neon Empty State renderer.
///
/// Implements the Neon design language:
/// - Larger spacing
/// - Card variant with subtle border
/// - Accent-colored icon
class NeonEmptyState extends StatelessComponent {
  final EmptyStateProps props;

  const NeonEmptyState(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Neon sizes
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
      ), // Neon: larger
      EmptyStateSizeVariant.lg => ('80px', '1.5rem', '1rem', '1.25rem'),
    };

    final Component content = dom.div(
      classes: 'neon-empty-state-content',
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
            classes: 'neon-empty-state-icon',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': iconSize,
                'height': iconSize,
                'color': 'var(--primary)',
                'flex-shrink': '0',
              },
            ),
            [props.icon!],
          ),

        // Text content
        dom.div(
          classes: 'neon-empty-state-text',
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
              classes: 'neon-empty-state-title',
              styles: dom.Styles(
                raw: {
                  'font-size': titleSize,
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                  'margin': '0',
                },
              ),
              [Component.text(props.title)],
            ),

            // Description
            if (props.description != null)
              dom.p(
                classes: 'neon-empty-state-description',
                styles: dom.Styles(
                  raw: {
                    'font-size': descSize,
                    'color': 'var(--muted-foreground)',
                    'margin': '0',
                    'max-width': '400px',
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
            classes: 'neon-empty-state-actions',
            styles: dom.Styles(
              raw: {
                'display': 'flex',
                'gap': '0.75rem', // Neon: more gap
                'margin-top': props.style == EmptyStateStyleVariant.compact
                    ? '0'
                    : '0.5rem',
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
        classes: 'neon-empty-state neon-empty-state-card',
        styles: const dom.Styles(
          raw: {
            'padding': '2.5rem', // Neon: more padding
            'background-color': 'var(--card)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
          },
        ),
        [content],
      );
    }

    return dom.div(
      classes: 'neon-empty-state',
      styles: dom.Styles(
        raw: {
          'padding': props.style == EmptyStateStyleVariant.compact
              ? '1rem'
              : '2rem', // Neon: more padding
        },
      ),
      [content],
    );
  }
}
