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
      ComponentSize.sm => ('0.25rem 0.625rem', '0.6875rem', '12px'),
      ComponentSize.md => ('0.375rem 0.75rem', '0.75rem', '14px'), // Codex: more padding
      ComponentSize.lg => ('0.5rem 1rem', '0.875rem', '16px'),
    };

    // Get color-specific values with Codex glows
    final (String bgColor, String fgColor, String? glowColor) = switch (props.color) {
      ColorVariant.primary => (
        'var(--primary)',
        'var(--primary-foreground)',
        '0 0 15px rgba(var(--primary-rgb), 0.2)',
      ),
      ColorVariant.secondary => (
        'var(--secondary)',
        'var(--secondary-foreground)',
        null,
      ),
      ColorVariant.destructive => (
        'var(--destructive)',
        'var(--destructive-foreground)',
        '0 0 10px rgba(var(--destructive-rgb), 0.25)',
      ),
      ColorVariant.success => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #ffffff)',
        '0 0 10px rgba(var(--success-rgb), 0.25)',
      ),
      ColorVariant.warning => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #000000)',
        null,
      ),
      ColorVariant.info => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #ffffff)',
        '0 0 10px rgba(var(--info-rgb), 0.25)',
      ),
    };

    // Codex style-specific styles with glows
    final Map<String, String> styleStyles = switch (props.style) {
      StyleVariant.solid => {
          'background-color': bgColor,
          'color': fgColor,
          'border': '1px solid transparent',
          if (glowColor != null) 'box-shadow': glowColor,
        },
      StyleVariant.outline => {
          'background-color': 'transparent',
          'color': bgColor,
          'border': '1px solid $bgColor',
        },
      StyleVariant.ghost => {
          'background-color': 'color-mix(in srgb, $bgColor 15%, transparent)',
          'color': bgColor,
          'border': '1px solid transparent',
        },
      StyleVariant.link => {
          'background-color': 'transparent',
          'color': bgColor,
          'border': '1px solid transparent',
        },
    };

    final bool isClickable = props.onTap != null;

    return dom.div(
      classes: 'codex-chip ${props.color.name}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'padding': padding,
        'border-radius': 'var(--arcane-radius-full)',
        'font-size': fontSize,
        'font-weight': 'var(--font-weight-medium)',
        'line-height': '1',
        'white-space': 'nowrap',
        'transition': 'all var(--transition)',
        ...styleStyles,
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
