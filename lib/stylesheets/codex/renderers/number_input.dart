import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/number_input_props.dart';

/// Codex Number Input renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon buttons with gradient backgrounds
/// - Holographic value display with neon accents
/// - Intense glow effects on interactive states
/// - Cyberpunk-style increment/decrement controls
class CodexNumberInput extends StatelessComponent {
  final NumberInputProps props;

  const CodexNumberInput(this.props);

  @override
  Component build(BuildContext context) {
    // Codex Neon sizes - larger with more presence
    final (height, fontSize, buttonWidth) = switch (props.size) {
      ComponentSize.sm => ('44px', '0.875rem', '44px'),
      ComponentSize.md => ('52px', '1rem', '52px'),
      ComponentSize.lg => ('60px', '1.125rem', '60px'),
    };

    final bool canDecrement = props.value > props.min;
    final bool canIncrement = props.value < props.max;
    final String displayValue = props.decimals > 0
        ? props.value.toStringAsFixed(props.decimals)
        : props.value.toInt().toString();

    return div(
      classes: 'codex-number-input codex-neon',
      id: props.id,
      attributes: {
        'data-value': props.value.toString(),
        'data-min': props.min.toString(),
        'data-max': props.max.toString(),
        'data-step': props.step.toString(),
        'data-decimals': props.decimals.toString(),
        'data-disabled': props.disabled.toString(),
        ...?props.attributes,
      },
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.875rem',
      }),
      [
        // Label with neon styling
        if (props.label != null)
          span(
            classes: 'codex-number-input-label codex-neon',
            styles: const Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Neon input container
        div(
          classes: 'codex-number-input-container codex-neon',
          styles: Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'stretch',
            'height': height,
            'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
            'border': '1px solid rgba(var(--primary-rgb), 0.3)',
            'border-radius': 'var(--radius)',
            'overflow': 'hidden',
            'opacity': props.disabled ? '0.4' : '1',
            'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.1)',
          }),
          [
            // Neon decrement button
            button(
              type: ButtonType.button,
              classes: 'codex-number-input-decrement codex-neon',
              attributes: {
                if (!canDecrement || props.disabled) 'disabled': 'true',
              },
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': buttonWidth,
                'height': '100%',
                'padding': '0',
                'border': 'none',
                'border-right': '1px solid rgba(var(--border-rgb), 0.3)',
                'background': (canDecrement && !props.disabled)
                    ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)'
                    : 'rgba(var(--muted-rgb), 0.2)',
                'color': (canDecrement && !props.disabled)
                    ? 'var(--primary)'
                    : 'var(--muted-foreground)',
                'font-size': '1.25rem',
                'font-weight': 'var(--font-weight-bold)',
                'cursor':
                    (canDecrement && !props.disabled) ? 'pointer' : 'not-allowed',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                'user-select': 'none',
                // Neon glow when active
                'text-shadow': (canDecrement && !props.disabled)
                    ? '0 0 10px rgba(var(--primary-rgb), 0.5)'
                    : 'none',
              }),
              events: (canDecrement && !props.disabled)
                  ? {
                      'click': (_) {
                        final num newValue =
                            (props.value - props.step).clamp(props.min, props.max);
                        props.onChanged?.call(
                            props.decimals > 0 ? newValue : newValue.toInt());
                      },
                    }
                  : null,
              [const Component.text('-')],
            ),

            // Neon value display
            div(
              classes: 'codex-number-input-value codex-neon',
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'gap': 'var(--space-2)',
                'min-width': '90px',
                'padding': '0 1rem',
                'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.4) 0%, rgba(var(--card-rgb), 0.3) 100%)',
                'font-size': fontSize,
                'font-weight': 'var(--font-weight-semibold)',
                'font-variant-numeric': 'tabular-nums',
                'color': 'var(--primary)',
                // Neon text glow
                'text-shadow': '0 0 10px rgba(var(--primary-rgb), 0.4)',
              }),
              [
                if (props.prefix != null)
                  span(
                    classes: 'codex-number-input-prefix',
                    styles:
                        const Styles(raw: {'color': 'var(--muted-foreground)'}),
                    [Component.text(props.prefix!)],
                  ),
                span(
                  classes: 'codex-number-input-display',
                  [Component.text(displayValue)],
                ),
                if (props.suffix != null)
                  span(
                    classes: 'codex-number-input-suffix',
                    styles:
                        const Styles(raw: {'color': 'var(--muted-foreground)'}),
                    [Component.text(props.suffix!)],
                  ),
              ],
            ),

            // Neon increment button
            button(
              type: ButtonType.button,
              classes: 'codex-number-input-increment codex-neon',
              attributes: {
                if (!canIncrement || props.disabled) 'disabled': 'true',
              },
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': buttonWidth,
                'height': '100%',
                'padding': '0',
                'border': 'none',
                'border-left': '1px solid rgba(var(--border-rgb), 0.3)',
                'background': (canIncrement && !props.disabled)
                    ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)'
                    : 'rgba(var(--muted-rgb), 0.2)',
                'color': (canIncrement && !props.disabled)
                    ? 'var(--primary)'
                    : 'var(--muted-foreground)',
                'font-size': '1.25rem',
                'font-weight': 'var(--font-weight-bold)',
                'cursor':
                    (canIncrement && !props.disabled) ? 'pointer' : 'not-allowed',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                'user-select': 'none',
                // Neon glow when active
                'text-shadow': (canIncrement && !props.disabled)
                    ? '0 0 10px rgba(var(--primary-rgb), 0.5)'
                    : 'none',
              }),
              events: (canIncrement && !props.disabled)
                  ? {
                      'click': (_) {
                        final num newValue =
                            (props.value + props.step).clamp(props.min, props.max);
                        props.onChanged?.call(
                            props.decimals > 0 ? newValue : newValue.toInt());
                      },
                    }
                  : null,
              [const Component.text('+')],
            ),
          ],
        ),
      ],
    );
  }
}
