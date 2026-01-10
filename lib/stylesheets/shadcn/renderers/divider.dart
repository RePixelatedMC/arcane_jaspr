import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/divider_props.dart';

/// ShadCN Divider renderer.
///
/// Similar to ShadCN Separator but with additional variants and dashed support.
/// Reference: https://ui.shadcn.com/docs/components/separator
class ShadcnDivider extends StatelessComponent {
  final DividerProps props;

  const ShadcnDivider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final isHorizontal = props.orientation == DividerOrientation.horizontal;
    final effectiveMargin = props.margin ?? 16;

    // Get thickness and color based on variant
    final (thickness, color) = switch (props.variant) {
      DividerVariant.standard => ('1px', 'var(--border)'),
      DividerVariant.subtle => ('1px', 'var(--muted)'),
      DividerVariant.bold => ('2px', 'var(--border)'),
    };

    // Handle labeled horizontal divider
    if (props.label != null && isHorizontal) {
      return _buildLabeledDivider(thickness, color, effectiveMargin);
    }

    // Vertical divider
    if (!isHorizontal) {
      return _buildVerticalDivider(thickness, color, effectiveMargin);
    }

    // Simple horizontal divider
    return dom.hr(
      classes: 'arcane-divider',
      attributes: {
        'role': 'separator',
        'aria-orientation': 'horizontal',
      },
      styles: dom.Styles(raw: {
        'margin': '${effectiveMargin}px 0',
        'border': 'none',
        'height': thickness,
        ..._getBackgroundStyle(color),
      }),
    );
  }

  Component _buildLabeledDivider(
    String thickness,
    String color,
    double margin,
  ) {
    return dom.div(
      classes: 'arcane-divider arcane-divider-labeled',
      attributes: {
        'role': 'separator',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--space-4)',
        'margin': '${margin}px 0',
      }),
      [
        // Left line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': thickness,
            ..._getBackgroundStyle(color),
          }),
          [],
        ),

        // Label
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
            'white-space': 'nowrap',
          }),
          [Component.text(props.label!)],
        ),

        // Right line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': thickness,
            ..._getBackgroundStyle(color),
          }),
          [],
        ),
      ],
    );
  }

  Component _buildVerticalDivider(
    String thickness,
    String color,
    double margin,
  ) {
    return dom.div(
      classes: 'arcane-divider arcane-divider-vertical',
      attributes: {
        'role': 'separator',
        'aria-orientation': 'vertical',
      },
      styles: dom.Styles(raw: {
        'width': thickness,
        'margin': '0 ${margin}px',
        ..._getBackgroundStyle(color),
        if (props.height != null)
          'height': '${props.height}px'
        else
          'align-self': 'stretch',
      }),
      [],
    );
  }

  Map<String, String> _getBackgroundStyle(String color) {
    if (props.dashed) {
      return {
        'background':
            'repeating-linear-gradient(to right, $color 0, $color 4px, transparent 4px, transparent 8px)',
      };
    }
    return {'background-color': color};
  }
}
