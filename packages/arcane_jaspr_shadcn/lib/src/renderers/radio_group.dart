import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/radio_group_props.dart';

/// ShadCN Radio Group renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/radio-group
///
/// ShadCN Radio Group:
/// - Radio: h-4 w-4 (16px), rounded-full, border border-primary
/// - Selected: inner dot h-2.5 w-2.5 (10px), bg-primary
/// - Focus: ring-2 ring-ring ring-offset-2
/// - Disabled: opacity-50, cursor-not-allowed
class ShadcnRadioGroup<T> extends StatelessComponent {
  final RadioGroupProps<T> props;

  const ShadcnRadioGroup(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null;
    final String groupName = props.name ?? 'radio_${identityHashCode(this)}';

    return dom.div(
      classes: 'arcane-radio-group',
      attributes: {
        'role': 'radiogroup',
        if (props.label != null) 'aria-labelledby': '${groupName}_label',
        'data-disabled': '${props.disabled}',
      },
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)', // ShadCN: space-y-2
        },
      ),
      [
        // Label - ShadCN: text-sm font-medium
        if (props.label != null)
          Component.element(
            tag: 'label',
            id: '${groupName}_label',
            styles: const dom.Styles(
              raw: {
                // ShadCN: text-sm font-medium
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--foreground)',
              },
            ),
            children: [
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(raw: {'color': 'var(--destructive)'}),
                  [Component.text(' *')],
                ),
            ],
          ),

        // Options container
        dom.div(
          classes: 'arcane-radio-group-options',
          styles: dom.Styles(
            raw: {
              'display': props.layout == RadioGroupLayout.grid
                  ? 'grid'
                  : 'flex',
              'flex-direction': props.layout == RadioGroupLayout.horizontal
                  ? 'row'
                  : 'column',
              'flex-wrap': props.layout == RadioGroupLayout.horizontal
                  ? 'wrap'
                  : 'nowrap',
              'gap': props.gap,
              if (props.layout == RadioGroupLayout.grid)
                'grid-template-columns': 'repeat(${props.gridColumns}, 1fr)',
            },
          ),
          [
            for (final option in props.options)
              _buildOption(option, groupName, hasError),
          ],
        ),

        // Error or helper text - ShadCN: text-sm text-muted-foreground
        if (props.error != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                // ShadCN: text-sm text-destructive
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            [Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                // ShadCN: text-sm text-muted-foreground
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }

  Component _buildOption(
    RadioOptionProps<T> option,
    String groupName,
    bool hasError,
  ) {
    final bool isSelected = props.value == option.value;
    final bool isDisabled = props.disabled || option.disabled;

    return switch (props.variant) {
      RadioGroupVariant.standard => _buildStandardRadio(
        option,
        groupName,
        isSelected,
        isDisabled,
        hasError,
      ),
      RadioGroupVariant.cards => _buildCardRadio(
        option,
        groupName,
        isSelected,
        isDisabled,
        hasError,
      ),
      RadioGroupVariant.buttons => _buildButtonRadio(
        option,
        groupName,
        isSelected,
        isDisabled,
      ),
      RadioGroupVariant.chips => _buildChipRadio(
        option,
        groupName,
        isSelected,
        isDisabled,
      ),
    };
  }

  Component _buildStandardRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-item',
      attributes: {
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': option.description != null ? 'flex-start' : 'center',
          'gap': 'var(--space-2)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          // ShadCN: disabled:opacity-50 disabled:cursor-not-allowed
          'opacity': isDisabled ? '0.5' : '1',
          'pointer-events': isDisabled ? 'none' : 'auto',
        },
      ),
      children: [
        // Radio input (hidden, for accessibility)
        dom.input(
          type: dom.InputType.radio,
          classes: 'arcane-radio-input',
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
            'data-state': isSelected ? 'checked' : 'unchecked',
            'data-disabled': '$isDisabled',
          },
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'opacity': '0',
              'pointer-events': 'none',
            },
          ),
          events: {
            if (!isDisabled && props.onChanged != null)
              'change': (e) => props.onChanged!(option.value),
          },
        ),

        // Custom radio circle - ShadCN styling
        // h-4 w-4 (16px), rounded-full, border border-primary
        dom.div(
          classes: 'arcane-radio-circle',
          attributes: {
            'data-state': isSelected ? 'checked' : 'unchecked',
            'data-disabled': '$isDisabled',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              // ShadCN: h-4 w-4 (16px)
              'width': '16px',
              'height': '16px',
              // ShadCN: rounded-full
              'border-radius': 'var(--radius-full)',
              // ShadCN: border border-primary
              'border': hasError
                  ? '1px solid var(--destructive)'
                  : '1px solid var(--primary)',
              'background': 'transparent',
              'flex-shrink': '0',
              // ShadCN: transition-colors
              'transition':
                  'color var(--transition), background-color var(--transition), border-color var(--transition)',
            },
          ),
          [
            // Inner dot when selected - ShadCN: h-2.5 w-2.5 (10px), bg-primary
            if (isSelected)
              const dom.div(
                styles: dom.Styles(
                  raw: {
                    // ShadCN: h-2.5 w-2.5 (10px)
                    'width': '10px',
                    'height': '10px',
                    // ShadCN: rounded-full
                    'border-radius': 'var(--radius-full)',
                    // ShadCN: bg-primary
                    'background': 'var(--primary)',
                  },
                ),
                [],
              ),
          ],
        ),

        // Label content
        dom.div(
          classes: 'arcane-radio-content',
          styles: const dom.Styles(raw: {'flex': '1'}),
          [
            // Icon + Label row
            dom.div(
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'gap': 'var(--space-1)',
                },
              ),
              [
                if (option.icon != null) option.icon!,
                dom.span(
                  styles: const dom.Styles(
                    raw: {
                      // ShadCN: text-sm font-medium
                      'font-size': 'var(--font-size-sm)',
                      'font-weight': 'var(--font-weight-medium)',
                      'color': 'var(--foreground)',
                      'line-height': '1',
                    },
                  ),
                  [Component.text(option.label)],
                ),
              ],
            ),
            // Description
            if (option.description != null)
              dom.span(
                styles: const dom.Styles(
                  raw: {
                    // ShadCN: text-sm text-muted-foreground
                    'font-size': 'var(--font-size-sm)',
                    'color': 'var(--muted-foreground)',
                    'margin-top': '0.25rem',
                  },
                ),
                [Component.text(option.description!)],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildCardRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
    bool hasError,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-card',
      attributes: {
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-1)',
          'padding': '1rem',
          'border-radius': 'var(--radius-md)',
          'border': isSelected
              ? '2px solid var(--primary)'
              : hasError
              ? '2px solid var(--destructive)'
              : '1px solid var(--border)',
          'background': isSelected ? 'var(--accent)' : 'var(--card)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'opacity': isDisabled ? '0.5' : '1',
          'transition':
              'border-color var(--transition), background-color var(--transition)',
        },
      ),
      children: [
        // Hidden input
        dom.input(
          type: dom.InputType.radio,
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
            'data-state': isSelected ? 'checked' : 'unchecked',
            'data-disabled': '$isDisabled',
          },
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'opacity': '0',
              'pointer-events': 'none',
            },
          ),
          events: {
            if (!isDisabled && props.onChanged != null)
              'change': (e) => props.onChanged!(option.value),
          },
        ),

        // Header with icon and indicator
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
            },
          ),
          [
            if (option.icon != null)
              dom.div(
                styles: dom.Styles(
                  raw: {
                    'color': isSelected
                        ? 'var(--primary)'
                        : 'var(--muted-foreground)',
                  },
                ),
                [option.icon!],
              ),
            // Selection indicator
            dom.div(
              styles: dom.Styles(
                raw: {
                  'width': '16px',
                  'height': '16px',
                  'border-radius': 'var(--radius-full)',
                  'border': isSelected
                      ? '5px solid var(--primary)'
                      : '1px solid var(--border)',
                  'background': isSelected
                      ? 'var(--background)'
                      : 'var(--input)',
                },
              ),
              [],
            ),
          ],
        ),

        // Label
        dom.span(
          styles: dom.Styles(
            raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': isSelected ? 'var(--primary)' : 'var(--foreground)',
            },
          ),
          [Component.text(option.label)],
        ),

        // Description
        if (option.description != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              },
            ),
            [Component.text(option.description!)],
          ),
      ],
    );
  }

  Component _buildButtonRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-button',
      attributes: {
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': 'var(--space-1)',
          'padding': '0.5rem 1rem',
          'border': isSelected
              ? '1px solid var(--primary)'
              : '1px solid var(--border)',
          'background': isSelected ? 'var(--primary)' : 'var(--card)',
          'color': isSelected
              ? 'var(--primary-foreground)'
              : 'var(--foreground)',
          'font-size': 'var(--font-size-sm)',
          'font-weight': 'var(--font-weight-medium)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'opacity': isDisabled ? '0.5' : '1',
          'transition':
              'color var(--transition), background-color var(--transition), border-color var(--transition)',
          // Button group - no rounded corners in middle
          'border-radius': '0',
          'margin-left': '-1px',
        },
      ),
      children: [
        dom.input(
          type: dom.InputType.radio,
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
            'data-state': isSelected ? 'checked' : 'unchecked',
            'data-disabled': '$isDisabled',
          },
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'opacity': '0',
              'pointer-events': 'none',
            },
          ),
          events: {
            if (!isDisabled && props.onChanged != null)
              'change': (e) => props.onChanged!(option.value),
          },
        ),
        if (option.icon != null) option.icon!,
        Component.text(option.label),
      ],
    );
  }

  Component _buildChipRadio(
    RadioOptionProps<T> option,
    String groupName,
    bool isSelected,
    bool isDisabled,
  ) {
    return Component.element(
      tag: 'label',
      classes: 'arcane-radio-chip',
      attributes: {
        'data-state': isSelected ? 'checked' : 'unchecked',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'gap': 'var(--space-1)',
          'padding': '0.25rem 1rem',
          'border-radius': 'var(--radius-full)',
          'border': isSelected
              ? '1px solid var(--primary)'
              : '1px solid var(--border)',
          'background': isSelected ? 'var(--accent)' : 'var(--card)',
          'color': isSelected ? 'var(--primary)' : 'var(--foreground)',
          'font-size': 'var(--font-size-sm)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'opacity': isDisabled ? '0.5' : '1',
          'transition':
              'color var(--transition), background-color var(--transition), border-color var(--transition)',
        },
      ),
      children: [
        dom.input(
          type: dom.InputType.radio,
          attributes: {
            'name': groupName,
            'value': option.value.toString(),
            if (isSelected) 'checked': 'true',
            if (isDisabled) 'disabled': 'true',
            'data-state': isSelected ? 'checked' : 'unchecked',
            'data-disabled': '$isDisabled',
          },
          styles: const dom.Styles(
            raw: {
              'position': 'absolute',
              'opacity': '0',
              'pointer-events': 'none',
            },
          ),
          events: {
            if (!isDisabled && props.onChanged != null)
              'change': (e) => props.onChanged!(option.value),
          },
        ),
        if (option.icon != null) option.icon!,
        Component.text(option.label),
      ],
    );
  }
}
