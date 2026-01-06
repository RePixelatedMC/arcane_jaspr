
/// Properties for code snippet components.
class CodeSnippetProps {
  /// The code to display
  final String code;

  /// Programming language (for syntax highlighting hints)
  final String? language;

  /// Whether to show line numbers
  final bool showLineNumbers;

  /// Whether to show copy button
  final bool showCopyButton;

  /// Maximum height (scrollable if exceeded)
  final double? maxHeight;

  /// Title/filename
  final String? title;

  const CodeSnippetProps({
    required this.code,
    this.language,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxHeight,
    this.title,
  });
}

/// Properties for inline code components.
class InlineCodeProps {
  /// Code text
  final String code;

  const InlineCodeProps({required this.code});
}

/// Properties for terminal components.
class TerminalProps {
  /// Commands to display
  final List<String> commands;

  /// Prompt symbol
  final String prompt;

  /// Title
  final String? title;

  /// Whether to show copy button
  final bool showCopyButton;

  const TerminalProps({
    required this.commands,
    this.prompt = '\$',
    this.title,
    this.showCopyButton = true,
  });
}
