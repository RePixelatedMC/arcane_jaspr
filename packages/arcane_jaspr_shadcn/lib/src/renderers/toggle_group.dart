import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/toggle_group_props.dart';

/// ShadCN-style toggle group component
/// Reference: https://ui.shadcn.com/docs/components/toggle-group
class ShadcnToggleGroup extends StatelessComponent {
  final ToggleGroupProps props;

  const ShadcnToggleGroup(this.props, {super.key});

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
    };

    return dom.div(
      classes: 'arcane-toggle-group',
      attributes: rootAttrs,
      styles: const dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'border-radius': 'var(--radius-sm)',
          'background-color': 'transparent',
          'gap': 'var(--space-1)',
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

    // ShadCN sizes
    final (height, paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('36px', '10px'),
      ToggleGroupSizeVariant.md => ('40px', '12px'),
      ToggleGroupSizeVariant.lg => ('44px', '20px'),
    };

    // Variant styles
    final variantStyles = switch (props.variant) {
      ToggleGroupVariantStyle.defaultVariant => <String, String>{
        'border': 'none',
      },
      ToggleGroupVariantStyle.outline => <String, String>{
        'border': '1px solid var(--input)',
        'background-color': isSelected ? 'var(--accent)' : 'transparent',
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
      if (isDisabled) 'disabled': 'true',
    };

    return dom.button(
      classes:
          'arcane-toggle-group-item ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'height': height,
          'padding': '0 $paddingH',
          'min-width': height,
          'border-radius': 'var(--radius-sm)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'background-color': isSelected ? 'var(--accent)' : 'transparent',
          'color': isSelected
              ? 'var(--accent-foreground)'
              : 'var(--foreground)',
          'transition':
              'color var(--transition), background-color var(--transition)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'pointer-events': isDisabled ? 'none' : 'auto',
          'opacity': isDisabled ? '0.5' : '1',
          ...variantStyles,
        },
      ),
      events: {
        'click': (_) {
          if (isDisabled) return;

          if (props.type == ToggleGroupSelectionType.single) {
            props.onChanged?.call(isSelected ? null : item.value);
          } else {
            final newValues = Set<String>.from(props.values ?? {});
            if (isSelected) {
              newValues.remove(item.value);
            } else {
              newValues.add(item.value);
            }
            props.onMultiChanged?.call(newValues);
          }
        },
      },
      [item.child],
    );
  }
}
