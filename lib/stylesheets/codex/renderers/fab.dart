import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/fab_props.dart';

/// Codex FAB (Floating Action Button) renderer.
class CodexFAB extends StatelessComponent {
  final FABProps props;

  const CodexFAB(this.props);

  @override
  Component build(BuildContext context) {
    final bool isExtended = props.label != null;

    // Get size-specific dimensions (Codex: larger sizes)
    final (double dimension, double iconSize) = switch (props.size) {
      FABSize.small => (44.0, 20.0),
      FABSize.regular => (60.0, 26.0),
      FABSize.large => (76.0, 34.0),
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

    // Get variant styles
    final Map<String, String> variantStyles = switch (props.variant) {
      FABVariant.primary => {
          'background-color': 'var(--primary)',
          'color': '#ffffff',
          'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.35)',
        },
      FABVariant.secondary => {
          'background-color': 'var(--secondary)',
          'color': 'var(--foreground)',
        },
      FABVariant.surface => {
          'background-color': 'var(--card)',
          'color': 'var(--foreground)',
          'border': '1px solid var(--border)',
        },
      FABVariant.success => {
          'background-color': 'var(--success)',
          'color': '#ffffff',
        },
      FABVariant.destructive => {
          'background-color': 'var(--destructive)',
          'color': '#ffffff',
        },
    };

    return button(
      id: props.id,
      classes: 'codex-fab ${props.disabled ? 'disabled' : ''} ${isExtended ? 'extended' : ''}',
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
        'gap': isExtended ? '0.75rem' : '0',
        if (!isExtended) 'width': '${dimension}px',
        if (isExtended) 'padding': '0 2rem',
        'height': '${dimension}px',
        'border-radius': isExtended ? '${dimension / 2}px' : 'var(--radius)',
        'border': 'none',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'box-shadow': '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
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
