import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import '../../../core/props/toggle_switch_props.dart';

/// Codex toggle switch renderer with restrained accent emphasis.
class CodexToggleSwitch extends StatelessComponent {
  final ToggleSwitchProps props;

  const CodexToggleSwitch(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (double width, double height, double thumbSize, double inset) =
        switch (props.size) {
      ComponentSize.sm => (44.0, 24.0, 18.0, 3.0),
      ComponentSize.md => (52.0, 28.0, 22.0, 3.0),
      ComponentSize.lg => (60.0, 32.0, 26.0, 3.0),
    };

    final String tone = switch (props.color) {
      ColorVariant.primary => 'var(--primary)',
      ColorVariant.secondary => 'var(--secondary)',
      ColorVariant.destructive => 'var(--destructive)',
      ColorVariant.success => 'var(--success)',
      ColorVariant.warning => 'var(--warning)',
      ColorVariant.info => 'var(--info)',
    };

    final double thumbTranslate = props.value ? (width - thumbSize - (inset * 2)) : 0;

    final Component switchWidget = dom.button(
      classes: 'codex-toggle-switch ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'role': 'switch',
        'aria-checked': '${props.value}',
        'data-state': props.value ? 'checked' : 'unchecked',
        'data-disabled': '${props.disabled}',
        'data-variant': props.color.name,
        'data-size': props.size.name,
        if (props.disabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
        'align-items': 'center',
        'width': '${width}px',
        'height': '${height}px',
        'padding': '${inset}px',
        'border-radius': '${height / 2}px',
        'border': props.value
            ? '1px solid color-mix(in srgb, $tone 40%, var(--border))'
            : '1px solid var(--border)',
        'background': props.value
            ? 'linear-gradient(180deg, color-mix(in srgb, $tone 72%, #0d1110), $tone)'
            : 'var(--codex-surface-1)',
        'box-shadow': props.value ? '0 10px 22px rgba(0, 0, 0, 0.3)' : 'none',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
        'transition': 'background 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease',
        'outline': 'none',
      }),
      events: props.disabled || props.onChanged == null
          ? null
          : {
              'click': (_) => props.onChanged!(!props.value),
            },
      [
        dom.span(
          classes: 'codex-toggle-thumb',
          styles: dom.Styles(raw: {
            'display': 'block',
            'width': '${thumbSize}px',
            'height': '${thumbSize}px',
            'border-radius': '50%',
            'background': '#ffffff',
            'border': '1px solid color-mix(in srgb, var(--border) 60%, transparent)',
            'transform': 'translateX(${thumbTranslate}px)',
            'transition': 'transform 0.2s ease',
            'box-shadow': '0 2px 8px rgba(0, 0, 0, 0.3)',
            'pointer-events': 'none',
          }),
          [],
        ),
      ],
    );

    if (props.label == null) {
      return switchWidget;
    }

    final Component labelWidget = dom.span(
      classes: 'codex-toggle-label',
      styles: dom.Styles(raw: {
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'color': props.disabled ? 'var(--muted-foreground)' : 'var(--foreground)',
        'user-select': 'none',
      }),
      [Component.text(props.label!)],
    );

    return dom.label(
      classes: 'codex-toggle-wrapper',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
      }),
      events: props.disabled || props.onChanged == null
          ? null
          : {
              'click': (e) {
                // Avoid double-toggle when the click originated on the button.
                if ((e.target as dynamic)?.tagName == 'BUTTON') return;
                props.onChanged!(!props.value);
              },
            },
      props.labelLeft ? [labelWidget, switchWidget] : [switchWidget, labelWidget],
    );
  }
}
