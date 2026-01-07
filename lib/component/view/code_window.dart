import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/code_window_props.dart' show CodeWindowStyle;

/// A code display window with macOS-style window chrome.
class ArcaneCodeWindow extends StatelessComponent {
  final String code;
  final String? title;
  final CodeWindowStyle style;
  final bool showButtons;
  final String? codeColor;
  final String? headerBackground;
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
class ArcaneCodePreview extends StatelessComponent {
  final String code;
  final String? language;
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
