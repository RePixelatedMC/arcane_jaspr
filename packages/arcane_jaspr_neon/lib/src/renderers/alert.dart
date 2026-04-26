import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/alert_props.dart';

/// Neon Alert renderer.
///
/// Implements the Neon accent dark design language:
/// - Elevated borders with accent effects
/// - layered-style gradients
/// - Restrained color variants
class NeonAlert extends StatelessComponent {
  final AlertProps props;

  const NeonAlert(this.props, {super.key});

  String get _defaultIcon => switch (props.color) {
    ColorVariant.info => '\u2139', // i
    ColorVariant.success => '\u2713', // checkmark
    ColorVariant.warning => '\u26A0', // warning
    ColorVariant.destructive => '\u2715', // x
    ColorVariant.primary => '\u2139', // i
    ColorVariant.secondary => '\u2139', // i
  };

  (String primary, String background, String border, String shadow)
  get _colors => switch (props.color) {
    ColorVariant.info => (
      'var(--info, #3b82f6)',
      'color-mix(in srgb, var(--info, #3b82f6) 10%, var(--card))',
      'var(--info, #3b82f6)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.success => (
      'var(--success, #22c55e)',
      'color-mix(in srgb, var(--success, #22c55e) 10%, var(--card))',
      'var(--success, #22c55e)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.warning => (
      'var(--warning, #f59e0b)',
      'color-mix(in srgb, var(--warning, #f59e0b) 10%, var(--card))',
      'var(--warning, #f59e0b)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.destructive => (
      'var(--destructive)',
      'color-mix(in srgb, var(--destructive) 10%, var(--card))',
      'var(--destructive)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.primary => (
      'var(--primary)',
      'color-mix(in srgb, var(--primary) 10%, var(--card))',
      'var(--primary)',
      '0 10px 24px rgba(0, 0, 0, 0.28)',
    ),
    ColorVariant.secondary => (
      'var(--secondary)',
      'color-mix(in srgb, var(--secondary) 10%, var(--card))',
      'var(--secondary)',
      '0 10px 20px rgba(0, 0, 0, 0.24)',
    ),
  };

  @override
  Component build(BuildContext context) {
    (String, String, String, String) colors = _colors;
    String primary = colors.$1;
    String bgColor = colors.$2;
    String borderColor = colors.$3;
    String shadow = colors.$4;

    Map<String, String> containerStyles = switch (props.style) {
      AlertStyle.solid => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 82%, #0d1110), $primary 68%, color-mix(in srgb, var(--neon-cyan) 44%, $primary))',
        'border': '1px solid transparent',
        'border-radius': 'var(--neon-radius-panel)',
        'color': '#ffffff',
        'box-shadow': shadow,
      },
      AlertStyle.subtle => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 9%, transparent), $bgColor), linear-gradient(90deg, color-mix(in srgb, $primary 5%, transparent) 1px, transparent 1px)',
        'background-size': 'auto, 18px 18px',
        'border': '1px solid $borderColor',
        'border-radius': 'var(--neon-radius-panel)',
        'box-shadow': shadow,
      },
      AlertStyle.outline => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 5%, transparent), color-mix(in srgb, var(--card) 74%, transparent))',
        'border': '1px solid $borderColor',
        'border-radius': 'var(--neon-radius-panel)',
        'box-shadow': shadow,
      },
      AlertStyle.accent => <String, String>{
        'background':
            'linear-gradient(135deg, color-mix(in srgb, $primary 10%, transparent), $bgColor), linear-gradient(90deg, color-mix(in srgb, $primary 8%, transparent) 1px, transparent 1px)',
        'background-size': 'auto, 18px 18px',
        'border': '1px solid $borderColor',
        'border-top': '2px solid $primary',
        'border-radius': 'var(--neon-radius-panel)',
        'box-shadow': shadow,
      },
    };

    bool isSolid = props.style == AlertStyle.solid;

    return dom.div(
      classes: 'neon-alert ',
      attributes: {
        'role': 'alert',
        'data-variant': props.color.name,
        'data-style': props.style.name,
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'width': '100%',
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '12px',
          'padding': '16px',
          'overflow': 'hidden',
          'clip-path': 'var(--neon-panel-clip)',
          'isolation': 'isolate',
          ...containerStyles,
        },
      ),
      [
        if (props.showIcon)
          dom.div(
            classes: 'neon-alert-icon',
            styles: dom.Styles(
              raw: {
                'flex-shrink': '0',
                'width': '16px',
                'height': '16px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'color': isSolid ? '#ffffff' : primary,
                'font-size': 'var(--font-size-base)',
                'margin-top': '1px',
                'filter': 'drop-shadow(0 0 8px $primary)',
              },
            ),
            [props.icon ?? Component.text(_defaultIcon)],
          ),

        dom.div(
          classes: 'neon-alert-content',
          styles: const dom.Styles(raw: {'flex': '1', 'min-width': '0'}),
          [
            if (props.title != null)
              dom.div(
                classes: 'neon-alert-title',
                styles: dom.Styles(
                  raw: {
                    'font-weight': 'var(--font-weight-medium)',
                    'line-height': '1',
                    'letter-spacing': '0',
                    'text-transform': 'uppercase',
                    'color': isSolid ? '#ffffff' : 'var(--foreground)',
                    if (props.message != null || props.child != null)
                      'margin-bottom': '4px',
                  },
                ),
                [Component.text(props.title!)],
              ),
            if (props.message != null)
              dom.div(
                classes: 'neon-alert-description',
                styles: dom.Styles(
                  raw: {
                    'font-size': 'var(--font-size-sm)',
                    'line-height': '1.625',
                    'color': isSolid
                        ? 'rgba(255, 255, 255, 0.9)'
                        : 'var(--muted-foreground)',
                  },
                ),
                [Component.text(props.message!)],
              ),
            if (props.child != null) props.child!,
            if (props.action != null)
              dom.div(styles: const dom.Styles(raw: {'margin-top': '12px'}), [
                props.action!,
              ]),
          ],
        ),

        if (props.dismissible)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'neon-alert-dismiss',
            attributes: const {'aria-label': 'Dismiss'},
            styles: dom.Styles(
              raw: {
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
                'color': isSolid
                    ? 'rgba(255, 255, 255, 0.8)'
                    : 'var(--muted-foreground)',
                'cursor': 'pointer',
                'border-radius': 'var(--arcane-radius-xs)',
                'opacity': '0.7',
                'transition': 'opacity var(--arcane-transition)',
                'font-size': 'var(--font-size-base)',
              },
            ),
            events: {'click': (_) => props.onDismiss?.call()},
            [const Component.text('\u00D7')], // x
          ),
      ],
    );
  }
}
