/// Style variants for the code window
enum CodeWindowStyle {
  /// Dark background (default)
  dark,

  /// Light background
  light,

  /// Terminal/console style with green text
  terminal,
}

/// Properties for code window components.
class CodeWindowProps {
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

/// Properties for code preview components.
class CodePreviewProps {
  /// The code to display
  final String code;

  /// Optional language label
  final String? language;

  /// Whether to use monospace font
  final bool mono;

  const CodePreviewProps({
    required this.code,
    this.language,
    this.mono = true,
  });
}
