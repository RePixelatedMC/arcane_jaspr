import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/callout_props.dart';

/// ShadCN Callout renderer.
///
/// Displays highlighted notices with icons and optional titles.
/// Similar to ShadCN Alert but styled as an inline callout.
class ShadcnCallout extends StatelessComponent {
  final CalloutProps props;

  const ShadcnCallout(this.props, {super.key});

  String get _defaultIcon => switch (props.variant) {
        CalloutVariant.info => 'i',
        CalloutVariant.success => '\u2713',
        CalloutVariant.warning => '\u26A0',
        CalloutVariant.error => '\u2715',
        CalloutVariant.neutral => '\u2022',
        CalloutVariant.tip => '\u{1F4A1}',
        CalloutVariant.note => '\u{1F4DD}',
      };

  (String background, String border, String iconColor) get _variantColors =>
      switch (props.variant) {
        CalloutVariant.info => (
            'color-mix(in srgb, var(--info) 10%, transparent)',
            'var(--info)',
            'var(--info)'
          ),
        CalloutVariant.success => (
            'color-mix(in srgb, var(--success) 10%, transparent)',
            'var(--success)',
            'var(--success)'
          ),
        CalloutVariant.warning => (
            'color-mix(in srgb, var(--warning) 10%, transparent)',
            'var(--warning)',
            'var(--warning)'
          ),
        CalloutVariant.error => (
            'color-mix(in srgb, var(--destructive) 10%, transparent)',
            'var(--destructive)',
            'var(--destructive)'
          ),
        CalloutVariant.neutral => (
            'var(--muted)',
            'var(--border)',
            'var(--muted-foreground)'
          ),
        CalloutVariant.tip => (
            'color-mix(in srgb, var(--accent) 10%, transparent)',
            'var(--accent)',
            'var(--accent)'
          ),
        CalloutVariant.note => (
            'color-mix(in srgb, var(--primary) 10%, transparent)',
            'var(--primary)',
            'var(--primary)'
          ),
      };

  @override
  Component build(BuildContext context) {
    final (background, borderColor, iconColor) = _variantColors;

    return dom.div(
      classes: 'arcane-callout arcane-callout-${props.variant.name}',
      attributes: {
        'role': 'alert',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': 'var(--space-4)',
        'padding': '1rem',
        'background': background,
        'border-left': '4px solid $borderColor',
        'border-radius': 'calc(var(--radius) - 2px)',
      }),
      [
        // Icon
        if (props.showIcon)
          dom.div(
            classes: 'arcane-callout-icon',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'width': '20px',
              'height': '20px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': iconColor,
              'font-size': 'var(--font-size-base)',
            }),
            [props.icon ?? Component.text(_defaultIcon)],
          ),

        // Content
        dom.div(
          classes: 'arcane-callout-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            if (props.title != null)
              dom.div(
                classes: 'arcane-callout-title',
                styles: const dom.Styles(raw: {
                  'font-weight': 'var(--font-weight-semibold)',
                  'color': 'var(--foreground)',
                  'margin-bottom': '0.25rem',
                }),
                [Component.text(props.title!)],
              ),
            if (props.content != null)
              dom.div(
                classes: 'arcane-callout-body',
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--foreground)',
                  'line-height': '1.7',
                }),
                [Component.text(props.content!)],
              ),
            if (props.child != null) props.child!,
          ],
        ),

        // Dismiss button
        if (props.dismissible)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'arcane-callout-dismiss',
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'width': '24px',
              'height': '24px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'border-radius': '0.125rem',
              'transition': 'all var(--arcane-transition)',
            }),
            events: {
              'click': (_) => props.onDismiss?.call(),
            },
            [const Component.text('\u00D7')],
          ),
      ],
    );
  }
}