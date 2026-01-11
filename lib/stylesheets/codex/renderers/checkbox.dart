import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/checkbox_props.dart';

/// Codex Checkbox renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon checkboxes with pulsing effect
/// - Holographic check animation
/// - Cyberpunk-style variant colors with intense glows
/// - Animated state transitions
class CodexCheckbox extends StatelessComponent {
  final CheckboxProps props;

  const CodexCheckbox(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex Neon size dimensions - larger with more presence
    final String boxSize = switch (props.size) {
      CheckboxSize.small => '20px',
      CheckboxSize.medium => '24px',
      CheckboxSize.large => '28px',
    };

    final String checkSize = switch (props.size) {
      CheckboxSize.small => '12px',
      CheckboxSize.medium => '14px',
      CheckboxSize.large => '18px',
    };

    // Codex Neon variant colors with intense glows
    final (String checkedBg, String borderColor, String glowColor, String checkColor) = switch (props.variant) {
      CheckboxVariant.primary => (
        'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
        'var(--primary)',
        '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.15)',
        '#ffffff',
      ),
      CheckboxVariant.success => (
        'linear-gradient(135deg, var(--success) 0%, color-mix(in srgb, var(--success) 70%, #00ffaa) 100%)',
        'var(--success)',
        '0 0 20px rgba(var(--success-rgb), 0.4), 0 0 40px rgba(var(--success-rgb), 0.15)',
        '#ffffff',
      ),
      CheckboxVariant.warning => (
        'linear-gradient(135deg, var(--warning) 0%, color-mix(in srgb, var(--warning) 70%, #ffaa00) 100%)',
        'var(--warning)',
        '0 0 20px rgba(var(--warning-rgb), 0.4), 0 0 40px rgba(var(--warning-rgb), 0.15)',
        '#000000',
      ),
      CheckboxVariant.error => (
        'linear-gradient(135deg, var(--destructive) 0%, color-mix(in srgb, var(--destructive) 70%, #ff0066) 100%)',
        'var(--destructive)',
        '0 0 20px rgba(var(--destructive-rgb), 0.4), 0 0 40px rgba(var(--destructive-rgb), 0.15)',
        '#ffffff',
      ),
    };

    return dom.div(
      classes: 'codex-checkbox-wrapper codex-neon',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '1rem',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.4' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
      }),
      events: props.disabled || props.onChanged == null
          ? null
          : {
              'click': (event) => props.onChanged!(!props.checked),
            },
      [
        // Neon checkbox box
        dom.div(
          classes: 'codex-checkbox codex-neon',
          styles: dom.Styles(raw: {
            'width': boxSize,
            'height': boxSize,
            // Codex Neon: rounded corners
            'border-radius': 'var(--radius-sm)',
            'background': props.checked
                ? checkedBg
                : 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
            'border': props.checked
                ? '1px solid $borderColor'
                : '1px solid rgba(var(--border-rgb), 0.5)',
            // Neon glow when checked
            'box-shadow': props.checked ? glowColor : '0 0 10px rgba(var(--primary-rgb), 0.1)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
          }),
          [
            if (props.checked)
              dom.span(
                styles: dom.Styles(raw: {
                  'color': checkColor,
                  'font-size': checkSize,
                  'font-weight': 'var(--font-weight-bold)',
                  'line-height': '1',
                  'text-shadow': '0 0 8px currentColor',
                  'animation': 'codex-check-pop 0.2s ease-out',
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
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--foreground)',
                    'display': 'block',
                    'line-height': '1.4',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.description != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                    'display': 'block',
                    'margin-top': '0.375rem',
                    'line-height': '1.4',
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),
      ],
    );
  }
}
