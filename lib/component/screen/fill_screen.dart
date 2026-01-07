import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/colors.dart';
import '../view/bar.dart';

/// Screen that fills the entire viewport.
class ArcaneFillScreen extends StatelessComponent {
  final Component child;
  final Component? header;
  final String? title;
  final String? subtitle;
  final List<Component>? actions;
  final Component? footer;
  final Component? sidebar;
  final bool sidebarRight;
  final Component? background;
  final double? loadingProgress;
  final bool loadingIndeterminate;
  final void Function()? onBack;
  final bool scrollable;

  const ArcaneFillScreen({
    required this.child,
    this.header,
    this.title,
    this.subtitle,
    this.actions,
    this.footer,
    this.sidebar,
    this.sidebarRight = false,
    this.background,
    this.loadingProgress,
    this.loadingIndeterminate = false,
    this.onBack,
    this.scrollable = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final Component? effectiveHeader = header ??
        (title != null
            ? ArcaneBar(
                titleText: title,
                subtitleText: subtitle,
                trailing: actions,
                onBack: onBack,
                backButton:
                    onBack != null ? BarBackButtonMode.always : BarBackButtonMode.never,
              )
            : null);

    return div(
      classes: 'arcane-fill-screen',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'min-height': '100vh',
        'height': '100%',
        'position': 'relative',
        'background-color': 'var(--background)',
      }),
      [
        if (background != null)
          div(
            classes: 'arcane-fill-screen-background',
            styles: const Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'z-index': '0',
              'overflow': 'hidden',
            }),
            [background!],
          ),
        div(
          classes: 'arcane-fill-screen-content',
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'flex': '1',
            'position': 'relative',
            'z-index': '1',
            'min-height': '0',
          }),
          [
            if (loadingProgress != null || loadingIndeterminate)
              _buildLoadingBar(),
            if (effectiveHeader != null) effectiveHeader,
            div(
              classes: 'arcane-fill-screen-body',
              styles: const Styles(raw: {
                'display': 'flex',
                'flex': '1',
                'min-height': '0',
              }),
              [
                if (sidebar != null && !sidebarRight) sidebar!,
                div(
                  classes: 'arcane-fill-screen-main',
                  styles: Styles(raw: {
                    'flex': '1',
                    if (scrollable) 'overflow-y': 'auto',
                    'overflow-x': 'hidden',
                    'display': 'flex',
                    'flex-direction': 'column',
                  }),
                  [child],
                ),
                if (sidebar != null && sidebarRight) sidebar!,
              ],
            ),
            if (footer != null)
              div(
                classes: 'arcane-fill-screen-footer',
                styles: const Styles(raw: {
                  'flex-shrink': '0',
                }),
                [footer!],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildLoadingBar() {
    return div(
      classes: 'arcane-fill-screen-loading',
      styles: const Styles(raw: {
        'height': '3px',
        'background-color': 'var(--border)',
        'overflow': 'hidden',
        'flex-shrink': '0',
      }),
      [
        div(
          styles: Styles(raw: {
            'height': '100%',
            'background-color': 'var(--accent)',
            if (!loadingIndeterminate)
              'width': '${(loadingProgress ?? 0) * 100}%',
            if (loadingIndeterminate) 'width': '30%',
            if (loadingIndeterminate)
              'animation': 'arcane-loading-slide 1.5s ease-in-out infinite',
          }),
          [],
        ),
      ],
    );
  }
}

/// Simple fullscreen container.
class ArcaneFullScreen extends StatelessComponent {
  final Component child;
  final Color? backgroundColor;

  const ArcaneFullScreen({
    required this.child,
    this.backgroundColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-fullscreen',
      styles: Styles(raw: {
        'min-height': '100vh',
        'width': '100%',
        'background-color':
            backgroundColor?.css ?? 'var(--background)',
      }),
      [child],
    );
  }
}
