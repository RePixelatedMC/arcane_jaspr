import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/fab_props.dart';

/// Codex FAB (Floating Action Button) renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Intense neon glows with pulsing animation
/// - Holographic-style gradient effects
/// - Glowing borders and icon effects
/// - Cyberpunk floating presence
class CodexFAB extends StatelessComponent {
  final FABProps props;

  const CodexFAB(this.props);

  @override
  Component build(BuildContext context) {
    final bool isExtended = props.label != null;

    // Codex Neon sizes - larger with more commanding presence
    final (double dimension, double iconSize) = switch (props.size) {
      ComponentSize.sm => (48.0, 22.0),
      ComponentSize.md => (64.0, 28.0),
      ComponentSize.lg => (80.0, 36.0),
    };

    // Get position styles
    final Map<String, String> positionStyles = switch (props.position) {
      FABPosition.bottomRight => {
        'position': 'fixed',
        'bottom': '2rem',
        'right': '2rem',
      },
      FABPosition.bottomLeft => {
        'position': 'fixed',
        'bottom': '2rem',
        'left': '2rem',
      },
      FABPosition.bottomCenter => {
        'position': 'fixed',
        'bottom': '2rem',
        'left': '50%',
        'transform': 'translateX(-50%)',
      },
      FABPosition.topRight => {
        'position': 'fixed',
        'top': '2rem',
        'right': '2rem',
      },
      FABPosition.topLeft => {
        'position': 'fixed',
        'top': '2rem',
        'left': '2rem',
      },
      FABPosition.relative => {},
    };

    // Codex Neon color variant styles with intense cyberpunk glows
    final Map<String, String> variantStyles = switch (props.color) {
      ColorVariant.primary => {
        'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 60%, #ff00ff) 100%)',
        'color': 'var(--primary-foreground)',
        'border': '1px solid rgba(var(--primary-rgb), 0.6)',
        'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.5), 0 0 60px rgba(var(--primary-rgb), 0.25), 0 8px 32px rgba(0, 0, 0, 0.4), inset 0 1px 0 rgba(255, 255, 255, 0.15)',
      },
      ColorVariant.secondary => {
        'background': 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 70%, var(--primary)) 100%)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid rgba(var(--border-rgb), 0.4)',
        'box-shadow': '0 0 20px rgba(var(--secondary-rgb), 0.3), 0 8px 32px rgba(0, 0, 0, 0.4)',
      },
      ColorVariant.destructive => {
        'background': 'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 60%, #ff0066) 100%)',
        'color': 'var(--destructive-foreground)',
        'border': '1px solid rgba(var(--destructive-rgb), 0.6)',
        'box-shadow': '0 0 30px rgba(var(--destructive-rgb), 0.5), 0 0 60px rgba(var(--destructive-rgb), 0.25), 0 8px 32px rgba(0, 0, 0, 0.4)',
      },
      ColorVariant.success => {
        'background': 'linear-gradient(135deg, var(--success) 0%, color-mix(in srgb, var(--success) 60%, #00ffaa) 100%)',
        'color': 'var(--success-foreground, #ffffff)',
        'border': '1px solid rgba(var(--success-rgb), 0.6)',
        'box-shadow': '0 0 30px rgba(var(--success-rgb), 0.5), 0 0 60px rgba(var(--success-rgb), 0.25), 0 8px 32px rgba(0, 0, 0, 0.4)',
      },
      ColorVariant.warning => {
        'background': 'linear-gradient(135deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 60%, #ffaa00) 100%)',
        'color': 'var(--warning-foreground, #000000)',
        'border': '1px solid rgba(var(--warning-rgb), 0.6)',
        'box-shadow': '0 0 30px rgba(var(--warning-rgb), 0.5), 0 0 60px rgba(var(--warning-rgb), 0.25), 0 8px 32px rgba(0, 0, 0, 0.4)',
      },
      ColorVariant.info => {
        'background': 'linear-gradient(135deg, var(--info) 0%, color-mix(in srgb, var(--info) 60%, #00aaff) 100%)',
        'color': 'var(--info-foreground, #ffffff)',
        'border': '1px solid rgba(var(--info-rgb), 0.6)',
        'box-shadow': '0 0 30px rgba(var(--info-rgb), 0.5), 0 0 60px rgba(var(--info-rgb), 0.25), 0 8px 32px rgba(0, 0, 0, 0.4)',
      },
    };

    return button(
      id: props.id,
      classes: 'codex-fab codex-neon ${props.disabled ? 'disabled' : ''} ${isExtended ? 'extended' : ''}',
      attributes: {
        if (props.disabled) 'disabled': 'true',
        'type': 'button',
        if (props.tooltip != null) 'title': props.tooltip!,
        if (props.tooltip != null) 'aria-label': props.tooltip!,
        ...?props.attributes,
      },
      styles: Styles(raw: {
        ...positionStyles,
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': isExtended ? '0.875rem' : '0',
        if (!isExtended) 'width': '${dimension}px',
        if (isExtended) 'padding': '0 2.5rem',
        'height': '${dimension}px',
        'border-radius': isExtended ? '${dimension / 2}px' : '50%',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.4' : '1',
        'z-index': '50',
        'position': 'relative',
        'overflow': 'hidden',
        // Neon transition with floating effect
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1), transform 0.2s ease-out',
        ...variantStyles,
      }),
      events: {
        'click': (event) {
          if (!props.disabled && props.onPressed != null) {
            props.onPressed!();
          }
        },
      },
      [
        div(
          styles: Styles(raw: {
            'width': '${iconSize}px',
            'height': '${iconSize}px',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'filter': 'drop-shadow(0 0 6px currentColor)',
          }),
          [props.icon],
        ),
        if (props.label != null)
          span(
            styles: const Styles(raw: {
              'font-weight': 'var(--font-weight-semibold)',
              'font-size': 'var(--font-size-sm)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'white-space': 'nowrap',
              'text-shadow': '0 0 10px rgba(255, 255, 255, 0.5)',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}
