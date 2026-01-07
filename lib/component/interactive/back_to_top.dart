import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Back to top button.
class ArcaneBackToTop extends StatelessComponent {
  final bool visible;
  final void Function()? onTap;
  final double right;
  final double bottom;
  final double size;

  const ArcaneBackToTop({
    this.visible = true,
    this.onTap,
    this.right = 24,
    this.bottom = 24,
    this.size = 48,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    if (!visible) {
      return const div([]);
    }

    return button(
      classes: 'arcane-back-to-top',
      attributes: {
        'type': 'button',
        'aria-label': 'Back to top',
      },
      styles: Styles(raw: {
        'position': 'fixed',
        'right': '${right}px',
        'bottom': '${bottom}px',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '${size}px',
        'height': '${size}px',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': '9999px',
        'box-shadow': '0 10px 15px -3px hsl(0 0% 0% / 0.1), 0 4px 6px -4px hsl(0 0% 0% / 0.1)',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
        'animation': 'arcane-back-to-top-fade 0.2s ease-out',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        const span(
          styles: Styles(raw: {
            'font-size': '1.25rem',
            'color': 'var(--muted-foreground)',
            'transform': 'rotate(-90deg)',
            'transition': 'all 150ms ease',
          }),
          [Component.text('\u2192')],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-back-to-top-fade').styles(raw: {
      '0%': 'opacity: 0; transform: translateY(20px)',
      '100%': 'opacity: 1; transform: translateY(0)',
    }),
    css('.arcane-back-to-top:hover').styles(raw: {
      'transform': 'translateY(-4px)',
      'box-shadow': '0 20px 25px -5px hsl(0 0% 0% / 0.1), 0 8px 10px -6px hsl(0 0% 0% / 0.1)',
    }),
    css('.arcane-back-to-top:hover span').styles(raw: {
      'color': 'var(--accent)',
    }),
  ];
}

/// Scroll progress indicator.
class ArcaneScrollProgress extends StatelessComponent {
  final double progress;
  final bool top;
  final double height;
  final String? color;

  const ArcaneScrollProgress({
    required this.progress,
    this.top = true,
    this.height = 3,
    this.color,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-scroll-progress',
      styles: Styles(raw: {
        'position': 'fixed',
        if (top) 'top': '0' else 'bottom': '0',
        'left': '0',
        'width': '100%',
        'height': '${height}px',
        'z-index': '1000',
        'background-color': 'var(--muted)',
      }),
      [
        div(
          classes: 'arcane-scroll-progress-bar',
          styles: Styles(raw: {
            'height': '100%',
            'width': '${progress.clamp(0, 100)}%',
            'background-color': color ?? 'var(--accent)',
            'transition': 'width 0.1s ease-out',
          }),
          [],
        ),
      ],
    );
  }
}

/// Floating action button.
class ArcaneFloatingActionButton extends StatelessComponent {
  final Component child;
  final void Function()? onTap;
  final double right;
  final double bottom;
  final double size;
  final String? label;
  final bool accent;

  const ArcaneFloatingActionButton({
    required this.child,
    this.onTap,
    this.right = 24,
    this.bottom = 24,
    this.size = 56,
    this.label,
    this.accent = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return button(
      classes: 'arcane-fab ${label != null ? 'extended' : ''}',
      attributes: {'type': 'button'},
      styles: Styles(raw: {
        'position': 'fixed',
        'right': '${right}px',
        'bottom': '${bottom}px',
        'z-index': '50',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.5rem',
        if (label == null) 'width': '${size}px',
        'height': '${size}px',
        if (label != null) 'padding': '0 20px',
        'background-color': accent ? 'var(--accent)' : 'var(--card)',
        'color': accent ? 'var(--accent-foreground)' : 'var(--foreground)',
        'border': accent ? 'none' : '1px solid var(--border)',
        'border-radius': '9999px',
        'box-shadow': '0 10px 15px -3px hsl(0 0% 0% / 0.1), 0 4px 6px -4px hsl(0 0% 0% / 0.1)',
        'cursor': 'pointer',
        'transition': 'all 150ms ease',
      }),
      events: {
        if (onTap != null) 'click': (e) => onTap!(),
      },
      [
        child,
        if (label != null)
          span(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
            }),
            [Component.text(label!)],
          ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-fab:hover').styles(raw: {
      'transform': 'scale(1.05)',
      'box-shadow': '0 20px 25px -5px hsl(0 0% 0% / 0.1), 0 8px 10px -6px hsl(0 0% 0% / 0.1)',
    }),
    css('.arcane-fab:active').styles(raw: {
      'transform': 'scale(0.98)',
    }),
  ];
}
