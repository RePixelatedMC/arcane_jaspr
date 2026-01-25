import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/chip_props.dart';

/// ShadCN-styled chip component
class ShadcnChip extends StatelessComponent {
  final ChipProps props;

  const ShadcnChip(this.props, {super.key});

  Map<String, String> get _variantStyles {
    // Get color-specific values
    final (String bgColor, String fgColor) = switch (props.color) {
      ColorVariant.primary => ('var(--primary)', 'var(--primary-foreground)'),
      ColorVariant.secondary => ('var(--secondary)', 'var(--secondary-foreground)'),
      ColorVariant.destructive => ('var(--destructive)', 'var(--destructive-foreground)'),
      ColorVariant.success => ('var(--success, #22c55e)', 'var(--success-foreground, #ffffff)'),
      ColorVariant.warning => ('var(--warning, #f59e0b)', 'var(--warning-foreground, #000000)'),
      ColorVariant.info => ('var(--info, #3b82f6)', 'var(--info-foreground, #ffffff)'),
    };

    return switch (props.style) {
      StyleVariant.solid => {
          'background-color': bgColor,
          'color': fgColor,
        },
      StyleVariant.outline => {
          'background-color': 'transparent',
          'color': bgColor,
          'border': '1px solid $bgColor',
        },
      StyleVariant.ghost => {
          'background-color': 'color-mix(in srgb, $bgColor 10%, transparent)',
          'color': bgColor,
        },
      StyleVariant.link => {
          'background-color': 'transparent',
          'color': bgColor,
        },
    };
  }

  @override
  Component build(BuildContext context) {
    final (padding, fontSize) = switch (props.size) {
      ComponentSize.sm => ('0.25rem 0.5rem', '0.75rem'),
      ComponentSize.md => ('0.375rem 0.625rem', '0.875rem'),
      ComponentSize.lg => ('0.5rem 1rem', '1rem'),
    };

    return dom.span(
      classes: 'arcane-chip ${props.onTap != null ? 'clickable' : ''}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'padding': padding,
        'border-radius': 'var(--arcane-radius-full, 9999px)',
        ..._variantStyles,
        'font-size': fontSize,
        'font-weight': 'var(--font-weight-medium)',
        'white-space': 'nowrap',
        'line-height': '1',
        if (props.onTap != null) 'cursor': 'pointer',
        'transition': 'var(--arcane-transition-fast, all var(--arcane-transition))',
      }),
      events: props.onTap != null
          ? {
              'click': (event) => props.onTap!(),
            }
          : null,
      [
        if (props.icon != null) props.icon!,
        Component.text(props.label),
        if (props.removable)
          dom.span(
            classes: 'arcane-chip-remove',
            styles: const dom.Styles(raw: {
              'margin-left': '2px',
              'cursor': 'pointer',
              'opacity': '0.7',
              'font-size': '1.1em',
              'line-height': '1',
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
            }),
            events: {
              'click': (event) {
                event.stopPropagation();
                props.onRemove?.call();
              },
            },
            [const Component.text('\u00D7')], // × character
          ),
      ],
    );
  }
}

/// ShadCN-styled chip group component
class ShadcnChipGroup extends StatelessComponent {
  final ChipGroupProps props;

  const ShadcnChipGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-chip-group',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': props.gap ?? '0.5rem',
      }),
      [
        for (final chip in props.chips) ShadcnChip(chip),
      ],
    );
  }
}