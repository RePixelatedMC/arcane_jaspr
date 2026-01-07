import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/carpet_props.dart';

/// Codex Carpet renderer.
class CodexCarpet extends StatelessComponent {
  final CarpetProps props;

  const CodexCarpet(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-carpet',
      styles: dom.Styles(raw: {
        'background-color': props.color ?? 'var(--secondary)',
        if (props.radius != null) 'border-radius': '${props.radius}px',
        if (props.border) 'border': '1px solid var(--border)',
        if (props.padding != null)
          'padding':
              '${props.padding!.top}px ${props.padding!.right}px ${props.padding!.bottom}px ${props.padding!.left}px',
      }),
      [props.child],
    );
  }
}

/// Codex Surface renderer.
class CodexSurface extends StatelessComponent {
  final SurfaceProps props;

  const CodexSurface(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String shadow = switch (props.elevation) {
      0 => 'none',
      1 => 'var(--arcane-shadow-xs)',
      2 => 'var(--arcane-shadow-sm)',
      3 => 'var(--arcane-shadow)',
      4 => 'var(--arcane-shadow-md)',
      _ => 'var(--arcane-shadow-lg)',
    };

    return dom.div(
      classes: 'codex-surface',
      styles: dom.Styles(raw: {
        'background-color': props.color ?? 'var(--card)',
        'border-radius': props.radius != null ? '${props.radius}px' : 'var(--radius)',
        if (props.border) 'border': '1px solid var(--border)',
        'box-shadow': shadow,
        if (props.padding != null)
          'padding':
              '${props.padding!.top}px ${props.padding!.right}px ${props.padding!.bottom}px ${props.padding!.left}px',
      }),
      [props.child],
    );
  }
}

/// Codex ArcaneDivider renderer.
class CodexArcaneDivider extends StatelessComponent {
  final ArcaneDividerProps props;

  const CodexArcaneDivider(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (props.vertical) {
      return dom.div(
        classes: 'codex-arcane-divider codex-arcane-divider-vertical',
        styles: dom.Styles(raw: {
          'width': '${props.thickness ?? 1}px',
          'height': '100%',
          'background-color': props.color ?? 'var(--border)',
          if (props.indent != null) 'margin-top': '${props.indent}px',
          if (props.endIndent != null) 'margin-bottom': '${props.endIndent}px',
        }),
        [],
      );
    }

    return dom.div(
      classes: 'codex-arcane-divider',
      styles: dom.Styles(raw: {
        'height': '${props.thickness ?? 1}px',
        'width': '100%',
        'background-color': props.color ?? 'var(--border)',
        if (props.indent != null) 'margin-left': '${props.indent}px',
        if (props.endIndent != null) 'margin-right': '${props.endIndent}px',
      }),
      [],
    );
  }
}
