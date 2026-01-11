import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/toggle_switch_props.dart';

/// Codex Toggle Switch renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Intense neon glows when active
/// - Holographic gradient backgrounds
/// - Glowing thumb with trail effect
/// - Cyberpunk-style color variants
class CodexToggleSwitch extends StatelessComponent {
  final ToggleSwitchProps props;

  const CodexToggleSwitch(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex Neon size-specific dimensions - larger with more presence
    final (double width, double height, double thumbSize, double thumbOffset) =
        switch (props.size) {
      ToggleSwitchSize.small => (48.0, 26.0, 22.0, 2.0),
      ToggleSwitchSize.medium => (56.0, 30.0, 26.0, 2.0),
      ToggleSwitchSize.large => (68.0, 36.0, 32.0, 2.0),
    };

    final double thumbTranslate =
        props.value ? (width - thumbSize - thumbOffset * 2) : 0.0;

    // Codex Neon variant colors with intense glows
    final (String activeGradient, String inactiveGradient, String glowColor, String thumbGlow) = switch (props.variant) {
      ToggleSwitchVariant.primary => (
        'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
        'linear-gradient(135deg, rgba(var(--muted-rgb), 0.8) 0%, rgba(var(--muted-rgb), 0.6) 100%)',
        '0 0 25px rgba(var(--primary-rgb), 0.4), 0 0 50px rgba(var(--primary-rgb), 0.15)',
        '0 0 15px rgba(var(--primary-rgb), 0.5)',
      ),
      ToggleSwitchVariant.success => (
        'linear-gradient(135deg, var(--success) 0%, color-mix(in srgb, var(--success) 70%, #00ffaa) 100%)',
        'linear-gradient(135deg, rgba(var(--muted-rgb), 0.8) 0%, rgba(var(--muted-rgb), 0.6) 100%)',
        '0 0 25px rgba(var(--success-rgb), 0.4), 0 0 50px rgba(var(--success-rgb), 0.15)',
        '0 0 15px rgba(var(--success-rgb), 0.5)',
      ),
      ToggleSwitchVariant.warning => (
        'linear-gradient(135deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 70%, #ffaa00) 100%)',
        'linear-gradient(135deg, rgba(var(--muted-rgb), 0.8) 0%, rgba(var(--muted-rgb), 0.6) 100%)',
        '0 0 25px rgba(var(--warning-rgb), 0.4), 0 0 50px rgba(var(--warning-rgb), 0.15)',
        '0 0 15px rgba(var(--warning-rgb), 0.5)',
      ),
      ToggleSwitchVariant.error => (
        'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #ff0066) 100%)',
        'linear-gradient(135deg, rgba(var(--muted-rgb), 0.8) 0%, rgba(var(--muted-rgb), 0.6) 100%)',
        '0 0 25px rgba(var(--destructive-rgb), 0.4), 0 0 50px rgba(var(--destructive-rgb), 0.15)',
        '0 0 15px rgba(var(--destructive-rgb), 0.5)',
      ),
    };

    final Component switchWidget = dom.button(
      classes:
          'codex-toggle-switch codex-neon ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
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
        'border': props.value ? 'none' : '1px solid rgba(var(--border-rgb), 0.5)',
        'border-radius': '${height / 2}px',
        'background': props.value ? activeGradient : inactiveGradient,
        // Neon glow when active
        'box-shadow': props.value ? glowColor : '0 0 10px rgba(var(--primary-rgb), 0.05)',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.4' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
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
        // Neon thumb with glow
        dom.span(
          classes: 'codex-toggle-thumb codex-neon',
          styles: dom.Styles(raw: {
            'display': 'block',
            'width': '${thumbSize}px',
            'height': '${thumbSize}px',
            'border-radius': '50%',
            'background': props.value
                ? 'linear-gradient(135deg, #ffffff 0%, rgba(255, 255, 255, 0.9) 100%)'
                : 'linear-gradient(135deg, var(--foreground) 0%, rgba(var(--foreground-rgb), 0.8) 100%)',
            'box-shadow': props.value
                ? '$thumbGlow, 0 2px 8px rgba(0, 0, 0, 0.3)'
                : '0 2px 4px rgba(0, 0, 0, 0.2)',
            'transform': 'translateX(${thumbTranslate}px)',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
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

    // With label - Codex Neon styling
    final Component labelWidget = dom.span(
      classes: 'codex-toggle-label',
      styles: dom.Styles(raw: {
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'color': props.disabled
            ? 'var(--muted-foreground)'
            : 'var(--foreground)',
        'user-select': 'none',
        'line-height': '1.4',
      }),
      [Component.text(props.label!)],
    );

    return dom.label(
      classes: 'codex-toggle-wrapper codex-neon',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '1rem',
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
