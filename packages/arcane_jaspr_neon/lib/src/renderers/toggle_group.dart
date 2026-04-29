import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/toggle_group_props.dart';

/// Neon toggle group renderer with restrained dark surfaces.
class NeonToggleGroup extends StatelessComponent {
  final ToggleGroupProps props;

  const NeonToggleGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String groupId = props.id ?? 'toggle-${identityHashCode(props)}';
    final bool multi = props.type == ToggleGroupSelectionType.multiple;
    final String mode = multi ? 'multi' : 'single';
    final String? value = multi
        ? (props.values == null ? null : props.values!.join(','))
        : props.value;

    final Map<String, String> rootAttrs = <String, String>{
      ...groupAttrs(
        groupId: groupId,
        mode: mode,
        value: value,
        disabled: props.disabled,
        changeAction: props.onChangeAction == null
            ? null
            : encodeArcaneAction(props.onChangeAction!),
      ),
      'role': 'group',
      'data-disabled': '${props.disabled}',
      'data-variant': props.variant.name,
      'data-size': props.size.name,
    };

    return dom.div(
      classes: 'neon-toggle-group',
      attributes: rootAttrs,
      styles: const dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '4px',
          'padding': '4px',
          'clip-path': 'var(--neon-clip-sm)',
          'background': 'var(--neon-panel-tint)',
          'border': '1px solid var(--neon-panel-border)',
          'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
        },
      ),
      [for (final item in props.items) _buildItem(groupId, item)],
    );
  }

  Component _buildItem(String groupId, ToggleGroupItemProps item) {
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
            '1px solid ${isSelected ? 'var(--neon-control-border-strong)' : 'transparent'}',
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 18%, var(--neon-surface-2))'
            : 'transparent',
        'box-shadow': isSelected
            ? '0 0 16px color-mix(in srgb, var(--neon-accent) 22%, transparent)'
            : 'none',
      },
      ToggleGroupVariantStyle.outline => {
        'border': isSelected
            ? '1px solid var(--neon-control-border-strong)'
            : '1px solid var(--neon-control-border)',
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 14%, var(--neon-surface-1))'
            : 'var(--neon-surface-1)',
        'box-shadow': isSelected
            ? '0 0 16px color-mix(in srgb, var(--neon-accent) 22%, transparent)'
            : 'none',
      },
    };

    final ArcaneInteraction action = props.type == ToggleGroupSelectionType.single
        ? ArcaneInteraction.selectValue(groupId, item.value)
        : ArcaneInteraction.toggleValue(groupId, item.value);

    final Map<String, String> attrs = <String, String>{
      ...groupItemAttrs(
        groupId: groupId,
        value: item.value,
        selected: isSelected,
        disabled: isDisabled,
      ),
      ...interactionAttrs(action),
      'type': 'button',
      'aria-pressed': '$isSelected',
      'data-state': isSelected ? 'on' : 'off',
      'data-disabled': '$isDisabled',
      if (isDisabled) 'disabled': 'true',
    };

    return dom.button(
      classes:
          'neon-toggle-group-item ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'height': height,
          'min-width': height,
          'padding': '0 $paddingH',
          'clip-path': 'var(--neon-clip-xs)',
          'font-family': 'var(--font-heading)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-semibold)',
          'letter-spacing': '0.04em',
          'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'pointer-events': isDisabled ? 'none' : 'auto',
          'opacity': isDisabled ? '0.5' : '1',
          'transition':
              'background 200ms ease, border-color 200ms ease, color 200ms ease, box-shadow 200ms ease',
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
