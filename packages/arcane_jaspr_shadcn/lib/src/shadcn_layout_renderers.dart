import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/web.dart' as dom;

class ShadcnLayoutRenderers extends LayoutRenderers {
  const ShadcnLayoutRenderers();

  @override
  Widget scaffold(ArcaneScaffoldProps props) {
    List<Widget> shellChildren = <Widget>[
      _header(props),
      dom.div(
        classes: 'arcane-scaffold-body',
        styles: const dom.Styles(
          raw: <String, String>{
            'display': 'grid',
            'grid-template-columns':
                'minmax(0, auto) minmax(0, 1fr) minmax(0, auto)',
            'min-height': '0',
            'flex': '1',
          },
        ),
        <Widget>[
          if (props.sidebar != null)
            dom.aside(
              classes: 'arcane-scaffold-sidebar',
              styles: const dom.Styles(
                raw: <String, String>{
                  'width': '17.5rem',
                  'border-right': '1px solid var(--border)',
                  'background': 'var(--background)',
                  'padding': '1rem',
                  'min-height': '0',
                  'overflow': 'auto',
                },
              ),
              <Widget>[props.sidebar!],
            ),
          dom.main_(
            classes: 'arcane-scaffold-main',
            styles: const dom.Styles(
              raw: <String, String>{
                'min-width': '0',
                'padding': '1.5rem',
                'overflow': 'auto',
              },
            ),
            <Widget>[props.body],
          ),
          if (props.secondary != null)
            dom.aside(
              classes: 'arcane-scaffold-secondary',
              styles: const dom.Styles(
                raw: <String, String>{
                  'width': '18rem',
                  'border-left': '1px solid var(--border)',
                  'background': 'var(--background)',
                  'padding': '1rem',
                  'min-height': '0',
                  'overflow': 'auto',
                },
              ),
              <Widget>[props.secondary!],
            ),
        ],
      ),
      if (props.footer != null)
        dom.footer(
          classes: 'arcane-scaffold-footer',
          styles: const dom.Styles(
            raw: <String, String>{
              'border-top': '1px solid var(--border)',
              'padding': '0.875rem 1.25rem',
              'background': 'var(--background)',
            },
          ),
          <Widget>[props.footer!],
        ),
      if (props.floatingAction != null)
        dom.div(
          classes: 'arcane-scaffold-floating',
          styles: const dom.Styles(
            raw: <String, String>{
              'position': 'fixed',
              'right': '1.25rem',
              'bottom': '1.25rem',
              'z-index': '40',
            },
          ),
          <Widget>[props.floatingAction!],
        ),
    ];

    return dom.div(
      classes: 'arcane-scaffold shadcn-scaffold',
      styles: const dom.Styles(
        raw: <String, String>{
          'min-height': '100vh',
          'display': 'flex',
          'flex-direction': 'column',
          'background': 'var(--background)',
          'color': 'var(--foreground)',
        },
      ),
      shellChildren,
    );
  }

  Widget _header(ArcaneScaffoldProps props) {
    return dom.header(
      classes: 'arcane-scaffold-header',
      styles: const dom.Styles(
        raw: <String, String>{
          'height': '3.5rem',
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'border-bottom': '1px solid var(--border)',
          'background':
              'color-mix(in srgb, var(--background) 96%, transparent)',
          'padding': '0 1.25rem',
          'position': 'sticky',
          'top': '0',
          'z-index': '30',
          'backdrop-filter': 'blur(10px)',
        },
      ),
      <Widget>[
        if (props.title != null)
          dom.div(
            classes: 'arcane-scaffold-title',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': '0.9375rem',
                'font-weight': '600',
                'line-height': '1',
                'white-space': 'nowrap',
              },
            ),
            <Widget>[Text(props.title!)],
          ),
        if (props.navigation != null)
          dom.nav(
            classes: 'arcane-scaffold-navigation',
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.25rem',
                'min-width': '0',
              },
            ),
            <Widget>[props.navigation!],
          ),
        const dom.div(
          styles: dom.Styles(raw: <String, String>{'flex': '1'}),
          <Widget>[],
        ),
        if (props.actions != null)
          dom.div(
            classes: 'arcane-scaffold-actions',
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.5rem',
              },
            ),
            <Widget>[props.actions!],
          ),
      ],
    );
  }
}
