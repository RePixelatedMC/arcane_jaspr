import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/mobile_menu_props.dart';

/// ShadCN Mobile Menu renderer (stateful).
class ShadcnMobileMenu extends StatefulComponent {
  final MobileMenuProps props;

  const ShadcnMobileMenu(this.props, {super.key});

  @override
  State<ShadcnMobileMenu> createState() => _ShadcnMobileMenuState();
}

class _ShadcnMobileMenuState extends State<ShadcnMobileMenu> {
  final Set<int> _expandedItems = {};

  void _toggleExpand(int index) {
    setState(() {
      if (_expandedItems.contains(index)) {
        _expandedItems.remove(index);
      } else {
        _expandedItems.add(index);
      }
    });
  }

  @override
  Component build(BuildContext context) {
    if (!component.props.isOpen) {
      return const dom.div([]);
    }

    return dom.div(
      classes: 'arcane-mobile-menu',
      styles: const dom.Styles(raw: {
        'position': 'fixed',
        'inset': '0',
        'z-index': '1000',
        'display': 'flex',
        'flex-direction': 'column',
        'background-color': 'var(--card)',
        'animation': 'arcane-mobile-menu-slide 0.2s ease-out',
      }),
      [
        // Header
        dom.div(
          classes: 'arcane-mobile-menu-header',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '1rem 20px',
            'border-bottom': '1px solid var(--border)',
          }),
          [
            if (component.props.logo != null)
              component.props.logo!
            else
              const dom.div([]),
            dom.button(
              classes: 'arcane-mobile-menu-close',
              attributes: const {
                'type': 'button',
                'aria-label': 'Close menu',
              },
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'font-size': 'var(--arcane-font-size-2xl)',
                'color': 'var(--muted-foreground)',
                'background': 'none',
                'border': 'none',
                'cursor': 'pointer',
                'transition': 'all var(--arcane-transition)',
              }),
              events: {
                'click': (e) => component.props.onClose?.call(),
              },
              [const Component.text('\u00d7')],
            ),
          ],
        ),

        // Navigation items
        dom.div(
          classes: 'arcane-mobile-menu-nav',
          styles: const dom.Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': '1rem 0',
          }),
          [
            for (var i = 0; i < component.props.items.length; i++)
              _buildNavItem(i, component.props.items[i]),
          ],
        ),

        // Footer with CTA
        if (component.props.cta != null)
          dom.div(
            classes: 'arcane-mobile-menu-footer',
            styles: const dom.Styles(raw: {
              'padding': '20px',
              'border-top': '1px solid var(--border)',
            }),
            [component.props.cta!],
          ),
      ],
    );
  }

  Component _buildNavItem(int index, MobileNavItem item) {
    final bool hasChildren =
        item.children != null && item.children!.isNotEmpty;
    final bool isExpanded = _expandedItems.contains(index);

    return dom.div(
      classes: 'arcane-mobile-nav-item',
      [
        // Main item
        if (hasChildren)
          dom.button(
            classes: 'arcane-mobile-nav-button',
            attributes: const {'type': 'button'},
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': 'var(--arcane-font-size-base)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': 'var(--foreground)',
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': 'all var(--arcane-transition)',
            }),
            events: {
              'click': (e) => _toggleExpand(index),
            },
            [
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': 'var(--arcane-space-2)',
                }),
                [
                  if (item.icon != null) item.icon!,
                  Component.text(item.label),
                ],
              ),
              dom.span(
                [const Component.text('\u25bc')],
                styles: dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                  'transition': 'all var(--arcane-transition)',
                }),
              ),
            ],
          )
        else if (item.href != null)
          dom.a(
            href: item.href!,
            classes: 'arcane-mobile-nav-link',
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-2)',
              'padding': '14px 20px',
              'font-size': 'var(--arcane-font-size-base)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': 'var(--foreground)',
              'text-decoration': 'none',
              'transition': 'all var(--arcane-transition)',
            }),
            [
              if (item.icon != null) item.icon!,
              Component.text(item.label),
            ],
          )
        else
          dom.button(
            classes: 'arcane-mobile-nav-button',
            attributes: const {'type': 'button'},
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--arcane-space-2)',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': 'var(--arcane-font-size-base)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': 'var(--foreground)',
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': 'all var(--arcane-transition)',
            }),
            events: {
              if (item.onTap != null) 'click': (e) => item.onTap!(),
            },
            [
              if (item.icon != null) item.icon!,
              Component.text(item.label),
            ],
          ),

        // Children
        if (hasChildren && isExpanded)
          dom.div(
            classes: 'arcane-mobile-nav-children',
            styles: const dom.Styles(raw: {
              'background-color': 'var(--muted)',
              'padding': '0.5rem 0',
            }),
            [
              for (final child in item.children!)
                if (child.href != null)
                  dom.a(
                    href: child.href!,
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': 'var(--arcane-space-2)',
                      'padding': '0.5rem 20px 0.5rem 44px',
                      'font-size': 'var(--arcane-font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'text-decoration': 'none',
                      'transition': 'all var(--arcane-transition)',
                    }),
                    [
                      if (child.icon != null) child.icon!,
                      Component.text(child.label),
                    ],
                  )
                else
                  dom.button(
                    attributes: const {'type': 'button'},
                    styles: const dom.Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': 'var(--arcane-space-2)',
                      'width': '100%',
                      'padding': '0.5rem 20px 0.5rem 44px',
                      'font-size': 'var(--arcane-font-size-sm)',
                      'color': 'var(--muted-foreground)',
                      'background': 'none',
                      'border': 'none',
                      'cursor': 'pointer',
                      'text-align': 'left',
                      'transition': 'all var(--arcane-transition)',
                    }),
                    events: {
                      if (child.onTap != null) 'click': (e) => child.onTap!(),
                    },
                    [
                      if (child.icon != null) child.icon!,
                      Component.text(child.label),
                    ],
                  ),
            ],
          ),
      ],
    );
  }
}

