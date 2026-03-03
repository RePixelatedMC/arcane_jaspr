import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/separator_props.dart';

/// ShadCN Separator renderer.
///
/// Unified separator component combining features from both Divider and Separator.
/// Supports variants, dashed lines, labels, icons, and custom colors.
///
/// Reference: https://ui.shadcn.com/docs/components/separator
class ShadcnSeparator extends StatelessComponent {
  final SeparatorProps props;

  const ShadcnSeparator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final isHorizontal = props.orientation == SeparatorOrientation.horizontal;
    final effectiveMargin = props.margin ?? 16;

    // Get thickness and color based on variant
    final (thickness, variantColor) = switch (props.variant) {
      SeparatorVariant.standard => ('1px', 'var(--border)'),
      SeparatorVariant.subtle => ('1px', 'var(--muted)'),
      SeparatorVariant.bold => ('2px', 'var(--border)'),
    };

    // Use custom color if provided, otherwise use variant color
    final effectiveColor = props.color ?? variantColor;

    // Handle labeled/icon horizontal separator
    if ((props.label != null || props.icon != null) && isHorizontal) {
      return _buildLabeledSeparator(thickness, effectiveColor, effectiveMargin);
    }

    // Vertical separator
    if (!isHorizontal) {
      return _buildVerticalSeparator(
        thickness,
        effectiveColor,
        effectiveMargin,
      );
    }

    // Simple horizontal separator
    return dom.hr(
      classes: 'arcane-separator',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
        if (!props.decorative) 'aria-orientation': 'horizontal',
      },
      styles: dom.Styles(
        raw: {
          'margin': '${effectiveMargin}px 0',
          'border': 'none',
          'height': thickness,
          ..._getBackgroundStyle(effectiveColor),
        },
      ),
    );
  }

  Component _buildLabeledSeparator(
    String thickness,
    String color,
    double margin,
  ) {
    return dom.div(
      classes: 'arcane-separator arcane-separator-labeled',
      attributes: {'role': props.decorative ? 'none' : 'separator'},
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': 'var(--space-4)',
          'margin': '${margin}px 0',
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
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
                'white-space': 'nowrap',
              },
            ),
            [Component.text(props.label!)],
          )
        else if (props.icon != null)
          dom.span(
            styles: const dom.Styles(raw: {'color': 'var(--muted-foreground)'}),
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
    double margin,
  ) {
    return dom.div(
      classes: 'arcane-separator arcane-separator-vertical',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
        if (!props.decorative) 'aria-orientation': 'vertical',
      },
      styles: dom.Styles(
        raw: {
          'width': thickness,
          'margin': '0 ${margin}px',
          ..._getBackgroundStyle(color),
          if (props.height != null)
            'height': '${props.height}px'
          else ...{
            'align-self': 'stretch',
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
      };
    }
    return {'background-color': color};
  }
}
