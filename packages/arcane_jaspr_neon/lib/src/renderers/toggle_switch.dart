import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/toggle_switch_props.dart';

class NeonToggleSwitch extends StatelessComponent {
  final ToggleSwitchProps props;

  const NeonToggleSwitch(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool inExternalGroup =
        props.group != null && props.group!.isNotEmpty && props.itemValue != null;
    final String groupId = inExternalGroup ? props.group! : props.id;
    final String optionValue = inExternalGroup ? props.itemValue! : 'on';
    final String groupMode = inExternalGroup ? 'multi' : 'single';
    final String currentGroupValue = props.value ? optionValue : '';

    final Map<String, String> rootAttrs = inExternalGroup
        ? const <String, String>{}
        : groupAttrs(
            groupId: groupId,
            mode: groupMode,
            value: currentGroupValue,
            disabled: props.disabled,
            changeAction: props.onChangeAction != null
                ? encodeArcaneAction(props.onChangeAction!)
                : null,
          );

    final Map<String, String> itemAttrs = mergeAttrs(<Map<String, String>>[
      groupItemAttrs(
        groupId: groupId,
        value: optionValue,
        selected: props.value,
        disabled: props.disabled,
      ),
      if (!props.disabled)
        interactionAttrs(
          ArcaneInteraction.toggleValue(groupId, optionValue),
        ),
    ]);

    (double, double, double, double, double) sizing = switch (props.size) {
      ComponentSize.sm => (46.0, 22.0, 14.0, 3.0, 0.25),
      ComponentSize.md => (54.0, 26.0, 18.0, 3.0, 0.3125),
      ComponentSize.lg => (62.0, 30.0, 22.0, 3.0, 0.375),
    };
    double width = sizing.$1;
    double height = sizing.$2;
    double thumbSize = sizing.$3;
    double inset = sizing.$4;
    double cut = sizing.$5;

    String tone = switch (props.color) {
      ColorVariant.primary => 'var(--neon-accent)',
      ColorVariant.secondary => 'var(--secondary)',
      ColorVariant.destructive => 'var(--destructive)',
      ColorVariant.success => 'var(--success)',
      ColorVariant.warning => 'var(--warning)',
      ColorVariant.info => 'var(--info)',
    };
    String accent = props.color == ColorVariant.primary
        ? 'var(--neon-accent-cool)'
        : tone;

    double thumbTranslate = props.value
        ? (width - thumbSize - (inset * 2))
        : 0;

    String trackClip =
        'polygon(0 ${cut}rem, ${cut}rem 0, 100% 0, 100% calc(100% - ${cut}rem), calc(100% - ${cut}rem) 100%, 0 100%)';
    double thumbCut = cut * 0.7;
    String thumbClip =
        'polygon(0 ${thumbCut}rem, ${thumbCut}rem 0, 100% 0, 100% calc(100% - ${thumbCut}rem), calc(100% - ${thumbCut}rem) 100%, 0 100%)';

    String trackBackground = props.value
        ? 'linear-gradient(135deg, color-mix(in srgb, $tone 30%, transparent), color-mix(in srgb, $accent 18%, transparent)), color-mix(in srgb, $tone 18%, var(--neon-surface-2))'
        : 'linear-gradient(135deg, color-mix(in srgb, var(--foreground) 4%, transparent), transparent 60%), var(--neon-surface-2)';
    String trackBorder = props.value
        ? '1px solid color-mix(in srgb, $tone 60%, transparent)'
        : '1px solid var(--neon-control-border)';
    String trackShadow = props.value
        ? '0 0 0 1px color-mix(in srgb, $tone 18%, transparent), 0 0 18px color-mix(in srgb, $tone 28%, transparent), inset 0 1px 0 color-mix(in srgb, #ffffff 14%, transparent)'
        : 'inset 0 1px 0 rgba(255, 255, 255, 0.05), inset 0 -1px 0 rgba(0, 0, 0, 0.18)';

    Component switchWidget = dom.button(
      classes:
          'neon-toggle-switch ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: mergeAttrs(<Map<String, String>>[
        <String, String>{
          'type': 'button',
          'role': 'switch',
          'aria-checked': '${props.value}',
          'data-state': props.value ? 'checked' : 'unchecked',
          'data-disabled': '${props.disabled}',
          'data-variant': props.color.name,
          'data-size': props.size.name,
          if (props.disabled) 'disabled': 'true',
        },
        itemAttrs,
      ]),
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'inline-flex',
          'align-items': 'center',
          'width': '${width}px',
          'height': '${height}px',
          'padding': '${inset}px',
          'clip-path': trackClip,
          'border': trackBorder,
          'background': trackBackground,
          'box-shadow': trackShadow,
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.45' : '1',
          'pointer-events': props.disabled ? 'none' : 'auto',
          'transition':
              'background 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease',
          'outline': 'none',
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : {'click': (_) => props.onChanged!(!props.value)},
      [
        dom.span(
          classes: 'neon-toggle-thumb',
          styles: dom.Styles(
            raw: {
              'display': 'block',
              'width': '${thumbSize}px',
              'height': '${thumbSize}px',
              'clip-path': thumbClip,
              'background': props.value
                  ? 'linear-gradient(180deg, #ffffff, color-mix(in srgb, $tone 12%, #f5f7fa))'
                  : 'linear-gradient(180deg, color-mix(in srgb, var(--foreground) 70%, transparent), color-mix(in srgb, var(--foreground) 50%, transparent))',
              'transform': 'translateX(${thumbTranslate}px)',
              'transition':
                  'transform 0.22s cubic-bezier(0.4, 0.1, 0.3, 1), background 0.2s ease, box-shadow 0.2s ease',
              'box-shadow': props.value
                  ? '0 2px 6px rgba(0, 0, 0, 0.32), 0 0 10px color-mix(in srgb, $tone 36%, transparent)'
                  : '0 2px 6px rgba(0, 0, 0, 0.32)',
              'pointer-events': 'none',
            },
          ),
          [],
        ),
      ],
    );

    if (props.label == null) return switchWidget;

    Component labelWidget = dom.span(
      classes: 'neon-toggle-label',
      styles: dom.Styles(
        raw: {
          'font-family': 'var(--font-heading)',
          'font-size': '0.6875rem',
          'font-weight': '600',
          'text-transform': 'uppercase',
          'letter-spacing': '0.08em',
          'color': props.disabled
              ? 'var(--muted-foreground)'
              : 'var(--foreground)',
          'user-select': 'none',
        },
      ),
      [Component.text(props.label!)],
    );

    return dom.label(
      classes: 'neon-toggle-wrapper',
      attributes: rootAttrs,
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '0.75rem',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : {
              'click': (e) {
                if ((e.target as dynamic)?.tagName == 'BUTTON') return;
                props.onChanged!(!props.value);
              },
            },
      props.labelLeft
          ? [labelWidget, switchWidget]
          : [switchWidget, labelWidget],
    );
  }
}
