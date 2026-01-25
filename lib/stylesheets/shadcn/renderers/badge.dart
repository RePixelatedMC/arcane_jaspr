import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/badge_props.dart';

/// ShadCN Badge renderer.
///
/// Outputs the exact HTML structure and CSS classes from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/badge
class ShadcnBadge extends StatelessComponent {
  final BadgeProps props;

  const ShadcnBadge(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN base styles:
    // inline-flex items-center rounded-full border px-2.5 py-0.5
    // text-xs font-semibold transition-colors
    // focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2
    final Map<String, String> baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'gap': 'var(--space-1)', // gap-1
      'border-radius': 'var(--arcane-radius-full)', // rounded-full
      'font-size': 'var(--font-size-xs)', // text-xs
      'font-weight': 'var(--font-weight-semibold)', // font-semibold
      'line-height': '1',
      'white-space': 'nowrap',
      'transition': 'color 150ms, background-color 150ms, border-color 150ms',
    };

    // Size-specific styles
    final Map<String, String> sizeStyles = switch (props.size) {
      ComponentSize.sm => {
        'padding': '0.125rem 0.5rem', // py-0.5 px-2
      },
      ComponentSize.md => {
        'padding': '0.125rem 0.625rem', // py-0.5 px-2.5 (ShadCN default)
      },
      ComponentSize.lg => {
        'padding': '0.25rem 0.75rem', // py-1 px-3
        'font-size': 'var(--font-size-sm)', // text-sm
      },
    };

    // Get color-specific values
    final (String bgColor, String fgColor) = switch (props.color) {
      ColorVariant.primary => ('var(--primary)', 'var(--primary-foreground)'),
      ColorVariant.secondary => ('var(--secondary)', 'var(--secondary-foreground)'),
      ColorVariant.destructive => ('var(--destructive)', 'var(--destructive-foreground)'),
      ColorVariant.success => ('var(--success, #22c55e)', 'var(--success-foreground, #ffffff)'),
      ColorVariant.warning => ('var(--warning, #f59e0b)', 'var(--warning-foreground, #000000)'),
      ColorVariant.info => ('var(--info, #3b82f6)', 'var(--info-foreground, #ffffff)'),
    };

    // Style-specific styles
    final Map<String, String> styleStyles = switch (props.style) {
      StyleVariant.solid => {
        'background-color': bgColor,
        'color': fgColor,
        'border': '1px solid transparent',
      },
      StyleVariant.outline => {
        'background-color': 'transparent',
        'color': bgColor,
        'border': '1px solid $bgColor',
      },
      StyleVariant.ghost => {
        'background-color': 'color-mix(in srgb, $bgColor 10%, transparent)',
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
      classes: 'arcane-badge',
      styles: dom.Styles(raw: allStyles),
      [
        if (props.icon != null) props.icon!,
        Component.text(props.label),
      ],
    );
  }
}
