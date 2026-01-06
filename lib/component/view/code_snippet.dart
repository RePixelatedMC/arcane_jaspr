import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import 'icon.dart';

/// A code snippet component with copy button overlaid in top-right corner
class ArcaneCodeSnippet extends StatefulComponent {
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
  State<ArcaneCodeSnippet> createState() => _CodeSnippetState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-code-copy-btn:hover').styles(raw: {
      'color': 'var(--foreground)',
      'background-color': 'var(--muted)',
    }),
  ];
}

class _CodeSnippetState extends State<ArcaneCodeSnippet> {
  bool _copied = false;

  void _copyToClipboard() {
    // Clipboard copy is handled by JavaScript via data-code attribute
    // This just updates the visual state
    setState(() => _copied = true);
    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final List<String> lines = component.code.split('\n');

    return div(
      classes: 'arcane-code-snippet',
      styles: const Styles(raw: {
        'position': 'relative',
        'background-color': 'hsl(var(--muted) / 0.5)',
        'border': '1px solid var(--border)',
        'border-radius': '0.375rem',
        'overflow': 'hidden',
      }),
      [
        // Language/title label (top-left, if present)
        if (component.title != null || component.language != null)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'padding': '0.5rem 1rem',
              'z-index': '1',
            }),
            [
              if (component.title != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--muted-foreground)',
                  }),
                  [text(component.title!)],
                )
              else if (component.language != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': '0.75rem',
                    'font-weight': '500',
                    'color': 'var(--muted-foreground)',
                    'text-transform': 'uppercase',
                    'padding': '0.25rem 0.5rem',
                    'background-color': 'var(--muted)',
                    'border-radius': '0.25rem',
                  }),
                  [text(component.language!)],
                ),
            ],
          ),

        // Copy button (top-right, overlaid)
        if (component.showCopyButton)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'right': '0',
              'padding': '0.5rem',
              'z-index': '2',
            }),
            [
              button(
                classes: 'arcane-code-copy-btn',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy code',
                  'data-code': component.code,
                },
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'padding': '0',
                  'color': _copied ? 'hsl(142 76% 36%)' : 'var(--muted-foreground)',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': '0.25rem',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                events: {
                  'click': (e) => _copyToClipboard(),
                },
                [
                  _copied
                      ? ArcaneIcon.check(size: IconSize.sm)
                      : ArcaneIcon.copy(size: IconSize.sm),
                ],
              ),
            ],
          ),

        // Code content
        div(
          classes: 'arcane-code-snippet-content',
          styles: Styles(raw: {
            'overflow': 'auto',
            if (component.maxHeight != null) 'max-height': '${component.maxHeight}px',
            // Add top padding when there's a language label or title
            if (component.title != null || component.language != null)
              'padding-top': '40px',
          }),
          [
            Component.element(
              tag: 'pre',
              classes: 'arcane-code-pre',
              styles: const Styles(raw: {
                'margin': '0',
                'padding': '1.5rem',
                'overflow-x': 'auto',
              }),
              children: [
                if (component.showLineNumbers)
                  div(
                    classes: 'arcane-code-with-lines',
                    styles: const Styles(raw: {
                      'display': 'flex',
                    }),
                    [
                      // Line numbers
                      div(
                        classes: 'arcane-code-line-numbers',
                        styles: const Styles(raw: {
                          'display': 'flex',
                          'flex-direction': 'column',
                          'padding-right': '1.5rem',
                          'border-right': '1px solid var(--border)',
                          'margin-right': '1.5rem',
                          'user-select': 'none',
                        }),
                        [
                          for (var i = 0; i < lines.length; i++)
                            span(
                              styles: Styles(raw: {
                                'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                                'font-size': '0.875rem',
                                'line-height': '1.7',
                                'color': 'var(--muted-foreground)',
                                'text-align': 'right',
                                'min-width': '${lines.length.toString().length * 8 + 8}px',
                              }),
                              [text('${i + 1}')],
                            ),
                        ],
                      ),
                      // Code
                      Component.element(
                        tag: 'code',
                        classes: component.language != null
                            ? 'arcane-code language-${component.language}'
                            : 'arcane-code',
                        styles: const Styles(raw: {
                          'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                          'font-size': '0.875rem',
                          'line-height': '1.7',
                          'color': 'var(--foreground)',
                          'white-space': 'pre',
                        }),
                        children: [text(component.code)],
                      ),
                    ],
                  )
                else
                  Component.element(
                    tag: 'code',
                    classes: component.language != null
                        ? 'arcane-code language-${component.language}'
                        : 'arcane-code',
                    styles: const Styles(raw: {
                      'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                      'font-size': '0.875rem',
                      'line-height': '1.7',
                      'color': 'var(--foreground)',
                      'white-space': 'pre',
                    }),
                    children: [text(component.code)],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// An inline code component
class ArcaneInlineCode extends StatelessComponent {
  /// Code text
  final String code;

  const ArcaneInlineCode(this.code, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'code',
      classes: 'arcane-inline-code',
      styles: const Styles(raw: {
        'display': 'inline',
        'padding': '2px 6px',
        'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
        'font-size': '0.875em',
        'background-color': 'var(--muted)',
        'border-radius': '0.25rem',
        'color': 'var(--accent)',
      }),
      children: [text(code)],
    );
  }
}

/// A terminal/command line component with copy button overlaid in top-right
class ArcaneTerminal extends StatefulComponent {
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
  State<ArcaneTerminal> createState() => _TerminalState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-terminal-copy:hover').styles(raw: {
      'color': 'var(--foreground)',
      'background-color': 'var(--muted)',
    }),
  ];
}

class _TerminalState extends State<ArcaneTerminal> {
  bool _copied = false;

  void _copyToClipboard() {
    // Clipboard copy is handled by JavaScript via data-code attribute
    // This just updates the visual state
    setState(() => _copied = true);
    // Reset after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final String allCommands = component.commands.join('\n');

    return div(
      classes: 'arcane-terminal',
      styles: const Styles(raw: {
        'position': 'relative',
        'background-color': 'hsl(var(--muted) / 0.5)',
        'border': '1px solid var(--border)',
        'border-radius': '0.375rem',
        'overflow': 'hidden',
      }),
      [
        // Terminal header with window dots
        div(
          classes: 'arcane-terminal-header',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
            'padding': '0.5rem 1rem',
            'background-color': 'var(--muted)',
            'border-bottom': '1px solid var(--border)',
          }),
          [
            // Window controls
            div(
              styles: const Styles(raw: {
                'display': 'flex',
                'gap': '0.5rem',
              }),
              [
                _windowDot('var(--destructive)'),
                _windowDot('hsl(38 92% 50%)'),
                _windowDot('hsl(142 76% 36%)'),
              ],
            ),
            // Title
            if (component.title != null)
              span(
                styles: const Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                  'flex': '1',
                }),
                [text(component.title!)],
              ),
          ],
        ),

        // Copy button (top-right, overlaid over content area)
        if (component.showCopyButton)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '40px', // Below header
              'right': '0',
              'padding': '0.5rem',
              'z-index': '2',
            }),
            [
              button(
                classes: 'arcane-terminal-copy',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy commands',
                  'data-code': allCommands,
                },
                styles: Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'padding': '0',
                  'color': _copied ? 'hsl(142 76% 36%)' : 'var(--muted-foreground)',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': '0.25rem',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                events: {
                  'click': (e) => _copyToClipboard(),
                },
                [
                  _copied
                      ? ArcaneIcon.check(size: IconSize.sm)
                      : ArcaneIcon.copy(size: IconSize.sm),
                ],
              ),
            ],
          ),

        // Terminal content
        Component.element(
          tag: 'pre',
          classes: 'arcane-terminal-content',
          styles: const Styles(raw: {
            'margin': '0',
            'padding': '1.5rem',
            'overflow-x': 'auto',
          }),
          children: [
            for (final cmd in component.commands) ...[
              span(
                styles: const Styles(raw: {
                  'color': 'hsl(142 76% 36%)',
                  'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                  'font-size': '0.875rem',
                }),
                [text('${component.prompt} ')],
              ),
              span(
                styles: const Styles(raw: {
                  'color': 'var(--foreground)',
                  'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                  'font-size': '0.875rem',
                }),
                [text(cmd)],
              ),
              text('\n'),
            ],
          ],
        ),
      ],
    );
  }

  Component _windowDot(String color) {
    return div(
      styles: Styles(raw: {
        'width': '12px',
        'height': '12px',
        'border-radius': '9999px',
        'background-color': color,
      }),
      [],
    );
  }
}
