import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export for backwards compatibility
export '../../core/props/kbd_props.dart' show KbdStyle, KbdSize;

/// Keyboard shortcut display component
///
/// Displays keyboard keys or shortcuts in a styled format.
///
/// ```dart
/// // Single key
/// ArcaneKbd('⌘')
///
/// // Key combination
/// ArcaneKbd.combo(['⌘', 'K'])
///
/// // With separator
/// ArcaneKbd.shortcut('Ctrl+Shift+P')
/// ```
class ArcaneKbd extends StatelessComponent {
  /// The key text to display
  final String? keyText;

  /// List of keys for a combination
  final List<String>? keys;

  /// Separator between keys (for combo display)
  final String separator;

  /// Style variant
  final KbdStyle style;

  /// Size variant
  final KbdSize size;

  const ArcaneKbd(
    this.keyText, {
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
    super.key,
  })  : keys = null,
        separator = '+';

  /// Display a key combination
  const ArcaneKbd.combo(
    this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
    super.key,
  }) : keyText = null;

  /// Parse a shortcut string like "Ctrl+Shift+P"
  factory ArcaneKbd.shortcut(
    String shortcut, {
    KbdStyle style = KbdStyle.raised,
    KbdSize size = KbdSize.md,
  }) {
    final parts = shortcut.split('+').map((s) => s.trim()).toList();
    return ArcaneKbd.combo(
      parts,
      separator: '+',
      style: style,
      size: size,
    );
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.kbd(KbdProps(
      keyText: keyText,
      keys: keys,
      separator: separator,
      style: style,
      size: size,
    ));
  }
}
