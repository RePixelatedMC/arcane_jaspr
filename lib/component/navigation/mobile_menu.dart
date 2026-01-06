import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Mobile navigation item
class ArcaneMobileNavItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final List<ArcaneMobileNavItem>? children;
  final Component? icon;

  const ArcaneMobileNavItem({
    required this.label,
    this.href,
    this.onTap,
    this.children,
    this.icon,
  });
}

/// A mobile hamburger menu (Supabase-style)
class ArcaneMobileMenu extends StatefulComponent {
  /// Navigation items
  final List<ArcaneMobileNavItem> items;

  /// Optional logo
  final Component? logo;

  /// Optional CTA button
  final Component? cta;

  /// Close callback
  final void Function()? onClose;

  /// Whether the menu is open
  final bool isOpen;

  const ArcaneMobileMenu({
    required this.items,
    this.logo,
    this.cta,
    this.onClose,
    this.isOpen = false,
    super.key,
  });

  @override
  State<ArcaneMobileMenu> createState() => _ArcaneMobileMenuState();

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-mobile-menu-slide').styles(raw: {
      '0%': 'opacity: 0; transform: translateX(-100%)',
      '100%': 'opacity: 1; transform: translateX(0)',
    }),
    css('.arcane-mobile-menu-close:hover').styles(raw: {
      'color': 'var(--foreground)',
    }),
    css('.arcane-mobile-nav-button:hover').styles(raw: {
      'background-color': 'var(--muted)',
    }),
    css('.arcane-mobile-nav-link:hover').styles(raw: {
      'background-color': 'var(--muted)',
    }),
    css('.arcane-mobile-nav-children a:hover').styles(raw: {
      'color': 'var(--foreground)',
    }),
    css('.arcane-mobile-nav-children button:hover').styles(raw: {
      'color': 'var(--foreground)',
    }),
  ];
}

class _ArcaneMobileMenuState extends State<ArcaneMobileMenu> {
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
    if (!component.isOpen) {
      return const div([]);
    }

