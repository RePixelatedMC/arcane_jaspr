import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../navigation/bottom_navigation_bar.dart';
import '../navigation/sidebar.dart';

/// Screen with built-in navigation (sidebar or bottom nav).
class ArcaneNavigationScreen extends StatefulComponent {
  final List<ArcaneNavigationDestination> destinations;
  final int initialIndex;
  final void Function(int index)? onNavigationChanged;
  final NavigationMode mode;
  final double breakpoint;
  final Component? sidebarHeader;
  final Component? sidebarFooter;
  final bool sidebarCollapsible;
  final bool sidebarCollapsed;

  const ArcaneNavigationScreen({
    required this.destinations,
    this.initialIndex = 0,
    this.onNavigationChanged,
    this.mode = NavigationMode.auto,
    this.breakpoint = 768,
    this.sidebarHeader,
    this.sidebarFooter,
    this.sidebarCollapsible = true,
    this.sidebarCollapsed = false,
    super.key,
  });

  @override
  State<ArcaneNavigationScreen> createState() => _ArcaneNavigationScreenState();
}

class _ArcaneNavigationScreenState extends State<ArcaneNavigationScreen> {
  late int _selectedIndex;
  late bool _sidebarCollapsed;

  @override
  void initState() {
    super.initState();
    _selectedIndex = component.initialIndex;
    _sidebarCollapsed = component.sidebarCollapsed;
  }

  void _selectDestination(int index) {
    if (index != _selectedIndex && index < component.destinations.length) {
      setState(() {
        _selectedIndex = index;
      });
      component.onNavigationChanged?.call(index);
    }
  }

  void _toggleSidebar(bool collapsed) {
    setState(() {
      _sidebarCollapsed = collapsed;
    });
  }

  @override
  Component build(BuildContext context) {
    final ArcaneNavigationDestination destination = _selectedIndex < component.destinations.length
        ? component.destinations[_selectedIndex]
        : component.destinations.first;

    final bool useBottomNav = component.mode == NavigationMode.bottom;
    final bool useSidebar = component.mode == NavigationMode.sidebar ||
        component.mode == NavigationMode.auto;

    return div(
      classes: 'arcane-navigation-screen',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'height': '100vh',
        'background-color': 'var(--background)',
      }),
      [
        div(
          classes: 'arcane-navigation-screen-body',
          styles: const Styles(raw: {
            'display': 'flex',
            'flex': '1',
            'min-height': '0',
          }),
          [
            if (useSidebar)
              ArcaneSidebar(
                header: component.sidebarHeader,
                footer: component.sidebarFooter,
                collapsed: _sidebarCollapsed,
                onCollapseChanged:
                    component.sidebarCollapsible ? _toggleSidebar : null,
                showCollapseToggle: component.sidebarCollapsible,
                children: [
                  for (int i = 0; i < component.destinations.length; i++)
                    ArcaneSidebarItem(
                      label: component.destinations[i].label,
                      icon: component.destinations[i].icon,
                      selected: i == _selectedIndex,
                      onTap: () => _selectDestination(i),
                      collapsed: _sidebarCollapsed,
                    ),
                ],
              ),
            div(
              classes: 'arcane-navigation-screen-content',
              styles: const Styles(raw: {
                'flex': '1',
                'overflow-y': 'auto',
                'min-width': '0',
              }),
              [destination.content],
            ),
          ],
        ),
        if (useBottomNav)
          ArcaneBottomNavigationBar(
            items: [
              for (final dest in component.destinations)
                ArcaneBottomNavItem(
                  label: dest.label,
                  icon: dest.icon,
                ),
            ],
            selectedIndex: _selectedIndex,
            onChanged: _selectDestination,
          ),
      ],
    );
  }
}

enum NavigationMode {
  auto,
  sidebar,
  bottom,
  rail,
}

/// Navigation destination.
class ArcaneNavigationDestination {
  final String label;
  final Component icon;
  final Component? selectedIcon;
  final Component content;

  const ArcaneNavigationDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
    required this.content,
  });
}

/// Responsive scaffold that adapts to screen size.
class ArcaneResponsiveScaffold extends StatelessComponent {
  final Component mobile;
  final Component? tablet;
  final Component? desktop;
  final double tabletBreakpoint;
  final double desktopBreakpoint;

  const ArcaneResponsiveScaffold({
    required this.mobile,
    this.tablet,
    this.desktop,
    this.tabletBreakpoint = 768,
    this.desktopBreakpoint = 1024,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-responsive-scaffold',
      [
        div(
          classes: 'arcane-responsive-mobile',
          styles: const Styles(raw: {
            'display': 'block',
          }),
          [mobile],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [];
}
