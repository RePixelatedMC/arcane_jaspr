import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/web.dart' as dom;

class NeubrutalismLayoutRenderers extends LayoutRenderers {
  const NeubrutalismLayoutRenderers();

  static bool _hasHeader(ArcaneScaffoldProps props) =>
      props.title != null || props.navigation != null || props.actions != null;

  static Widget _header(ArcaneScaffoldProps props) {
    return dom.header(
      classes: 'arcane-scaffold-header',
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'height': 'var(--nb-topbar-height, 70px)',
          'min-height': 'var(--nb-topbar-height, 70px)',
          'box-sizing': 'border-box',
          'border-bottom':
              'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
          'background-color': 'var(--secondary-background, #fff)',
          'padding': '0 1.25rem',
          'box-shadow': 'none',
          'position': 'fixed',
          'top': '0',
          'left': '0',
          'right': '0',
          'z-index': '70',
        },
      ),
      <Widget>[
        if (props.title != null)
          dom.div(
            classes: 'arcane-scaffold-title',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-family': 'var(--font-heading)',
                'font-size': '1.125rem',
                'font-weight': '900',
                'letter-spacing': '-0.02em',
                'line-height': '1',
                'white-space': 'nowrap',
                'text-transform': 'uppercase',
                'color': 'var(--foreground)',
                'padding': '0.375rem 0.75rem',
                'background-color': 'var(--nb-accent, var(--primary))',
                'border':
                    'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
                'border-radius': 'var(--nb-radius-soft, 4px)',
                'box-shadow':
                    'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
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
                'gap': '0.625rem',
                'min-width': '0',
                'width': '100%',
                'flex': '1 1 auto',
              },
            ),
            <Widget>[props.navigation!],
          )
        else
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
                'gap': '0.625rem',
              },
            ),
            <Widget>[props.actions!],
          ),
      ],
    );
  }

  @override
  Widget scaffold(ArcaneScaffoldProps props) {
    Map<String, String> footerStyles = <String, String>{
      'border-top': 'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
      'padding': '1rem 1.25rem',
      'background-color': 'var(--secondary-background, #fff)',
      'font-weight': '600',
    };
    if (props.sidebar != null) {
      footerStyles['margin-left'] = 'var(--nb-sidebar-width, 250px)';
    }
    if (props.secondary != null) {
      footerStyles['margin-right'] = 'var(--nb-secondary-width, 250px)';
    }

    Map<String, String> mainStyles = <String, String>{
      'min-width': '0',
      'min-height': _hasHeader(props)
          ? 'calc(100svh - var(--nb-topbar-height, 70px))'
          : '100svh',
      'padding': '0',
      'box-sizing': 'border-box',
      'background-color': 'var(--background)',
      'overflow': 'visible',
      'position': 'relative',
      'border': '0',
      'box-shadow': 'none',
    };
    if (props.sidebar != null) {
      mainStyles['margin-left'] = 'var(--nb-sidebar-width, 250px)';
    }
    if (props.secondary != null) {
      mainStyles['margin-right'] = 'var(--nb-secondary-width, 250px)';
    }

    return dom.div(
      classes: 'arcane-scaffold neubrutalism-scaffold',
      styles: dom.Styles(
        raw: <String, String>{
          'min-height': '100vh',
          'display': 'block',
          'background': 'var(--background)',
          'color': 'var(--foreground)',
          'box-sizing': 'border-box',
          if (_hasHeader(props)) 'padding-top': 'var(--nb-topbar-height, 70px)',
        },
      ),
      <Widget>[
        if (_hasHeader(props)) _header(props),
        dom.div(
          classes: 'arcane-scaffold-body',
          styles: const dom.Styles(
            raw: <String, String>{
              'display': 'block',
              'min-height': '0',
              'padding': '0',
              'gap': '0',
              'box-sizing': 'border-box',
              'background': 'var(--background)',
            },
          ),
          <Widget>[
            if (props.sidebar != null)
              dom.aside(
                classes: 'arcane-scaffold-sidebar',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'position': 'fixed',
                    'top': 'var(--nb-topbar-height, 70px)',
                    'left': '0',
                    'bottom': '0',
                    'width': 'var(--nb-sidebar-width, 250px)',
                    'height': 'calc(100svh - var(--nb-topbar-height, 70px))',
                    'box-sizing': 'border-box',
                    'border-right':
                        'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
                    'border-radius': '0',
                    'background-color': 'var(--secondary-background, #fff)',
                    'box-shadow': 'none',
                    'padding': '0',
                    'min-height': '0',
                    'overflow-y': 'auto',
                    'overflow-x': 'hidden',
                    'z-index': '50',
                  },
                ),
                <Widget>[props.sidebar!],
              ),
            dom.main_(
              classes: 'arcane-scaffold-main',
              styles: dom.Styles(raw: mainStyles),
              <Widget>[props.body],
            ),
            if (props.secondary != null)
              dom.aside(
                classes: 'arcane-scaffold-secondary',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'position': 'fixed',
                    'top': 'var(--nb-topbar-height, 70px)',
                    'right': '0',
                    'bottom': '0',
                    'width': 'var(--nb-secondary-width, 250px)',
                    'height': 'calc(100svh - var(--nb-topbar-height, 70px))',
                    'box-sizing': 'border-box',
                    'border-left':
                        'var(--nb-border-thick, 4px) solid var(--nb-line, #000)',
                    'border-radius': '0',
                    'background-color': 'var(--secondary-background, #fff)',
                    'box-shadow': 'none',
                    'padding': '0',
                    'min-height': '0',
                    'overflow-y': 'auto',
                    'overflow-x': 'hidden',
                    'z-index': '45',
                  },
                ),
                <Widget>[props.secondary!],
              ),
          ],
        ),
        if (props.footer != null)
          dom.footer(
            classes: 'arcane-scaffold-footer',
            styles: dom.Styles(raw: footerStyles),
            <Widget>[props.footer!],
          ),
        if (props.floatingAction != null)
          dom.div(
            classes: 'arcane-scaffold-floating',
            styles: const dom.Styles(
              raw: <String, String>{
                'position': 'fixed',
                'right': '1.5rem',
                'bottom': '1.5rem',
                'z-index': '40',
                'filter': 'drop-shadow(4px 4px 0 var(--nb-shadow-color, #000))',
              },
            ),
            <Widget>[props.floatingAction!],
          ),
      ],
    );
  }
}
