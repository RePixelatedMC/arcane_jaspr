import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/code_window_props.dart';

/// ShadCN Code Window renderer.
class ShadcnCodeWindow extends StatelessComponent {
  final CodeWindowProps props;

  const ShadcnCodeWindow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final effectiveHeaderBg = props.headerBackground ?? _getHeaderBackground();
    final effectiveBodyBg = props.bodyBackground ?? _getBodyBackground();
    final effectiveCodeColor = props.codeColor ?? _getCodeColor();

    return dom.div(
      classes: 'arcane-code-window',
      styles: dom.Styles(raw: {
        'background': effectiveBodyBg,
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'overflow': 'hidden',
      }),
      [
        // Window header
        dom.div(
          classes: 'arcane-code-window-header',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.5rem',
            'padding': '0.5rem 1rem',
            'background': effectiveHeaderBg,
            'border-bottom': '1px solid var(--border)',
          }),
          [
            if (props.showButtons) ...[
              _buildDot('#FF5F57'),
              _buildDot('#FFBD2E'),
              _buildDot('#28C840'),
            ],
            if (props.title != null)
              dom.div(
                styles: dom.Styles(raw: {
                  'flex': '1',
                  'text-align': props.showButtons ? 'center' : 'left',
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'font-family':
                      'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                }),
                [dom.text(props.title!)],
              ),
          ],
        ),
        // Code content
        dom.pre(
          styles: dom.Styles(raw: {
            'margin': '0',
            'padding': '1rem',
            'font-family':
                'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
            'font-size': '0.875rem',
            'line-height': '1.6',
            'color': effectiveCodeColor,
            'overflow-x': 'auto',
          }),
          [
            Component.element(
              tag: 'code',
              children: [Component.text(props.code)],
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
        'background': color,
      }),
      [],
    );
  }

  String _getHeaderBackground() {
    return switch (props.style) {
      CodeWindowStyle.dark => 'var(--muted)',
      CodeWindowStyle.light => '#f5f5f5',
      CodeWindowStyle.terminal => '#1a1a1a',
    };
  }

  String _getBodyBackground() {
    return switch (props.style) {
      CodeWindowStyle.dark => 'var(--card)',
      CodeWindowStyle.light => '#ffffff',
      CodeWindowStyle.terminal => '#0d0d0d',
    };
  }

  String _getCodeColor() {
    return switch (props.style) {
      CodeWindowStyle.dark => 'var(--foreground)',
      CodeWindowStyle.light => '#1a1a1a',
      CodeWindowStyle.terminal => '#00ff00',
    };
  }
}

/// ShadCN Code Preview renderer.
class ShadcnCodePreview extends StatelessComponent {
  final CodePreviewProps props;

  const ShadcnCodePreview(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-code-preview',
      styles: const dom.Styles(raw: {
        'background': 'var(--muted)',
        'border': '1px solid var(--border)',
        'border-radius': 'calc(var(--radius) - 2px)',
        'overflow': 'hidden',
      }),
      [
        if (props.language != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'padding': '0.25rem 0.5rem',
              'background': 'var(--card)',
              'border-bottom': '1px solid var(--border)',
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'text-transform': 'uppercase',
            }),
            [dom.text(props.language!)],
          ),
        dom.pre(
          styles: dom.Styles(raw: {
            'margin': '0',
            'padding': '0.5rem',
            if (props.mono)
              'font-family':
                  'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
            'font-size': '0.875rem',
            'line-height': '1.5',
            'color': 'var(--foreground)',
            'overflow-x': 'auto',
          }),
          [
            Component.element(
              tag: 'code',
              children: [Component.text(props.code)],
            ),
          ],
        ),
      ],
    );
  }
}
