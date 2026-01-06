/// Size variants for OTP input
enum OtpInputSizeVariant {
  sm,
  md,
  lg,
}

/// Props for the OTP input component
class OtpInputProps {
  /// Number of digits
  final int length;

  /// Current digit values
  final List<String> digits;

  /// Hide digits like a password
  final bool obscure;

  /// Visual size
  final OtpInputSizeVariant size;

  /// Whether the input is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Label above the input
  final String? label;

  /// Separator character
  final String? separator;

  /// Position to show separator
  final int? separatorPosition;

  /// Input handler
  final void Function(int index, String value)? onInput;

  const OtpInputProps({
    this.length = 6,
    this.digits = const [],
    this.obscure = false,
    this.size = OtpInputSizeVariant.md,
    this.disabled = false,
    this.error,
    this.label,
    this.separator,
    this.separatorPosition,
    this.onInput,
  });
}
