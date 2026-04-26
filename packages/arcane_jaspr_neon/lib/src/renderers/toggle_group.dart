import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/toggle_group_props.dart';

/// Neon toggle group renderer with restrained dark surfaces.
class NeonToggleGroup extends StatelessComponent {
  final ToggleGroupProps props;

  const NeonToggleGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neon-toggle-group',
      attributes: {
        'role': 'group',
        'data-disabled': '${props.disabled}',
        'data-variant': props.variant.name,
        'data-size': props.size.name,
      },
      styles: const dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '4px',
          'padding': '4px',
          'border-radius': 'var(--radius)',
          'background': 'var(--neon-surface-1)',
          'border': '1px solid var(--border)',
        },
      ),
      [for (final item in props.items) _buildItem(item)],
    );
  }

  Component _buildItem(ToggleGroupItemProps item) {
    final bool isSelected = props.type == ToggleGroupSelectionType.single
        ? props.value == item.value
        : (props.values?.contains(item.value) ?? false);
    final bool isDisabled = props.disabled || item.disabled;

    final (String height, String paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('36px', '12px'),
      ToggleGroupSizeVariant.md => ('42px', '16px'),
      ToggleGroupSizeVariant.lg => ('48px', '20px'),
    };

    final Map<String, String> variantStyles = switch (props.variant) {
      ToggleGroupVariantStyle.defaultVariant => {
        'border':
            '1px solid ${isSelected ? 'var(--neon-accent-border)' : 'transparent'}',
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 14%, var(--neon-surface-2))'
            : 'transparent',
      },
      ToggleGroupVariantStyle.outline => {
        'border': isSelected
            ? '1px solid var(--neon-accent-border)'
            : '1px solid var(--border)',
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 12%, var(--neon-surface-1))'
            : 'var(--neon-surface-1)',
      },
    };

    return dom.button(
      classes:
          'neon-toggle-group-item ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'aria-pressed': '$isSelected',
        'data-state': isSelected ? 'on' : 'off',
        'data-disabled': '$isDisabled',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'height': height,
          'min-width': height,
          'padding': '0 $paddingH',
          'border-radius': 'calc(var(--radius) - 2px)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'pointer-events': isDisabled ? 'none' : 'auto',
          'opacity': isDisabled ? '0.5' : '1',
          'transition':
              'background 0.2s ease, border-color 0.2s ease, color 0.2s ease',
          ...variantStyles,
        },
      ),
      events: isDisabled
          ? null
          : {
              'click': (_) {
                if (props.type == ToggleGroupSelectionType.single) {
                  props.onChanged?.call(isSelected ? null : item.value);
                  return;
                }
                final Set<String> next = Set<String>.from(
                  props.values ?? <String>{},
                );
                if (isSelected) {
                  next.remove(item.value);
                } else {
                  next.add(item.value);
                }
                props.onMultiChanged?.call(next);
              },
            },
      [item.child],
    );
  }
}
