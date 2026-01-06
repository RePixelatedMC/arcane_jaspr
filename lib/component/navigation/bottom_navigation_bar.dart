import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A bottom navigation bar component.
class ArcaneBottomNavigationBar extends StatelessComponent {
  /// The navigation items
  final List<ArcaneBottomNavItem> items;

  /// The currently selected index
  final int selectedIndex;

  /// Callback when selection changes
  final void Function(int index)? onChanged;

  /// Whether to show labels
  final bool showLabels;

  /// Whether to show labels only when selected
  final bool showSelectedLabels;

  /// Height of the navigation bar
  final double height;

  const ArcaneBottomNavigationBar({
    required this.items,
    required this.selectedIndex,
    this.onChanged,
    this.showLabels = true,
    this.showSelectedLabels = false,
    this.height = 64,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return nav(
      classes: 'arcane-bottom-nav',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-around',
        'height': '${height}px',
        'background-color': 'var(--card)',
        'border-top': '1px solid var(--border)',
        'padding': '0 0.5rem',
        'flex-shrink': '0',
      }),
      [
        for (var i = 0; i < items.length; i++)
          _buildItem(context, i, items[i]),
      ],
    );
  }

  Component _buildItem(BuildContext context, int index, ArcaneBottomNavItem item) {
    final bool isSelected = index == selectedIndex;
    final bool shouldShowLabel = showLabels || (showSelectedLabels && isSelected);

    return button(
      classes: 'arcane-bottom-nav-item ${isSelected ? 'selected' : ''}',
      attributes: {
        'type': 'button',
        'aria-selected': '$isSelected',
      },
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.25rem',
        'flex': '1',
        'height': '100%',
        'padding': '0.5rem',
        'background': 'transparent',
        'border': 'none',
        'color': isSelected ? 'var(--accent)' : 'var(--muted-foreground)',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
        'position': 'relative',
      }),
      events: {
        'click': (event) {
          if (onChanged != null) {
            onChanged!(index);
          }
        },
      },
      [
        // Icon container with indicator
        div(
          classes: 'arcane-bottom-nav-icon',
          styles: Styles(raw: {
            'position': 'relative',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '48px',
            'height': '32px',
            'border-radius': '0.5rem',
            'background-color': isSelected ? 'hsl(var(--accent) / 0.1)' : 'transparent',
            'transition': 'all 150ms ease',
          }),
          [
            div(
              styles: const Styles(raw: {
                'width': '24px',
                'height': '24px',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
              }),
              [item.icon],
            ),
            if (item.badge != null)
              span(
                classes: 'arcane-bottom-nav-badge',
                styles: const Styles(raw: {
                  'position': 'absolute',
                  'top': '0',
                  'right': '0.25rem',
                  'min-width': '16px',
                  'height': '16px',
                  'padding': '0 0.25rem',
                  'background-color': 'var(--destructive)',
                  'color': 'var(--destructive-foreground)',
                  'font-size': '0.625rem',
                  'font-weight': '600',
                  'border-radius': '0.25rem',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                }),
                [text(item.badge!)],
              ),
          ],
        ),

        // Label
        if (shouldShowLabel)
          span(
            classes: 'arcane-bottom-nav-label',
            styles: Styles(raw: {
              'font-size': '0.75rem',
              'font-weight': isSelected ? '600' : '500',
              'white-space': 'nowrap',
              'overflow': 'hidden',
              'text-overflow': 'ellipsis',
              'max-width': '100%',
            }),
            [text(item.label)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-bottom-nav-item:hover:not(.selected) .arcane-bottom-nav-icon')
        .styles(raw: {
      'background-color': 'var(--muted)',
    }),
  ];
}

/// A bottom navigation item
class ArcaneBottomNavItem {
  final String label;
  final Component icon;
  final Component? activeIcon;
  final String? badge;

  const ArcaneBottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.badge,
  });
}

/// A fixed position bottom bar container
class ArcaneBottomBar extends StatelessComponent {
  final Component child;
  final bool safeArea;

  const ArcaneBottomBar({
    required this.child,
    this.safeArea = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-bottom-bar',
      styles: Styles(raw: {
        'position': 'fixed',
        'bottom': '0',
        'left': '0',
        'right': '0',
        'z-index': '40',
        if (safeArea) 'padding-bottom': 'env(safe-area-inset-bottom)',
      }),
      [child],
    );
  }
}