/// ShadCN Hamburger Button renderer.
class ShadcnHamburgerButton extends StatelessComponent {
  final HamburgerButtonProps props;

  const ShadcnHamburgerButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.button(
      classes: 'arcane-hamburger ${props.isOpen ? 'open' : ''}',
      attributes: {
        'type': 'button',
        'aria-label': props.isOpen ? 'Close menu' : 'Open menu',
        'aria-expanded': props.isOpen.toString(),
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'align-items': 'center',
        'gap': '5px',
        'width': '${props.size + 16}px',
        'height': '${props.size + 16}px',
        'padding': '0.5rem',
        'background': 'none',
        'border': 'none',
        'cursor': 'pointer',
      }),
      events: {
        if (props.onTap != null) 'click': (e) => props.onTap!(),
      },
      [
        dom.span(
          [],
          classes: 'arcane-hamburger-line',
          styles: dom.Styles(raw: {
            'display': 'block',
            'width': '${props.size}px',
            'height': '2px',
            'background-color': 'var(--foreground)',
            'border-radius': '1px',
            'transition': 'all var(--arcane-transition)',
            if (props.isOpen) 'transform': 'translateY(7px) rotate(45deg)',
          }),
        ),
        dom.span(
          [],
          classes: 'arcane-hamburger-line',
          styles: dom.Styles(raw: {
            'display': 'block',
            'width': '${props.size}px',
            'height': '2px',
            'background-color': 'var(--foreground)',
            'border-radius': '1px',
            'transition': 'all var(--arcane-transition)',
            if (props.isOpen) 'opacity': '0',
          }),
        ),
        dom.span(
          [],
          classes: 'arcane-hamburger-line',
          styles: dom.Styles(raw: {
            'display': 'block',
            'width': '${props.size}px',
            'height': '2px',
            'background-color': 'var(--foreground)',
            'border-radius': '1px',
            'transition': 'all var(--arcane-transition)',
            if (props.isOpen) 'transform': 'translateY(-7px) rotate(-45deg)',
          }),
        ),
      ],
    );
  }
}
