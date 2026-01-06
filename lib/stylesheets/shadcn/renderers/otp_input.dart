import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/otp_input_props.dart';

/// ShadCN-style OTP input component
/// Reference: https://ui.shadcn.com/docs/components/input-otp
class ShadcnOtpInput extends StatelessComponent {
  final OtpInputProps props;

  const ShadcnOtpInput(this.props, {super.key});

  (String, String) get _sizeStyles => switch (props.size) {
        OtpInputSizeVariant.sm => ('40px', '16px'),
        OtpInputSizeVariant.md => ('48px', '18px'),
        OtpInputSizeVariant.lg => ('56px', '20px'),
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
      classes: 'arcane-otp-input',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '8px',
      }),
      [
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': '14px',
              'font-weight': '500',
              'color': 'var(--foreground)',
            }),
            [dom.text(props.label!)],
          ),

        // Digit inputs row
        dom.div(
          classes: 'arcane-otp-digits',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '8px',
          }),
          [
            for (var i = 0; i < props.length; i++) ...[
              // Separator
              if (sepPos != null && i == sepPos && props.separator != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'color': 'var(--muted-foreground)',
                    'font-size': '18px',
                    'margin': '0 4px',
                  }),
                  [dom.text(props.separator!)],
                ),

              // Digit input
              dom.input(
                classes: 'arcane-otp-digit ${hasError ? 'error' : ''} ${digits.length > i && digits[i].isNotEmpty ? 'filled' : ''}',
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
                  if (props.disabled) 'disabled': 'true',
                  'value': digits.length > i ? digits[i] : '',
                },
                styles: dom.Styles(raw: {
                  'width': size,
                  'height': size,
                  'font-size': fontSize,
                  'text-align': 'center',
                  'font-weight': '600',
                  'color': 'var(--foreground)',
                  'background-color': 'var(--background)',
                  'border': '2px solid ${hasError ? 'var(--destructive)' : 'var(--input)'}',
                  'border-radius': '6px',
                  'transition': 'border-color 150ms ease, box-shadow 150ms ease',
                  'caret-color': 'transparent',
                  if (props.disabled) 'opacity': '0.5',
                  if (props.disabled) 'cursor': 'not-allowed',
                }),
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
            styles: const dom.Styles(raw: {
              'font-size': '14px',
              'color': 'var(--destructive)',
            }),
            [dom.text(props.error!)],
          ),
      ],
    );
  }
}
