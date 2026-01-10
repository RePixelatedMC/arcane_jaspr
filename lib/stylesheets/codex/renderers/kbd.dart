import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/kbd_props.dart';

/// Codex keyboard shortcut display component.
class CodexKbd extends StatelessComponent {
  final KbdProps props;

  const CodexKbd(this.props, {super.key});

  (String padding, String fontSize, String minWidth) get _sizeStyles =>
      switch (props.size) {
        KbdSize.sm => ('3px 6px', '0.75rem', '22px'),
        KbdSize.md => ('5px 10px', '0.875rem', '28px'),
        KbdSize.lg => ('8px 14px', '1rem', '36px'),
      };

  Map<String, String> get _styleMap {
    final (padding, fontSize, minWidth) = _sizeStyles;

    final baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'min-width': minWidth,
      'padding': padding,
      'font-size': fontSize,
      'font-family': 'var(--font-mono, ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace)',
      'font-weight': 'var(--arcane-font-weight-medium)',
      'line-height': '1',
      'white-space': 'nowrap',
      'user-select': 'none',
    };

    return switch (props.style) {
      KbdStyle.raised => {
          ...baseStyles,
          'background': 'linear-gradient(180deg, var(--secondary) 0%, var(--card) 100%)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-sm)',
          'box-shadow': '0 2px 0 var(--border), inset 0 1px 0 rgba(255, 255, 255, 0.05)',
          'color': 'var(--foreground)',
        },
      KbdStyle.flat => {
          ...baseStyles,
          'background': 'var(--secondary)',
          'border': 'none',
          'border-radius': 'var(--radius-sm)',
          'color': 'var(--foreground)',
        },
      KbdStyle.outline => {
          ...baseStyles,
          'background': 'transparent',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-sm)',
          'color': 'var(--muted-foreground)',
        },
    };
  }

  @override
  Component build(BuildContext context) {
    if (props.keys != null && props.keys!.isNotEmpty) {
      return dom.span(
        styles: const dom.Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '6px',
        }),
        [
          for (var i = 0; i < props.keys!.length; i++) ...[
            Component.element(
              tag: 'kbd',
              styles: dom.Styles(raw: _styleMap),
              children: [Component.text(props.keys![i])],
            ),
            if (i < props.keys!.length - 1)
              dom.span(
                styles: const dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'font-size': 'var(--arcane-font-size-xs)',
                }),
                [Component.text(props.separator)],
              ),
          ],
        ],
      );
    }

    return Component.element(
      tag: 'kbd',
      styles: dom.Styles(raw: _styleMap),
      children: [Component.text(props.keyText ?? '')],
    );
  }
}
