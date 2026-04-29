import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/checkbox_props.dart';

/// ShadCN Checkbox renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/checkbox
class ShadcnCheckbox extends StatelessComponent {
  final CheckboxProps props;

  const ShadcnCheckbox(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN size dimensions
    // Default: h-4 w-4 (16px), rounded-sm (4px)
    final String boxSize = switch (props.size) {
      ComponentSize.sm => '14px', // h-3.5
      ComponentSize.md => '16px', // h-4 (shadcn default)
      ComponentSize.lg => '20px', // h-5
    };

    // Get color variant colors - border is always the color value (like radio)
    final (String checkedBg, String borderColor) = switch (props.color) {
      ColorVariant.primary => ('var(--primary)', 'var(--primary)'),
      ColorVariant.secondary => ('var(--secondary)', 'var(--secondary)'),
      ColorVariant.destructive => ('var(--destructive)', 'var(--destructive)'),
      ColorVariant.success => (
        'var(--success, #22c55e)',
        'var(--success, #22c55e)',
      ),
      ColorVariant.warning => (
        'var(--warning, #f59e0b)',
        'var(--warning, #f59e0b)',
      ),
      ColorVariant.info => ('var(--info, #3b82f6)', 'var(--info, #3b82f6)'),
    };

    // Checkmark foreground color
    final String checkColor = switch (props.color) {
      ColorVariant.primary => 'var(--primary-foreground)',
      ColorVariant.secondary => 'var(--secondary-foreground)',
      ColorVariant.destructive => 'var(--destructive-foreground)',
      ColorVariant.success => 'var(--success-foreground, #ffffff)',
      ColorVariant.warning => 'var(--warning-foreground, #000000)',
      ColorVariant.info => 'var(--info-foreground, #ffffff)',
    };

    final bool inExternalGroup =
        props.group != null && props.group!.isNotEmpty && props.value != null;
    final String groupId = inExternalGroup ? props.group! : props.id;
    final String itemValue = inExternalGroup ? props.value! : 'on';
    final String groupMode = inExternalGroup ? 'multi' : 'multi';
    final String currentGroupValue = props.checked ? itemValue : '';

    final Map<String, String> rootAttrs = inExternalGroup
        ? const <String, String>{}
        : groupAttrs(
            groupId: groupId,
            mode: groupMode,
            value: currentGroupValue,
            disabled: props.disabled,
          );

    final Map<String, String> itemAttrs = mergeAttrs(<Map<String, String>>[
      groupItemAttrs(
        groupId: groupId,
        value: itemValue,
        selected: props.checked,
        disabled: props.disabled,
      ),
      <String, String>{
        'role': 'checkbox',
        'aria-checked': '${props.checked}',
        'tabindex': props.disabled ? '-1' : '0',
        'data-state': props.checked ? 'checked' : 'unchecked',
        'data-disabled': '${props.disabled}',
      },
      if (!props.disabled)
        interactionAttrs(
          ArcaneInteraction.toggleValue(groupId, itemValue),
        ),
    ]);

    final Map<String, String> wrapperAttrs = mergeAttrs(<Map<String, String>>[
      rootAttrs,
      <String, String>{
        'data-state': props.checked ? 'checked' : 'unchecked',
        'data-disabled': '${props.disabled}',
      },
    ]);

    return dom.div(
      classes: 'arcane-checkbox-wrapper',
      attributes: wrapperAttrs,
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': 'var(--space-2)', // gap-2
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          // ShadCN: disabled:opacity-50 disabled:cursor-not-allowed
          'opacity': props.disabled ? '0.5' : '1',
          'pointer-events': props.disabled ? 'none' : 'auto',
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (event) => props.onChanged!(!props.checked),
            },
      [
        // Checkbox box - ShadCN styling
        // peer h-4 w-4 shrink-0 rounded-sm border border-primary
        // ring-offset-background focus-visible:outline-none
        // focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2
        // disabled:cursor-not-allowed disabled:opacity-50
        // data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground
        dom.div(
          classes: 'arcane-checkbox',
          attributes: itemAttrs,
          styles: dom.Styles(
            raw: {
              'width': boxSize,
              'height': boxSize,
              // ShadCN: rounded-sm (4px / 0.125rem)
              'border-radius': '0.125rem',
              // ShadCN: data-[state=checked]:bg-primary
              'background-color': props.checked ? checkedBg : 'transparent',
              // ShadCN: border border-primary
              'border': '1px solid $borderColor',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
              // ShadCN: transition-colors
              'transition':
                  'color var(--transition), background-color var(--transition), border-color var(--transition)',
            },
          ),
          [
            if (props.checked)
              dom.span(
                styles: dom.Styles(
                  raw: {
                    // ShadCN: text-primary-foreground when checked
                    'color': checkColor,
                    'line-height': '1',
                  },
                ),
                [ArcaneIcon.check(size: IconSize.xs)],
              ),
          ],
        ),
        // Label and description
        if (props.label != null || props.description != null)
          dom.div(styles: const dom.Styles(raw: {'flex': '1'}), [
            if (props.label != null)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    // ShadCN: text-sm font-medium leading-none
                    // peer-disabled:cursor-not-allowed peer-disabled:opacity-70
                    'font-size': 'var(--font-size-sm)', // 14px
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--foreground)',
                    'display': 'block',
                    'line-height': '1',
                  },
                ),
                [Component.text(props.label!)],
              ),
            if (props.description != null)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    // ShadCN: text-sm text-muted-foreground
                    'font-size': 'var(--font-size-sm)', // 14px
                    'color': 'var(--muted-foreground)',
                    'display': 'block',
                    'margin-top': '0.25rem', // 4px
                  },
                ),
                [Component.text(props.description!)],
              ),
          ]),
      ],
    );
  }
}
