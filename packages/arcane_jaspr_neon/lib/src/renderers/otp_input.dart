import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/otp_input_props.dart';

/// Neon OTP input component.
class NeonOtpInput extends StatelessComponent {
  final OtpInputProps props;

  const NeonOtpInput(this.props, {super.key});

  (String, String) get _sizeStyles => switch (props.size) {
    OtpInputSizeVariant.sm => ('44px', '1rem'),
    OtpInputSizeVariant.md => ('52px', '1.125rem'),
    OtpInputSizeVariant.lg => ('60px', '1.25rem'),
  };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final (size, fontSize) = _sizeStyles;
    final sepPos = props.separatorPosition;
    final digits = props.digits.isEmpty
        ? List.filled(props.length, '')
        : props.digits;

    return dom.div(
      classes: 'neon-otp-input',
      attributes: {
        'data-state': hasError ? 'error' : 'idle',
        'data-disabled': '${props.disabled}',
        'data-size': props.size.name,
      },
      styles: const dom.Styles(
        raw: {'display': 'flex', 'flex-direction': 'column', 'gap': '10px'},
      ),
      [
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--foreground)',
              },
            ),
            [Component.text(props.label!)],
          ),

        // Digit inputs row
        dom.div(
          classes: 'neon-otp-digits',
          styles: const dom.Styles(
            raw: {'display': 'flex', 'align-items': 'center', 'gap': '10px'},
          ),
          [
            for (var i = 0; i < props.length; i++) ...[
              // Separator
              if (sepPos != null && i == sepPos && props.separator != null)
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      'color': 'var(--muted-foreground)',
                      'font-size': 'var(--font-size-lg)',
                      'margin': '0 6px',
                    },
                  ),
                  [Component.text(props.separator!)],
                ),

              // Digit input
              dom.input(
                classes:
                    'neon-otp-digit ${hasError ? 'error' : ''} ${digits.length > i && digits[i].isNotEmpty ? 'filled' : ''}',
                type: props.obscure
                    ? dom.InputType.password
                    : dom.InputType.text,
                attributes: {
                  'maxlength': '1',
                  'inputmode': 'numeric',
                  'pattern': '[0-9]*',
                  'autocomplete': 'one-time-code',
                  'aria-label': 'Digit ${i + 1} of ${props.length}',
                  'data-otp-index': '$i',
                  'data-otp-length': '${props.length}',
                  'data-state': digits.length > i && digits[i].isNotEmpty
                      ? 'filled'
                      : 'empty',
                  'data-disabled': '${props.disabled}',
                  if (props.disabled) 'disabled': 'true',
                  'value': digits.length > i ? digits[i] : '',
                },
                styles: dom.Styles(
                  raw: {
                    'width': size,
                    'height': size,
                    'font-size': fontSize,
                    'text-align': 'center',
                    'font-weight': 'var(--font-weight-semibold)',
                    'color': 'var(--foreground)',
                    'background-color': 'var(--input)',
                    'border':
                        '2px solid ${hasError ? 'var(--destructive)' : 'var(--border)'}',
                    'border-radius': 'var(--radius)',
                    'transition':
                        'border-color var(--arcane-transition), box-shadow var(--arcane-transition)',
                    'caret-color': 'transparent',
                    if (props.disabled) 'opacity': '0.5',
                    if (props.disabled) 'cursor': 'not-allowed',
                  },
                ),
                events: props.onInput != null
                    ? {
                        'input': (e) {
                          final target = e.target as dynamic;
                          props.onInput!(i, target.value as String);
                        },
                      }
                    : null,
              ),
            ],
          ],
        ),

        // Error message
        if (hasError)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            [Component.text(props.error!)],
          ),
      ],
    );
  }
}
