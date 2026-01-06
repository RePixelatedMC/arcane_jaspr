import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/theme_toggle_props.dart';

/// ShadCN-styled theme toggle component
class ShadcnThemeToggle extends StatelessComponent {
  final ThemeToggleProps props;

  const ShadcnThemeToggle(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final (width, height, thumbSize, iconSize) = switch (props.size) {
      ThemeToggleSize.sm => ('48px', '26px', '20px', '12px'),
      ThemeToggleSize.md => ('56px', '30px', '24px', '14px'),
      ThemeToggleSize.lg => ('68px', '36px', '30px', '18px'),
    };

    // Calculate thumb translation
    final thumbTranslate = switch (props.size) {
      ThemeToggleSize.sm => '22px',
      ThemeToggleSize.md => '26px',
      ThemeToggleSize.lg => '32px',
    };

    return dom.button(
      type: dom.ButtonType.button,
      classes: 'arcane-theme-toggle',
      attributes: {
        'data-theme': props.isDark ? 'dark' : 'light',
        'aria-label': props.isDark ? 'Switch to light mode' : 'Switch to dark mode',
        'role': 'switch',
        'aria-checked': props.isDark.toString(),
      },
      styles: dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'align-items': 'center',
        'width': width,
        'height': height,
        'padding': '3px',
        'border': 'none',
        'border-radius': '9999px',
        'background': props.isDark
            ? 'var(--arcane-muted)'
            : 'rgba(var(--arcane-warning-rgb), 0.3)',
        'cursor': 'pointer',
        'transition': 'var(--arcane-transition-fast, all 150ms ease)',
      }),
      events: props.onChanged != null
          ? {'click': (_) => props.onChanged!(!props.isDark)}
          : null,
      [
        // Track icons
        dom.div(
          classes: 'arcane-theme-toggle-icons',
          styles: dom.Styles(raw: {
            'position': 'absolute',
            'inset': '0',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'padding': '0 6px',
            'font-size': iconSize,
            'pointer-events': 'none',
          }),
          [
            // Sun icon (left)
            dom.span(
              classes: 'arcane-theme-toggle-sun',
              styles: dom.Styles(raw: {
                'opacity': props.isDark ? '0.3' : '1',
                'transition': 'var(--arcane-transition-fast, all 150ms ease)',
              }),
              [Component.text('\u2600\uFE0F')], // sun emoji
            ),
            // Moon icon (right)
            dom.span(
              classes: 'arcane-theme-toggle-moon',
              styles: dom.Styles(raw: {
                'opacity': props.isDark ? '1' : '0.3',
                'transition': 'var(--arcane-transition-fast, all 150ms ease)',
              }),
              [Component.text('\uD83C\uDF19')], // moon emoji
            ),
          ],
        ),

        // Thumb
        dom.div(
          classes: 'arcane-theme-toggle-thumb',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': thumbSize,
            'height': thumbSize,
            'border-radius': '9999px',
            'background': props.isDark ? 'var(--arcane-foreground)' : 'var(--arcane-warning)',
            'box-shadow': 'var(--arcane-shadow-sm, 0 2px 4px rgba(0, 0, 0, 0.2))',
            'transition': 'var(--arcane-transition-fast, all 150ms ease)',
            'transform': props.isDark ? 'translateX($thumbTranslate)' : 'translateX(0)',
          }),
          [],
        ),
      ],
    );
  }
}

/// ShadCN-styled simple theme toggle component
class ShadcnThemeToggleSimple extends StatelessComponent {
  final ThemeToggleSimpleProps props;

  const ShadcnThemeToggleSimple(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.button(
      type: dom.ButtonType.button,
      classes: 'arcane-theme-toggle-simple',
      attributes: {
        'data-theme': props.isDark ? 'dark' : 'light',
        'aria-label': props.isDark ? 'Switch to light mode' : 'Switch to dark mode',
        'role': 'switch',
        'aria-checked': props.isDark.toString(),
      },
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': '0.25rem 0.5rem',
        'border': 'none',
        'border-radius': '9999px',
        'background': 'var(--arcane-muted)',
        'cursor': 'pointer',
      }),
      events: props.onChanged != null
          ? {'click': (_) => props.onChanged!(!props.isDark)}
          : null,
      [
        // Sun
        dom.span(
          classes: 'arcane-theme-toggle-simple-sun',
          styles: dom.Styles(raw: {
            'font-size': '1rem',
            'opacity': props.isDark ? '0.4' : '1',
            'transition': 'var(--arcane-transition-fast, all 150ms ease)',
          }),
          [Component.text('\u2600\uFE0F')], // sun emoji
        ),

        // Toggle track
        dom.div(
          classes: 'arcane-theme-toggle-simple-track',
          styles: dom.Styles(raw: {
            'position': 'relative',
            'width': '36px',
            'height': '18px',
            'border-radius': '9999px',
            'background': props.isDark ? 'var(--arcane-accent)' : 'var(--arcane-warning)',
          }),
          [
            // Thumb
            dom.div(
              classes: 'arcane-theme-toggle-simple-thumb',
              styles: dom.Styles(raw: {
                'position': 'absolute',
                'top': '2px',
                'width': '14px',
                'height': '14px',
                'border-radius': '9999px',
                'background': 'var(--arcane-card)',
                'transition': 'var(--arcane-transition-fast, all 150ms ease)',
                'left': props.isDark ? '20px' : '2px',
              }),
              [],
            ),
          ],
        ),

        // Moon
        dom.span(
          classes: 'arcane-theme-toggle-simple-moon',
          styles: dom.Styles(raw: {
            'font-size': '1rem',
            'opacity': props.isDark ? '1' : '0.4',
            'transition': 'var(--arcane-transition-fast, all 150ms ease)',
          }),
          [Component.text('\uD83C\uDF19')], // moon emoji
        ),
      ],
    );
  }
}
