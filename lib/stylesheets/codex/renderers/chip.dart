import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/chip_props.dart';

/// Codex Chip renderer.
///
/// Implements the Codex design language:
/// - Accent-colored variants with subtle glow
/// - Slightly larger sizes
/// - Larger border radius
class CodexChip extends StatelessComponent {
  final ChipProps props;

  const CodexChip(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes - slightly larger
    final (String padding, String fontSize, String iconSize) = switch (props.size) {
      ChipSize.small => ('0.25rem 0.625rem', '0.6875rem', '12px'),
      ChipSize.medium => ('0.375rem 0.75rem', '0.75rem', '14px'), // Codex: more padding
      ChipSize.large => ('0.5rem 1rem', '0.875rem', '16px'),
    };

    // Codex variant styles with accent colors
    final Map<String, String> variantStyles = switch (props.variant) {
      ChipVariant.standard => {
          'background-color': 'var(--secondary)',
          'color': 'var(--foreground)',
          'border': '1px solid var(--border)',
        },
      ChipVariant.primary => {
          'background-color': 'var(--codex-accent)',
          'color': '#ffffff',
          'border': '1px solid transparent',
          'box-shadow': 'var(--codex-accent-glow-subtle)',
        },
      ChipVariant.secondary => {
          'background-color': 'var(--secondary)',
          'color': 'var(--secondary-foreground)',
          'border': '1px solid var(--border)',
        },
      ChipVariant.success => {
          'background-color': 'var(--success)',
          'color': 'var(--success-foreground)',
          'border': '1px solid transparent',
          'box-shadow': '0 0 10px rgba(var(--success-rgb), 0.25)',
        },
      ChipVariant.warning => {
          'background-color': 'var(--warning)',
          'color': 'var(--warning-foreground)',
          'border': '1px solid transparent',
        },
      ChipVariant.error => {
          'background-color': 'var(--destructive)',
          'color': 'var(--destructive-foreground)',
          'border': '1px solid transparent',
          'box-shadow': '0 0 10px rgba(var(--destructive-rgb), 0.25)',
        },
      ChipVariant.outline => {
          'background-color': 'transparent',
          'color': 'var(--codex-accent)',
          'border': '1px solid var(--codex-accent-border)',
        },
    };

    final bool isClickable = props.onTap != null;

    return dom.div(
      classes: 'codex-chip ${props.variant.name}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'padding': padding,
        'border-radius': 'var(--arcane-radius-full)',
        'font-size': fontSize,
        'font-weight': 'var(--arcane-font-weight-medium)',
        'line-height': '1',
        'white-space': 'nowrap',
        'transition': 'all var(--transition)',
        ...variantStyles,
        if (isClickable) 'cursor': 'pointer',
      }),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [
        // Icon
        if (props.icon != null)
          dom.span(
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': iconSize,
              'height': iconSize,
            }),
            [props.icon!],
          ),

        // Label
        Component.text(props.label),

        // Remove button
        if (props.removable)
          dom.button(
            classes: 'codex-chip-remove',
            attributes: {'type': 'button'},
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '16px',
              'height': '16px',
              'margin-left': '0.125rem',
              'margin-right': '-0.25rem',
              'background': 'transparent',
              'border': 'none',
              'border-radius': 'var(--arcane-radius-full)',
              'color': 'inherit',
              'opacity': '0.7',
              'cursor': 'pointer',
              'transition': 'opacity var(--transition)',
            }),
            events: props.onRemove == null
                ? null
                : {
                    'click': (e) {
                      e.stopPropagation();
                      props.onRemove!();
                    },
                  },
            [const Component.text('\u2715')],
          ),
      ],
    );
  }
}

/// Codex Chip Group renderer.
class CodexChipGroup extends StatelessComponent {
  final ChipGroupProps props;

  const CodexChipGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-chip-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': props.gap ?? '0.5rem',
      }),
      [
        for (final chip in props.chips)
          CodexChip(chip),
      ],
    );
  }
}
