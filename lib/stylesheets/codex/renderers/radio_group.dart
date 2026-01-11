import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/radio_group_props.dart';

/// Codex Radio Group renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon radio buttons with pulse effect
/// - Holographic card variants with glass morphism
/// - Cyberpunk-style button and chip variants
/// - Intense accent glows on selection
class CodexRadioGroup<T> extends StatelessComponent {
  final RadioGroupProps<T> props;

  const CodexRadioGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Layout styles
    final Map<String, String> layoutStyles = switch (props.layout) {
      RadioGroupLayout.vertical => {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': props.gap,
      },
      RadioGroupLayout.horizontal => {
        'display': 'flex',
        'flex-direction': 'row',
        'flex-wrap': 'wrap',
        'gap': props.gap,
      },
      RadioGroupLayout.grid => {
        'display': 'grid',
        'grid-template-columns': 'repeat(${props.gridColumns}, 1fr)',
        'gap': props.gap,
      },
    };

    return dom.div(
      classes: 'codex-radio-group codex-neon',
      styles: dom.Styles(raw: {
        'width': '100%',
        'opacity': props.disabled ? '0.4' : '1',
      }),
      [
        // Label with neon accent
        if (props.label != null)
          dom.div(
            classes: 'codex-radio-group-label codex-neon',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'color': 'var(--foreground)',
              'margin-bottom': '1rem',
            }),
            [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--primary)',
                    'margin-left': '0.375rem',
                    'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.5)',
                  }),
                  [Component.text('*')],
                ),
            ],
          ),

        // Options
        dom.div(
          classes: 'codex-radio-group-options',
          styles: dom.Styles(raw: layoutStyles),
          [
            for (final option in props.options)
              _buildOption(option),
          ],
        ),

        // Error with neon glow or helper text
        if (props.error != null)
          dom.div(
            classes: 'codex-radio-group-error',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--destructive)',
              'text-shadow': '0 0 8px rgba(var(--destructive-rgb), 0.4)',
              'margin-top': '0.75rem',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'codex-radio-group-helper',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.75rem',
            }),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }

  Component _buildOption(RadioOptionProps<T> option) {
    final bool isSelected = props.value == option.value;
    final bool isDisabled = props.disabled || option.disabled;

    return switch (props.variant) {
      RadioGroupVariant.standard => _buildStandardRadio(option, isSelected, isDisabled),
      RadioGroupVariant.cards => _buildCardRadio(option, isSelected, isDisabled),
      RadioGroupVariant.buttons => _buildButtonRadio(option, isSelected, isDisabled),
      RadioGroupVariant.chips => _buildChipRadio(option, isSelected, isDisabled),
    };
  }

  Component _buildStandardRadio(RadioOptionProps<T> option, bool isSelected, bool isDisabled) {
    return dom.label(
      classes: 'codex-radio-option codex-neon ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '1rem',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'padding': '0.5rem 0',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        // Neon radio circle
        dom.div(
          classes: 'codex-radio-circle codex-neon',
          styles: dom.Styles(raw: {
            'width': '24px',
            'height': '24px',
            'border-radius': '50%',
            'border': isSelected
                ? '2px solid var(--primary)'
                : '2px solid rgba(var(--border-rgb), 0.5)',
            'background': isSelected
                ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)'
                : 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            // Neon glow when selected
            'box-shadow': isSelected
                ? '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.15)'
                : '0 0 10px rgba(var(--primary-rgb), 0.05)',
          }),
          [
            if (isSelected)
              const dom.div(
                styles: dom.Styles(raw: {
                  'width': '10px',
                  'height': '10px',
                  'border-radius': '50%',
                  'background': 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)',
                  'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.5)',
                  'animation': 'codex-pulse 2s ease-in-out infinite',
                }),
                [],
              ),
          ],
        ),

        // Label and description
        dom.div(
          styles: const dom.Styles(raw: {'flex': '1'}),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.5rem',
              }),
              [
                if (option.icon != null)
                  dom.div(
                    styles: dom.Styles(raw: {
                      'color': isSelected ? 'var(--primary)' : 'var(--muted-foreground)',
                      'filter': isSelected ? 'drop-shadow(0 0 4px currentColor)' : 'none',
                    }),
                    [option.icon!],
                  ),
                dom.span(
                  styles: dom.Styles(raw: {
                    'font-size': 'var(--font-size-sm)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': isSelected ? 'var(--primary)' : 'var(--foreground)',
                  }),
                  [Component.text(option.label)],
                ),
              ],
            ),
            if (option.description != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.375rem',
                  'display': 'block',
                  'line-height': '1.4',
                }),
                [Component.text(option.description!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildCardRadio(RadioOptionProps<T> option, bool isSelected, bool isDisabled) {
    return dom.div(
      classes: 'codex-radio-card codex-neon ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '1rem',
        'padding': '1.25rem 1.5rem',
        'background': isSelected
            ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.15) 0%, rgba(var(--primary-rgb), 0.05) 100%)'
            : 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
        'border': isSelected
            ? '1px solid var(--primary)'
            : '1px solid rgba(var(--border-rgb), 0.3)',
        'border-radius': 'var(--radius)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        // Neon glow when selected
        'box-shadow': isSelected
            ? '0 0 25px rgba(var(--primary-rgb), 0.3), 0 0 50px rgba(var(--primary-rgb), 0.1)'
            : '0 0 10px rgba(var(--primary-rgb), 0.05)',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        if (option.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'color': isSelected ? 'var(--primary)' : 'var(--muted-foreground)',
              'filter': isSelected ? 'drop-shadow(0 0 6px currentColor)' : 'none',
            }),
            [option.icon!],
          ),
        dom.div(
          styles: const dom.Styles(raw: {'flex': '1'}),
          [
            dom.div(
              styles: dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': isSelected ? 'var(--primary)' : 'var(--foreground)',
                'text-shadow': isSelected ? '0 0 8px rgba(var(--primary-rgb), 0.3)' : 'none',
              }),
              [Component.text(option.label)],
            ),
            if (option.description != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.375rem',
                  'line-height': '1.4',
                }),
                [Component.text(option.description!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildButtonRadio(RadioOptionProps<T> option, bool isSelected, bool isDisabled) {
    return dom.button(
      classes: 'codex-radio-button codex-neon ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.5rem',
        'padding': '0.75rem 1.25rem',
        'background': isSelected
            ? 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)'
            : 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
        'color': isSelected ? '#ffffff' : 'var(--foreground)',
        'border': isSelected ? 'none' : '1px solid rgba(var(--border-rgb), 0.5)',
        'border-radius': 'var(--radius)',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-semibold)',
        'letter-spacing': '0.025em',
        'text-transform': 'uppercase',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        // Neon glow when selected
        'box-shadow': isSelected
            ? '0 0 20px rgba(var(--primary-rgb), 0.4), 0 0 40px rgba(var(--primary-rgb), 0.15), inset 0 1px 0 rgba(255, 255, 255, 0.1)'
            : '0 0 10px rgba(var(--primary-rgb), 0.05)',
        'text-shadow': isSelected ? '0 0 10px rgba(255, 255, 255, 0.5)' : 'none',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        if (option.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'filter': isSelected ? 'drop-shadow(0 0 4px currentColor)' : 'none',
            }),
            [option.icon!],
          ),
        Component.text(option.label),
      ],
    );
  }

  Component _buildChipRadio(RadioOptionProps<T> option, bool isSelected, bool isDisabled) {
    return dom.button(
      classes: 'codex-radio-chip codex-neon ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': '0.5rem 1rem',
        'background': isSelected
            ? 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)'
            : 'linear-gradient(135deg, rgba(var(--secondary-rgb), 0.8) 0%, rgba(var(--secondary-rgb), 0.6) 100%)',
        'color': isSelected ? '#ffffff' : 'var(--foreground)',
        'border': 'none',
        'border-radius': '9999px',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        'box-shadow': isSelected
            ? '0 0 15px rgba(var(--primary-rgb), 0.4), 0 0 30px rgba(var(--primary-rgb), 0.15)'
            : '0 0 8px rgba(var(--primary-rgb), 0.05)',
        'text-shadow': isSelected ? '0 0 8px rgba(255, 255, 255, 0.5)' : 'none',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        if (option.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'filter': isSelected ? 'drop-shadow(0 0 4px currentColor)' : 'none',
            }),
            [option.icon!],
          ),
        Component.text(option.label),
      ],
    );
  }
}
