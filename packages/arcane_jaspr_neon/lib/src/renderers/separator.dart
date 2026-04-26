import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/separator_props.dart';

/// Neon Separator renderer.
///
/// Unified separator component combining features from both Divider and Separator.
/// Implements the Neon design language:
/// - Subtle border color for OLED screens
/// - Optional label/icon with accent styling
/// - Dashed line support
/// - Variant-based thickness
class NeonSeparator extends StatelessComponent {
  final SeparatorProps props;

  const NeonSeparator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final isHorizontal = props.orientation == SeparatorOrientation.horizontal;

    // Neon variant colors and thickness
    final (variantColor, thickness) = switch (props.variant) {
      SeparatorVariant.standard => ('var(--border)', '1px'),
      SeparatorVariant.subtle => ('var(--muted)', '1px'),
      SeparatorVariant.bold => ('var(--border)', '2px'),
    };

    // Use custom color if provided
    final effectiveColor = props.color ?? variantColor;

    // Neon: larger default margin
    final margin = props.margin != null ? '${props.margin}px' : '1rem';

    // Handle labeled/icon horizontal separator
    if ((props.label != null || props.icon != null) && isHorizontal) {
      return _buildLabeledSeparator(thickness, effectiveColor, margin);
    }

    // Vertical separator
    if (!isHorizontal) {
      return _buildVerticalSeparator(thickness, effectiveColor, margin);
    }

    // Simple horizontal separator
    return dom.div(
      classes: 'neon-separator',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
        if (!props.decorative) 'aria-orientation': 'horizontal',
      },
      styles: dom.Styles(
        raw: {
          'width': '100%',
          'height': thickness,
          'margin': '$margin 0',
          ..._getBackgroundStyle(effectiveColor),
        },
      ),
      [],
    );
  }

  Component _buildLabeledSeparator(
    String thickness,
    String color,
    String margin,
  ) {
    return dom.div(
      classes: 'neon-separator neon-separator-with-label',
      attributes: {'role': props.decorative ? 'none' : 'separator'},
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'width': '100%',
          'margin': '$margin 0',
          'gap': 'var(--arcane-space-4)',
        },
      ),
      [
        // Left line
        dom.div(
          styles: dom.Styles(
            raw: {
              'flex': '1',
              'height': thickness,
              ..._getBackgroundStyle(color),
            },
          ),
          [],
        ),

        // Label or icon
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--arcane-font-size-xs)',
                'font-weight': 'var(--arcane-font-weight-medium)',
                'text-transform': 'uppercase',
                'letter-spacing': '0',
                'color': 'var(--muted-foreground)',
                'flex-shrink': '0',
              },
            ),
            [Component.text(props.label!)],
          )
        else if (props.icon != null)
          dom.span(
            styles: const dom.Styles(
              raw: {'color': 'var(--muted-foreground)', 'flex-shrink': '0'},
            ),
            [props.icon!],
          ),

        // Right line
        dom.div(
          styles: dom.Styles(
            raw: {
              'flex': '1',
              'height': thickness,
              ..._getBackgroundStyle(color),
            },
          ),
          [],
        ),
      ],
    );
  }

  Component _buildVerticalSeparator(
    String thickness,
    String color,
    String margin,
  ) {
    return dom.div(
      classes: 'neon-separator neon-separator-vertical',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
        if (!props.decorative) 'aria-orientation': 'vertical',
      },
      styles: dom.Styles(
        raw: {
          'width': thickness,
          'margin': '0 $margin',
          ..._getBackgroundStyle(color),
          if (props.height != null)
            'height': '${props.height}px'
          else ...{
            'height': '100%',
            'min-height': '20px',
          },
        },
      ),
      [],
    );
  }

  Map<String, String> _getBackgroundStyle(String color) {
    if (props.dashed) {
      final isVertical = props.orientation == SeparatorOrientation.vertical;
      return {
        'background': isVertical
            ? 'repeating-linear-gradient(to bottom, $color 0, $color 4px, transparent 4px, transparent 8px)'
            : 'repeating-linear-gradient(to right, $color 0, $color 4px, transparent 4px, transparent 8px)',
        'background-color': 'transparent',
      };
    }
    return {'background-color': color};
  }
}
