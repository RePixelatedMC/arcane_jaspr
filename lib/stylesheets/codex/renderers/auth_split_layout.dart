import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/auth_split_layout_props.dart';

/// Codex AuthSplitLayout renderer.
class CodexAuthSplitLayout extends StatelessComponent {
  final AuthSplitLayoutProps props;

  const CodexAuthSplitLayout(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<Component> panels = [
      // Branding panel (hidden on mobile)
      dom.div(
        classes: 'codex-auth-split-branding',
        styles: const dom.Styles(raw: {
          'flex': '1',
          'display': 'none',
          'background-color': 'var(--card)',
          'border-right': '1px solid var(--border)',
        }),
        [props.brandingContent],
      ),

      // Form panel
      dom.div(
        classes: 'codex-auth-split-form',
        styles: const dom.Styles(raw: {
          'flex': '1',
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '2rem',
          'min-height': '100vh',
          'background-color': 'var(--background)',
        }),
        [
          // Mobile header
          if (props.mobileHeader != null)
            dom.div(
              classes: 'codex-auth-mobile-header',
              styles: const dom.Styles(raw: {
                'margin-bottom': '2rem',
              }),
              [props.mobileHeader!],
            ),

          // Form content
          dom.div(
            classes: 'codex-auth-form-content',
            styles: const dom.Styles(raw: {
              'width': '100%',
              'max-width': '420px',
            }),
            [props.formContent],
          ),
        ],
      ),
    ];

    return dom.div(
      classes: 'codex-auth-split-layout',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'min-height': '100vh',
      }),
      props.reverseSides ? panels.reversed.toList() : panels,
    );
  }
}
