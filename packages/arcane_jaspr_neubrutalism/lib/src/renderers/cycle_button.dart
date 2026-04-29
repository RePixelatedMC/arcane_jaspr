import 'dart:convert';

import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';

/// Neubrutalism cycle button renderer.
class NeubrutalismCycleButton<T> extends StatelessComponent {
  final CycleButtonProps<T> props;

  const NeubrutalismCycleButton(this.props);

  @override
  Component build(BuildContext context) {
    final List<CycleOption<T>> options = props.options;
    final int currentIndex = options.indexWhere((o) => o.value == props.value);
    final int safeIndex = currentIndex >= 0 ? currentIndex : 0;
    final CycleOption<T> currentOption = options[safeIndex];
    final String cycleId =
        props.id ?? 'cycle-${identityHashCode(props).toRadixString(36)}';

    final List<String> values = options.map((o) => o.value.toString()).toList();
    final List<String> labels =
        options.map((o) => o.label ?? o.value.toString()).toList();

    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2.25rem',
        'padding': '0 0.9rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '2.6rem',
        'padding': '0 1.1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '3rem',
        'padding': '0 1.4rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '2.6rem',
        'width': '2.6rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2.25rem',
        'width': '2.25rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
    };

    final Map<String, String> variantStyles = _variantStyles(props.variant);
    final ArcaneInteraction action = ArcaneInteraction.cycleNext(cycleId);

    final Map<String, String> attrs = <String, String>{
      'type': 'button',
      'data-state': 'idle',
      'data-disabled': '${props.disabled}',
      'data-variant': props.variant.name,
      'data-size': props.size.name,
      'data-arcane-cycle': cycleId,
      'data-arcane-cycle-active': safeIndex.toString(),
      'data-arcane-cycle-values': jsonEncode(values),
      'data-arcane-cycle-labels': jsonEncode(labels),
      'data-arcane-value': values[safeIndex],
      if (props.disabled) 'disabled': 'true',
      if (props.disabled) 'data-arcane-disabled': 'true',
      ...interactionAttrs(action),
      ...?props.attributes,
    };

    return dom.button(
      id: props.id,
      classes: 'neubrutalism-cycle-button ${props.disabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.6rem',
          ...sizeStyles,
          'font-family': 'var(--font-heading)',
          'font-weight': 'var(--font-weight-semibold)',
          'letter-spacing': '0.06em',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition':
              'background 200ms ease, border-color 200ms ease, color 200ms ease, transform 200ms ease',
          ...variantStyles,
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (_) {
                final int next = (safeIndex + 1) % options.length;
                props.onChanged!(options[next].value);
              },
            },
      <Component>[
        if (currentOption.icon != null) currentOption.icon!,
        dom.span(
          classes: 'neubrutalism-cycle-button-label',
          attributes: const <String, String>{'data-arcane-cycle-label': ''},
          [Component.text(currentOption.label ?? currentOption.value.toString())],
        ),
        const dom.span(
          classes: 'neubrutalism-cycle-button-indicator',
          styles: dom.Styles(
            raw: {
              'font-size': '0.78em',
              'opacity': '0.65',
              'color': 'var(--nb-accent, var(--primary))',
            },
          ),
          [Component.text('\u21bb')],
        ),
      ],
    );
  }
}

/// Neubrutalism toggle button renderer.
class NeubrutalismToggleButton extends StatelessComponent {
  final ToggleButtonProps props;

  const NeubrutalismToggleButton(this.props);

  @override
  Component build(BuildContext context) {
    final String groupId =
        props.id ?? 'toggle-${identityHashCode(props).toRadixString(36)}';
    final ArcaneInteraction action =
        ArcaneInteraction.toggleValue(groupId, 'on');

    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2.25rem',
        'padding': '0 0.9rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '2.6rem',
        'padding': '0 1.1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '3rem',
        'padding': '0 1.4rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '2.6rem',
        'width': '2.6rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2.25rem',
        'width': '2.25rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
    };

    final Map<String, String> attrs = <String, String>{
      'type': 'button',
      'aria-pressed': '${props.value}',
      'data-state': props.value ? 'on' : 'off',
      'data-disabled': '${props.disabled}',
      'data-arcane-group': groupId,
      'data-arcane-group-mode': 'multi',
      'data-arcane-value': 'on',
      if (props.value) 'data-arcane-selected': 'true',
      if (props.disabled) 'disabled': 'true',
      if (props.disabled) 'data-arcane-disabled': 'true',
      ...interactionAttrs(action),
      ...?props.attributes,
    };

    return dom.button(
      id: props.id,
      classes:
          'neubrutalism-toggle-button ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.6rem',
          ...sizeStyles,
          'font-family': 'var(--font-heading)',
          'font-weight': 'var(--font-weight-semibold)',
          'letter-spacing': '0.06em',
          'background': props.value
              ? 'var(--nb-accent, var(--primary))'
              : 'var(--nb-paper, var(--card))',
          'color': props.value
              ? 'var(--nb-on-accent, #000)'
              : 'var(--foreground)',
          'border':
              'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
          'border-radius': 'var(--nb-radius-soft, 4px)',
          'box-shadow':
              'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition':
              'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease), background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (_) => props.onChanged!(!props.value),
            },
      <Component>[
        if (props.icon != null) props.icon!,
        if (props.label != null) Component.text(props.label!),
      ],
    );
  }
}

Map<String, String> _variantStyles(CycleButtonVariant variant) {
  return switch (variant) {
    CycleButtonVariant.outline => <String, String>{
      'background': 'var(--nb-paper, var(--card))',
      'color': 'var(--foreground)',
      'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    },
    CycleButtonVariant.primary => <String, String>{
      'background': 'var(--nb-accent, var(--primary))',
      'color': 'var(--nb-on-accent, #000)',
      'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
    },
    CycleButtonVariant.secondary => <String, String>{
      'background': 'var(--nb-paper-soft, var(--card))',
      'color': 'var(--foreground)',
      'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
    },
    CycleButtonVariant.ghost => <String, String>{
      'background': 'transparent',
      'color': 'var(--foreground)',
      'border': 'var(--nb-border-thin, 2px) solid transparent',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow': 'none',
    },
    CycleButtonVariant.destructive => <String, String>{
      'background': 'var(--destructive)',
      'color': 'var(--destructive-foreground, #fff)',
      'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'box-shadow':
          'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
    },
  };
}
