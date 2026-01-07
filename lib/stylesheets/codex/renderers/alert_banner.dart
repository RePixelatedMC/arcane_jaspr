import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/alert_banner_props.dart';

/// Codex Alert Banner renderer.
class CodexAlertBanner extends StatelessComponent {
  final AlertBannerProps props;

  const CodexAlertBanner(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (String bgColor, String borderColor, String textColor, String iconColor) = switch (props.variant) {
      AlertBannerVariant.info => props.filled
          ? (
              'var(--codex-accent)',
              'var(--codex-accent)',
              '#ffffff',
              '#ffffff',
            )
          : (
              'rgba(var(--codex-accent-rgb), 0.1)',
              'rgba(var(--codex-accent-rgb), 0.25)',
              'var(--foreground)',
              'var(--codex-accent)',
            ),
      AlertBannerVariant.success => props.filled
          ? (
              'var(--success)',
              'var(--success)',
              '#ffffff',
              '#ffffff',
            )
          : (
              'rgba(22, 101, 52, 0.1)',
              'rgba(22, 101, 52, 0.25)',
              'var(--foreground)',
              'var(--success)',
            ),
      AlertBannerVariant.warning => props.filled
          ? (
              'var(--warning)',
              'var(--warning)',
              '#ffffff',
              '#ffffff',
            )
          : (
              'rgba(146, 64, 14, 0.1)',
              'rgba(146, 64, 14, 0.25)',
              'var(--foreground)',
              'var(--warning)',
            ),
      AlertBannerVariant.error => props.filled
          ? (
              'var(--destructive)',
              'var(--destructive)',
              '#ffffff',
              '#ffffff',
            )
          : (
              'rgba(153, 27, 27, 0.1)',
              'rgba(153, 27, 27, 0.25)',
              'var(--foreground)',
              'var(--destructive)',
            ),
      AlertBannerVariant.neutral => (
          'var(--secondary)',
          'var(--border)',
          'var(--foreground)',
          'var(--muted-foreground)',
        ),
    };

    final String defaultIcon = switch (props.variant) {
      AlertBannerVariant.info => '\u24D8',
      AlertBannerVariant.success => '\u2713',
      AlertBannerVariant.warning => '\u26A0',
      AlertBannerVariant.error => '\u2717',
      AlertBannerVariant.neutral => '\u2022',
    };

    return dom.div(
      classes: 'codex-alert-banner codex-alert-banner-${props.variant.name} ${props.filled ? 'filled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '1rem',
        'padding': '1.25rem 1.5rem',
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-radius': 'var(--radius)',
        'color': textColor,
      }),
      [
        dom.span(
          classes: 'codex-alert-banner-icon',
          styles: dom.Styles(raw: {
            'flex-shrink': '0',
            'font-size': '1.125rem',
            'color': iconColor,
          }),
          [props.icon ?? Component.text(defaultIcon)],
        ),
        dom.div(
          classes: 'codex-alert-banner-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (props.title != null)
              dom.div(
                classes: 'codex-alert-banner-title',
                styles: const dom.Styles(raw: {
                  'font-weight': '600',
                  'font-size': '0.875rem',
                  'margin-bottom': '0.25rem',
                }),
                [Component.text(props.title!)],
              ),
            dom.div(
              classes: 'codex-alert-banner-message',
              styles: const dom.Styles(raw: {
                'font-size': '0.875rem',
                'line-height': '1.625',
              }),
              [Component.text(props.message)],
            ),
          ],
        ),
        if (props.action != null) props.action!,
        if (props.dismissible)
          dom.button(
            classes: 'codex-alert-banner-dismiss',
            attributes: const {
              'type': 'button',
              'aria-label': 'Dismiss',
            },
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'padding': '0.25rem',
              'background': 'none',
              'border': 'none',
              'color': 'inherit',
              'opacity': '0.7',
              'cursor': 'pointer',
              'font-size': '1rem',
              'line-height': '1',
              'transition': 'opacity 150ms ease',
            }),
            events: {
              'click': (e) => props.onDismiss?.call(),
            },
            [const Component.text('\u00D7')],
          ),
      ],
    );
  }
}
