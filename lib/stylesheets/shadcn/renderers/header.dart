import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/header_props.dart';

/// ShadCN-style header/navbar component
class ShadcnHeader extends StatelessComponent {
  final HeaderProps props;

  const ShadcnHeader(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.header(
      classes:
          'arcane-header ${props.sticky ? 'sticky' : ''} ${props.transparent ? 'transparent' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'padding': '0 24px',
        'height': '64px',
        'background-color':
            props.transparent ? 'transparent' : 'var(--background)',
        if (props.bordered) 'border-bottom': '1px solid var(--border)',
        if (props.sticky) 'position': 'sticky',
        if (props.sticky) 'top': '0',
        if (props.sticky) 'z-index': '50',
        if (!props.transparent) 'backdrop-filter': 'blur(12px)',
      }),
      [
        // Left section: Logo + Nav
        dom.div(
          classes: 'arcane-header-left',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '32px',
          }),
          [
            // Logo
            dom.div(
              classes: 'arcane-header-logo',
              [props.logo],
            ),

            // Navigation
            dom.nav(
              classes: 'arcane-header-nav',
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': 'var(--arcane-space-1)',
              }),
              [
                for (final item in props.navItems) _buildNavItem(item),
              ],
            ),
          ],
        ),

        // Right section: Search + Actions
        dom.div(
          classes: 'arcane-header-right',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '16px',
          }),
          [
            // Search
            if (props.showSearch)
              dom.div(
                classes: 'arcane-header-search',
                styles: const dom.Styles(raw: {
                  'position': 'relative',
                }),
                [
                  dom.input(
                    type: dom.InputType.search,
                    attributes: {
                      'placeholder': props.searchPlaceholder,
                    },
                    styles: const dom.Styles(raw: {
                      'padding': '8px 12px 8px 36px',
                      'font-size': 'var(--arcane-font-size-sm)',
                      'background-color': 'var(--muted)',
                      'border': '1px solid var(--border)',
                      'border-radius': 'var(--arcane-radius-sm)',
                      'color': 'var(--foreground)',
                      'width': '200px',
                      'outline': 'none',
                      'transition': 'border-color var(--arcane-transition), width var(--arcane-transition)',
                    }),
                    events: props.onSearch != null
                        ? {
                            'input': (e) {
                              final target = e.target;
                              if (target != null) {
                                final value =
                                    (target as dynamic).value as String? ?? '';
                                props.onSearch!(value);
                              }
                            },
                          }
                        : null,
                  ),
                  // Search icon placeholder
                  const dom.span(
                    styles: dom.Styles(raw: {
                      'position': 'absolute',
                      'left': '12px',
                      'top': '50%',
                      'transform': 'translateY(-50%)',
                      'color': 'var(--muted-foreground)',
                      'font-size': 'var(--arcane-font-size-sm)',
                      'pointer-events': 'none',
                    }),
                    [Component.text('\u{1F50D}')], // Magnifying glass
                  ),
                ],
              ),

            // Actions
            if (props.actions != null) ...props.actions!,
          ],
        ),
      ],
    );
  }

  Component _buildNavItem(NavItemProps item) {
    final bool hasChildren =
        item.children != null && item.children!.isNotEmpty;

    return dom.div(
      classes:
          'arcane-nav-item ${hasChildren ? 'has-dropdown' : ''} ${item.isActive ? 'active' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
      }),
      [
        if (item.href != null)
          dom.a(
            href: item.href!,
            classes: 'arcane-nav-link',
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-1)',
              'padding': '8px 12px',
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': item.isActive
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'text-decoration': 'none',
              'border-radius': 'var(--arcane-radius-sm)',
              'transition': 'color var(--arcane-transition), background-color var(--arcane-transition)',
            }),
            [
              Component.text(item.label),
              if (hasChildren)
                const dom.span(
                  styles: dom.Styles(raw: {'font-size': '10px'}),
                  [Component.text('\u{25BC}')], // Down arrow
                ),
            ],
          )
        else
          dom.button(
            classes: 'arcane-nav-link',
            attributes: {'type': 'button'},
            styles: dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-1)',
              'padding': '8px 12px',
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': item.isActive
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'background': 'none',
              'border': 'none',
              'border-radius': 'var(--arcane-radius-sm)',
              'cursor': 'pointer',
              'transition': 'color var(--arcane-transition), background-color var(--arcane-transition)',
            }),
            events: item.onTap != null ? {'click': (_) => item.onTap!()} : null,
            [
              Component.text(item.label),
              if (hasChildren)
                const dom.span(
                  styles: dom.Styles(raw: {'font-size': '10px'}),
                  [Component.text('\u{25BC}')], // Down arrow
                ),
            ],
          ),
      ],
    );
  }
}

/// ShadCN-style standalone nav link
class ShadcnNavLink extends StatelessComponent {
  final NavLinkProps props;

  const ShadcnNavLink(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final List<Component> content = [
      Component.text(props.label),
      if (props.showArrow)
        const dom.span(
          classes: 'nav-link-arrow',
          styles: dom.Styles(raw: {
            'transition': 'transform var(--arcane-transition)',
          }),
          [Component.text('\u{2192}')], // Right arrow
        ),
    ];

    if (props.href != null) {
      return dom.a(
        href: props.href!,
        classes: 'arcane-nav-link-standalone',
        styles: dom.Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': 'var(--arcane-space-1)',
          'font-size': 'var(--arcane-font-size-sm)',
          'font-weight': 'var(--arcane-font-weight-medium)',
          'color':
              props.isActive ? 'var(--primary)' : 'var(--muted-foreground)',
          'text-decoration': 'none',
          'transition': 'color var(--arcane-transition)',
        }),
        content,
      );
    }

    return dom.button(
      classes: 'arcane-nav-link-standalone',
      attributes: {'type': 'button'},
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-1)',
        'font-size': 'var(--arcane-font-size-sm)',
        'font-weight': 'var(--arcane-font-weight-medium)',
        'color': props.isActive ? 'var(--primary)' : 'var(--muted-foreground)',
        'text-decoration': 'none',
        'transition': 'color var(--arcane-transition)',
        'background': 'none',
        'border': 'none',
        'padding': '0',
        'cursor': 'pointer',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      content,
    );
  }
}