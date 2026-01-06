import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/chip_props.dart';

/// ShadCN-styled chip component
class ShadcnChip extends StatelessComponent {
  final ChipProps props;

  const ShadcnChip(this.props, {super.key});

  Map<String, String> get _variantStyles => switch (props.variant) {
        ChipVariant.standard => {
            'background-color': 'var(--arcane-muted)',
            'color': 'var(--arcane-muted-foreground)',
          },
        ChipVariant.primary => {
            'background-color': 'var(--arcane-primary)',
            'color': 'var(--arcane-primary-foreground)',
          },
        ChipVariant.secondary => {
            'background-color': 'var(--arcane-secondary)',
            'color': 'var(--arcane-secondary-foreground)',
          },
        ChipVariant.success => {
            'background-color': 'var(--arcane-success-container)',
            'color': 'var(--arcane-success)',
          },
        ChipVariant.warning => {
            'background-color': 'var(--arcane-warning-container)',
            'color': 'var(--arcane-warning)',
          },
        ChipVariant.error => {
            'background-color': 'var(--arcane-destructive-container)',
            'color': 'var(--arcane-destructive)',
          },
        ChipVariant.outline => {
            'background-color': 'transparent',
            'color': 'var(--arcane-foreground)',
            'border': '1px solid var(--arcane-border)',
          },
      };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize) = switch (props.size) {
      ChipSize.small => ('0.25rem 0.5rem', '0.75rem'),
      ChipSize.medium => ('0.375rem 0.625rem', '0.875rem'),
      ChipSize.large => ('0.5rem 1rem', '1rem'),
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
        'font-weight': '500',
        'white-space': 'nowrap',
        'line-height': '1',
        if (props.onTap != null) 'cursor': 'pointer',
        'transition': 'var(--arcane-transition-fast, all 150ms ease)',
      }),
      events: props.onTap != null
          ? {
              'click': (event) => props.onTap!(),
            }
          : null,
      [
        if (props.icon != null) props.icon!,
        dom.text(props.label),
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
            [dom.text('\u00D7')], // × character
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
