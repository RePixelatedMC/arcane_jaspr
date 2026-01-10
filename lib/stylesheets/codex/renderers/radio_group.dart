import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/radio_group_props.dart';

/// Codex Radio Group renderer.
///
/// Implements the Codex design language:
/// - Larger radio buttons (1.25x)
/// - Accent-colored when selected with subtle glow
/// - More spacing between options
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
      classes: 'codex-radio-group',
      styles: dom.Styles(raw: {
        'width': '100%',
        'opacity': props.disabled ? '0.5' : '1',
      }),
      [
        // Label
        if (props.label != null)
          dom.div(
            classes: 'codex-radio-group-label',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': 'var(--foreground)',
              'margin-bottom': '0.75rem', // Codex: more margin
            }),
            [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {
                    'color': 'var(--destructive)',
                    'margin-left': '0.25rem',
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

        // Helper text or error
        if (props.error != null)
          dom.div(
            classes: 'codex-radio-group-error',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--destructive)',
              'margin-top': '0.5rem',
            }),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'codex-radio-group-helper',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.5rem',
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
      classes: 'codex-radio-option ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.75rem', // Codex: more gap
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'padding': '0.375rem 0',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        // Radio circle - Codex larger size
        dom.div(
          classes: 'codex-radio-circle',
          styles: dom.Styles(raw: {
            'width': '20px', // Codex: larger (vs 16px)
            'height': '20px',
            'border-radius': 'var(--arcane-radius-full)',
            'border': isSelected
                ? '2px solid var(--codex-accent)'
                : '2px solid var(--border)',
            'background-color': 'transparent',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            'transition': 'all var(--transition)',
            // Codex: subtle glow when selected
            if (isSelected) 'box-shadow': 'var(--codex-accent-glow-subtle)',
          }),
          [
            if (isSelected)
              const dom.div(
                styles: dom.Styles(raw: {
                  'width': '10px',
                  'height': '10px',
                  'border-radius': 'var(--arcane-radius-full)',
                  'background-color': 'var(--codex-accent)',
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
                'gap': 'var(--arcane-space-2)',
              }),
              [
                if (option.icon != null) option.icon!,
                dom.span(
                  styles: const dom.Styles(raw: {
                    'font-size': 'var(--arcane-font-size-sm)',
                    'font-weight': 'var(--arcane-font-weight-medium)',
                    'color': 'var(--foreground)',
                  }),
                  [Component.text(option.label)],
                ),
              ],
            ),
            if (option.description != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
                  'display': 'block',
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
      classes: 'codex-radio-card ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': '0.75rem',
        'padding': '1rem 1.25rem', // Codex: more padding
        'background-color': isSelected
            ? 'rgba(var(--codex-accent-rgb), 0.1)'
            : 'var(--card)',
        'border': isSelected
            ? '1px solid var(--codex-accent)'
            : '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all var(--transition)',
        // Codex: subtle glow when selected
        if (isSelected) 'box-shadow': 'var(--codex-accent-glow-subtle)',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        if (option.icon != null)
          dom.div(
            styles: dom.Styles(raw: {
              'color': isSelected ? 'var(--codex-accent)' : 'var(--muted-foreground)',
            }),
            [option.icon!],
          ),
        dom.div(
          styles: const dom.Styles(raw: {'flex': '1'}),
          [
            dom.div(
              styles: dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-sm)',
                'font-weight': 'var(--arcane-font-weight-medium)',
                'color': isSelected ? 'var(--codex-accent)' : 'var(--foreground)',
              }),
              [Component.text(option.label)],
            ),
            if (option.description != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '0.25rem',
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
      classes: 'codex-radio-button ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': 'var(--arcane-space-2)',
        'padding': '0.625rem 1rem', // Codex: more padding
        'background-color': isSelected ? 'var(--codex-accent)' : 'transparent',
        'color': isSelected ? '#ffffff' : 'var(--foreground)',
        'border': isSelected ? 'none' : '1px solid var(--border)',
        'border-radius': 'var(--radius-md)',
        'font-size': 'var(--arcane-font-size-sm)',
        'font-weight': 'var(--arcane-font-weight-medium)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all var(--transition)',
        // Codex: glow when selected
        if (isSelected) 'box-shadow': 'var(--codex-accent-glow-medium)',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        if (option.icon != null) option.icon!,
        Component.text(option.label),
      ],
    );
  }

  Component _buildChipRadio(RadioOptionProps<T> option, bool isSelected, bool isDisabled) {
    return dom.button(
      classes: 'codex-radio-chip ${isSelected ? 'selected' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'padding': '0.375rem 0.875rem',
        'background-color': isSelected
            ? 'var(--codex-accent)'
            : 'var(--secondary)',
        'color': isSelected ? '#ffffff' : 'var(--foreground)',
        'border': 'none',
        'border-radius': 'var(--arcane-radius-full)',
        'font-size': 'var(--arcane-font-size-xs)',
        'font-weight': 'var(--arcane-font-weight-medium)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all var(--transition)',
        if (isSelected) 'box-shadow': 'var(--codex-accent-glow-subtle)',
      }),
      events: isDisabled
          ? null
          : {'click': (_) => props.onChanged?.call(option.value)},
      [
        if (option.icon != null) option.icon!,
        Component.text(option.label),
      ],
    );
  }
}