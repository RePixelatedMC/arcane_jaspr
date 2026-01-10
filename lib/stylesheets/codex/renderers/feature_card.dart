import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/feature_card_props.dart';

/// Codex Feature Card renderer.
///
/// Implements the Codex design language:
/// - Larger padding and icon size
/// - Accent-colored hover state
/// - Subtle glow on hover
class CodexFeatureCard extends StatelessComponent {
  final FeatureCardProps props;

  const CodexFeatureCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.href != null || props.onTap != null;

    final Component content = dom.div(
      classes: 'codex-feature-card-inner',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': props.horizontal ? 'row' : 'column',
        'gap': props.horizontal ? '1.25rem' : '1rem',
        'align-items': props.horizontal ? 'flex-start' : 'flex-start',
      }),
      [
        // Icon
        if (props.icon != null)
          dom.div(
            classes: 'codex-feature-card-icon',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '56px', // Codex: larger
              'height': '56px',
              'border-radius': 'var(--radius)',
              'background-color': 'rgba(var(--codex-accent-rgb), 0.1)',
              'color': 'var(--codex-accent)',
              'flex-shrink': '0',
            }),
            [props.icon!],
          ),

        // Content
        dom.div(
          classes: 'codex-feature-card-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
          }),
          [
            // Title row
            dom.div(
              classes: 'codex-feature-card-title-row',
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--arcane-space-2)',
              }),
              [
                dom.h3(
                  classes: 'codex-feature-card-title',
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-lg)',
                    'font-weight': 'var(--arcane-font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'margin': '0',
                  }),
                  [Component.text(props.title)],
                ),
                if (props.showArrow && isInteractive)
                  const dom.span(
                    classes: 'codex-feature-card-arrow',
                    styles: dom.Styles(raw: {
                      'font-size': 'var(--arcane-font-size-base)',
                      'color': 'var(--codex-accent)',
                      'transition': 'transform var(--transition)',
                    }),
                    [Component.text('->')],
                  ),
              ],
            ),

            // Description
            dom.p(
              classes: 'codex-feature-card-description',
              styles: const dom.Styles(raw: {
                'font-size': '0.9375rem', // Codex: larger
                'color': 'var(--muted-foreground)',
                'line-height': '1.6',
                'margin': '0.5rem 0 0 0',
              }),
              [Component.text(props.description)],
            ),
          ],
        ),
      ],
    );

    if (props.href != null) {
      return dom.a(
        classes: 'codex-feature-card interactive',
        href: props.href!,
        styles: _cardStyles(isInteractive),
        [content],
      );
    }

    return dom.div(
      classes: 'codex-feature-card ${isInteractive ? 'interactive' : ''}',
      styles: _cardStyles(isInteractive),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [content],
    );
  }

  dom.Styles _cardStyles(bool isInteractive) {
    return dom.Styles(raw: {
      'display': 'block',
      'padding': '2rem', // Codex: larger padding
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--radius)',
      if (isInteractive) 'cursor': 'pointer',
      'transition': 'all var(--transition)',
      'text-decoration': 'none',
    });
  }
}

/// Codex Icon Card renderer.
class CodexIconCard extends StatelessComponent {
  final IconCardProps props;

  const CodexIconCard(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool isInteractive = props.href != null || props.onTap != null;

    final Component content = dom.div(
      classes: 'codex-icon-card-inner',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'text-align': 'center',
        'gap': 'var(--arcane-space-4)',
      }),
      [
        // Icon
        dom.div(
          classes: 'codex-icon-card-icon',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '64px', // Codex: larger
            'height': '64px',
            'border-radius': 'var(--radius-lg)',
            'background-color': 'rgba(var(--codex-accent-rgb), 0.1)',
            'color': 'var(--codex-accent)',
          }),
          [props.icon],
        ),

        // Title
        dom.h4(
          classes: 'codex-icon-card-title',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-base)',
            'font-weight': 'var(--arcane-font-weight-semibold)',
            'color': 'var(--foreground)',
            'margin': '0',
          }),
          [Component.text(props.title)],
        ),

        // Subtitle
        if (props.subtitle != null)
          dom.p(
            classes: 'codex-icon-card-subtitle',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [Component.text(props.subtitle!)],
          ),
      ],
    );

    if (props.href != null) {
      return dom.a(
        classes: 'codex-icon-card interactive',
        href: props.href!,
        styles: _cardStyles(isInteractive),
        [content],
      );
    }

    return dom.div(
      classes: 'codex-icon-card ${isInteractive ? 'interactive' : ''}',
      styles: _cardStyles(isInteractive),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [content],
    );
  }

  dom.Styles _cardStyles(bool isInteractive) {
    return dom.Styles(raw: {
      'display': 'block',
      'padding': '2rem', // Codex: larger padding
      'background-color': 'var(--card)',
      'border': '1px solid var(--border)',
      'border-radius': 'var(--radius)',
      if (isInteractive) 'cursor': 'pointer',
      'transition': 'all var(--transition)',
      'text-decoration': 'none',
    });
  }
}