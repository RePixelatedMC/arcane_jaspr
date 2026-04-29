import 'package:arcane_jaspr/core/props/button_props.dart';

class NeonControlStyles {
  const NeonControlStyles._();

  static Map<String, String> buttonBase(bool isDisabled) => <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'gap': '0.625rem',
    'white-space': 'nowrap',
    'border-radius': 'var(--neon-radius-control, 0.375rem)',
    'clip-path':
        'polygon(0 var(--neon-cut-sm, 0.625rem), var(--neon-cut-sm, 0.625rem) 0, 100% 0, 100% calc(100% - var(--neon-cut-sm, 0.625rem)), calc(100% - var(--neon-cut-sm, 0.625rem)) 100%, 0 100%)',
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-semibold)',
    'line-height': '1.25rem',
    'text-transform': 'uppercase',
    'letter-spacing': '0.06em',
    'outline': 'none',
    'cursor': isDisabled ? 'not-allowed' : 'pointer',
    'pointer-events': isDisabled ? 'none' : 'auto',
    'opacity': isDisabled ? '0.45' : '1',
    'user-select': 'none',
    '-webkit-user-select': 'none',
    'position': 'relative',
    'overflow': 'hidden',
    'transition':
        'color 0.16s ease, background-color 0.16s ease, border-color 0.16s ease, box-shadow 0.16s ease, transform 0.16s ease, filter 0.16s ease',
    'box-shadow': 'var(--neon-inset)',
  };

  static Map<String, String> buttonSize(ButtonSize size) => switch (size) {
    ButtonSize.sm => <String, String>{
      'height': '2.375rem',
      'padding': '0 1rem',
      'font-size': '0.8125rem',
    },
    ButtonSize.md => <String, String>{
      'height': '2.75rem',
      'padding': '0.625rem 1.25rem',
    },
    ButtonSize.lg => <String, String>{
      'height': '3.125rem',
      'padding': '0 1.75rem',
      'font-size': '0.9375rem',
    },
    ButtonSize.iconSm => <String, String>{
      'height': '2.375rem',
      'width': '2.375rem',
      'padding': '0',
    },
    ButtonSize.iconMd => <String, String>{
      'height': '2.75rem',
      'width': '2.75rem',
      'padding': '0',
    },
    ButtonSize.iconLg => <String, String>{
      'height': '3.125rem',
      'width': '3.125rem',
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
