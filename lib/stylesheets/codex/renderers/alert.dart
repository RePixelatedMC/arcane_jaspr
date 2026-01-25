import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/alert_props.dart';

/// Codex Alert renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing borders with neon effects
/// - Holographic-style gradients
/// - Intense color variants with glows
class CodexAlert extends StatelessComponent {
  final AlertProps props;

  const CodexAlert(this.props, {super.key});

  String get _defaultIcon => switch (props.color) {
        ColorVariant.info => '\u2139', // i
        ColorVariant.success => '\u2713', // checkmark
        ColorVariant.warning => '\u26A0', // warning
        ColorVariant.destructive => '\u2715', // x
        ColorVariant.primary => '\u2139', // i
        ColorVariant.secondary => '\u2139', // i
      };

  (String primary, String background, String border, String glow) get _colors =>
      switch (props.color) {
        ColorVariant.info => (
            'var(--info, #3b82f6)',
            'color-mix(in srgb, var(--info, #3b82f6) 10%, var(--card))',
            'var(--info, #3b82f6)',
            '0 0 20px rgba(var(--info-rgb), 0.2)',
          ),
        ColorVariant.success => (
            'var(--success, #22c55e)',
            'color-mix(in srgb, var(--success, #22c55e) 10%, var(--card))',
            'var(--success, #22c55e)',
            '0 0 20px rgba(var(--success-rgb), 0.2)',
          ),
        ColorVariant.warning => (
            'var(--warning, #f59e0b)',
            'color-mix(in srgb, var(--warning, #f59e0b) 10%, var(--card))',
            'var(--warning, #f59e0b)',
            '0 0 20px rgba(var(--warning-rgb), 0.2)',
          ),
        ColorVariant.destructive => (
            'var(--destructive)',
            'color-mix(in srgb, var(--destructive) 10%, var(--card))',
            'var(--destructive)',
            '0 0 20px rgba(var(--destructive-rgb), 0.2)',
          ),
        ColorVariant.primary => (
            'var(--primary)',
            'color-mix(in srgb, var(--primary) 10%, var(--card))',
            'var(--primary)',
            '0 0 20px rgba(var(--primary-rgb), 0.2)',
          ),
        ColorVariant.secondary => (
            'var(--secondary)',
            'color-mix(in srgb, var(--secondary) 10%, var(--card))',
            'var(--secondary)',
            '0 0 15px rgba(var(--secondary-rgb), 0.15)',
          ),
      };

  @override
  Component build(BuildContext context) {
    final (primary, bgColor, borderColor, glow) = _colors;

    // Codex Neon Alert styles vary by style variant
    final containerStyles = switch (props.style) {
      AlertStyle.solid => <String, String>{
          'background': 'linear-gradient(135deg, $primary 0%, color-mix(in srgb, $primary 70%, #ff00ff) 100%)',
          'border': '1px solid transparent',
          'border-radius': 'var(--arcane-radius-md)',
          'color': '#ffffff',
          'box-shadow': glow,
        },
      AlertStyle.subtle => <String, String>{
          'background-color': bgColor,
          'border': '1px solid $borderColor',
          'border-radius': 'var(--arcane-radius-md)',
          'box-shadow': glow,
        },
      AlertStyle.outline => <String, String>{
          'background-color': 'var(--card)',
          'border': '1px solid $borderColor',
          'border-radius': 'var(--arcane-radius-md)',
          'box-shadow': glow,
        },
      AlertStyle.accent => <String, String>{
          'background-color': bgColor,
          'border': '1px solid $borderColor',
          'border-left': '4px solid $primary',
          'border-radius': 'var(--arcane-radius-md)',
          'box-shadow': glow,
        },
    };

    final isSolid = props.style == AlertStyle.solid;

    return dom.div(
      classes: 'codex-alert codex-neon',
      attributes: const {'role': 'alert'},
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': '100%',
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '12px',
        'padding': '16px',
        ...containerStyles,
      }),
      [
        // Icon
        if (props.showIcon)
          dom.div(
            classes: 'codex-alert-icon',
            styles: dom.Styles(raw: {
              'flex-shrink': '0',
              'width': '16px',
              'height': '16px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'color': isSolid ? '#ffffff' : primary,
              'font-size': 'var(--font-size-base)',
              'margin-top': '1px',
            }),
            [props.icon ?? Component.text(_defaultIcon)],
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
                styles: dom.Styles(raw: {
                  'font-weight': 'var(--font-weight-medium)',
                  'line-height': '1',
                  'letter-spacing': '-0.025em',
                  'color': isSolid ? '#ffffff' : 'var(--foreground)',
                  if (props.message != null || props.child != null) 'margin-bottom': '4px',
                }),
                [Component.text(props.title!)],
              ),
            // Description
            if (props.message != null)
              dom.div(
                classes: 'codex-alert-description',
                styles: dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'line-height': '1.625',
                  'color': isSolid ? 'rgba(255, 255, 255, 0.9)' : 'var(--muted-foreground)',
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
            classes: 'codex-alert-dismiss',
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
              'color': isSolid ? 'rgba(255, 255, 255, 0.8)' : 'var(--muted-foreground)',
              'cursor': 'pointer',
              'border-radius': 'var(--arcane-radius-xs)',
              'opacity': '0.7',
              'transition': 'opacity var(--arcane-transition)',
              'font-size': 'var(--font-size-base)',
            }),
            events: {'click': (_) => props.onDismiss?.call()},
            [const Component.text('\u00D7')], // x
          ),
      ],
    );
  }
}
