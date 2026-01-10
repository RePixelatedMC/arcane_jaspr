import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/bottom_navigation_props.dart';

/// ShadCN Bottom Navigation Bar renderer.
class ShadcnBottomNavigationBar extends StatelessComponent {
  final BottomNavigationBarProps props;

  const ShadcnBottomNavigationBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.nav(
      classes: 'arcane-bottom-nav',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-around',
        'height': '${props.height}px',
        'background-color': 'var(--card)',
        'border-top': '1px solid var(--border)',
        'padding': '0 0.5rem',
        'flex-shrink': '0',
      }),
      [
        for (var i = 0; i < props.items.length; i++)
          _buildItem(context, i, props.items[i]),
      ],
    );
  }

  Component _buildItem(
      BuildContext context, int index, BottomNavItem item) {
    final bool isSelected = index == props.selectedIndex;
    final bool shouldShowLabel =
        props.showLabels || (props.showSelectedLabels && isSelected);

    return dom.button(
      classes: 'arcane-bottom-nav-item ${isSelected ? 'selected' : ''}',
      attributes: {
        'type': 'button',
        'aria-selected': '$isSelected',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': 'var(--arcane-space-1)',
        'flex': '1',
        'height': '100%',
        'padding': '0.5rem',
        'background': 'transparent',
        'border': 'none',
        'color': isSelected ? 'var(--accent)' : 'var(--muted-foreground)',
        'cursor': 'pointer',
        'transition': 'all var(--arcane-transition)',
        'position': 'relative',
      }),
      events: {
        'click': (event) {
          if (props.onChanged != null) {
            props.onChanged!(index);
          }
        },
      },
      [
        // Icon container with indicator
        dom.div(
          classes: 'arcane-bottom-nav-icon',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '32px',
            'border-radius': 'var(--arcane-radius-md)',
            'background-color':
                isSelected ? 'color-mix(in srgb, var(--accent) 10%, transparent)' : 'transparent',
            'transition': 'all var(--arcane-transition)',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'width': '24px',
                'height': '24px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
              }),
              [item.icon],
            ),
            if (item.badge != null)
              dom.span(
                classes: 'arcane-bottom-nav-badge',
                styles: const dom.Styles(raw: {
                  'position': 'absolute',
                  'top': '0',
                  'right': '0.25rem',
                  'min-width': '16px',
                  'height': '16px',
                  'padding': '0 0.25rem',
                  'background-color': 'var(--destructive)',
                  'color': 'var(--destructive-foreground)',
                  'font-size': '0.625rem',
                  'font-weight': 'var(--arcane-font-weight-semibold)',
                  'border-radius': 'var(--arcane-radius-xs)',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                }),
                [Component.text(item.badge!)],
              ),
          ],
        ),

        // Label
        if (shouldShowLabel)
          dom.span(
            classes: 'arcane-bottom-nav-label',
            styles: dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'font-weight': isSelected ? '600' : '500',
              'white-space': 'nowrap',
              'overflow': 'hidden',
              'text-overflow': 'ellipsis',
              'max-width': '100%',
            }),
            [Component.text(item.label)],
          ),
      ],
    );
  }
}

/// ShadCN Bottom Bar renderer.
class ShadcnBottomBar extends StatelessComponent {
  final BottomBarProps props;

  const ShadcnBottomBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-bottom-bar',
      styles: dom.Styles(raw: {
        'position': 'fixed',
        'bottom': '0',
        'left': '0',
        'right': '0',
        'z-index': '40',
        if (props.safeArea) 'padding-bottom': 'env(safe-area-inset-bottom)',
      }),
      [props.child],
    );
  }
}
