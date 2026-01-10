import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../../core/props/number_input_props.dart';

/// Codex Number Input renderer.
class CodexNumberInput extends StatelessComponent {
  final NumberInputProps props;

  const CodexNumberInput(this.props);

  @override
  Component build(BuildContext context) {
    final (height, fontSize, buttonWidth) = switch (props.size) {
      NumberInputSize.sm => ('36px', '0.875rem', '36px'),
      NumberInputSize.md => ('44px', '1rem', '44px'),
      NumberInputSize.lg => ('52px', '1.125rem', '52px'),
    };

    final bool canDecrement = props.value > props.min;
    final bool canIncrement = props.value < props.max;
    final String displayValue = props.decimals > 0
        ? props.value.toStringAsFixed(props.decimals)
        : props.value.toInt().toString();

    return div(
      classes: 'codex-number-input',
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
        'gap': '0.75rem',
      }),
      [
        // Label
        if (props.label != null)
          span(
            classes: 'codex-number-input-label',
            styles: const Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Input container
        div(
          classes: 'codex-number-input-container',
          styles: Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'stretch',
            'height': height,
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'overflow': 'hidden',
            'opacity': props.disabled ? '0.5' : '1',
          }),
          [
            // Decrement button
            button(
              type: ButtonType.button,
              classes: 'codex-number-input-decrement',
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
                'border-right': '1px solid var(--border)',
                'background': (canDecrement && !props.disabled)
                    ? 'var(--secondary)'
                    : 'var(--card)',
                'color': (canDecrement && !props.disabled)
                    ? 'var(--foreground)'
                    : 'var(--muted-foreground)',
                'font-size': fontSize,
                'font-weight': 'var(--font-weight-bold)',
                'cursor':
                    (canDecrement && !props.disabled) ? 'pointer' : 'not-allowed',
                'transition': 'all var(--arcane-transition)',
                'user-select': 'none',
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

            // Value display
            div(
              classes: 'codex-number-input-value',
              styles: Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'gap': 'var(--space-2)',
                'min-width': '70px',
                'padding': '0 0.75rem',
                'background': 'var(--input)',
                'font-size': fontSize,
                'font-weight': 'var(--font-weight-medium)',
                'font-variant-numeric': 'tabular-nums',
                'color': 'var(--foreground)',
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

            // Increment button
            button(
              type: ButtonType.button,
              classes: 'codex-number-input-increment',
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
                'border-left': '1px solid var(--border)',
                'background': (canIncrement && !props.disabled)
                    ? 'var(--secondary)'
                    : 'var(--card)',
                'color': (canIncrement && !props.disabled)
                    ? 'var(--foreground)'
                    : 'var(--muted-foreground)',
                'font-size': fontSize,
                'font-weight': 'var(--font-weight-bold)',
                'cursor':
                    (canIncrement && !props.disabled) ? 'pointer' : 'not-allowed',
                'transition': 'all var(--arcane-transition)',
                'user-select': 'none',
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
