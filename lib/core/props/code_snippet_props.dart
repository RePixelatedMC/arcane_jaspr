import 'package:jaspr/jaspr.dart';

/// Code snippet component properties.
class CodeSnippetProps {
  final String code;
  final String? language;
  final bool showLineNumbers;
  final bool showCopyButton;
  final double? maxHeight;
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

/// Inline code component properties.
class InlineCodeProps {
  final String code;

  const InlineCodeProps({required this.code});
}

/// Terminal component properties.
class TerminalProps {
  final List<String> commands;
  final String prompt;
  final String? title;
  final bool showCopyButton;

  const TerminalProps({
    required this.commands,
    this.prompt = '\$',
    this.title,
    this.showCopyButton = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for code snippet components.
mixin CodeSnippetRendererContract {
  Component codeSnippet(CodeSnippetProps props);
  Component inlineCode(InlineCodeProps props);
  Component terminal(TerminalProps props);
}
