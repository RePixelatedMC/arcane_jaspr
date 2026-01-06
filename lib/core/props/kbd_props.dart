/// Keyboard key display style
enum KbdStyle {
  /// Default raised key style
  raised,

  /// Flat minimal style
  flat,

  /// Outline style
  outline,
}

/// Keyboard key display size
enum KbdSize {
  sm,
  md,
  lg,
}

/// Props for keyboard shortcut display component
class KbdProps {
  /// The key text to display (single key)
  final String? keyText;

  /// List of keys for a combination
  final List<String>? keys;

  /// Separator between keys (for combo display)
  final String separator;

  /// Style variant
  final KbdStyle style;

  /// Size variant
  final KbdSize size;

  const KbdProps({
    this.keyText,
    this.keys,
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
  }) : assert(keyText != null || keys != null,
            'Either keyText or keys must be provided');

  /// Create a single key
  const KbdProps.key(
    String key, {
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
  })  : keyText = key,
        keys = null,
        separator = '+';

  /// Create a key combination
  const KbdProps.combo(
    List<String> this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
  }) : keyText = null;
}
