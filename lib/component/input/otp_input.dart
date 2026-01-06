import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/otp_input_props.dart'
    show OtpInputSizeVariant, OtpInputProps;

/// Size variants for OTP input
enum OtpInputSize {
  sm,
  md,
  lg,
}

/// One-time password input with separate digit fields.
///
/// Provides auto-advance focus, paste support, and keyboard navigation.
///
/// Example:
/// ```dart
/// ArcaneOtpInput(
///   length: 6,
///   onComplete: (code) => verifyCode(code),
/// )
/// ```
class ArcaneOtpInput extends StatefulComponent {
  /// Number of digits (typically 4 or 6)
  final int length;

  /// Called when all digits are filled
  final void Function(String)? onComplete;

  /// Called on any change
  final void Function(String)? onChange;

  /// Initial value (must match length if provided)
  final String? value;

  /// Hide digits like a password
  final bool obscure;

  /// Visual size
  final OtpInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Error message to display
  final String? error;

  /// Label above the input
  final String? label;

  /// Separator character between digits (e.g., '-')
  final String? separator;

  /// Position to show separator (e.g., 3 for "123-456")
  final int? separatorPosition;

  const ArcaneOtpInput({
    this.length = 6,
    this.onComplete,
    this.onChange,
    this.value,
    this.obscure = false,
    this.size = OtpInputSize.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    super.key,
  });

  /// Creates a 4-digit OTP input
  const ArcaneOtpInput.fourDigit({
    this.onComplete,
    this.onChange,
    this.value,
    this.obscure = false,
    this.size = OtpInputSize.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    super.key,
  }) : length = 4;

  /// Creates a 6-digit OTP input
  const ArcaneOtpInput.sixDigit({
    this.onComplete,
    this.onChange,
    this.value,
    this.obscure = false,
    this.size = OtpInputSize.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    super.key,
  }) : length = 6;

  @override
  State<ArcaneOtpInput> createState() => _ArcaneOtpInputState();
}

class _ArcaneOtpInputState extends State<ArcaneOtpInput> {
  late List<String> _digits;

  @override
  void initState() {
    super.initState();
    _initDigits();
  }

  void _initDigits() {
    if (component.value != null && component.value!.length == component.length) {
      _digits = component.value!.split('');
    } else {
      _digits = List.filled(component.length, '');
    }
  }

  String get _fullValue => _digits.join();

  void _handleInput(int index, String value) {
    if (component.disabled) return;

    // Handle paste (multiple characters)
    if (value.length > 1) {
      _handlePaste(value);
      return;
    }

    // Single character input
    if (value.isNotEmpty && RegExp(r'[0-9]').hasMatch(value)) {
      setState(() {
        _digits[index] = value;
      });

      component.onChange?.call(_fullValue);

      // Check if complete
      if (_digits.every((d) => d.isNotEmpty)) {
        component.onComplete?.call(_fullValue);
      }
    }
  }

  void _handlePaste(String pastedValue) {
    // Extract only digits
    final digits = pastedValue.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return;

    setState(() {
      for (var i = 0; i < component.length && i < digits.length; i++) {
        _digits[i] = digits[i];
      }
    });

    component.onChange?.call(_fullValue);

    if (_digits.every((d) => d.isNotEmpty)) {
      component.onComplete?.call(_fullValue);
    }
  }

  OtpInputSizeVariant get _propsSize => switch (component.size) {
        OtpInputSize.sm => OtpInputSizeVariant.sm,
        OtpInputSize.md => OtpInputSizeVariant.md,
        OtpInputSize.lg => OtpInputSizeVariant.lg,
      };

  @override
  Component build(BuildContext context) {
    return context.renderers.otpInput(OtpInputProps(
      length: component.length,
      digits: _digits,
      obscure: component.obscure,
      size: _propsSize,
      disabled: component.disabled,
      error: component.error,
      label: component.label,
      separator: component.separator,
      separatorPosition: component.separatorPosition,
      onInput: _handleInput,
    ));
  }
}
