import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/auth_layout_props.dart';

/// Codex AuthLayout renderer.
class CodexAuthLayout extends StatelessComponent {
  final AuthLayoutProps props;

  const CodexAuthLayout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-auth-layout',
      styles: dom.Styles(raw: {
        'min-height': '100vh',
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '2rem',
        'background-color': props.backgroundColor,
        'position': 'relative',
        'overflow': 'hidden',
      }),
      [
        // Grid background
        if (props.showGrid)
          dom.div(
            classes: 'codex-auth-grid',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background-image':
                  'linear-gradient(${props.gridColor} 1px, transparent 1px), linear-gradient(90deg, ${props.gridColor} 1px, transparent 1px)',
              'background-size': '50px 50px',
              'pointer-events': 'none',
            }),
            [],
          ),

        // Glow effects
        if (props.showGlows) ...[
          dom.div(
            classes: 'codex-auth-glow-primary',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '-20%',
              'left': '-10%',
              'width': '50%',
              'height': '50%',
              'background': 'radial-gradient(circle, ${props.primaryGlowColor} 0%, transparent 70%)',
              'pointer-events': 'none',
            }),
            [],
          ),
          dom.div(
            classes: 'codex-auth-glow-secondary',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '-20%',
              'right': '-10%',
              'width': '50%',
              'height': '50%',
              'background': 'radial-gradient(circle, ${props.secondaryGlowColor} 0%, transparent 70%)',
              'pointer-events': 'none',
            }),
            [],
          ),
        ],

        // Content container
        dom.div(
          classes: 'codex-auth-content',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'z-index': '1',
            'width': '100%',
            'max-width': props.maxWidth,
            'display': 'flex',
            'flex-direction': 'column',
            'align-items': 'center',
            'gap': '2rem',
          }),
          [
            // Header (logo)
            if (props.header != null) props.header!,

            // Main content
            props.child,

            // Footer
            if (props.footer != null) props.footer!,
          ],
        ),
      ],
    );
  }
}

/// Codex AuthBackLink renderer.
class CodexAuthBackLink extends StatelessComponent {
  final AuthBackLinkProps props;

  const CodexAuthBackLink(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.a(
      classes: 'codex-auth-back-link',
      href: props.href,
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'font-size': '0.875rem',
        'color': 'var(--muted-foreground)',
        'text-decoration': 'none',
        'transition': 'color 150ms ease',
      }),
      [
        // Arrow icon
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': '1rem',
          }),
          [const Component.text('<-')],
        ),
        Component.text(props.text),
      ],
    );
  }
}
