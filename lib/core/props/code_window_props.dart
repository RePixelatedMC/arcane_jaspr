enum CodeWindowStyle {
  dark,
  light,
  terminal,
}

/// Code window component properties.
class CodeWindowProps {
  final String code;
  final String? title;
  final CodeWindowStyle style;
  final bool showButtons;
  final String? codeColor;
  final String? headerBackground;
  final String? bodyBackground;

  const CodeWindowProps({
    required this.code,
    this.title,
    this.style = CodeWindowStyle.dark,
    this.showButtons = true,
    this.codeColor,
    this.headerBackground,
    this.bodyBackground,
  });
}

/// Code preview component properties.
class CodePreviewProps {
  final String code;
  final String? language;
  final bool mono;

  const CodePreviewProps({
    required this.code,
    this.language,
    this.mono = true,
  });
}
