import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/header_props.dart';

/// Codex Header/Navbar renderer.
///
/// Implements the Codex design language:
/// - Larger height and padding
/// - OLED-first with subtle border
/// - Accent-colored active states
class CodexHeader extends StatelessComponent {
  final HeaderProps props;

  const CodexHeader(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.header(
      classes: 'codex-header ${props.sticky ? 'sticky' : ''} ${props.transparent ? 'transparent' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'position': props.sticky ? 'sticky' : 'relative',
        // Codex: larger height
        'height': '72px',
        'padding': '0 2rem', // Codex: more horizontal padding
        // Frosted glass effect with semi-transparent background
        'background-color': props.transparent
            ? 'transparent'
            : 'rgba(var(--arcane-card-rgb, 10, 10, 10), 0.75)',
        if (props.bordered) 'border-bottom': '1px solid var(--border)',
        'top': '0',
        'z-index': '50',
        // Frosted glass blur
        'backdrop-filter': 'blur(12px)',
        '-webkit-backdrop-filter': 'blur(12px)',
        'transition': 'all var(--transition)',
      }),
      [
        // Left section: logo (fixed width to allow center nav to be truly centered)
        dom.div(
          classes: 'codex-header-logo',
          styles: const dom.Styles(raw: {
            'flex-shrink': '0',
            'min-width': '200px', // Fixed width to balance with actions
          }),
          [props.logo],
        ),

        // Center section: navigation (flex-grow to center)
        dom.nav(
          classes: 'codex-header-nav',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'gap': 'var(--arcane-space-2)', // Codex: more gap
            'flex-grow': '1', // Allow nav to grow and center
          }),
          [
            for (final item in props.navItems)
              _buildNavItem(item),
          ],
        ),

        // Right section: search and actions (fixed width to match logo)
        dom.div(
          classes: 'codex-header-actions',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'flex-end',
            'gap': '0.75rem', // Codex: more gap
            'flex-shrink': '0',
            'min-width': '200px', // Match logo width for balance
          }),
          [
            if (props.showSearch)
              _buildSearch(),
            if (props.actions != null)
              ...props.actions!,
          ],
        ),
      ],
    );
  }

  Component _buildNavItem(NavItemProps item) {
    final bool hasDropdown = item.children != null && item.children!.isNotEmpty;

    return dom.div(
      classes: 'codex-nav-item ${item.isActive ? 'active' : ''}',
      styles: const dom.Styles(raw: {
        'position': 'relative',
      }),
      [
        if (item.href != null)
          dom.a(
            href: item.href!,
            classes: 'codex-nav-link',
            styles: dom.Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'gap': '0.375rem',
              // Codex: larger padding
              'padding': '0.625rem 1rem',
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': item.isActive ? '600' : '500',
              'color': item.isActive
                  ? 'var(--codex-accent)'
                  : 'var(--muted-foreground)',
              'text-decoration': 'none',
              'border-radius': 'var(--radius-md)',
              'transition': 'all var(--transition)',
              // Codex: subtle background on hover
              'background-color': item.isActive
                  ? 'rgba(var(--codex-accent-rgb), 0.1)'
                  : 'transparent',
            }),
            [
              Component.text(item.label),
              if (hasDropdown)
                const dom.span(
                  styles: dom.Styles(raw: {'font-size': '0.625rem'}),
                  [Component.text('\u25BC')], // Down arrow
                ),
            ],
          )
        else
          dom.button(
            classes: 'codex-nav-button',
            styles: dom.Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'gap': '0.375rem',
              'padding': '0.625rem 1rem',
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': item.isActive ? '600' : '500',
              'color': item.isActive
                  ? 'var(--codex-accent)'
                  : 'var(--muted-foreground)',
              'background': 'transparent',
              'border': 'none',
              'border-radius': 'var(--radius-md)',
              'cursor': 'pointer',
              'transition': 'all var(--transition)',
            }),
            events: item.onTap == null ? null : {'click': (_) => item.onTap!()},
            [
              Component.text(item.label),
              if (hasDropdown)
                const dom.span(
                  styles: dom.Styles(raw: {'font-size': '0.625rem'}),
                  [Component.text('\u25BC')],
                ),
            ],
          ),
      ],
    );
  }

  Component _buildSearch() {
    return dom.div(
      classes: 'codex-header-search',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
      }),
      [
        dom.input(
          type: dom.InputType.text,
          attributes: {
            'placeholder': props.searchPlaceholder,
          },
          styles: const dom.Styles(raw: {
            // Codex: larger input
            'height': '40px',
            'padding': '0 1rem 0 2.5rem',
            'background-color': 'var(--input)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'font-size': 'var(--arcane-font-size-sm)',
            'color': 'var(--foreground)',
            'outline': 'none',
            'min-width': '200px',
            'transition': 'all var(--transition)',
          }),
          events: props.onSearch == null
              ? null
              : {
                  'input': (e) {
                    final dynamic target = e.target;
                    final String? value = target?.value;
                    if (value != null) props.onSearch!(value);
                  },
                },
        ),
        // Search icon placeholder
        const dom.span(
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'left': '0.75rem',
            'color': 'var(--muted-foreground)',
            'font-size': 'var(--arcane-font-size-sm)',
            'pointer-events': 'none',
          }),
          [Component.text('\u{1F50D}')], // Magnifying glass
        ),
      ],
    );
  }
}

/// Codex Nav Link renderer.
class CodexNavLink extends StatelessComponent {
  final NavLinkProps props;

  const CodexNavLink(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final Component content = dom.span(
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
      }),
      [
        Component.text(props.label),
        if (props.showArrow)
          const dom.span(
            styles: dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'transition': 'transform var(--transition)',
            }),
            [Component.text('\u2192')], // Right arrow
          ),
      ],
    );

    if (props.href != null) {
      return dom.a(
        href: props.href!,
        classes: 'codex-nav-link ${props.isActive ? 'active' : ''}',
        styles: dom.Styles(raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'font-size': 'var(--arcane-font-size-sm)',
          'font-weight': props.isActive ? '600' : '500',
          'color': props.isActive
              ? 'var(--codex-accent)'
              : 'var(--muted-foreground)',
          'text-decoration': 'none',
          'transition': 'all var(--transition)',
        }),
        [content],
      );
    }

    return dom.button(
      classes: 'codex-nav-link ${props.isActive ? 'active' : ''}',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'background': 'transparent',
        'border': 'none',
        'padding': '0',
        'font-size': 'var(--arcane-font-size-sm)',
        'font-weight': props.isActive ? '600' : '500',
        'color': props.isActive
            ? 'var(--codex-accent)'
            : 'var(--muted-foreground)',
        'cursor': 'pointer',
        'transition': 'all var(--transition)',
      }),
      events: props.onTap == null ? null : {'click': (_) => props.onTap!()},
      [content],
    );
  }
}