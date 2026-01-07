import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/code_snippet_props.dart';

/// A code snippet component with copy button overlaid in top-right corner.
class ArcaneCodeSnippet extends StatelessComponent {
  final String code;
  final String? language;
  final bool showLineNumbers;
  final bool showCopyButton;
  final double? maxHeight;
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

/// An inline code component.
class ArcaneInlineCode extends StatelessComponent {
  final String code;

  const ArcaneInlineCode(this.code, {super.key});

  @override
  Component build(BuildContext context) {
    return context.renderers.inlineCode(InlineCodeProps(code: code));
  }
}

/// A terminal/command line component with copy button overlaid in top-right.
class ArcaneTerminal extends StatelessComponent {
  final List<String> commands;
  final String prompt;
  final String? title;
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
