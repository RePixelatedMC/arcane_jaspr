enum KbdStyle {
  raised,
  flat,
  outline,
}

enum KbdSize {
  sm,
  md,
  lg,
}

/// Keyboard shortcut display component properties.
class KbdProps {
  final String? keyText;
  final List<String>? keys;
  final String separator;
  final KbdStyle style;
  final KbdSize size;

  const KbdProps({
    this.keyText,
    this.keys,
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
  }) : assert(keyText != null || keys != null,
            'Either keyText or keys must be provided');

  const KbdProps.key(
    String key, {
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
  })  : keyText = key,
        keys = null,
        separator = '+';

  const KbdProps.combo(
    List<String> this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
  }) : keyText = null;
}
