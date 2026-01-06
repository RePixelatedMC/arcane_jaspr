import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/code_snippet_props.dart';
import '../../../component/view/icon.dart';

/// ShadCN Code Snippet renderer.
class ShadcnCodeSnippet extends StatefulComponent {
  final CodeSnippetProps props;

  const ShadcnCodeSnippet(this.props, {super.key});

  @override
  State<ShadcnCodeSnippet> createState() => _ShadcnCodeSnippetState();
}

class _ShadcnCodeSnippetState extends State<ShadcnCodeSnippet> {
  bool _copied = false;

  void _copyToClipboard() {
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final List<String> lines = component.props.code.split('\n');

    return dom.div(
      classes: 'arcane-code-snippet',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'background-color': 'hsl(var(--muted) / 0.5)',
        'border': '1px solid var(--border)',
        'border-radius': 'calc(var(--radius) - 2px)',
        'overflow': 'hidden',
      }),
      [
        // Language/title label
        if (component.props.title != null || component.props.language != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'padding': '0.5rem 1rem',
              'z-index': '1',
            }),
            [
              if (component.props.title != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--muted-foreground)',
                  }),
                  [dom.text(component.props.title!)],
                )
              else if (component.props.language != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': '0.75rem',
                    'font-weight': '500',
                    'color': 'var(--muted-foreground)',
                    'text-transform': 'uppercase',
                    'padding': '0.25rem 0.5rem',
                    'background-color': 'var(--muted)',
                    'border-radius': '0.25rem',
                  }),
                  [dom.text(component.props.language!)],
                ),
            ],
          ),

        // Copy button
        if (component.props.showCopyButton)
          dom.div(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'right': '0',
              'padding': '0.5rem',
              'z-index': '2',
            }),
            [
              dom.button(
                classes: 'arcane-code-copy-btn',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy code',
                  'data-code': component.props.code,
                },
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'padding': '0',
                  'color':
                      _copied ? 'hsl(142 76% 36%)' : 'var(--muted-foreground)',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': '0.25rem',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                events: {'click': (e) => _copyToClipboard()},
                [
                  _copied
                      ? ArcaneIcon.check(size: IconSize.sm)
                      : ArcaneIcon.copy(size: IconSize.sm),
                ],
              ),
            ],
          ),

        // Code content
        dom.div(
          classes: 'arcane-code-snippet-content',
          styles: dom.Styles(raw: {
            'overflow': 'auto',
            if (component.props.maxHeight != null)
              'max-height': '${component.props.maxHeight}px',
            if (component.props.title != null ||
                component.props.language != null)
              'padding-top': '40px',
          }),
          [
            Component.element(
              tag: 'pre',
              classes: 'arcane-code-pre',
              styles: const dom.Styles(raw: {
                'margin': '0',
                'padding': '1.5rem',
                'overflow-x': 'auto',
              }),
              children: [
                if (component.props.showLineNumbers)
                  _buildWithLineNumbers(lines)
                else
                  _buildCodeElement(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildWithLineNumbers(List<String> lines) {
    return dom.div(
      classes: 'arcane-code-with-lines',
      styles: const dom.Styles(raw: {'display': 'flex'}),
      [
        dom.div(
          classes: 'arcane-code-line-numbers',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'padding-right': '1.5rem',
            'border-right': '1px solid var(--border)',
            'margin-right': '1.5rem',
            'user-select': 'none',
          }),
          [
            for (var i = 0; i < lines.length; i++)
              dom.span(
                styles: dom.Styles(raw: {
                  'font-family':
                      'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                  'font-size': '0.875rem',
                  'line-height': '1.7',
                  'color': 'var(--muted-foreground)',
                  'text-align': 'right',
                  'min-width': '${lines.length.toString().length * 8 + 8}px',
                }),
                [dom.text('${i + 1}')],
              ),
          ],
        ),
        _buildCodeElement(),
      ],
    );
  }

  Component _buildCodeElement() {
    return Component.element(
      tag: 'code',
      classes: component.props.language != null
          ? 'arcane-code language-${component.props.language}'
          : 'arcane-code',
      styles: const dom.Styles(raw: {
        'font-family':
            'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
        'font-size': '0.875rem',
        'line-height': '1.7',
        'color': 'var(--foreground)',
        'white-space': 'pre',
      }),
      children: [dom.text(component.props.code)],
    );
  }
}

/// ShadCN Inline Code renderer.
class ShadcnInlineCode extends StatelessComponent {
  final InlineCodeProps props;

  const ShadcnInlineCode(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'code',
      classes: 'arcane-inline-code',
      styles: const dom.Styles(raw: {
        'display': 'inline',
        'padding': '2px 6px',
        'font-family':
            'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
        'font-size': '0.875em',
        'background-color': 'var(--muted)',
        'border-radius': '0.25rem',
        'color': 'var(--accent)',
      }),
      children: [dom.text(props.code)],
    );
  }
}

/// ShadCN Terminal renderer.
class ShadcnTerminal extends StatefulComponent {
  final TerminalProps props;

  const ShadcnTerminal(this.props, {super.key});

  @override
  State<ShadcnTerminal> createState() => _ShadcnTerminalState();
}

class _ShadcnTerminalState extends State<ShadcnTerminal> {
  bool _copied = false;

  void _copyToClipboard() {
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _copied = false);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final String allCommands = component.props.commands.join('\n');

    return dom.div(
      classes: 'arcane-terminal',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'background-color': 'hsl(var(--muted) / 0.5)',
        'border': '1px solid var(--border)',
        'border-radius': 'calc(var(--radius) - 2px)',
        'overflow': 'hidden',
      }),
      [
        // Header
        dom.div(
          classes: 'arcane-terminal-header',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '1rem',
            'padding': '0.5rem 1rem',
            'background-color': 'var(--muted)',
            'border-bottom': '1px solid var(--border)',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'gap': '0.5rem',
              }),
              [
                _windowDot('var(--destructive)'),
                _windowDot('hsl(38 92% 50%)'),
                _windowDot('hsl(142 76% 36%)'),
              ],
            ),
            if (component.props.title != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': '0.875rem',
                  'color': 'var(--muted-foreground)',
                  'flex': '1',
                }),
                [dom.text(component.props.title!)],
              ),
          ],
        ),

        // Copy button
        if (component.props.showCopyButton)
          dom.div(
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '40px',
              'right': '0',
              'padding': '0.5rem',
              'z-index': '2',
            }),
            [
              dom.button(
                classes: 'arcane-terminal-copy',
                attributes: {
                  'type': 'button',
                  'aria-label': 'Copy commands',
                  'data-code': allCommands,
                },
                styles: dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '28px',
                  'height': '28px',
                  'padding': '0',
                  'color':
                      _copied ? 'hsl(142 76% 36%)' : 'var(--muted-foreground)',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': '0.25rem',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                events: {'click': (e) => _copyToClipboard()},
                [
                  _copied
                      ? ArcaneIcon.check(size: IconSize.sm)
                      : ArcaneIcon.copy(size: IconSize.sm),
                ],
              ),
            ],
          ),

        // Content
        Component.element(
          tag: 'pre',
          classes: 'arcane-terminal-content',
          styles: const dom.Styles(raw: {
            'margin': '0',
            'padding': '1.5rem',
            'overflow-x': 'auto',
          }),
          children: [
            for (final cmd in component.props.commands) ...[
              dom.span(
                styles: const dom.Styles(raw: {
                  'color': 'hsl(142 76% 36%)',
                  'font-family':
                      'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                  'font-size': '0.875rem',
                }),
                [dom.text('${component.props.prompt} ')],
              ),
              dom.span(
                styles: const dom.Styles(raw: {
                  'color': 'var(--foreground)',
                  'font-family':
                      'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                  'font-size': '0.875rem',
                }),
                [dom.text(cmd)],
              ),
              dom.text('\n'),
            ],
          ],
        ),
      ],
    );
  }

  Component _windowDot(String color) {
    return dom.div(
      styles: dom.Styles(raw: {
        'width': '12px',
        'height': '12px',
        'border-radius': '9999px',
        'background-color': color,
      }),
      [],
    );
  }
}
