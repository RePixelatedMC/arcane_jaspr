import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/checkbox_props.dart';

/// Codex Checkbox renderer.
///
/// Implements the Codex design language:
/// - Larger checkbox sizes (1.25x)
/// - Accent-colored when checked with subtle glow
/// - Larger border radius
/// - More gap between checkbox and label
class CodexCheckbox extends StatelessComponent {
  final CheckboxProps props;

  const CodexCheckbox(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex size dimensions - slightly larger than ShadCN
    final String boxSize = switch (props.size) {
      CheckboxSize.small => '16px', // vs ShadCN 14px
      CheckboxSize.medium => '20px', // vs ShadCN 16px
      CheckboxSize.large => '24px', // vs ShadCN 20px
    };

    final String checkSize = switch (props.size) {
      CheckboxSize.small => '12px',
      CheckboxSize.medium => '14px',
      CheckboxSize.large => '16px',
    };

    // Codex uses accent color for primary variant
    final (String checkedBg, String borderColor, String glowColor) = switch (props.variant) {
      CheckboxVariant.primary => (
          'var(--codex-accent)',
          'var(--codex-accent)',
          'var(--codex-accent-glow-subtle)',
        ),
      CheckboxVariant.success => (
          'var(--success)',
          'var(--success)',
          '0 0 10px rgba(var(--success-rgb), 0.3)',
        ),
      CheckboxVariant.warning => (
          'var(--warning)',
          'var(--warning)',
          '0 0 10px rgba(var(--warning-rgb), 0.3)',
        ),
      CheckboxVariant.error => (
          'var(--destructive)',
          'var(--destructive)',
          '0 0 10px rgba(var(--destructive-rgb), 0.3)',
        ),
    };

    // Checkmark foreground color
    final String checkColor = switch (props.variant) {
      CheckboxVariant.primary => '#ffffff',
      CheckboxVariant.success => 'var(--success-foreground)',
      CheckboxVariant.warning => 'var(--warning-foreground)',
      CheckboxVariant.error => 'var(--destructive-foreground)',
    };

    return dom.div(
      classes: 'codex-checkbox-wrapper',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.75rem', // Codex: more gap (12px vs ShadCN 8px)
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
      }),
      events: props.disabled || props.onChanged == null
          ? null
          : {
              'click': (event) => props.onChanged!(!props.checked),
            },
      [
        // Checkbox box - Codex styling with accent glow
        dom.div(
          classes: 'codex-checkbox',
          styles: dom.Styles(raw: {
            'width': boxSize,
            'height': boxSize,
            // Codex: larger radius than ShadCN
            'border-radius': 'var(--radius-sm)', // 8px vs ShadCN 4px
            'background-color': props.checked ? checkedBg : 'transparent',
            'border': props.checked
                ? '1px solid $borderColor'
                : '1px solid var(--border)',
            // Codex: subtle glow when checked
            'box-shadow': props.checked ? glowColor : 'none',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'all var(--transition)',
          }),
          [
            if (props.checked)
              dom.span(
                styles: dom.Styles(raw: {
                  'color': checkColor,
                  'font-size': checkSize,
                  'font-weight': 'var(--arcane-font-weight-bold)',
                  'line-height': '1',
                }),
                [const Component.text('\u2713')],
              ),
          ],
        ),
        // Label and description
        if (props.label != null || props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'flex': '1',
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-sm)',
                    'font-weight': 'var(--arcane-font-weight-medium)',
                    'color': 'var(--foreground)',
                    'display': 'block',
                    'line-height': '1.25',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.description != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-sm)',
                    'color': 'var(--muted-foreground)',
                    'display': 'block',
                    'margin-top': '0.375rem', // Codex: slightly more gap
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),
      ],
    );
  }
}
