import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/auth_split_layout_props.dart';

/// Renders a split-screen auth layout.
Component renderAuthSplitLayout(AuthSplitLayoutProps props) {
  final leftPanel = _buildBrandingPanel(props.brandingContent);
  final rightPanel = _buildFormPanel(props.formContent, props.mobileHeader);

  return dom.div(
    styles: const dom.Styles(raw: {
      'display': 'flex',
      'min-height': '100vh',
      'background': 'var(--background)',
    }),
    [
      // Branding panel (hidden on mobile)
      if (!props.reverseSides) leftPanel else rightPanel,
      // Form panel
      if (!props.reverseSides) rightPanel else leftPanel,
    ],
  );
}

Component _buildBrandingPanel(Component brandingContent) {
  // Using raw div for complex media query styling
  return dom.div(
    styles: const dom.Styles(raw: {
      'flex': '1',
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': 'center',
      'padding': '3rem',
      'position': 'relative',
      'overflow': 'hidden',
      'background': 'var(--muted)',
    }),
    classes: 'auth-branding-panel',
    [
      // Background gradient glow
      const dom.div(
        styles: dom.Styles(raw: {
          'position': 'absolute',
          'inset': '0',
          'pointer-events': 'none',
        }),
        [
          // Top-left green glow
          dom.div(
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '-20%',
              'left': '-10%',
              'width': '60%',
              'height': '60%',
              'background':
                  'radial-gradient(circle, hsl(var(--accent) / 0.2) 0%, transparent 70%)',
            }),
            [],
          ),
          // Bottom-right cyan glow
          dom.div(
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'bottom': '-20%',
              'right': '-10%',
              'width': '50%',
              'height': '50%',
              'background':
                  'radial-gradient(circle, hsl(var(--secondary) / 0.15) 0%, transparent 70%)',
            }),
            [],
          ),
          // Subtle grid pattern
          dom.div(
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'background-image':
                  'linear-gradient(hsl(var(--foreground) / 0.03) 1px, transparent 1px), linear-gradient(90deg, hsl(var(--foreground) / 0.03) 1px, transparent 1px)',
              'background-size': '40px 40px',
            }),
            [],
          ),
        ],
      ),
      // Content
      dom.div(
        styles: const dom.Styles(raw: {
          'position': 'relative',
          'z-index': '1',
          'max-width': '420px',
          'margin': '0 auto',
        }),
        [brandingContent],
      ),
    ],
  );
}

Component _buildFormPanel(Component formContent, Component? mobileHeader) {
  return dom.div(
    styles: const dom.Styles(raw: {
      'flex-grow': '1',
      'display': 'flex',
      'flex-direction': 'column',
      'justify-content': 'center',
      'align-items': 'center',
      'padding': '2rem 3rem',
      'background': 'var(--background)',
      'min-height': '100vh',
    }),
    [
      // Mobile header (only shown on mobile when branding panel is hidden)
      if (mobileHeader != null)
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'none',
            'margin-bottom': '1.5rem',
          }),
          classes: 'auth-mobile-header',
          [mobileHeader],
        ),
      // Form content
      dom.div(
        styles: const dom.Styles(raw: {
          'width': '100%',
          'max-width': '420px',
        }),
        [formContent],
      ),
    ],
  );
}