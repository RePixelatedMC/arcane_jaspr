import 'package:jaspr/jaspr.dart';

import '../../core/props/code_window_props.dart';
import '../../core/theme_provider.dart';

// Re-export enums for usage
export '../../core/props/code_window_props.dart' show CodeWindowStyle;

/// A code display window with macOS-style window chrome.
///
/// Features a header with red/yellow/green traffic light buttons
/// and an optional title.
///
/// ```dart
/// ArcaneCodeWindow(
///   title: 'main.dart',
///   code: '''
/// void main() {
///   print('Hello, World!');
/// }
/// ''',
/// )
/// ```
class ArcaneCodeWindow extends StatelessComponent {
  /// The code content to display
  final String code;

  /// Optional title shown in the header
  final String? title;

  /// Window style variant
  final CodeWindowStyle style;

  /// Whether to show the traffic light buttons
  final bool showButtons;

  /// Custom code text color
  final String? codeColor;

  /// Custom header background color
  final String? headerBackground;

  /// Custom body background color
  final String? bodyBackground;

  const ArcaneCodeWindow({
    required this.code,
    this.title,
    this.style = CodeWindowStyle.dark,
    this.showButtons = true,
    this.codeColor,
    this.headerBackground,
    this.bodyBackground,
    super.key,
  });

  /// Create a terminal-style window
  const ArcaneCodeWindow.terminal({
    required this.code,
    this.title,
    this.showButtons = true,
    this.codeColor,
    this.headerBackground,
    this.bodyBackground,
    super.key,
  }) : style = CodeWindowStyle.terminal;

  @override
  Component build(BuildContext context) {
    return context.renderers.codeWindow(CodeWindowProps(
      code: code,
      title: title,
      style: style,
      showButtons: showButtons,
      codeColor: codeColor,
      headerBackground: headerBackground,
      bodyBackground: bodyBackground,
    ));
  }
}

/// A simple code snippet preview without window chrome.
///
/// For inline or compact code display.
///
/// ```dart
/// ArcaneCodePreview(
///   code: 'const x = 42;',
///   language: 'dart',
/// )
/// ```
class ArcaneCodePreview extends StatelessComponent {
  /// The code to display
  final String code;

  /// Optional language label
  final String? language;

  /// Whether to use monospace font
  final bool mono;

  const ArcaneCodePreview({
    required this.code,
    this.language,
    this.mono = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.codePreview(CodePreviewProps(
      code: code,
      language: language,
      mono: mono,
    ));
  }
}
