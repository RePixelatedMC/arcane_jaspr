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

typedef ArcaneDashboardNavItem = DashboardNavItem;
typedef ArcaneDashboardNavGroup = DashboardNavGroup;

/// A reusable dashboard layout with sidebar navigation.
class ArcaneDashboardLayout extends StatelessComponent {
  final Component child;
  final String currentRoute;
  final List<DashboardNavGroup> navigation;
  final Component? sidebarHeader;
  final Component? sidebarFooter;
  final Component? topBar;
  final String sidebarWidth;
  final String backgroundColor;
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
class ArcaneDashboardTopBar extends StatelessComponent {
  final Component? leading;
  final Component? trailing;
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
  final String? userName;
  final String? userSubtitle;
  final String? avatarUrl;
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
