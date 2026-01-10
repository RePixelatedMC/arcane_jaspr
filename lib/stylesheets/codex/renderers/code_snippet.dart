import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/code_snippet_props.dart';

/// Codex Code Snippet renderer.
///
/// Implements the Codex design language:
/// - Dark code background for OLED
/// - Accent-colored header
/// - Larger padding
class CodexCodeSnippet extends StatelessComponent {
  final CodeSnippetProps props;

  const CodexCodeSnippet(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<String> lines = props.code.split('\n');

    return dom.div(
      classes: 'codex-code-snippet',
      styles: const dom.Styles(raw: {
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
        'background-color': '#0a0a0a',
        'border': '1px solid var(--border)',
      }),
      [
        // Header (if title or copy button)
        if (props.title != null || props.showCopyButton)
          dom.div(
            classes: 'codex-code-snippet-header',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'padding': '0.75rem 1rem',
              'background-color': '#0d0d0d',
              'border-bottom': '1px solid var(--border)',
            }),
            [
              // Title/language
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-medium)',
                  'color': 'var(--muted-foreground)',
                  'text-transform': 'uppercase',
                  'letter-spacing': '0.05em',
                }),
                [
                  Component.text(
                      props.title ?? props.language?.toUpperCase() ?? 'CODE')
                ],
              ),

              // Copy button
              if (props.showCopyButton)
                const dom.button(
                  classes: 'codex-code-copy-button',
                  attributes: {'type': 'button'},
                  styles: dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'gap': '0.375rem',
                    'padding': '0.375rem 0.75rem',
                    'background-color': 'var(--secondary)',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius-sm)',
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                    'transition': 'all var(--transition)',
                  }),
                  [Component.text('Copy')],
                ),
            ],
          ),

        // Code content
        dom.div(
          classes: 'codex-code-snippet-content',
          styles: dom.Styles(raw: {
            'padding': '1rem 1.25rem', // Codex: larger padding
            if (props.maxHeight != null) 'max-height': '${props.maxHeight}px',
            if (props.maxHeight != null) 'overflow-y': 'auto',
          }),
          [
            dom.pre(
              styles: const dom.Styles(raw: {
                'margin': '0',
                'font-family': 'var(--font-mono)',
                'font-size': '0.8125rem',
                'line-height': '1.7',
                'tab-size': '2',
              }),
              [
                dom.code(
                  classes:
                      props.language != null ? 'language-${props.language}' : '',
                  [
                    if (props.showLineNumbers)
                      for (int i = 0; i < lines.length; i++)
                        dom.div(
                          classes: 'codex-code-line',
                          styles: const dom.Styles(raw: {
                            'display': 'flex',
                          }),
                          [
                            // Line number
                            dom.span(
                              classes: 'codex-code-line-number',
                              styles: const dom.Styles(raw: {
                                'display': 'inline-block',
                                'width': '3rem',
                                'color': 'var(--muted)',
                                'text-align': 'right',
                                'padding-right': '1rem',
                                'user-select': 'none',
                              }),
                              [Component.text('${i + 1}')],
                            ),
                            // Code line
                            dom.span(
                              styles: const dom.Styles(raw: {
                                'color': 'var(--foreground)',
                              }),
                              [Component.text(lines[i])],
                            ),
                          ],
                        )
                    else
                      dom.span(
                        styles: const dom.Styles(raw: {
                          'color': 'var(--foreground)',
                          'white-space': 'pre-wrap',
                          'word-break': 'break-word',
                        }),
                        [Component.text(props.code)],
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Codex Inline Code renderer.
class CodexInlineCode extends StatelessComponent {
  final InlineCodeProps props;

  const CodexInlineCode(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.code(
      classes: 'codex-inline-code',
      styles: const dom.Styles(raw: {
        'display': 'inline',
        'padding': '0.2em 0.4em',
        'font-family': 'var(--font-mono)',
        'font-size': '0.875em',
        'background-color': 'var(--secondary)',
        'border-radius': 'var(--radius-xs)',
        'color': 'var(--primary)',
      }),
      [Component.text(props.code)],
    );
  }
}

/// Codex Terminal renderer.
class CodexTerminal extends StatelessComponent {
  final TerminalProps props;

  const CodexTerminal(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-terminal',
      styles: const dom.Styles(raw: {
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
        'background-color': '#000000',
        'border': '1px solid var(--border)',
      }),
      [
        // Header with traffic lights
        dom.div(
          classes: 'codex-terminal-header',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': 'var(--space-2)',
            'padding': '0.75rem 1rem',
            'background-color': '#0a0a0a',
            'border-bottom': '1px solid var(--border)',
          }),
          [
            // Traffic lights
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'gap': 'var(--space-2)',
              }),
              [
                _buildDot('#ff5f56'), // Red
                _buildDot('#ffbd2e'), // Yellow
                _buildDot('#27c93f'), // Green
              ],
            ),

            // Title
            if (props.title != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'margin-left': 'auto',
                  'margin-right': 'auto',
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.title!)],
              ),

            // Copy button
            if (props.showCopyButton)
              const dom.button(
                classes: 'codex-terminal-copy',
                attributes: {'type': 'button'},
                styles: dom.Styles(raw: {
                  'margin-left': 'auto',
                  'padding': '0.25rem 0.5rem',
                  'background': 'transparent',
                  'border': 'none',
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                }),
                [Component.text('Copy')],
              ),
          ],
        ),

        // Terminal content
        dom.div(
          classes: 'codex-terminal-content',
          styles: const dom.Styles(raw: {
            'padding': '1rem 1.25rem',
            'font-family': 'var(--font-mono)',
            'font-size': '0.8125rem',
            'line-height': '1.7',
          }),
          [
            for (final cmd in props.commands)
              dom.div(
                classes: 'codex-terminal-line',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'gap': '0.75rem',
                }),
                [
                  // Prompt
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'color': 'var(--primary)',
                      'user-select': 'none',
                    }),
                    [Component.text(props.prompt)],
                  ),
                  // Command
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'color': 'var(--foreground)',
                    }),
                    [Component.text(cmd)],
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildDot(String color) {
    return dom.div(
      styles: dom.Styles(raw: {
        'width': '12px',
        'height': '12px',
        'border-radius': '50%',
        'background-color': color,
      }),
      [],
    );
  }
}