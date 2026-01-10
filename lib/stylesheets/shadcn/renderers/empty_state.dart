import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/empty_state_props.dart';

/// ShadCN Empty State renderer.
///
/// Based on common empty state patterns seen in modern UI libraries.
class ShadcnEmptyState extends StatelessComponent {
  final EmptyStateProps props;

  const ShadcnEmptyState(this.props, {super.key});

  (String iconSize, String titleSize, String descSize, String padding, String gap)
      get _sizeStyles => switch (props.size) {
            EmptyStateSizeVariant.sm => ('32px', '1rem', '0.875rem', '1rem', '0.5rem'),
            EmptyStateSizeVariant.md => ('48px', '1.125rem', '1rem', '1.5rem', '0.75rem'),
            EmptyStateSizeVariant.lg => ('64px', '1.25rem', '1.125rem', '2rem', '1rem'),
          };

  @override
  Component build(BuildContext context) {
    final (iconSize, titleSize, descSize, padding, gap) = _sizeStyles;

    final content = dom.div(
      classes: 'arcane-empty-state',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'text-align': 'center',
        'padding': padding,
        'gap': gap,
      }),
      [
        // Icon/Emoji
        if (props.icon != null || props.emoji != null)
          dom.div(
            classes: 'arcane-empty-state-icon',
            styles: dom.Styles(raw: {
              'font-size': iconSize,
              'line-height': '1',
              'opacity': '0.6',
            }),
            [
              if (props.icon != null) props.icon!,
              if (props.icon == null && props.emoji != null)
                Component.text(props.emoji!),
            ],
          ),

        // Title
        dom.div(
          classes: 'arcane-empty-state-title',
          styles: dom.Styles(raw: {
            'font-size': titleSize,
            'font-weight': 'var(--arcane-font-weight-semibold)',
            'color': 'var(--foreground)',
          }),
          [Component.text(props.title)],
        ),

        // Description
        if (props.description != null)
          dom.div(
            classes: 'arcane-empty-state-description',
            styles: dom.Styles(raw: {
              'font-size': descSize,
              'color': 'var(--muted-foreground)',
              'max-width': '360px',
            }),
            [Component.text(props.description!)],
          ),

        // Actions
        if (props.action != null || props.secondaryAction != null)
          dom.div(
            classes: 'arcane-empty-state-actions',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'gap': 'var(--arcane-space-2)',
              'margin-top': '0.5rem',
            }),
            [
              if (props.action != null) props.action!,
              if (props.secondaryAction != null) props.secondaryAction!,
            ],
          ),
      ],
    );

    if (props.style == EmptyStateStyleVariant.card) {
      return dom.div(
        classes: 'arcane-empty-state-card',
        styles: const dom.Styles(raw: {
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--arcane-radius-md)',
        }),
        [content],
      );
    }

    return content;
  }
}
