import 'package:jaspr/jaspr.dart';

import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

enum KbdStyle {
  raised,
  flat,
  outline,
}

/// Keyboard shortcut display component properties.
class KbdProps {
  final String? keyText;
  final List<String>? keys;
  final String separator;
  final KbdStyle style;
  final ComponentSize size;

  const KbdProps({
    this.keyText,
    this.keys,
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = ComponentSize.md,
  }) : assert(keyText != null || keys != null,
            'Either keyText or keys must be provided');

  const KbdProps.key(
    String key, {
    this.style = KbdStyle.raised,
    this.size = ComponentSize.md,
  })  : keyText = key,
        keys = null,
        separator = '+';

  const KbdProps.combo(
    List<String> this.keys, {
    this.separator = '+',
    this.style = KbdStyle.raised,
    this.size = ComponentSize.md,
  }) : keyText = null;
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for keyboard shortcut components.
mixin KbdRendererContract {
  /// Renders a keyboard shortcut display component.
  Component kbd(KbdProps props);
}
