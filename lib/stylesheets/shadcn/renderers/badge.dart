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
      'gap': '0.25rem', // gap-1
      'border-radius': '9999px', // rounded-full
      'font-size': '0.75rem', // text-xs
      'font-weight': '600', // font-semibold
      'line-height': '1',
      'white-space': 'nowrap',
      'transition': 'color 150ms, background-color 150ms, border-color 150ms',
    };

    // Size-specific styles
    final Map<String, String> sizeStyles = switch (props.size) {
      BadgeSize.small => {
        'padding': '0.125rem 0.5rem', // py-0.5 px-2
      },
      BadgeSize.medium => {
        'padding': '0.125rem 0.625rem', // py-0.5 px-2.5 (ShadCN default)
      },
      BadgeSize.large => {
        'padding': '0.25rem 0.75rem', // py-1 px-3
        'font-size': '0.875rem', // text-sm
      },
    };

    // Variant-specific styles (matching ShadCN exactly)
    final Map<String, String> variantStyles = switch (props.variant) {
      BadgeVariant.standard => {
        'background-color': 'var(--primary)',
        'color': 'var(--primary-foreground)',
        'border': '1px solid transparent',
      },
      BadgeVariant.primary => {
        'background-color': 'var(--primary)',
        'color': 'var(--primary-foreground)',
        'border': '1px solid transparent',
      },
      BadgeVariant.secondary => {
        'background-color': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid transparent',
      },
      BadgeVariant.success => {
        'background-color': 'var(--success, #22c55e)',
        'color': 'var(--success-foreground, #ffffff)',
        'border': '1px solid transparent',
      },
      BadgeVariant.warning => {
        'background-color': 'var(--warning, #f59e0b)',
        'color': 'var(--warning-foreground, #000000)',
        'border': '1px solid transparent',
      },
      BadgeVariant.error => {
        'background-color': 'var(--destructive)',
        'color': 'var(--destructive-foreground)',
        'border': '1px solid transparent',
      },
      BadgeVariant.info => {
        'background-color': 'var(--info, #3b82f6)',
        'color': 'var(--info-foreground, #ffffff)',
        'border': '1px solid transparent',
      },
      BadgeVariant.outline => {
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': '1px solid var(--border)',
      },
    };

    // Combine all styles
    final Map<String, String> allStyles = {
      ...baseStyles,
      ...sizeStyles,
      ...variantStyles,
    };

    return dom.span(
      classes: 'arcane-badge',
      styles: dom.Styles(raw: allStyles),
      [
        if (props.icon != null) props.icon!,
        dom.text(props.label),
      ],
    );
  }
}
