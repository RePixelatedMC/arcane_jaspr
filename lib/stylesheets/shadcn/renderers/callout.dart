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
            'hsl(199 89% 48% / 0.1)',
            'hsl(199 89% 48%)',
            'hsl(199 89% 48%)'
          ),
        CalloutVariant.success => (
            'hsl(142 76% 36% / 0.1)',
            'hsl(142 76% 36%)',
            'hsl(142 76% 36%)'
          ),
        CalloutVariant.warning => (
            'hsl(38 92% 50% / 0.1)',
            'hsl(38 92% 50%)',
            'hsl(38 92% 50%)'
          ),
        CalloutVariant.error => (
            'hsl(var(--destructive) / 0.1)',
            'var(--destructive)',
            'var(--destructive)'
          ),
        CalloutVariant.neutral => (
            'var(--muted)',
            'var(--border)',
            'var(--muted-foreground)'
          ),
        CalloutVariant.tip => (
            'hsl(var(--accent) / 0.1)',
            'var(--accent)',
            'var(--accent)'
          ),
        CalloutVariant.note => (
            'hsl(var(--primary) / 0.1)',
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
        'gap': '1rem',
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
              'font-size': '1rem',
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
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                  'margin-bottom': '0.25rem',
                }),
                [Component.text(props.title!)],
              ),
            if (props.content != null)
              dom.div(
                classes: 'arcane-callout-body',
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
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
              'transition': 'all 150ms ease',
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