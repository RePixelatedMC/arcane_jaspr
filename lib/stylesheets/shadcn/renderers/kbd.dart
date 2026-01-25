import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/kbd_props.dart';

/// ShadCN-styled keyboard shortcut display component
class ShadcnKbd extends StatelessComponent {
  final KbdProps props;

  const ShadcnKbd(this.props, {super.key});

  (String padding, String fontSize, String minWidth) get _sizeStyles =>
      switch (props.size) {
        ComponentSize.sm => ('2px 5px', '0.75rem', '20px'),
        ComponentSize.md => ('4px 8px', '0.875rem', '24px'),
        ComponentSize.lg => ('6px 12px', '1rem', '32px'),
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
      'font-weight': 'var(--font-weight-medium)',
      'line-height': '1',
      'white-space': 'nowrap',
      'user-select': 'none',
    };

    return switch (props.style) {
      KbdStyle.raised => {
          ...baseStyles,
          'background': 'linear-gradient(180deg, var(--arcane-muted) 0%, var(--arcane-card) 100%)',
          'border': '1px solid var(--arcane-border)',
          'border-radius': 'var(--arcane-radius-xs, 0.25rem)',
          'box-shadow': '0 2px 0 var(--arcane-border), inset 0 1px 0 rgba(var(--arcane-foreground-rgb), 0.1)',
          'color': 'var(--arcane-foreground)',
        },
      KbdStyle.flat => {
          ...baseStyles,
          'background': 'var(--arcane-muted)',
          'border': 'none',
          'border-radius': 'var(--arcane-radius-xs, 0.25rem)',
          'color': 'var(--arcane-foreground)',
        },
      KbdStyle.outline => {
          ...baseStyles,
          'background': 'transparent',
          'border': '1px solid var(--arcane-border)',
          'border-radius': 'var(--arcane-radius-xs, 0.25rem)',
          'color': 'var(--arcane-muted-foreground)',
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
          'gap': 'var(--space-1)',
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
                  'color': 'var(--arcane-muted-foreground)',
                  'font-size': 'var(--font-size-xs)',
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
