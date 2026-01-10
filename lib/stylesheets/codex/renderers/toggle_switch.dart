import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/toggle_switch_props.dart';

/// Codex Toggle Switch renderer.
///
/// Implements the Codex design language:
/// - Larger sizes (1.25x)
/// - Accent color with subtle glow when active
/// - Smoother animations
class CodexToggleSwitch extends StatelessComponent {
  final ToggleSwitchProps props;

  const CodexToggleSwitch(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex size-specific dimensions - larger than ShadCN
    final (double width, double height, double thumbSize, double thumbOffset) =
        switch (props.size) {
      ToggleSwitchSize.small => (40.0, 22.0, 18.0, 2.0), // vs ShadCN 36x20
      ToggleSwitchSize.medium => (48.0, 26.0, 22.0, 2.0), // vs ShadCN 44x24
      ToggleSwitchSize.large => (60.0, 32.0, 28.0, 2.0), // vs ShadCN 56x28
    };

    final double thumbTranslate =
        props.value ? (width - thumbSize - thumbOffset * 2) : 0.0;

    // Codex uses accent color for primary, with glow
    final (String activeColor, String inactiveColor, String glowColor) = switch (props.variant) {
      ToggleSwitchVariant.primary => (
          'var(--primary)',
          'var(--muted)',
          '0 0 15px rgba(var(--primary-rgb), 0.2)',
        ),
      ToggleSwitchVariant.success => (
          'var(--success)',
          'var(--muted)',
          '0 0 10px rgba(var(--success-rgb), 0.3)',
        ),
      ToggleSwitchVariant.warning => (
          'var(--warning)',
          'var(--muted)',
          '0 0 10px rgba(var(--warning-rgb), 0.3)',
        ),
      ToggleSwitchVariant.error => (
          'var(--destructive)',
          'var(--muted)',
          '0 0 10px rgba(var(--destructive-rgb), 0.3)',
        ),
    };

    final Component switchWidget = dom.button(
      classes:
          'codex-toggle-switch ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'role': 'switch',
        'aria-checked': props.value.toString(),
        if (props.disabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
        'align-items': 'center',
        'flex-shrink': '0',
        'width': '${width}px',
        'height': '${height}px',
        'padding': '${thumbOffset}px',
        'border': props.value ? 'none' : '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-full)',
        'background-color': props.value ? activeColor : inactiveColor,
        // Codex: subtle glow when active
        'box-shadow': props.value ? glowColor : 'none',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
        'transition': 'all var(--transition)',
        'outline': 'none',
        'box-sizing': 'border-box',
      }),
      events: {
        'click': (event) {
          if (!props.disabled && props.onChanged != null) {
            props.onChanged!(!props.value);
          }
        },
      },
      [
        // Thumb with subtle shadow
        dom.span(
          classes: 'codex-toggle-thumb',
          styles: dom.Styles(raw: {
            'display': 'block',
            'width': '${thumbSize}px',
            'height': '${thumbSize}px',
            'border-radius': 'var(--arcane-radius-full)',
            'background-color': 'var(--foreground)',
            'box-shadow': '0 2px 4px rgba(0, 0, 0, 0.2)',
            'transform': 'translateX(${thumbTranslate}px)',
            'transition': 'transform var(--transition)',
            'pointer-events': 'none',
            'flex-shrink': '0',
          }),
          [],
        ),
      ],
    );

    // If no label, return just the switch
    if (props.label == null) {
      return switchWidget;
    }

    // With label - Codex styling with more gap
    final Component labelWidget = dom.span(
      classes: 'codex-toggle-label',
      styles: dom.Styles(raw: {
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'color': props.disabled
            ? 'var(--muted-foreground)'
            : 'var(--foreground)',
        'user-select': 'none',
        'line-height': '1.25',
      }),
      [Component.text(props.label!)],
    );

    return dom.label(
      classes: 'codex-toggle-wrapper',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.75rem', // Codex: more gap (12px vs ShadCN 8px)
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
      }),
      events: {
        'click': (event) {
          if (!props.disabled && props.onChanged != null) {
            props.onChanged!(!props.value);
          }
        },
      },
      props.labelLeft
          ? [labelWidget, switchWidget]
          : [switchWidget, labelWidget],
    );
  }
}
