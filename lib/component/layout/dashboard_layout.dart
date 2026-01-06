import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../core/theme_provider.dart';

export '../../core/props/dashboard_layout_props.dart';

/// A navigation item for the dashboard sidebar (re-export from props)
typedef ArcaneDashboardNavItem = DashboardNavItem;

/// A group of navigation items with an optional label (re-export from props)
typedef ArcaneDashboardNavGroup = DashboardNavGroup;

/// A reusable dashboard layout with sidebar navigation.
///
/// Use this for client dashboards, admin panels, or any authenticated area.
/// The sidebar includes navigation groups, a header slot, and a footer slot.
class ArcaneDashboardLayout extends StatelessComponent {
  /// The main content to display
  final Component child;

  /// The current route path for active state highlighting
  final String currentRoute;

  /// Navigation groups to display in the sidebar
  final List<DashboardNavGroup> navigation;

  /// Header component for the sidebar (typically a logo)
  final Component? sidebarHeader;

  /// Footer component for the sidebar (typically settings/logout)
  final Component? sidebarFooter;

  /// Top bar component (typically user info/notifications)
  final Component? topBar;

  /// Sidebar width
  final String sidebarWidth;

  /// Background color for the main area
  final String backgroundColor;

  /// Background color for the sidebar
  final String sidebarBackgroundColor;

  const ArcaneDashboardLayout({
    super.key,
    required this.child,
    required this.currentRoute,
    required this.navigation,
    this.sidebarHeader,
    this.sidebarFooter,
    this.topBar,
    this.sidebarWidth = '256px',
    this.backgroundColor = 'var(--background)',
    this.sidebarBackgroundColor = 'var(--card)',
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.dashboardLayout(DashboardLayoutProps(
      child: child,
      currentRoute: currentRoute,
      navigation: navigation,
      sidebarHeader: sidebarHeader,
      sidebarFooter: sidebarFooter,
      topBar: topBar,
      sidebarWidth: sidebarWidth,
      backgroundColor: backgroundColor,
      sidebarBackgroundColor: sidebarBackgroundColor,
    ));
  }
}

/// A simple top bar component for dashboard layouts.
///
/// Displays breadcrumbs/title on the left and user actions on the right.
class ArcaneDashboardTopBar extends StatelessComponent {
  /// Left side content (e.g., breadcrumbs, page title)
  final Component? leading;

  /// Right side content (e.g., notifications, user menu)
  final Component? trailing;

  /// Background color
  final String backgroundColor;

  const ArcaneDashboardTopBar({
    super.key,
    this.leading,
    this.trailing,
    this.backgroundColor = 'var(--card)',
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.dashboardTopBar(DashboardTopBarProps(
      leading: leading,
      trailing: trailing,
      backgroundColor: backgroundColor,
    ));
  }
}

/// A user menu component for the dashboard top bar.
class ArcaneDashboardUserMenu extends StatelessComponent {
  /// User's display name
  final String? userName;

  /// User's subtitle (e.g., plan name, role)
  final String? userSubtitle;

  /// User's avatar URL
  final String? avatarUrl;

  /// Callback when user menu is clicked
  final void Function()? onTap;

  const ArcaneDashboardUserMenu({
    super.key,
    this.userName,
    this.userSubtitle,
    this.avatarUrl,
    this.onTap,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-dashboard-user-menu',
      attributes: {'type': 'button'},
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': '0.5rem',
        'background': 'transparent',
        'border': 'none',
        'border-radius': '0.375rem',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        // Avatar
        div(
          styles: const Styles(raw: {
            'width': '36px',
            'height': '36px',
            'border-radius': '9999px',
            'overflow': 'hidden',
            'flex-shrink': '0',
            'background': 'var(--muted)',
          }),
          [
            if (avatarUrl != null)
              img(
                src: avatarUrl!,
                alt: userName ?? 'User',
                styles: const Styles(raw: {
                  'width': '100%',
                  'height': '100%',
                  'object-fit': 'cover',
                }),
              ),
          ],
        ),
        // Name and subtitle
        if (userName != null || userSubtitle != null)
          div(
            styles: const Styles(raw: {
              'text-align': 'left',
            }),
            [
              if (userName != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': '0.875rem',
                    'font-weight': '500',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(userName!)],
                ),
              if (userSubtitle != null)
                div(
                  styles: const Styles(raw: {
                    'font-size': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text(userSubtitle!)],
                ),
            ],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-dashboard-user-menu:hover').styles(raw: {
      'background-color': 'var(--muted)',
    }),
  ];
}
