import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/alert_banner_props.dart';

/// ShadCN Alert Banner renderer.
class ShadcnAlertBanner extends StatelessComponent {
  final AlertBannerProps props;

  const ShadcnAlertBanner(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (String bgColor, String borderColor, String textColor, String iconColor) = switch (props.variant) {
      AlertBannerVariant.info => props.filled
          ? (
              'var(--info)',
              'var(--info)',
              'var(--info-foreground)',
              'var(--info-foreground)',
            )
          : (
              'transparent',
              'var(--info)',
              'var(--foreground)',
              'var(--info)',
            ),
      AlertBannerVariant.success => props.filled
          ? (
              'var(--success)',
              'var(--success)',
              'var(--success-foreground)',
              'var(--success-foreground)',
            )
          : (
              'transparent',
              'var(--success)',
              'var(--foreground)',
              'var(--success)',
            ),
      AlertBannerVariant.warning => props.filled
          ? (
              'var(--warning)',
              'var(--warning)',
              'var(--warning-foreground)',
              'var(--warning-foreground)',
            )
          : (
              'transparent',
              'var(--warning)',
              'var(--foreground)',
              'var(--warning)',
            ),
      AlertBannerVariant.error => props.filled
          ? (
              'var(--destructive)',
              'var(--destructive)',
              'var(--destructive-foreground)',
              'var(--destructive-foreground)',
            )
          : (
              'transparent',
              'var(--destructive)',
              'var(--foreground)',
              'var(--destructive)',
            ),
      AlertBannerVariant.neutral => (
          'var(--muted)',
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
      classes: 'arcane-alert arcane-alert-${props.variant.name} ${props.filled ? 'filled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': 'var(--space-4)',
        'padding': '1rem 1.25rem',
        'background-color': bgColor,
        'border': '1px solid $borderColor',
        'border-radius': 'var(--radius)',
        'color': textColor,
      }),
      [
        dom.span(
          classes: 'arcane-alert-icon',
          styles: dom.Styles(raw: {
            'flex-shrink': '0',
            'font-size': 'var(--font-size-lg)',
            'color': iconColor,
          }),
          [props.icon ?? Component.text(defaultIcon)],
        ),
        dom.div(
          classes: 'arcane-alert-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (props.title != null)
              dom.div(
                classes: 'arcane-alert-title',
                styles: const dom.Styles(raw: {
                  'font-weight': 'var(--font-weight-semibold)',
                  'font-size': 'var(--font-size-sm)',
                  'margin-bottom': '0.25rem',
                }),
                [Component.text(props.title!)],
              ),
            dom.div(
              classes: 'arcane-alert-message',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'line-height': '1.625',
              }),
              [Component.text(props.message)],
            ),
          ],
        ),
        if (props.action != null) props.action!,
        if (props.dismissible)
          dom.button(
            classes: 'arcane-alert-dismiss',
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
              'font-size': 'var(--font-size-base)',
              'line-height': '1',
              'transition': 'opacity var(--arcane-transition)',
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
