import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:web/web.dart' as web;

/// A code block component with syntax highlighting and copy-to-clipboard functionality.
///
/// Displays code in a styled container with a language label and copy button
/// overlaid in the top-right corner.
class CodeBlock extends StatefulComponent {
  final String code;
  final String? language;
  final String? title;

  const CodeBlock({
    super.key,
    required this.code,
    this.language,
    this.title,
  });

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
  bool _copied = false;

  void _copyToClipboard() {
    web.window.navigator.clipboard.writeText(component.code);
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
    final hasLabel = component.language != null || component.title != null;

    // Use raw div() with explicit inline styles to ensure positioning works
    return div(
      styles: const Styles(raw: {
        'position': 'relative',
        'margin-bottom': '16px',
        'border-radius': '8px',
        'overflow': 'hidden',
        'background': 'var(--arcane-code-background, var(--arcane-surface-variant))',
        'border': '1px solid var(--arcane-border)',
      }),
      [
        // Language label (top-left, if present)
        if (hasLabel)
          div(
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'padding': '8px 12px',
              'z-index': '1',
            }),
            [
              if (component.title != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': '12px',
                    'color': 'var(--arcane-muted)',
                  }),
                  [Component.text(component.title!)],
                )
              else if (component.language != null)
                span(
                  styles: const Styles(raw: {
                    'font-size': '11px',
                    'color': 'var(--arcane-muted)',
                    'padding': '2px 8px',
                    'background': 'rgba(255,255,255,0.1)',
                    'border-radius': '4px',
                  }),
                  [Component.text(component.language!)],
                ),
            ],
          ),

        // Copy button (top-right, overlaid)
        div(
          styles: const Styles(raw: {
            'position': 'absolute',
            'top': '8px',
            'right': '8px',
            'z-index': '10',
          }),
          [
            button(
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '28px',
                'height': '28px',
                'padding': '0',
                'border': 'none',
                'background': 'transparent',
                'color': _copied ? 'var(--arcane-success)' : 'var(--arcane-muted)',
                'cursor': 'pointer',
                'border-radius': '4px',
              }),
              events: {'click': (_) => _copyToClipboard()},
              [
                _copied
                    ? ArcaneIcon.check(size: IconSize.sm)
                    : ArcaneIcon.copy(size: IconSize.sm),
              ],
            ),
          ],
        ),

        // Code content with syntax highlighting
        div(
          styles: Styles(raw: {
            'overflow': 'auto',
            'max-height': '500px',
            if (hasLabel) 'padding-top': '32px',
          }),
          [
            Component.element(
              tag: 'pre',
              styles: const Styles(raw: {
                'margin': '0',
                'padding': '16px',
                'background': 'transparent',
                'overflow': 'auto',
              }),
              children: [
                Component.element(
                  tag: 'code',
                  classes: 'language-${component.language ?? 'dart'}',
                  styles: const Styles(raw: {
                    'font-family': 'var(--font-mono)',
                    'font-size': '13px',
                    'line-height': '1.6',
                  }),
                  children: [Component.text(component.code)],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Inline code component for short code snippets within text.
class InlineCodeBlock extends StatelessComponent {
  final String code;

  const InlineCodeBlock({
    super.key,
    required this.code,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneSpan(
      styles: const ArcaneStyleData(
        fontFamily: FontFamily.mono,
        fontSize: FontSize.sm,
        padding: PaddingPreset.inlineCode,
        background: Background.glassOverlay,
        borderRadius: Radius.xs,
        textColor: TextColor.accent,
      ),
      child: ArcaneText(code),
    );
  }
}
