import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/separator_props.dart';

/// ShadCN Separator renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/separator
class ShadcnSeparator extends StatelessComponent {
  final SeparatorProps props;

  const ShadcnSeparator(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveColor = props.color ?? 'var(--border)';
    final isHorizontal = props.orientation == SeparatorOrientation.horizontal;

    // Handle label/icon case (horizontal only)
    if ((props.label != null || props.icon != null) && isHorizontal) {
      return _buildLabeledSeparator(effectiveColor);
    }

    // ShadCN Separator: shrink-0 bg-border
    // Horizontal: h-[1px] w-full
    // Vertical: h-full w-[1px]
    return dom.div(
      classes: 'arcane-separator',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
        if (!props.decorative) 'aria-orientation': props.orientation.name,
      },
      styles: dom.Styles(raw: {
        'flex-shrink': '0',
        'background-color': effectiveColor,
        if (isHorizontal) ...{
          'height': '1px',
          'width': '100%',
        } else ...{
          'width': '1px',
          'height': '100%',
          'min-height': '20px',
        },
      }),
      [],
    );
  }

  Component _buildLabeledSeparator(String effectiveColor) {
    return dom.div(
      classes: 'arcane-separator-labeled',
      attributes: {
        'role': props.decorative ? 'none' : 'separator',
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-4)',
        'width': '100%',
      }),
      [
        // Left line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': '0',
            'border-top': '1px solid $effectiveColor',
          }),
          [],
        ),

        // Label or icon
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'color': 'var(--muted-foreground)',
              'white-space': 'nowrap',
            }),
            [Component.text(props.label!)],
          )
        else if (props.icon != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'color': 'var(--muted-foreground)',
            }),
            [props.icon!],
          ),

        // Right line
        dom.div(
          styles: dom.Styles(raw: {
            'flex': '1',
            'height': '0',
            'border-top': '1px solid $effectiveColor',
          }),
          [],
        ),
      ],
    );
  }
}
