import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/alert_props.dart';

/// ShadCN Alert renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/alert
class ShadcnAlert extends StatelessComponent {
  final AlertProps props;

  const ShadcnAlert(this.props, {super.key});

  String get _defaultIcon => switch (props.color) {
        ColorVariant.info => '\u2139', // ℹ
        ColorVariant.success => '\u2713', // ✓
        ColorVariant.warning => '\u26A0', // ⚠
        ColorVariant.destructive => '\u2715', // ✕
        ColorVariant.primary => '\u2139', // ℹ
        ColorVariant.secondary => '\u2139', // ℹ
      };

  (String primary, String background, String border) get _colors =>
      switch (props.color) {
        ColorVariant.info => (
            'var(--info, #3b82f6)',
            'color-mix(in srgb, var(--info, #3b82f6) 10%, transparent)',
            'color-mix(in srgb, var(--info, #3b82f6) 30%, transparent)',
          ),
        ColorVariant.success => (
            'var(--success, #22c55e)',
            'color-mix(in srgb, var(--success, #22c55e) 10%, transparent)',
            'color-mix(in srgb, var(--success, #22c55e) 30%, transparent)',
          ),
        ColorVariant.warning => (
            'var(--warning, #f59e0b)',
            'color-mix(in srgb, var(--warning, #f59e0b) 10%, transparent)',
            'color-mix(in srgb, var(--warning, #f59e0b) 30%, transparent)',
          ),
        ColorVariant.destructive => (
            'var(--destructive)',
            'color-mix(in srgb, var(--destructive) 10%, transparent)',
            'color-mix(in srgb, var(--destructive) 30%, transparent)',
          ),
        ColorVariant.primary => (
            'var(--primary)',
            'color-mix(in srgb, var(--primary) 10%, transparent)',
            'color-mix(in srgb, var(--primary) 30%, transparent)',
          ),
        ColorVariant.secondary => (
            'var(--secondary)',
            'color-mix(in srgb, var(--secondary) 10%, transparent)',
            'color-mix(in srgb, var(--secondary) 30%, transparent)',
          ),
      };

  @override
  Component build(BuildContext context) {
    final (primary, bgColor, borderColor) = _colors;

    // ShadCN Alert styles vary by style
    final containerStyles = switch (props.style) {
      AlertStyle.subtle => <String, String>{
          'background-color': bgColor,
          'border': '1px solid $borderColor',
          'border-radius': 'var(--arcane-radius-md)', // rounded-lg
        },
      AlertStyle.solid => <String, String>{
          'background-color': primary,
          'border': '1px solid transparent',
          'border-radius': 'var(--arcane-radius-md)',
          'color': 'var(--primary-foreground)',
        },
      AlertStyle.outline => <String, String>{
          'background-color': 'var(--background)',
          'border': '1px solid $borderColor',
          'border-radius': 'var(--arcane-radius-md)',
          'color': 'var(--foreground)',
        },
      AlertStyle.accent => <String, String>{
          'background-color': bgColor,
          'border': '1px solid $borderColor',
          'border-left': '4px solid $primary',
          'border-radius': 'var(--arcane-radius-md)',
        },
    };

    final isSolid = props.style == AlertStyle.solid;

    return dom.div(
      classes: 'arcane-alert',
      attributes: const {'role': 'alert'},
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '12px',
        'padding': '16px', // p-4
        ...containerStyles,
      }),
      [
        // Icon
        if (props.showIcon)
          dom.div(
            classes: 'arcane-alert-icon',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'width': '16px',
              'height': '16px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': isSolid ? 'var(--primary-foreground)' : primary,
              'font-size': 'var(--font-size-base)',
              'margin-top': '1px',
            }),
            [props.icon ?? Component.text(_defaultIcon)],
          ),

        // Content
        dom.div(
          classes: 'arcane-alert-content',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            // Title
            if (props.title != null)
              dom.div(
                classes: 'arcane-alert-title',
                styles: dom.Styles(raw: {
                  'font-weight': 'var(--font-weight-medium)',
                  'line-height': '1',
                  'letter-spacing': '-0.025em',
                  'color': isSolid ? 'var(--primary-foreground)' : 'var(--foreground)',
                  if (props.message != null || props.child != null) 'margin-bottom': '4px',
                }),
                [Component.text(props.title!)],
              ),
            // Description
            if (props.message != null)
              dom.div(
                classes: 'arcane-alert-description',
                styles: dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'line-height': '1.625',
                  'color': isSolid ? 'var(--primary-foreground)' : 'var(--muted-foreground)',
                }),
                [Component.text(props.message!)],
              ),
            if (props.child != null) props.child!,
            if (props.action != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'margin-top': '12px',
                }),
                [props.action!],
              ),
          ],
        ),

        // Dismiss button
        if (props.dismissible)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'arcane-alert-dismiss',
            attributes: const {'aria-label': 'Dismiss'},
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'right': '8px',
              'top': '8px',
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': isSolid ? 'var(--primary-foreground)' : 'var(--muted-foreground)',
              'cursor': 'pointer',
              'border-radius': 'var(--arcane-radius-xs)', // rounded-sm
              'opacity': '0.7',
              'transition': 'opacity var(--arcane-transition)',
              'font-size': 'var(--font-size-base)',
            }),
            events: {'click': (_) => props.onDismiss?.call()},
            [const Component.text('\u00D7')], // ×
          ),
      ],
    );
  }
}