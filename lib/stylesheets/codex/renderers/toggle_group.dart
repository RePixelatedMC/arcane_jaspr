import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/toggle_group_props.dart';

/// Codex toggle group component.
class CodexToggleGroup extends StatelessComponent {
  final ToggleGroupProps props;

  const CodexToggleGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-toggle-group',
      attributes: {'role': 'group'},
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'border-radius': 'var(--radius)',
        'background-color': 'transparent',
        'gap': '6px',
      }),
      [for (final item in props.items) _buildItem(item)],
    );
  }

  Component _buildItem(ToggleGroupItemProps item) {
    final bool isSelected = props.type == ToggleGroupSelectionType.single
        ? props.value == item.value
        : (props.values?.contains(item.value) ?? false);
    final bool isDisabled = props.disabled || item.disabled;

    // Codex sizes (1.25x ShadCN)
    final (height, paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('40px', '12px'),
      ToggleGroupSizeVariant.md => ('48px', '16px'),
      ToggleGroupSizeVariant.lg => ('52px', '24px'),
    };

    // Variant styles
    final variantStyles = switch (props.variant) {
      ToggleGroupVariantStyle.defaultVariant => <String, String>{
          'border': 'none',
        },
      ToggleGroupVariantStyle.outline => <String, String>{
          'border': '1px solid var(--border)',
          'background-color':
              isSelected ? 'rgba(var(--primary-rgb), 0.15)' : 'transparent',
        },
    };

    return dom.button(
      classes:
          'codex-toggle-group-item ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'aria-pressed': '$isSelected',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'height': height,
        'padding': '0 $paddingH',
        'min-width': height,
        'border-radius': 'var(--radius)',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'background-color':
            isSelected ? 'rgba(var(--primary-rgb), 0.15)' : 'transparent',
        'color': isSelected
            ? 'var(--primary)'
            : 'var(--foreground)',
        'transition': 'color var(--arcane-transition), background-color var(--arcane-transition)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'pointer-events': isDisabled ? 'none' : 'auto',
        'opacity': isDisabled ? '0.5' : '1',
        if (isSelected) 'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.15)',
        ...variantStyles,
      }),
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
