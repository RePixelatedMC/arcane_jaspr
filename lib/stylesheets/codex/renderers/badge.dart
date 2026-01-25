import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/badge_props.dart';

/// Codex Badge renderer.
///
/// Implements the Codex design language:
/// - Accent-colored primary variant with subtle glow
/// - Slightly larger padding
/// - Larger border radius
class CodexBadge extends StatelessComponent {
  final BadgeProps props;

  const CodexBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex base styles
    final Map<String, String> baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': '0.375rem', // Codex: slightly more gap
      'border-radius': 'var(--arcane-radius-full)',
      'font-size': 'var(--font-size-xs)',
      'font-weight': 'var(--font-weight-semibold)',
      'line-height': '1',
      'white-space': 'nowrap',
      'transition': 'all var(--transition)',
    };

    // Codex size-specific styles - slightly more padding
    final Map<String, String> sizeStyles = switch (props.size) {
      ComponentSize.sm => {
        'padding': '0.25rem 0.625rem', // Codex: more padding
      },
      ComponentSize.md => {
        'padding': '0.25rem 0.75rem', // Codex: more padding
      },
      ComponentSize.lg => {
        'padding': '0.375rem 1rem', // Codex: more padding
        'font-size': 'var(--font-size-sm)',
      },
    };

    // Get color-specific values with Codex glows
    final (String bgColor, String fgColor, String? glowColor) = switch (props.color) {
      ColorVariant.primary => (
        'var(--primary)',
        'var(--primary-foreground)',
        '0 0 15px rgba(var(--primary-rgb), 0.2)',
      ),
      ColorVariant.secondary => (
        'var(--secondary)',
        'var(--secondary-foreground)',
        null,
      ),
      ColorVariant.destructive => (
        'var(--destructive)',
        'var(--destructive-foreground)',
        '0 0 10px rgba(var(--destructive-rgb), 0.25)',
      ),
      ColorVariant.success => (
        'var(--success, #22c55e)',
        'var(--success-foreground, #ffffff)',
        '0 0 10px rgba(var(--success-rgb), 0.25)',
      ),
      ColorVariant.warning => (
        'var(--warning, #f59e0b)',
        'var(--warning-foreground, #000000)',
        null,
      ),
      ColorVariant.info => (
        'var(--info, #3b82f6)',
        'var(--info-foreground, #ffffff)',
        '0 0 10px rgba(var(--info-rgb), 0.25)',
      ),
    };

    // Codex style-specific styles with glows
    final Map<String, String> styleStyles = switch (props.style) {
      StyleVariant.solid => {
        'background-color': bgColor,
        'color': fgColor,
        'border': '1px solid transparent',
        if (glowColor != null) 'box-shadow': glowColor,
      },
      StyleVariant.outline => {
        'background-color': 'transparent',
        'color': bgColor,
        'border': '1px solid $bgColor',
      },
      StyleVariant.ghost => {
        'background-color': 'color-mix(in srgb, $bgColor 15%, transparent)',
        'color': bgColor,
        'border': '1px solid transparent',
      },
      StyleVariant.link => {
        'background-color': 'transparent',
        'color': bgColor,
        'border': '1px solid transparent',
      },
    };

    // Combine all styles
    final Map<String, String> allStyles = {
      ...baseStyles,
      ...sizeStyles,
      ...styleStyles,
    };

    return dom.span(
      classes: 'codex-badge',
      styles: dom.Styles(raw: allStyles),
      [
        if (props.icon != null) props.icon!,
        Component.text(props.label),
      ],
    );
  }
}
