import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Style variants for the code window
enum CodeWindowStyle {
  /// Dark background (default)
  dark,

  /// Light background
  light,

  /// Terminal/console style with green text
  terminal,
}

/// A code display window with macOS-style window chrome.
///
/// Features a header with red/yellow/green traffic light buttons
/// and an optional title.
///
/// ```dart
/// ArcaneCodeWindow(
///   title: 'main.dart',
///   code: '''
/// void main() {
///   print('Hello, World!');
/// }
/// ''',
/// )
/// ```
class ArcaneCodeWindow extends StatelessComponent {
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

  const ArcaneCodeWindow({
    required this.code,
    this.title,
    this.style = CodeWindowStyle.dark,
    this.showButtons = true,
    this.codeColor,
    this.headerBackground,
    this.bodyBackground,
    super.key,
  });

  /// Create a terminal-style window
  const ArcaneCodeWindow.terminal({
    required this.code,
    this.title,
    this.showButtons = true,
    this.codeColor,
    this.headerBackground,
    this.bodyBackground,
    super.key,
  }) : style = CodeWindowStyle.terminal;

  @override
  Component build(BuildContext context) {
    final effectiveHeaderBg = headerBackground ?? _getHeaderBackground();
    final effectiveBodyBg = bodyBackground ?? _getBodyBackground();
    final effectiveCodeColor = codeColor ?? _getCodeColor();

    return div(
      styles: Styles(raw: {
        'background': effectiveBodyBg,
        'border': '1px solid var(--border)',
        'border-radius': '0.5rem',
        'overflow': 'hidden',
      }),
      [
        // Window header
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.5rem',
            'padding': '0.5rem 1rem',
            'background': effectiveHeaderBg,
            'border-bottom': '1px solid var(--border)',
          }),
          [
            // Traffic light buttons
            if (showButtons) ...[
              _buildDot('#FF5F57'), // Red
              _buildDot('#FFBD2E'), // Yellow
              _buildDot('#28C840'), // Green
            ],
            // Title (centered or after buttons)
            if (title != null)
              div(
                styles: Styles(raw: {
                  'flex': '1',
                  'text-align': showButtons ? 'center' : 'left',
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
                }),
                [text(title!)],
              ),
          ],
        ),
        // Code content
        pre(
          styles: Styles(raw: {
            'margin': '0',
            'padding': '1rem',
            'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
            'font-size': '0.875rem',
            'line-height': '1.6',
            'color': effectiveCodeColor,
            'overflow-x': 'auto',
          }),
          [
            Component.element(tag: 'code', children: [Component.text(code)]),
          ],
        ),
      ],
    );
  }

  Component _buildDot(String color) {
    return div(
      styles: Styles(raw: {
        'width': '12px',
        'height': '12px',
        'border-radius': '50%',
        'background': color,
      }),
      [],
    );
  }

  String _getHeaderBackground() {
    switch (style) {
      case CodeWindowStyle.dark:
        return 'var(--muted)';
      case CodeWindowStyle.light:
        return '#f5f5f5';
      case CodeWindowStyle.terminal:
        return '#1a1a1a';
    }
  }

  String _getBodyBackground() {
    switch (style) {
      case CodeWindowStyle.dark:
        return 'var(--card)';
      case CodeWindowStyle.light:
        return '#ffffff';
      case CodeWindowStyle.terminal:
        return '#0d0d0d';
    }
  }

  String _getCodeColor() {
    switch (style) {
      case CodeWindowStyle.dark:
        return 'var(--foreground)';
      case CodeWindowStyle.light:
        return '#1a1a1a';
      case CodeWindowStyle.terminal:
        return '#00ff00';
    }
  }
}

/// A simple code snippet preview without window chrome.
///
/// For inline or compact code display.
///
/// ```dart
/// ArcaneCodePreview(
///   code: 'const x = 42;',
///   language: 'dart',
/// )
/// ```
class ArcaneCodePreview extends StatelessComponent {
  /// The code to display
  final String code;

  /// Optional language label
  final String? language;

  /// Whether to use monospace font
  final bool mono;

  const ArcaneCodePreview({
    required this.code,
    this.language,
    this.mono = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: const Styles(raw: {
        'background': 'var(--muted)',
        'border': '1px solid var(--border)',
        'border-radius': '0.375rem',
        'overflow': 'hidden',
      }),
      [
        if (language != null)
          div(
            styles: const Styles(raw: {
              'padding': '0.25rem 0.5rem',
              'background': 'var(--card)',
              'border-bottom': '1px solid var(--border)',
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
              'text-transform': 'uppercase',
            }),
            [text(language!)],
          ),
        pre(
          styles: Styles(raw: {
            'margin': '0',
            'padding': '0.5rem',
            if (mono) 'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
            'font-size': '0.875rem',
            'line-height': '1.5',
            'color': 'var(--foreground)',
            'overflow-x': 'auto',
          }),
          [Component.element(tag: 'code', children: [Component.text(code)])],
        ),
      ],
    );
  }
}
