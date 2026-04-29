import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/toggle_group_props.dart';

class NeubrutalismToggleGroup extends StatelessComponent {
  final ToggleGroupProps props;

  const NeubrutalismToggleGroup(this.props, {super.key});

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
      classes: 'neubrutalism-toggle-group',
      attributes: rootAttrs,
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '4px',
          'padding': '4px',
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
        },
      ),
      <Component>[for (final ToggleGroupItemProps item in props.items) _buildItem(groupId, item)],
    );
  }

  Component _buildItem(String groupId, ToggleGroupItemProps item) {
    final bool isSelected = props.type == ToggleGroupSelectionType.single
        ? props.value == item.value
        : (props.values?.contains(item.value) ?? false);
    final bool isDisabled = props.disabled || item.disabled;

    final (String height, String paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('32px', '12px'),
      ToggleGroupSizeVariant.md => ('38px', '16px'),
      ToggleGroupSizeVariant.lg => ('44px', '20px'),
    };

    final Map<String, String> variantStyles = isSelected
        ? <String, String>{
            'background': 'var(--nb-accent, var(--primary))',
            'color': 'var(--nb-on-accent, #000)',
            'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
            'box-shadow':
                'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
          }
        : <String, String>{
            'background': 'transparent',
            'color': 'var(--foreground)',
            'border': 'var(--nb-border-thin, 2px) solid transparent',
            'box-shadow': 'none',
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
          'neubrutalism-toggle-group-item ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'height': height,
          'min-width': height,
          'padding': '0 $paddingH',
          'font-family': 'var(--font-heading)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': '800',
          'letter-spacing': '0.02em',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'pointer-events': isDisabled ? 'none' : 'auto',
          'opacity': isDisabled ? '0.5' : '1',
          'transition':
              'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease), background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
          ...variantStyles,
        },
      ),
      events: isDisabled
          ? null
          : <String, EventCallback>{
              'click': (dynamic _) {
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
      <Component>[item.child],
    );
  }
}
