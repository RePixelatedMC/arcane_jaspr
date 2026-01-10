import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/alert_props.dart';

/// Codex Alert renderer.
///
/// Implements the Codex design language:
/// - Larger padding (1.25x)
/// - Accent-colored variants with subtle glow
/// - Larger border radius
class CodexAlert extends StatelessComponent {
  final AlertProps props;

  const CodexAlert(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex severity colors - darker for OLED
    final (String bgColor, String borderColor, String textColor, String iconColor, String? glowColor) =
        switch (props.severity) {
      AlertSeverity.info => (
          'rgba(30, 64, 175, 0.15)',
          'var(--info)',
          'var(--info-foreground)',
          'var(--info)',
          '0 0 15px rgba(var(--info-rgb), 0.2)',
        ),
      AlertSeverity.success => (
          'rgba(22, 101, 52, 0.15)',
          'var(--success)',
          'var(--success-foreground)',
          'var(--success)',
          '0 0 15px rgba(var(--success-rgb), 0.2)',
        ),
      AlertSeverity.warning => (
          'rgba(146, 64, 14, 0.15)',
          'var(--warning)',
          'var(--warning-foreground)',
          'var(--warning)',
          null,
        ),
      AlertSeverity.error => (
          'rgba(153, 27, 27, 0.15)',
          'var(--destructive)',
          'var(--destructive-foreground)',
          'var(--destructive)',
          '0 0 15px rgba(var(--destructive-rgb), 0.2)',
        ),
    };

    // Codex variant-specific styles
    final Map<String, String> variantStyles = switch (props.variant) {
      AlertVariant.subtle => {
          'background-color': bgColor,
          'border': '1px solid transparent',
          'color': 'var(--foreground)',
        },
      AlertVariant.solid => {
          'background-color': borderColor,
          'border': 'none',
          'color': textColor,
          if (glowColor != null) 'box-shadow': glowColor,
        },
      AlertVariant.outline => {
          'background-color': 'transparent',
          'border': '1px solid $borderColor',
          'color': 'var(--foreground)',
        },
      AlertVariant.accent => {
          'background-color': bgColor,
          'border-left': '4px solid $borderColor',
          'border-top': 'none',
          'border-right': 'none',
          'border-bottom': 'none',
          'color': 'var(--foreground)',
        },
    };

    return dom.div(
      classes: 'codex-alert codex-alert-${props.severity.name}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '0.75rem', // Codex: more gap
        'padding': '1.25rem', // Codex: 1.25x padding (vs 1rem)
        'border-radius': 'var(--radius)', // Codex: larger radius
        ...variantStyles,
        'transition': 'all var(--transition)',
      }),
      [
        // Icon
        if (props.showIcon)
          dom.div(
            classes: 'codex-alert-icon',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'color': props.variant == AlertVariant.solid ? textColor : iconColor,
            }),
            [
              props.icon ?? _buildDefaultIcon(props.severity),
            ],
          ),

        // Content
        dom.div(
          classes: 'codex-alert-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            // Title
            if (props.title != null)
              dom.div(
                classes: 'codex-alert-title',
                styles: const dom.Styles(raw: {
                  'font-weight': 'var(--font-weight-semibold)',
                  'font-size': 'var(--font-size-sm)',
                  'margin-bottom': '0.375rem', // Codex: slightly more
                }),
                [Component.text(props.title!)],
              ),

            // Message or child
            if (props.message != null || props.child != null)
              dom.div(
                classes: 'codex-alert-message',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'inherit',
                  'opacity': '0.9',
                }),
                [
                  if (props.message != null) Component.text(props.message!),
                  if (props.child != null) props.child!,
                ],
              ),
          ],
        ),

        // Action or dismiss
        if (props.action != null || props.dismissible)
          dom.div(
            classes: 'codex-alert-actions',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'display': 'flex',
              'align-items': 'flex-start',
              'gap': 'var(--space-2)',
            }),
            [
              if (props.action != null) props.action!,
              if (props.dismissible)
                dom.button(
                  classes: 'codex-alert-dismiss',
                  styles: const dom.Styles(raw: {
                    'background': 'transparent',
                    'border': 'none',
                    'cursor': 'pointer',
                    'padding': '0.25rem',
                    'color': 'inherit',
                    'opacity': '0.7',
                    'transition': 'opacity var(--transition)',
                  }),
                  events: props.onDismiss == null
                      ? null
                      : {'click': (_) => props.onDismiss!()},
                  [const Component.text('x')],
                ),
            ],
          ),
      ],
    );
  }

  Component _buildDefaultIcon(AlertSeverity severity) {
    final String icon = switch (severity) {
      AlertSeverity.info => 'i',
      AlertSeverity.success => '\u2713',
      AlertSeverity.warning => '!',
      AlertSeverity.error => '\u2717',
    };

    return dom.span(
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '20px',
        'height': '20px',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-bold)',
      }),
      [Component.text(icon)],
    );
  }
}
