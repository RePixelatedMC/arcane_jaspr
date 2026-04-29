import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/checkbox_props.dart';

class NeubrutalismCheckbox extends StatelessComponent {
  final CheckboxProps props;

  const NeubrutalismCheckbox(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    String boxSize = switch (props.size) {
      ComponentSize.sm => '20px',
      ComponentSize.md => '24px',
      ComponentSize.lg => '28px',
    };

    String tone;
    String checkColor;
    switch (props.color) {
      case ColorVariant.primary:
        tone = 'var(--nb-accent, var(--primary))';
        checkColor = 'var(--nb-ink, #000)';
        break;
      case ColorVariant.secondary:
        tone = 'var(--nb-accent-cool, var(--secondary))';
        checkColor = 'var(--nb-ink, #000)';
        break;
      case ColorVariant.destructive:
        tone = 'var(--destructive)';
        checkColor = '#ffffff';
        break;
      case ColorVariant.success:
        tone = 'var(--success)';
        checkColor = 'var(--nb-ink, #000)';
        break;
      case ColorVariant.warning:
        tone = 'var(--warning)';
        checkColor = 'var(--nb-ink, #000)';
        break;
      case ColorVariant.info:
        tone = 'var(--info)';
        checkColor = '#ffffff';
        break;
    }

    final bool inExternalGroup =
        props.group != null && props.group!.isNotEmpty && props.value != null;
    final String groupId = inExternalGroup ? props.group! : props.id;
    final String itemValue = inExternalGroup ? props.value! : 'on';
    final String currentGroupValue = props.checked ? itemValue : '';

    final Map<String, String> rootAttrs = inExternalGroup
        ? const <String, String>{}
        : groupAttrs(
            groupId: groupId,
            mode: 'multi',
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
        'data-variant': props.color.name,
        'data-size': props.size.name,
      },
    ]);

    return dom.div(
      classes:
          'neubrutalism-checkbox-wrapper ${props.disabled ? 'disabled' : ''}',
      attributes: wrapperAttrs,
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '0.625rem',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'pointer-events': props.disabled ? 'none' : 'auto',
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (_) => props.onChanged!(!props.checked),
            },
      <Component>[
        dom.div(
          classes: 'neubrutalism-checkbox',
          attributes: itemAttrs,
          styles: dom.Styles(
            raw: <String, String>{
              'width': boxSize,
              'height': boxSize,
              'border-radius': 'var(--nb-radius-soft, 4px)',
              'background-color':
                  props.checked ? tone : 'var(--nb-paper, #fff)',
              'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
              'box-shadow': 'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'flex-shrink': '0',
              'transition':
                  'transform 120ms cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 120ms cubic-bezier(0.2, 0.8, 0.2, 1)',
            },
          ),
          <Component>[
            if (props.checked)
              dom.span(
                styles: dom.Styles(
                  raw: <String, String>{
                    'color': checkColor,
                    'font-size': switch (props.size) {
                      ComponentSize.sm => '13px',
                      ComponentSize.md => '15px',
                      ComponentSize.lg => '17px',
                    },
                    'font-weight': '900',
                    'line-height': '1',
                  },
                ),
                <Component>[const Component.text('\u2713')],
              ),
          ],
        ),
        if (props.label != null || props.description != null)
          dom.div(
            styles: const dom.Styles(raw: <String, String>{'flex': '1'}),
            <Component>[
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: <String, String>{
                      'display': 'block',
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': '600',
                      'color': 'var(--foreground)',
                      'line-height': '1.4',
                    },
                  ),
                  <Component>[Component.text(props.label!)],
                ),
              if (props.description != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: <String, String>{
                      'display': 'block',
                      'font-size': 'var(--font-size-sm)',
                      'color': 'var(--foreground)',
                      'line-height': '1.4',
                      'margin-top': '0.25rem',
                    },
                  ),
                  <Component>[Component.text(props.description!)],
                ),
            ],
          ),
      ],
    );
  }
}

