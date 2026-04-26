import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/web.dart' as dom;

class NeonLayoutRenderers extends LayoutRenderers {
  const NeonLayoutRenderers();

  @override
  Widget scaffold(ArcaneScaffoldProps props) {
    return dom.div(
      classes: 'arcane-scaffold neon-scaffold',
      styles: const dom.Styles(
        raw: <String, String>{
          'min-height': '100vh',
          'display': 'grid',
          'grid-template-rows': '3.75rem minmax(0, 1fr) auto',
          'background':
              'linear-gradient(135deg, color-mix(in srgb, var(--primary) 5%, transparent), transparent 36rem), radial-gradient(circle at top right, color-mix(in srgb, var(--neon-cyan) 14%, transparent), transparent 32rem), transparent',
          'color': 'var(--foreground)',
        },
      ),
      <Widget>[
        _header(props),
        dom.div(
          classes: 'arcane-scaffold-body',
          styles: const dom.Styles(
            raw: <String, String>{
              'display': 'grid',
              'grid-template-columns':
                  'minmax(0, auto) minmax(0, 1fr) minmax(0, auto)',
              'min-height': '0',
              'padding': '0.75rem',
              'gap': '0.75rem',
            },
          ),
          <Widget>[
            if (props.sidebar != null)
              dom.aside(
                classes: 'arcane-scaffold-sidebar',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'width': '19rem',
                    'border':
                        '1px solid var(--neon-panel-border, var(--border))',
                    'border-radius': 'var(--neon-radius-panel)',
                    'clip-path': 'var(--neon-panel-clip)',
                    'background':
                        'linear-gradient(135deg, color-mix(in srgb, var(--neon-cyan) 9%, transparent), transparent 42%), linear-gradient(color-mix(in srgb, var(--primary) 4%, transparent) 1px, transparent 1px), color-mix(in srgb, var(--card) 80%, transparent)',
                    'background-size': 'auto, 18px 18px, auto',
                    'box-shadow':
                        'var(--neon-panel-shadow), var(--neon-inset-highlight)',
                    'padding': '0.875rem',
                    'min-height': '0',
                    'overflow': 'auto',
                    'position': 'relative',
                    'backdrop-filter': 'blur(16px)',
                    '-webkit-backdrop-filter': 'blur(16px)',
                  },
                ),
                <Widget>[props.sidebar!],
              ),
            dom.main_(
              classes: 'arcane-scaffold-main',
              styles: const dom.Styles(
                raw: <String, String>{
                  'min-width': '0',
                  'padding': '1rem',
                  'border':
                      '1px solid var(--neon-panel-border, var(--border))',
                  'border-radius': 'var(--neon-radius-panel)',
                  'clip-path': 'var(--neon-panel-clip)',
                  'background':
                      'radial-gradient(circle at top left, color-mix(in srgb, var(--neon-cyan) 8%, transparent), transparent 22rem), linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 3%, transparent) 1px, transparent 1px), linear-gradient(color-mix(in srgb, var(--primary) 3%, transparent) 1px, transparent 1px), color-mix(in srgb, var(--background) 74%, transparent)',
                  'background-size': 'auto, 24px 24px, 24px 24px, auto',
                  'overflow': 'auto',
                  'position': 'relative',
                  'backdrop-filter': 'blur(14px)',
                  '-webkit-backdrop-filter': 'blur(14px)',
                },
              ),
              <Widget>[props.body],
            ),
            if (props.secondary != null)
              dom.aside(
                classes: 'arcane-scaffold-secondary',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'width': '20rem',
                    'border':
                        '1px solid var(--neon-panel-border, var(--border))',
                    'border-radius': 'var(--neon-radius-panel)',
                    'clip-path': 'var(--neon-panel-clip)',
                    'background':
                        'linear-gradient(135deg, color-mix(in srgb, var(--neon-magenta) 8%, transparent), transparent 42%), linear-gradient(90deg, color-mix(in srgb, var(--neon-magenta) 4%, transparent) 1px, transparent 1px), color-mix(in srgb, var(--card) 76%, transparent)',
                    'background-size': 'auto, 18px 18px, auto',
                    'box-shadow':
                        'var(--neon-panel-shadow), var(--neon-inset-highlight)',
                    'padding': '0.875rem',
                    'min-height': '0',
                    'overflow': 'auto',
                    'position': 'relative',
                    'backdrop-filter': 'blur(16px)',
                    '-webkit-backdrop-filter': 'blur(16px)',
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
                'border-top':
                    '1px solid var(--neon-panel-border, var(--border))',
                'padding': '0.875rem 1.25rem',
                'background':
                    'linear-gradient(90deg, color-mix(in srgb, var(--primary) 7%, transparent), color-mix(in srgb, var(--background) 78%, transparent))',
                'box-shadow':
                    '0 -12px 28px color-mix(in srgb, var(--primary) 7%, transparent)',
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
                'right': '1.5rem',
                'bottom': '1.5rem',
                'z-index': '40',
                'filter':
                    'drop-shadow(0 12px 28px color-mix(in srgb, var(--primary) 28%, transparent))',
              },
            ),
            <Widget>[props.floatingAction!],
          ),
      ],
    );
  }

  Widget _header(ArcaneScaffoldProps props) {
    return dom.header(
      classes: 'arcane-scaffold-header',
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'border-bottom':
              '1px solid var(--neon-panel-border, var(--border))',
          'background':
              'linear-gradient(90deg, color-mix(in srgb, var(--primary) 14%, transparent), color-mix(in srgb, var(--background) 80%, transparent) 32%, color-mix(in srgb, var(--neon-cyan) 10%, transparent)), linear-gradient(90deg, color-mix(in srgb, var(--neon-cyan) 16%, transparent) 1px, transparent 1px)',
          'background-size': 'auto, 28px 28px',
          'padding': '0 1.25rem',
          'box-shadow':
              '0 14px 36px rgba(0,0,0,0.24), 0 0 24px color-mix(in srgb, var(--primary) 10%, transparent)',
          'backdrop-filter': 'blur(18px)',
          '-webkit-backdrop-filter': 'blur(18px)',
        },
      ),
      <Widget>[
        if (props.title != null)
          dom.div(
            classes: 'arcane-scaffold-title',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-family': 'var(--font-heading)',
                'font-size': '1rem',
                'font-weight': '700',
                'letter-spacing': '0',
                'line-height': '1',
                'white-space': 'nowrap',
                'text-transform': 'uppercase',
                'color': 'var(--neon-accent)',
                'text-shadow':
                    '0 0 18px color-mix(in srgb, var(--neon-accent) 34%, transparent)',
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
                'gap': '0.75rem',
              },
            ),
            <Widget>[props.actions!],
          ),
      ],
    );
  }
}
