import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/kbd_props.dart' show KbdStyle, KbdSize;

/// Keyboard shortcut display component.
class ArcaneKbd extends StatelessComponent {
  final String? keyText;
  final List<String>? keys;
  final String separator;
  final KbdStyle style;
  final KbdSize size;

  const ArcaneKbd(
    this.keyText, {
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
    super.key,
  })  : keys = null,
        separator = '+';

  const ArcaneKbd.combo(
    this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = KbdSize.md,
    super.key,
  }) : keyText = null;

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
