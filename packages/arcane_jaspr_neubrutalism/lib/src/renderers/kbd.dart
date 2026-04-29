import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/kbd_props.dart';

/// Neubrutalism keyboard shortcut display component.
class NeubrutalismKbd extends StatelessComponent {
  final KbdProps props;

  const NeubrutalismKbd(this.props, {super.key});

  (String padding, String fontSize, String minWidth) get _sizeStyles =>
      switch (props.size) {
        ComponentSize.sm => ('2px 6px', '0.6875rem', '20px'),
        ComponentSize.md => ('3px 8px', '0.8125rem', '26px'),
        ComponentSize.lg => ('5px 12px', '0.9375rem', '34px'),
      };

  Map<String, String> get _styleMap {
    final (padding, fontSize, minWidth) = _sizeStyles;

    final Map<String, String> baseStyles = <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'min-width': minWidth,
      'padding': padding,
      'font-size': fontSize,
      'font-family':
          'var(--font-mono, ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace)',
      'font-weight': '600',
      'line-height': '1',
      'letter-spacing': '0.04em',
      'white-space': 'nowrap',
      'user-select': 'none',
      'color': 'var(--nb-accent-cool, var(--secondary))',
    };

    return switch (props.style) {
      KbdStyle.raised => <String, String>{
        ...baseStyles,
        'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      KbdStyle.flat => <String, String>{
        ...baseStyles,
        'box-shadow': 'none',
      },
      KbdStyle.outline => <String, String>{
        ...baseStyles,
        'background': 'transparent !important',
        'color': 'var(--muted-foreground)',
        'box-shadow': 'none',
      },
    };
  }

  @override
  Component build(BuildContext context) {
    if (props.keys != null && props.keys!.isNotEmpty) {
      return dom.span(
        styles: const dom.Styles(
          raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'gap': '6px',
          },
        ),
        [
          for (var i = 0; i < props.keys!.length; i++) ...[
            Component.element(
              tag: 'kbd',
              classes: 'neubrutalism-kbd',
              styles: dom.Styles(raw: _styleMap),
              children: [Component.text(props.keys![i])],
            ),
            if (i < props.keys!.length - 1)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    'color': 'var(--muted-foreground)',
                    'font-size': 'var(--font-size-xs)',
                  },
                ),
                [Component.text(props.separator)],
              ),
          ],
        ],
      );
    }

    return Component.element(
      tag: 'kbd',
      classes: 'neubrutalism-kbd',
      styles: dom.Styles(raw: _styleMap),
      children: [Component.text(props.keyText ?? '')],
    );
  }
}