    return div(
      classes: 'arcane-mobile-menu',
      styles: const Styles(raw: {
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
        div(
          classes: 'arcane-mobile-menu-header',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '1rem 20px',
            'border-bottom': '1px solid var(--border)',
          }),
          [
            if (component.logo != null) component.logo! else const div([]),
            button(
              classes: 'arcane-mobile-menu-close',
              attributes: {
                'type': 'button',
                'aria-label': 'Close menu',
              },
              styles: const Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'font-size': '1.5rem',
                'color': 'var(--muted-foreground)',
                'background': 'none',
                'border': 'none',
                'cursor': 'pointer',
                'transition': 'all 150ms ease',
              }),
              events: {
                'click': (e) => component.onClose?.call(),
              },
              [text('\u00d7')],
            ),
          ],
        ),

        // Navigation items
        div(
          classes: 'arcane-mobile-menu-nav',
          styles: const Styles(raw: {
            'flex': '1',
            'overflow-y': 'auto',
            'padding': '1rem 0',
          }),
          [
            for (var i = 0; i < component.items.length; i++)
              _buildNavItem(i, component.items[i]),
          ],
        ),

        // Footer with CTA
        if (component.cta != null)
          div(
            classes: 'arcane-mobile-menu-footer',
            styles: const Styles(raw: {
              'padding': '20px',
              'border-top': '1px solid var(--border)',
            }),
            [component.cta!],
          ),
      ],
    );
  }

  Component _buildNavItem(int index, ArcaneMobileNavItem item) {
    final bool hasChildren = item.children != null && item.children!.isNotEmpty;
    final bool isExpanded = _expandedItems.contains(index);

    return div(
      classes: 'arcane-mobile-nav-item',
      [
        // Main item
        if (hasChildren)
          button(
            classes: 'arcane-mobile-nav-button',
            attributes: {'type': 'button'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': '1rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': 'all 150ms ease',
            }),
            events: {
              'click': (e) => _toggleExpand(index),
            },
            [
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': '0.5rem',
                }),
                [
                  if (item.icon != null) item.icon!,
                  text(item.label),
                ],
              ),
              span(
                [text('\u25bc')],
                styles: Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--muted-foreground)',
                  'transform': isExpanded ? 'rotate(180deg)' : 'rotate(0deg)',
                  'transition': 'all 150ms ease',
                }),
              ),
            ],
          )
        else if (item.href != null)
          a(
            href: item.href!,
            classes: 'arcane-mobile-nav-link',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.5rem',
              'padding': '14px 20px',
              'font-size': '1rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
              'text-decoration': 'none',
              'transition': 'all 150ms ease',
            }),
            [
              if (item.icon != null) item.icon!,
              text(item.label),
            ],
          )
        else
          button(
            classes: 'arcane-mobile-nav-button',
            attributes: {'type': 'button'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.5rem',
              'width': '100%',
              'padding': '14px 20px',
              'font-size': '1rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
              'background': 'none',
              'border': 'none',
              'cursor': 'pointer',
              'text-align': 'left',
              'transition': 'all 150ms ease',
            }),
            events: {
              if (item.onTap != null) 'click': (e) => item.onTap!(),
            },
            [
              if (item.icon != null) item.icon!,
              text(item.label),
            ],
          ),

        // Children
        if (hasChildren && isExpanded)
          div(
            classes: 'arcane-mobile-nav-children',
            styles: const Styles(raw: {
              'background-color': 'var(--muted)',
              'padding': '0.5rem 0',
            }),
            [
              for (final child in item.children!)
                if (child.href != null)
                  a(
                    href: child.href!,
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '0.5rem',
                      'padding': '0.5rem 20px 0.5rem 44px',
                      'font-size': '0.875rem',
                      'color': 'var(--muted-foreground)',
                      'text-decoration': 'none',
                      'transition': 'all 150ms ease',
                    }),
                    [
                      if (child.icon != null) child.icon!,
                      text(child.label),
                    ],
                  )
                else
                  button(
                    attributes: {'type': 'button'},
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'gap': '0.5rem',
                      'width': '100%',
                      'padding': '0.5rem 20px 0.5rem 44px',
                      'font-size': '0.875rem',
                      'color': 'var(--muted-foreground)',
                      'background': 'none',
                      'border': 'none',
                      'cursor': 'pointer',
                      'text-align': 'left',
                      'transition': 'all 150ms ease',
                    }),
                    events: {
                      if (child.onTap != null) 'click': (e) => child.onTap!(),
                    },
                    [
                      if (child.icon != null) child.icon!,
                      text(child.label),
                    ],
                  ),
            ],
          ),
      ],
    );
  }
}

/// Hamburger menu button
class ArcaneHamburgerButton extends StatelessComponent {
  /// Whether the menu is open
  final bool isOpen;

  /// Click handler
  final void Function()? onTap;

  /// Size
  final double size;

  const ArcaneHamburgerButton({
    this.isOpen = false,
    this.onTap,
    this.size = 24,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-hamburger ${isOpen ? 'open' : ''}',
      attributes: {
        'type': 'button',
        'aria-label': isOpen ? 'Close menu' : 'Open menu',
        'aria-expanded': isOpen.toString(),
      },
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'align-items': 'center',
        'gap': '5px',
        'width': '${size + 16}px',
        'height': '${size + 16}px',
        'padding': '0.5rem',
        'background': 'none',
        'border': 'none',
        'cursor': 'pointer',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        span(
          [],
          classes: 'arcane-hamburger-line',
          styles: Styles(raw: {
            'display': 'block',
            'width': '${size}px',
            'height': '2px',
            'background-color': 'var(--foreground)',
            'border-radius': '1px',
            'transition': 'all 150ms ease',
            if (isOpen) 'transform': 'translateY(7px) rotate(45deg)',
          }),
        ),
        span(
          [],
          classes: 'arcane-hamburger-line',
          styles: Styles(raw: {
            'display': 'block',
            'width': '${size}px',
            'height': '2px',
            'background-color': 'var(--foreground)',
            'border-radius': '1px',
            'transition': 'all 150ms ease',
            if (isOpen) 'opacity': '0',
          }),
        ),
        span(
          [],
          classes: 'arcane-hamburger-line',
          styles: Styles(raw: {
            'display': 'block',
            'width': '${size}px',
            'height': '2px',
            'background-color': 'var(--foreground)',
            'border-radius': '1px',
            'transition': 'all 150ms ease',
            if (isOpen) 'transform': 'translateY(-7px) rotate(-45deg)',
          }),
        ),
      ],
    );
  }
}
