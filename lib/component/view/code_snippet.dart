import 'package:jaspr/jaspr.dart';

import '../../core/props/code_snippet_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/code_snippet_props.dart';

/// A code snippet component with copy button overlaid in top-right corner
class ArcaneCodeSnippet extends StatelessComponent {
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

  const ArcaneCodeSnippet({
    required this.code,
    this.language,
    this.showLineNumbers = false,
    this.showCopyButton = true,
    this.maxHeight,
    this.title,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.codeSnippet(CodeSnippetProps(
      code: code,
      language: language,
      showLineNumbers: showLineNumbers,
      showCopyButton: showCopyButton,
      maxHeight: maxHeight,
      title: title,
    ));
  }
}

/// An inline code component
class ArcaneInlineCode extends StatelessComponent {
  /// Code text
  final String code;

  const ArcaneInlineCode(this.code, {super.key});

  @override
  Component build(BuildContext context) {
    return context.renderers.inlineCode(InlineCodeProps(code: code));
  }
}

/// A terminal/command line component with copy button overlaid in top-right
class ArcaneTerminal extends StatelessComponent {
  /// Commands to display
  final List<String> commands;

  /// Prompt symbol
  final String prompt;

  /// Title
  final String? title;

  /// Whether to show copy button
  final bool showCopyButton;

  const ArcaneTerminal({
    required this.commands,
    this.prompt = '\$',
    this.title,
    this.showCopyButton = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.terminal(TerminalProps(
      commands: commands,
      prompt: prompt,
      title: title,
      showCopyButton: showCopyButton,
    ));
  }
}
