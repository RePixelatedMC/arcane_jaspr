import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';

export '../../core/props/dropdown_menu_props.dart' show DropdownAlignment;

/// A dropdown menu item
class ArcaneDropdownItem {
  final String label;
  final String? href;
  final void Function()? onTap;
  final Component? icon;
  final String? description;
  final bool disabled;
  final bool divider;

  const ArcaneDropdownItem({
    required this.label,
    this.href,
    this.onTap,
    this.icon,
    this.description,
    this.disabled = false,
    this.divider = false,
  });

  /// Create a divider item
  const ArcaneDropdownItem.divider()
      : label = '',
        href = null,
        onTap = null,
        icon = null,
        description = null,
        disabled = false,
        divider = true;
}

/// A dropdown menu component matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/dropdown-menu
class ArcaneDropdownMenu extends StatefulComponent {
  /// Trigger element
  final Component trigger;

  /// Menu items
  final List<ArcaneDropdownItem> items;

  /// Alignment
  final DropdownAlignment alignment;

  /// Width
  final double? width;

  const ArcaneDropdownMenu({
    required this.trigger,
    required this.items,
    this.alignment = DropdownAlignment.left,
    this.width,
    super.key,
  });

  @override
  State<ArcaneDropdownMenu> createState() => _ArcaneDropdownMenuState();
}

class _ArcaneDropdownMenuState extends State<ArcaneDropdownMenu> {
  bool _isOpen = false;

  void _toggle() {
    setState(() => _isOpen = !_isOpen);
  }

  void _close() {
    setState(() => _isOpen = false);
  }

  @override
  Component build(BuildContext context) {
    // Convert ArcaneDropdownItem to DropdownItemProps
    final List<DropdownItemProps> itemProps = component.items
        .map((item) => DropdownItemProps(
              label: item.label,
              href: item.href,
              onTap: item.onTap,
              icon: item.icon,
              description: item.description,
              disabled: item.disabled,
              divider: item.divider,
            ))
        .toList();

    // Delegate rendering to the current stylesheet's dropdown menu renderer
    return context.renderers.dropdownMenu(DropdownMenuProps(
      trigger: component.trigger,
      items: itemProps,
      isOpen: _isOpen,
      onToggle: _toggle,
      onClose: _close,
      alignment: component.alignment,
      width: component.width,
    ));
  }
}

/// A navigation dropdown with mega-menu style
class ArcaneMegaMenu extends StatefulComponent {
  /// Trigger label
  final String label;

  /// Menu sections
  final List<ArcaneMegaMenuSection> sections;

  /// Footer content
  final Component? footer;

  const ArcaneMegaMenu({
    required this.label,
    required this.sections,
    this.footer,
    super.key,
  });

  @override
  State<ArcaneMegaMenu> createState() => _ArcaneMegaMenuState();
}

/// A section in a mega menu
class ArcaneMegaMenuSection {
  final String? title;
  final List<ArcaneDropdownItem> items;

  const ArcaneMegaMenuSection({
    this.title,
    required this.items,
  });
}

class _ArcaneMegaMenuState extends State<ArcaneMegaMenu> {
  bool _isOpen = false;

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-mega-menu ${_isOpen ? 'open' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
      }),
      events: {
        'mouseenter': (e) => setState(() => _isOpen = true),
        'mouseleave': (e) => setState(() => _isOpen = false),
      },
      [
        // Trigger
        dom.button(
          classes: 'arcane-mega-menu-trigger',
          attributes: {'type': 'button'},
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.25rem',
            'padding': '8px 12px',
            'font-size': '0.875rem',
            'font-weight': '500',
            'color': _isOpen ? 'var(--foreground)' : 'var(--muted-foreground)',
            'background': 'none',
            'border': 'none',
            'cursor': 'pointer',
            'transition': 'color 150ms ease',
          }),
          [
            Component.text(component.label),
            dom.span(
              styles: dom.Styles(raw: {
                'font-size': '0.75rem',
                'transform': _isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
                'transition': 'transform 150ms ease',
              }),
              [Component.text('\u25BC')],
            ),
          ],
        ),

        // Menu panel
        if (_isOpen)
          dom.div(
            classes: 'arcane-mega-menu-panel',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '50%',
              'transform': 'translateX(-50%)',
              'z-index': '100',
              'margin-top': '0.5rem',
              'padding': '1rem',
              'background-color': 'var(--popover)',
              'border': '1px solid var(--border)',
              'border-radius': '0.375rem',
              'box-shadow': '0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1)',
              'display': 'flex',
              'gap': '2rem',
              'animation': 'arcane-dropdown-fade 0.15s ease-out',
            }),
            [
              for (final section in component.sections)
                dom.div(
                  classes: 'arcane-mega-menu-section',
                  styles: const dom.Styles(raw: {
                    'min-width': '180px',
                  }),
                  [
                    if (section.title != null)
                      dom.div(
                        styles: const dom.Styles(raw: {
                          'font-size': '0.75rem',
                          'font-weight': '600',
                          'text-transform': 'uppercase',
                          'letter-spacing': '0.05em',
                          'color': 'var(--muted-foreground)',
                          'margin-bottom': '0.5rem',
                        }),
                        [Component.text(section.title!)],
                      ),
                    dom.div(
                      styles: const dom.Styles(raw: {
                        'display': 'flex',
                        'flex-direction': 'column',
                        'gap': '0.25rem',
                      }),
                      [
                        for (final item in section.items)
                          _buildMegaItem(item),
                      ],
                    ),
                  ],
                ),
              if (component.footer != null)
                dom.div(
                  classes: 'arcane-mega-menu-footer',
                  styles: const dom.Styles(raw: {
                    'padding-left': '1rem',
                    'border-left': '1px solid var(--border)',
                  }),
                  [component.footer!],
                ),
            ],
          ),
      ],
    );
  }

  Component _buildMegaItem(ArcaneDropdownItem item) {
    final Component itemContent = dom.div(
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.5rem',
      }),
      [
        if (item.icon != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'flex-shrink': '0',
              'margin-top': '2px',
            }),
            [item.icon!],
          ),
        dom.div([
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
            }),
            [Component.text(item.label)],
          ),
          if (item.description != null)
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': '0.75rem',
                'color': 'var(--muted-foreground)',
                'margin-top': '2px',
              }),
              [Component.text(item.description!)],
            ),
        ]),
      ],
    );

    if (item.href != null) {
      return dom.a(
        href: item.href!,
        classes: 'arcane-mega-menu-item',
        styles: const dom.Styles(raw: {
          'display': 'block',
          'padding': '10px 0.5rem',
          'text-decoration': 'none',
          'border-radius': '0.25rem',
          'transition': 'background-color 150ms ease',
        }),
        [itemContent],
      );
    }

    return dom.button(
      classes: 'arcane-mega-menu-item',
      attributes: {'type': 'button'},
      styles: const dom.Styles(raw: {
        'display': 'block',
        'width': '100%',
        'padding': '10px 0.5rem',
        'text-align': 'left',
        'background': 'none',
        'border': 'none',
        'border-radius': '0.25rem',
        'cursor': 'pointer',
        'transition': 'background-color 150ms ease',
      }),
      events: {
        if (item.onTap != null) 'click': (e) => item.onTap!(),
      },
      [itemContent],
    );
  }
}