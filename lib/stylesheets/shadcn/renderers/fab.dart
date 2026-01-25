import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/fab_props.dart';

/// ShadCN FAB (Floating Action Button) renderer.
class ShadcnFAB extends StatelessComponent {
  final FABProps props;

  const ShadcnFAB(this.props);

  @override
  Component build(BuildContext context) {
    final bool isExtended = props.label != null;

    // Get size-specific dimensions
    final (double dimension, double iconSize) = switch (props.size) {
      ComponentSize.sm => (40.0, 18.0),
      ComponentSize.md => (56.0, 24.0),
      ComponentSize.lg => (72.0, 32.0),
    };

    // Get position styles
    final Map<String, String> positionStyles = switch (props.position) {
      FABPosition.bottomRight => {
          'position': 'fixed',
          'bottom': '1.5rem',
          'right': '1.5rem',
        },
      FABPosition.bottomLeft => {
          'position': 'fixed',
          'bottom': '1.5rem',
          'left': '1.5rem',
        },
      FABPosition.bottomCenter => {
          'position': 'fixed',
          'bottom': '1.5rem',
          'left': '50%',
          'transform': 'translateX(-50%)',
        },
      FABPosition.topRight => {
          'position': 'fixed',
          'top': '1.5rem',
          'right': '1.5rem',
        },
      FABPosition.topLeft => {
          'position': 'fixed',
          'top': '1.5rem',
          'left': '1.5rem',
        },
      FABPosition.relative => {},
    };

    // Get color variant styles
    final Map<String, String> variantStyles = switch (props.color) {
      ColorVariant.primary => {
          'background-color': 'var(--primary)',
          'color': 'var(--primary-foreground)',
        },
      ColorVariant.secondary => {
          'background-color': 'var(--secondary)',
          'color': 'var(--secondary-foreground)',
        },
      ColorVariant.destructive => {
          'background-color': 'var(--destructive)',
          'color': 'var(--destructive-foreground)',
        },
      ColorVariant.success => {
          'background-color': 'var(--success, #22c55e)',
          'color': 'var(--success-foreground, #ffffff)',
        },
      ColorVariant.warning => {
          'background-color': 'var(--warning, #f59e0b)',
          'color': 'var(--warning-foreground, #000000)',
        },
      ColorVariant.info => {
          'background-color': 'var(--info, #3b82f6)',
          'color': 'var(--info-foreground, #ffffff)',
        },
    };

    return button(
      id: props.id,
      classes: 'arcane-fab ${props.disabled ? 'disabled' : ''} ${isExtended ? 'extended' : ''}',
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
        'gap': isExtended ? '0.5rem' : '0',
        if (!isExtended) 'width': '${dimension}px',
        if (isExtended) 'padding': '0 1.5rem',
        'height': '${dimension}px',
        'border-radius': isExtended ? '${dimension / 2}px' : '0.5rem',
        'border': 'none',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'box-shadow': 'var(--arcane-shadow-lg)',
        'transition': 'all var(--arcane-transition-slow)',
        'z-index': '50',
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
          }),
          [props.icon],
        ),
        if (props.label != null)
          span(
            styles: const Styles(raw: {
              'font-weight': 'var(--font-weight-medium)',
              'font-size': 'var(--font-size-base)',
              'white-space': 'nowrap',
            }),
            [Component.text(props.label!)],
          ),
      ],
    );
  }
}
