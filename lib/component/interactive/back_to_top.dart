import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// A back to top button (Supabase-style)
class ArcaneBackToTop extends StatelessComponent {
  /// Whether the button is visible
  final bool visible;

  /// Click handler
  final void Function()? onTap;

  /// Position from right
  final double right;

  /// Position from bottom
  final double bottom;

  /// Button size
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
        span(
          styles: const Styles(raw: {
            'font-size': '1.25rem',
            'color': 'var(--muted-foreground)',
            'transform': 'rotate(-90deg)',
            'transition': 'all 150ms ease',
          }),
          [text('\u2192')],
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

/// A scroll progress indicator
class ArcaneScrollProgress extends StatelessComponent {
  /// Progress value (0-100)
  final double progress;

  /// Whether to show at top or bottom
  final bool top;

  /// Bar height
  final double height;

  /// Color
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

/// A floating action button
class ArcaneFloatingActionButton extends StatelessComponent {
  /// Button icon/content
  final Component child;

  /// Click handler
  final void Function()? onTap;

  /// Position from right
  final double right;

  /// Position from bottom
  final double bottom;

  /// Button size
  final double size;

  /// Whether extended with label
  final String? label;

  /// Whether to use accent color
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
            [text(label!)],
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
