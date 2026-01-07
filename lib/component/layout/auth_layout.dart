import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/auth_layout_props.dart';

/// A layout for authentication screens with centered content and optional background effects.
class ArcaneAuthLayout extends StatelessComponent {
  final Component child;
  final Component? header;
  final Component? footer;
  final bool showGrid;
  final bool showGlows;
  final String primaryGlowColor;
  final String secondaryGlowColor;
  final String gridColor;
  final String maxWidth;
  final String backgroundColor;

  const ArcaneAuthLayout({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.primaryGlowColor = 'hsl(var(--accent) / 0.15)',
    this.secondaryGlowColor = 'hsl(199 89% 48% / 0.15)',
    this.gridColor = 'hsl(var(--border) / 0.3)',
    this.maxWidth = '420px',
    this.backgroundColor = 'var(--background)',
  });

  const ArcaneAuthLayout.themed({
    super.key,
    required this.child,
    this.header,
    this.footer,
    this.showGrid = true,
    this.showGlows = true,
    this.maxWidth = '420px',
    this.backgroundColor = 'var(--background)',
  })  : primaryGlowColor = 'hsl(var(--accent) / 0.15)',
        secondaryGlowColor = 'hsl(199 89% 48% / 0.15)',
        gridColor = 'hsl(var(--border) / 0.3)';

  @override
  Component build(BuildContext context) {
    return context.renderers.authLayout(AuthLayoutProps(
      child: child,
      header: header,
      footer: footer,
      showGrid: showGrid,
      showGlows: showGlows,
      primaryGlowColor: primaryGlowColor,
      secondaryGlowColor: secondaryGlowColor,
      gridColor: gridColor,
      maxWidth: maxWidth,
      backgroundColor: backgroundColor,
    ));
  }
}

/// A simple "back to" link for auth layouts.
class ArcaneAuthBackLink extends StatelessComponent {
  final String href;
  final String text;

  const ArcaneAuthBackLink({
    super.key,
    required this.href,
    this.text = 'Back to home',
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.authBackLink(AuthBackLinkProps(
      href: href,
      text: text,
    ));
  }
}
