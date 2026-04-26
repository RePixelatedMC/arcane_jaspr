import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/radio_group_props.dart';

/// Neon radio group renderer with restrained dark styling.
class NeonRadioGroup<T> extends StatelessComponent {
  final RadioGroupProps<T> props;

  const NeonRadioGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final Map<String, String> layoutStyles = switch (props.layout) {
      RadioGroupLayout.vertical => {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': props.gap,
      },
      RadioGroupLayout.horizontal => {
        'display': 'flex',
        'flex-wrap': 'wrap',
        'gap': props.gap,
      },
      RadioGroupLayout.grid => {
        'display': 'grid',
        'grid-template-columns': 'repeat(${props.gridColumns}, minmax(0, 1fr))',
        'gap': props.gap,
      },
    };

    return dom.div(
      classes: 'neon-radio-group ${props.disabled ? 'disabled' : ''}',
      attributes: {
        'data-disabled': '${props.disabled}',
        'data-layout': props.layout.name,
        'data-variant': props.variant.name,
      },
      styles: dom.Styles(
        raw: {'width': '100%', 'opacity': props.disabled ? '0.55' : '1'},
      ),
      [
        if (props.label != null)
          dom.div(
            classes: 'neon-radio-group-label',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--foreground)',
                'margin-bottom': '0.65rem',
              },
            ),
            [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(
                    raw: {
                      'color': 'var(--destructive)',
                      'margin-left': '0.35rem',
                    },
                  ),
                  [Component.text('*')],
                ),
            ],
          ),
        dom.div(
          classes: 'neon-radio-group-options',
          styles: dom.Styles(raw: layoutStyles),
          [
            for (final RadioOptionProps<T> option in props.options)
              _buildOption(option),
          ],
        ),
        if (props.error != null)
          dom.div(
            classes: 'neon-radio-group-error',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
                'margin-top': '0.6rem',
              },
            ),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'neon-radio-group-helper',
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
                'margin-top': '0.6rem',
              },
            ),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }

  Component _buildOption(RadioOptionProps<T> option) {
    final bool isSelected = props.value == option.value;
    final bool isDisabled = props.disabled || option.disabled;

    return switch (props.variant) {
      RadioGroupVariant.standard => _standardOption(
        option,
        isSelected,
        isDisabled,
      ),
      RadioGroupVariant.cards => _cardOption(option, isSelected, isDisabled),
      RadioGroupVariant.buttons => _buttonOption(
        option,
        isSelected,
        isDisabled,
      ),
      RadioGroupVariant.chips => _chipOption(option, isSelected, isDisabled),
    };
  }

  Component _standardOption(
    RadioOptionProps<T> option,
    bool isSelected,
    bool isDisabled,
  ) {
    return dom.label(
      classes:
          'neon-radio-option ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '0.7rem',
          'padding': '0.25rem 0',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
        },
      ),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        dom.div(
          classes: 'neon-radio-circle',
          styles: dom.Styles(
            raw: {
              'width': '18px',
              'height': '18px',
              'border-radius': '50%',
              'border': isSelected
                  ? '2px solid var(--neon-accent)'
                  : '2px solid var(--border)',
              'background': 'var(--neon-surface-1)',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'margin-top': '2px',
            },
          ),
          [
            if (isSelected)
              const dom.div(
                styles: dom.Styles(
                  raw: {
                    'width': '8px',
                    'height': '8px',
                    'border-radius': '50%',
                    'background': 'var(--neon-accent)',
                  },
                ),
                [],
              ),
          ],
        ),
        _optionText(option, isSelected),
      ],
    );
  }

  Component _cardOption(
    RadioOptionProps<T> option,
    bool isSelected,
    bool isDisabled,
  ) {
    return dom.div(
      classes:
          'neon-radio-card ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'flex-start',
          'gap': '0.7rem',
          'padding': '0.9rem 1rem',
          'border-radius': 'var(--radius)',
          'border': isSelected
              ? '1px solid var(--neon-accent-border)'
              : '1px solid var(--border)',
          'background': isSelected
              ? 'color-mix(in srgb, var(--neon-accent) 12%, var(--neon-surface-2))'
              : 'var(--neon-surface-1)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
        },
      ),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [if (option.icon != null) option.icon!, _optionText(option, isSelected)],
    );
  }

  Component _buttonOption(
    RadioOptionProps<T> option,
    bool isSelected,
    bool isDisabled,
  ) {
    return dom.button(
      classes:
          'neon-radio-button ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.55rem',
          'padding': '0.6rem 1rem',
          'border-radius': 'var(--radius)',
          'border': isSelected
              ? '1px solid var(--neon-accent-border)'
              : '1px solid var(--border)',
          'background': isSelected
              ? 'linear-gradient(180deg, color-mix(in srgb, var(--neon-accent) 20%, var(--neon-surface-2)), var(--neon-surface-2))'
              : 'var(--neon-surface-1)',
          'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
        },
      ),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [if (option.icon != null) option.icon!, Component.text(option.label)],
    );
  }

  Component _chipOption(
    RadioOptionProps<T> option,
    bool isSelected,
    bool isDisabled,
  ) {
    return dom.button(
      classes:
          'neon-radio-chip ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': '0.45rem',
          'padding': '0.45rem 0.8rem',
          'border-radius': '999px',
          'border': isSelected
              ? '1px solid var(--neon-accent-border)'
              : '1px solid var(--border)',
          'background': isSelected
              ? 'color-mix(in srgb, var(--neon-accent) 14%, var(--neon-surface-2))'
              : 'var(--neon-surface-1)',
          'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
        },
      ),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [if (option.icon != null) option.icon!, Component.text(option.label)],
    );
  }

  Component _optionText(RadioOptionProps<T> option, bool isSelected) {
    return dom.div(styles: const dom.Styles(raw: {'flex': '1'}), [
      dom.div(
        styles: dom.Styles(
          raw: {
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
          },
        ),
        [Component.text(option.label)],
      ),
      if (option.description != null)
        dom.div(
          styles: const dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.2rem',
              'line-height': '1.35',
            },
          ),
          [Component.text(option.description!)],
        ),
    ]);
  }
}
