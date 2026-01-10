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
      'font-size': 'var(--arcane-font-size-xs)',
      'font-weight': 'var(--arcane-font-weight-semibold)',
      'line-height': '1',
      'white-space': 'nowrap',
      'transition': 'all var(--transition)',
    };

    // Codex size-specific styles - slightly more padding
    final Map<String, String> sizeStyles = switch (props.size) {
      BadgeSize.small => {
        'padding': '0.25rem 0.625rem', // Codex: more padding
      },
      BadgeSize.medium => {
        'padding': '0.25rem 0.75rem', // Codex: more padding
      },
      BadgeSize.large => {
        'padding': '0.375rem 1rem', // Codex: more padding
        'font-size': 'var(--arcane-font-size-sm)',
      },
    };

    // Codex variant-specific styles with accent colors and glows
    final Map<String, String> variantStyles = switch (props.variant) {
      BadgeVariant.standard => {
        'background-color': 'var(--codex-accent)',
        'color': '#ffffff',
        'border': '1px solid transparent',
        'box-shadow': 'var(--codex-accent-glow-subtle)',
      },
      BadgeVariant.primary => {
        'background-color': 'var(--codex-accent)',
        'color': '#ffffff',
        'border': '1px solid transparent',
        'box-shadow': 'var(--codex-accent-glow-subtle)',
      },
      BadgeVariant.secondary => {
        'background-color': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border': '1px solid var(--border)',
      },
      BadgeVariant.success => {
        'background-color': 'var(--success)',
        'color': 'var(--success-foreground)',
        'border': '1px solid transparent',
        'box-shadow': '0 0 10px rgba(var(--success-rgb), 0.25)',
      },
      BadgeVariant.warning => {
        'background-color': 'var(--warning)',
        'color': 'var(--warning-foreground)',
        'border': '1px solid transparent',
      },
      BadgeVariant.error => {
        'background-color': 'var(--destructive)',
        'color': 'var(--destructive-foreground)',
        'border': '1px solid transparent',
        'box-shadow': '0 0 10px rgba(var(--destructive-rgb), 0.25)',
      },
      BadgeVariant.info => {
        'background-color': 'var(--info)',
        'color': 'var(--info-foreground)',
        'border': '1px solid transparent',
        'box-shadow': '0 0 10px rgba(var(--info-rgb), 0.25)',
      },
      BadgeVariant.outline => {
        'background-color': 'transparent',
        'color': 'var(--codex-accent)',
        'border': '1px solid var(--codex-accent-border)',
      },
    };

    // Combine all styles
    final Map<String, String> allStyles = {
      ...baseStyles,
      ...sizeStyles,
      ...variantStyles,
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
