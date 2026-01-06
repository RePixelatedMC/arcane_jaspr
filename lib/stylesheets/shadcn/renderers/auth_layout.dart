import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';

/// ShadCN Auth Layout renderer.
class ShadcnAuthLayout extends StatelessComponent {
  final AuthLayoutProps props;

  const ShadcnAuthLayout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-auth-layout',
      styles: dom.Styles(raw: {
        'min-height': '100vh',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'background': props.backgroundColor,
        'padding': '1.5rem',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      [
        // Background effects
        if (props.showGrid || props.showGlows) _buildBackgroundEffects(),
        // Content container
        dom.div(
          classes: 'arcane-auth-content',
          styles: dom.Styles(raw: {
            'width': '100%',
            'max-width': props.maxWidth,
            'position': 'relative',
            'z-index': '1',
          }),
          [
            // Header (logo)
            if (props.header != null)
              dom.div(
                classes: 'arcane-auth-header',
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'center',
                  'margin-bottom': '2rem',
                }),
                [props.header!],
              ),
            // Main content (auth card)
            props.child,
            // Footer (back link)
            if (props.footer != null)
              dom.div(
                classes: 'arcane-auth-footer',
                styles: const dom.Styles(raw: {
                  'text-align': 'center',
                  'margin-top': '2rem',
                }),
                [props.footer!],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildBackgroundEffects() {
    return dom.div(
      classes: 'arcane-auth-background',
      styles: const dom.Styles(raw: {
        'position': 'absolute',
        'inset': '0',
        'pointer-events': 'none',
        'overflow': 'hidden',
      }),
      [
        // Grid pattern
        if (props.showGrid)
          dom.div(
            classes: 'arcane-auth-grid',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background-image':
                  'linear-gradient(${props.gridColor} 1px, transparent 1px), linear-gradient(90deg, ${props.gridColor} 1px, transparent 1px)',
              'background-size': '50px 50px',
            }),
            [],
          ),
        // Top left glow
        if (props.showGlows)
          dom.div(
            classes: 'arcane-auth-glow-primary',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '-200px',
              'left': '-200px',
              'width': '500px',
              'height': '500px',
              'background':
                  'radial-gradient(circle, ${props.primaryGlowColor} 0%, transparent 70%)',
            }),
            [],
          ),
        // Bottom right glow
        if (props.showGlows)
          dom.div(
            classes: 'arcane-auth-glow-secondary',
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '-200px',
              'right': '-200px',
              'width': '500px',
              'height': '500px',
              'background':
                  'radial-gradient(circle, ${props.secondaryGlowColor} 0%, transparent 70%)',
            }),
            [],
          ),
      ],
    );
  }
}

/// ShadCN Auth Back Link renderer.
class ShadcnAuthBackLink extends StatelessComponent {
  final AuthBackLinkProps props;

  const ShadcnAuthBackLink(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.a(
      href: props.href,
      classes: 'arcane-auth-back-link',
      styles: const dom.Styles(raw: {
        'font-size': '0.875rem',
        'color': 'var(--muted-foreground)',
        'text-decoration': 'none',
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.25rem',
        'transition': 'all 150ms ease',
      }),
      [Component.text('\u2190 ${props.text}')],
    );
  }
}
