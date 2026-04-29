import 'package:arcane_jaspr/core/props/button_props.dart';

class NeubrutalismControlStyles {
  const NeubrutalismControlStyles._();

  static Map<String, String> buttonBase(bool isDisabled) => <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'gap': '0.5rem',
    'white-space': 'nowrap',
    'border-radius': 'var(--nb-radius-soft, 4px)',
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-sm)',
    'font-weight': '800',
    'line-height': '1.25rem',
    'letter-spacing': '0',
    'text-transform': 'none',
    'outline': 'none',
    'cursor': isDisabled ? 'not-allowed' : 'pointer',
    'pointer-events': isDisabled ? 'none' : 'auto',
    'opacity': isDisabled ? '0.5' : '1',
    'user-select': 'none',
    '-webkit-user-select': 'none',
    'position': 'relative',
    'transition':
        'transform 120ms cubic-bezier(0.2, 0.8, 0.2, 1), box-shadow 120ms cubic-bezier(0.2, 0.8, 0.2, 1), background-color 120ms cubic-bezier(0.2, 0.8, 0.2, 1)',
  };

  static Map<String, String> buttonSize(ButtonSize size) => switch (size) {
    ButtonSize.sm => <String, String>{
      'height': '2.25rem',
      'padding': '0 0.875rem',
      'font-size': '0.8125rem',
    },
    ButtonSize.md => <String, String>{
      'height': '2.625rem',
      'padding': '0.5rem 1.125rem',
    },
    ButtonSize.lg => <String, String>{
      'height': '3rem',
      'padding': '0 1.5rem',
      'font-size': '0.9375rem',
    },
    ButtonSize.iconSm => <String, String>{
      'height': '2.25rem',
      'width': '2.25rem',
      'padding': '0',
    },
    ButtonSize.iconMd => <String, String>{
      'height': '2.625rem',
      'width': '2.625rem',
      'padding': '0',
    },
    ButtonSize.iconLg => <String, String>{
      'height': '3rem',
      'width': '3rem',
      'padding': '0',
    },
  };

  static Map<String, String> buttonAttributes(
    ButtonProps props,
    bool isDisabled,
  ) => <String, String>{
    'data-state': props.loading ? 'loading' : 'idle',
    'data-disabled': '$isDisabled',
    'data-variant': props.variant.name,
    'data-size': props.size.name,
    ...?props.attributes,
  };
}
