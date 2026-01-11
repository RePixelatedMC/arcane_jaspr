import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/toggle_group_props.dart';

/// Codex Toggle Group renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon selection states
/// - Holographic gradient backgrounds
/// - Cyberpunk-inspired borders and shadows
/// - Animated state transitions with glow effects
class CodexToggleGroup extends StatelessComponent {
  final ToggleGroupProps props;

  const CodexToggleGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-toggle-group codex-neon',
      attributes: {'role': 'group'},
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'border-radius': 'var(--radius)',
        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.4) 0%, rgba(var(--card-rgb), 0.3) 100%)',
        'padding': '4px',
        'gap': '4px',
        'border': '1px solid rgba(var(--border-rgb), 0.3)',
        'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.05)',
      }),
      [for (final item in props.items) _buildItem(item)],
    );
  }

  Component _buildItem(ToggleGroupItemProps item) {
    final bool isSelected = props.type == ToggleGroupSelectionType.single
        ? props.value == item.value
        : (props.values?.contains(item.value) ?? false);
    final bool isDisabled = props.disabled || item.disabled;

    // Codex Neon sizes - larger with more presence
    final (height, paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('44px', '16px'),
      ToggleGroupSizeVariant.md => ('52px', '20px'),
      ToggleGroupSizeVariant.lg => ('60px', '28px'),
    };

    // Codex Neon variant styles
    final variantStyles = switch (props.variant) {
      ToggleGroupVariantStyle.defaultVariant => <String, String>{
        'border': 'none',
        'background': isSelected
            ? 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)'
            : 'transparent',
      },
      ToggleGroupVariantStyle.outline => <String, String>{
        'border': isSelected
            ? '1px solid var(--primary)'
            : '1px solid rgba(var(--border-rgb), 0.3)',
        'background': isSelected
            ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)'
            : 'transparent',
      },
    };

    return dom.button(
      classes:
          'codex-toggle-group-item codex-neon ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
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
        'font-weight': 'var(--font-weight-semibold)',
        'letter-spacing': '0.025em',
        'color': isSelected ? '#ffffff' : 'var(--foreground)',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'pointer-events': isDisabled ? 'none' : 'auto',
        'opacity': isDisabled ? '0.4' : '1',
        // Neon glow when selected
        'box-shadow': isSelected
            ? '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.15)'
            : 'none',
        'text-shadow': isSelected ? '0 0 10px rgba(255, 255, 255, 0.5)' : 'none',
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
      [
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'filter': isSelected ? 'drop-shadow(0 0 4px currentColor)' : 'none',
          }),
          [item.child],
        ),
      ],
    );
  }
}
