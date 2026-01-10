import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/mobile_menu_props.dart';

/// Codex MobileMenu renderer.
class CodexMobileMenu extends StatelessComponent {
  final MobileMenuProps props;

  const CodexMobileMenu(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    if (!props.isOpen) {
      return const dom.div([]);
    }

    return dom.div(
      classes: 'codex-mobile-menu',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '100',
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--background)',
      }),
      [
        // Header
        dom.div(
          classes: 'codex-mobile-menu-header',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '1rem 1.5rem',
            'border-bottom': '1px solid var(--border)',
          }),
          [
            if (props.logo != null) props.logo!,
            if (props.onClose != null)
              dom.button(
                classes: 'codex-mobile-menu-close',
                styles: const dom.Styles(raw: {
                  'padding': '0.5rem',
                  'background': 'none',
                  'border': 'none',
                  'color': 'var(--foreground)',
                  'cursor': 'pointer',
                  'font-size': 'var(--arcane-font-size-2xl)',
                }),
                events: {'click': (_) => props.onClose!()},
                [const Component.text('X')],
              ),
          ],
        ),

        // Navigation
        dom.nav(
          classes: 'codex-mobile-menu-nav',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': '1rem',
          }),
          [
            for (final item in props.items)
              _buildNavItem(item),
          ],
        ),

        // CTA
        if (props.cta != null)
          dom.div(
            classes: 'codex-mobile-menu-cta',
            styles: const dom.Styles(raw: {
              'padding': '1rem 1.5rem',
              'border-top': '1px solid var(--border)',
            }),
            [props.cta!],
          ),
      ],
    );
  }

  Component _buildNavItem(MobileNavItem item) {
    final bool hasChildren = item.children != null && item.children!.isNotEmpty;

    if (item.href != null) {
      return dom.a(
        classes: 'codex-mobile-nav-item',
        href: item.href!,
        styles: const dom.Styles(raw: {
          'display': 'flex',
          'align-items': 'center',
          'gap': '0.75rem',
          'padding': '0.875rem 1rem',
          'font-size': 'var(--arcane-font-size-base)',
          'color': 'var(--foreground)',
          'text-decoration': 'none',
          'border-radius': 'var(--radius)',
          'transition': 'background-color var(--arcane-transition)',
        }),
        [
          if (item.icon != null) item.icon!,
          Component.text(item.label),
        ],
      );
    }

    return dom.div(
      classes: 'codex-mobile-nav-group',
      [
        dom.button(
          classes: 'codex-mobile-nav-item',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'width': '100%',
            'padding': '0.875rem 1rem',
            'font-size': 'var(--arcane-font-size-base)',
            'color': 'var(--foreground)',
            'background': 'none',
            'border': 'none',
            'cursor': 'pointer',
            'border-radius': 'var(--radius)',
          }),
          events: item.onTap != null ? {'click': (_) => item.onTap!()} : null,
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.75rem',
              }),
              [
                if (item.icon != null) item.icon!,
                Component.text(item.label),
              ],
            ),
            if (hasChildren)
              const dom.span(
                styles: dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text('>')],
              ),
          ],
        ),
        if (hasChildren)
          dom.div(
            classes: 'codex-mobile-nav-children',
            styles: const dom.Styles(raw: {
              'padding-left': '1rem',
            }),
            [
              for (final child in item.children!)
                _buildNavItem(child),
            ],
          ),
      ],
    );
  }
}