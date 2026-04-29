import 'dart:convert';

import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';

/// Neon cycle button renderer.
class NeonCycleButton<T> extends StatelessComponent {
  final CycleButtonProps<T> props;

  const NeonCycleButton(this.props);

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
      classes: 'neon-cycle-button ${props.disabled ? 'disabled' : ''}',
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
          'clip-path': 'var(--neon-clip-sm)',
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
          classes: 'neon-cycle-button-label',
          attributes: const <String, String>{'data-arcane-cycle-label': ''},
          [Component.text(currentOption.label ?? currentOption.value.toString())],
        ),
        const dom.span(
          classes: 'neon-cycle-button-indicator',
          styles: dom.Styles(
            raw: {
              'font-size': '0.78em',
              'opacity': '0.65',
              'color': 'var(--neon-accent)',
            },
          ),
          [Component.text('\u21bb')],
        ),
      ],
    );
  }
}

/// Neon toggle button renderer.
class NeonToggleButton extends StatelessComponent {
  final ToggleButtonProps props;

  const NeonToggleButton(this.props);

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
          'neon-toggle-button ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
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
          'clip-path': 'var(--neon-clip-sm)',
          'background': props.value
              ? 'color-mix(in srgb, var(--neon-accent) 18%, var(--neon-surface-2))'
              : 'var(--neon-surface-1)',
          'color': props.value ? 'var(--neon-accent)' : 'var(--foreground)',
          'border': props.value
              ? '1px solid var(--neon-control-border-strong)'
              : '1px solid var(--neon-control-border)',
          'box-shadow': props.value
              ? '0 0 18px color-mix(in srgb, var(--neon-accent) 22%, transparent), inset 0 1px 0 var(--neon-inset)'
              : 'inset 0 1px 0 var(--neon-inset)',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition':
              'background 200ms ease, border-color 200ms ease, color 200ms ease, box-shadow 200ms ease',
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
    CycleButtonVariant.outline => {
      'background': 'var(--neon-surface-1)',
      'color': 'var(--foreground)',
      'border': '1px solid var(--neon-control-border)',
      'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
    },
    CycleButtonVariant.primary => {
      'background':
          'linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 82%, var(--neon-surface-0)), var(--neon-accent))',
      'color': 'var(--neon-on-accent)',
      'border': '1px solid var(--neon-control-border-strong)',
      'box-shadow':
          '0 0 22px color-mix(in srgb, var(--neon-accent) 28%, transparent), inset 0 1px 0 var(--neon-inset)',
    },
    CycleButtonVariant.secondary => {
      'background': 'var(--neon-surface-2)',
      'color': 'var(--foreground)',
      'border': '1px solid var(--neon-control-border)',
      'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
    },
    CycleButtonVariant.ghost => {
      'background': 'transparent',
      'color': 'var(--foreground)',
      'border': '1px solid transparent',
    },
    CycleButtonVariant.destructive => {
      'background':
          'linear-gradient(180deg, color-mix(in srgb, var(--destructive) 82%, var(--neon-surface-0)), var(--destructive))',
      'color': '#ffffff',
      'border':
          '1px solid color-mix(in srgb, var(--destructive) 50%, transparent)',
      'box-shadow':
          '0 0 22px color-mix(in srgb, var(--destructive) 28%, transparent), inset 0 1px 0 var(--neon-inset)',
    },
  };
}
