enum OtpInputSizeVariant {
  sm,
  md,
  lg,
}

/// OTP input component properties.
class OtpInputProps {
  final int length;
  final List<String> digits;
  final bool obscure;
  final OtpInputSizeVariant size;
  final bool disabled;
  final String? error;
  final String? label;
  final String? separator;
  final int? separatorPosition;
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
