import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/bottom_navigation_props.dart';
import '../../../core/props/mobile_menu_props.dart';

/// Codex BottomNavigationBar renderer.
class CodexBottomNavigationBar extends StatelessComponent {
  final BottomNavigationBarProps props;

  const CodexBottomNavigationBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.nav(
      classes: 'codex-bottom-navigation-bar',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-around',
        'height': '${props.height}px',
        'background-color': 'var(--card)',
        'border-top': '1px solid var(--border)',
        'padding': '0 0.5rem',
      }),
      [
        for (int i = 0; i < props.items.length; i++)
          _buildNavItem(props.items[i], i, props.selectedIndex == i),
      ],
    );
  }

  Component _buildNavItem(BottomNavItem item, int index, bool isSelected) {
    final bool showLabel = props.showLabels ||
        (props.showSelectedLabels && isSelected);

    return dom.button(
      classes: 'codex-bottom-nav-item ${isSelected ? 'selected' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.25rem',
        'flex': '1',
        'padding': '0.5rem',
        'background': 'none',
        'border': 'none',
        'cursor': 'pointer',
        'color': isSelected
            ? 'var(--codex-accent)'
            : 'var(--muted-foreground)',
        'transition': 'color 150ms ease',
      }),
      events: props.onChanged != null
          ? {'click': (_) => props.onChanged!(index)}
          : null,
      [
        // Icon with optional badge
        dom.div(
          classes: 'codex-bottom-nav-icon',
          styles: const dom.Styles(raw: {
            'position': 'relative',
          }),
          [
            isSelected && item.activeIcon != null
                ? item.activeIcon!
                : item.icon,
            if (item.badge != null)
              dom.span(
                classes: 'codex-bottom-nav-badge',
                styles: const dom.Styles(raw: {
                  'position': 'absolute',
                  'top': '-4px',
                  'right': '-8px',
                  'min-width': '16px',
                  'height': '16px',
                  'padding': '0 4px',
                  'font-size': '0.625rem',
                  'font-weight': '600',
                  'color': '#ffffff',
                  'background-color': 'var(--destructive)',
                  'border-radius': '9999px',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                }),
                [Component.text(item.badge!)],
              ),
          ],
        ),

        // Label
        if (showLabel)
          dom.span(
            classes: 'codex-bottom-nav-label',
            styles: dom.Styles(raw: {
              'font-size': '0.6875rem',
              'font-weight': isSelected ? '500' : '400',
            }),
            [Component.text(item.label)],
          ),
      ],
    );
  }
}

/// Codex BottomBar renderer.
class CodexBottomBar extends StatelessComponent {
  final BottomBarProps props;

  const CodexBottomBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-bottom-bar',
      styles: dom.Styles(raw: {
        'position': 'fixed',
        'bottom': '0',
        'left': '0',
        'right': '0',
        'z-index': '50',
        if (props.safeArea)
          'padding-bottom': 'env(safe-area-inset-bottom, 0px)',
      }),
      [props.child],
    );
  }
}

/// Codex HamburgerButton renderer.
class CodexHamburgerButton extends StatelessComponent {
  final HamburgerButtonProps props;

  const CodexHamburgerButton(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.button(
      classes: 'codex-hamburger-button ${props.isOpen ? 'open' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'justify-content': 'center',
        'align-items': 'center',
        'gap': '4px',
        'width': '${props.size}px',
        'height': '${props.size}px',
        'padding': '4px',
        'background': 'none',
        'border': 'none',
        'cursor': 'pointer',
      }),
      events: props.onTap != null ? {'click': (_) => props.onTap!()} : null,
      [
        for (int i = 0; i < 3; i++)
          dom.span(
            styles: dom.Styles(raw: {
              'width': '${props.size - 8}px',
              'height': '2px',
              'background-color': 'var(--foreground)',
              'border-radius': '1px',
              'transition': 'all 150ms ease',
            }),
            [],
          ),
      ],
    );
  }
}
