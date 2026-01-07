import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/callout_props.dart';

/// Codex Callout renderer.
///
/// Implements the Codex design language:
/// - Glass effect background
/// - Accent-colored left border with glow
/// - Larger padding
class CodexCallout extends StatelessComponent {
  final CalloutProps props;

  const CodexCallout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Variant colors and icons
    final (String borderColor, String bgColor, String textColor, String iconChar) =
        switch (props.variant) {
      CalloutVariant.info => (
          'var(--codex-info)',
          'rgba(30, 64, 175, 0.1)',
          'var(--codex-info)',
          'i',
        ),
      CalloutVariant.success => (
          'var(--codex-success)',
          'rgba(22, 101, 52, 0.1)',
          'var(--codex-success)',
          '!',
        ),
      CalloutVariant.warning => (
          'var(--codex-warning)',
          'rgba(146, 64, 14, 0.1)',
          'var(--codex-warning)',
          '!',
        ),
      CalloutVariant.error => (
          'var(--codex-destructive)',
          'rgba(153, 27, 27, 0.1)',
          'var(--codex-destructive)',
          'x',
        ),
      CalloutVariant.neutral => (
          'var(--border)',
          'var(--secondary)',
          'var(--muted-foreground)',
          '*',
        ),
      CalloutVariant.tip => (
          'var(--codex-accent)',
          'rgba(var(--codex-accent-rgb), 0.1)',
          'var(--codex-accent)',
          '*',
        ),
      CalloutVariant.note => (
          'var(--codex-accent)',
          'rgba(var(--codex-accent-rgb), 0.08)',
          'var(--foreground)',
          'i',
        ),
    };

    return dom.div(
      classes: 'codex-callout codex-callout-${props.variant.name}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '1rem', // Codex: larger gap
        'padding': '1.25rem', // Codex: larger padding
        'background-color': bgColor,
        'border-left': '3px solid $borderColor',
        'border-radius': 'var(--radius)',
      }),
      [
        // Icon
        if (props.showIcon)
          dom.div(
            classes: 'codex-callout-icon',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'color': textColor,
              'font-weight': '600',
              'flex-shrink': '0',
            }),
            [props.icon ?? Component.text(iconChar)],
          ),

        // Content
        dom.div(
          classes: 'codex-callout-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '0.375rem',
          }),
          [
            // Title
            if (props.title != null)
              dom.div(
                classes: 'codex-callout-title',
                styles: dom.Styles(raw: {
                  'font-size': '0.9375rem',
                  'font-weight': '600',
                  'color': textColor,
                }),
                [Component.text(props.title!)],
              ),

            // Content text or child
            if (props.content != null)
              dom.div(
                classes: 'codex-callout-text',
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                  'line-height': '1.6',
                }),
                [Component.text(props.content!)],
              )
            else if (props.child != null)
              props.child!,
          ],
        ),

        // Dismiss button
        if (props.dismissible)
          dom.button(
            classes: 'codex-callout-dismiss',
            attributes: {'type': 'button'},
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'background': 'transparent',
              'border': 'none',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'flex-shrink': '0',
            }),
            events:
                props.onDismiss == null ? null : {'click': (_) => props.onDismiss!()},
            [const Component.text('x')],
          ),
      ],
    );
  }
}
