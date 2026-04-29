import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/select_props.dart';

/// Neubrutalism Select renderer.
class NeubrutalismSelect<T> extends StatelessComponent {
  final SelectProps<T> props;

  const NeubrutalismSelect(this.props, {super.key});

  String _serializeValue(T? value) {
    if (value == null) return '';
    return value.toString();
  }

  @override
  Component build(BuildContext context) {
    final (
      String height,
      String fontSize,
      String padding,
    ) = switch (props.size) {
      ComponentSize.sm => ('40px', '0.8125rem', '0.625rem 1rem'),
      ComponentSize.md => ('48px', '0.875rem', '0.75rem 1.25rem'),
      ComponentSize.lg => ('56px', '1rem', '1rem 1.5rem'),
    };

    // Get display text
    final String displayText = _getDisplayText();

    final bool hasError = props.error != null;
    final String borderColor = hasError
        ? 'var(--destructive)'
        : 'var(--nb-line, #000)';
    const String shadowOffset =
        'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))';

    final String surfaceId =
        props.id ?? 'nb-select-${identityHashCode(props)}';
    final String triggerId = '$surfaceId-trigger';
    final String groupId = props.group ?? '$surfaceId-group';
    final String groupMode = props.multiSelect ? 'multi' : 'single';
    final String? groupValue = props.multiSelect
        ? (props.values ?? <T>[])
            .map(_serializeValue)
            .where((String s) => s.isNotEmpty)
            .join('\u001f')
        : _serializeValue(props.value);
    final String? changeActionEncoded = props.onSelectAction != null
        ? encodeArcaneAction(props.onSelectAction!)
        : null;

    final ArcaneInteraction toggleAction =
        ArcaneInteraction.togglePopover(surfaceId);
    final ArcaneInteraction dismissAction =
        ArcaneInteraction.closePopover(surfaceId);

    return dom.div(
      classes:
          'neubrutalism-select ${props.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: <String, String>{
        'data-disabled': '${props.disabled}',
        'data-size': props.size.name,
      },
      styles: const dom.Styles(raw: <String, String>{'position': 'relative', 'width': '100%'}),
      <Component>[
        if (props.label != null)
          dom.label(
            classes: 'neubrutalism-select-label',
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'block',
                'font-family': 'var(--font-heading)',
                'font-size': '0.75rem',
                'font-weight': '600',
                'letter-spacing': '0.08em',
                'text-transform': 'uppercase',
                'color': 'var(--muted-foreground)',
                'margin-bottom': '0.625rem',
              },
            ),
            <Component>[
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(
                    raw: <String, String>{'color': 'var(--nb-accent, var(--primary))', 'margin-left': '0.375rem'},
                  ),
                  <Component>[Component.text('*')],
                ),
            ],
          ),

        dom.button(
          classes: 'neubrutalism-select-trigger',
          attributes: <String, String>{
            'type': 'button',
            'aria-haspopup': 'listbox',
            'aria-controls': surfaceId,
            'aria-expanded': 'false',
            'data-disabled': '${props.disabled}',
            'data-variant': props.multiSelect ? 'multi' : 'single',
            'data-size': props.size.name,
            if (props.disabled) 'disabled': 'true',
            ...anchorAttrs(triggerId),
            ...interactionAttrs(toggleAction),
          },
          styles: dom.Styles(
            raw: <String, String>{
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'width': '100%',
              'height': height,
              'padding': padding,
              'background': 'var(--nb-paper, var(--card))',
              'border': 'var(--nb-border-thick, 3px) solid $borderColor',
              'border-radius': '0',
              'font-family': 'var(--font-body)',
              'font-weight': '600',
              'font-size': fontSize,
              'color':
                  props.value != null ||
                      (props.values != null && props.values!.isNotEmpty)
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'cursor': props.disabled ? 'not-allowed' : 'pointer',
              'outline': 'none',
              'box-shadow': shadowOffset,
              'transition':
                  'translate 0.12s ease, box-shadow 0.12s ease',
              if (props.disabled) 'opacity': '0.5',
            },
          ),
          events: props.disabled || props.onToggle == null
              ? null
              : <String, void Function(dynamic)>{
                  'click': (_) => props.onToggle!(),
                },
          <Component>[
            if (props.prefix != null)
              dom.span(
                styles: const dom.Styles(
                  raw: <String, String>{
                    'margin-right': '0.75rem',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                <Component>[props.prefix!],
              ),

            // Display text
            dom.span(
              styles: const dom.Styles(
                raw: <String, String>{
                  'flex': '1',
                  'text-align': 'left',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              <Component>[Component.text(displayText)],
            ),

            if (props.clearable &&
                (props.value != null ||
                    (props.values != null && props.values!.isNotEmpty)))
              dom.span(
                classes: 'neubrutalism-select-clear',
                attributes: interactionAttrs(
                  ArcaneInteraction.clearValue(groupId),
                ),
                styles: const dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '20px',
                    'height': '20px',
                    'margin-right': '0.5rem',
                    'color': 'var(--destructive)',
                    'cursor': 'pointer',
                    'transition': 'all 0.2s ease',
                  },
                ),
                events: props.onClear == null
                    ? null
                    : <String, void Function(dynamic)>{
                        'click': (dynamic e) {
                          (e as dynamic).stopPropagation();
                          props.onClear!();
                        },
                      },
                <Component>[ArcaneIcon.x(size: IconSize.xs)],
              ),

            dom.span(
              styles: const dom.Styles(
                raw: <String, String>{
                  'display': 'flex',
                  'align-items': 'center',
                  'color': 'var(--muted-foreground)',
                },
              ),
              <Component>[ArcaneIcon.chevronsUpDown(size: IconSize.sm)],
            ),
          ],
        ),

        dom.div(
          classes: 'neubrutalism-select-dropdown neubrutalism-select-content',
          attributes: <String, String>{
            'role': 'listbox',
            ...surfaceAttrs(
              surface: 'popover',
              id: surfaceId,
              initiallyOpen: props.isOpen,
              dismissible: true,
              escapeCloses: true,
              focusTrap: false,
              scrimCloses: true,
              restoreFocus: true,
              anchorId: triggerId,
              anchorPlacement: props.dropdownDirection ==
                      SelectDropdownDirection.up
                  ? 'top'
                  : 'bottom',
              anchorAlign: 'start',
              anchorOffset: '8',
            ),
            ...groupAttrs(
              groupId: groupId,
              mode: groupMode,
              value: groupValue,
              required: props.required,
              disabled: props.disabled,
              maxSelections: props.maxSelections?.toString(),
              changeAction: changeActionEncoded,
            ),
            'data-arcane-command': surfaceId,
          },
          styles: dom.Styles(
            raw: <String, String>{
              'z-index': '50',
              'min-width': '100%',
              'max-height': props.maxDropdownHeight ?? '320px',
              'overflow-y': 'auto',
              'background': 'var(--nb-paper, var(--card))',
              'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
              'border-radius': '0',
              'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
            },
          ),
          <Component>[
            if (props.searchable)
              dom.div(
                classes: 'neubrutalism-select-search',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'padding': '0.625rem',
                    'border-bottom': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                  },
                ),
                <Component>[
                  dom.input(
                    type: dom.InputType.text,
                    attributes: <String, String>{
                      'placeholder': props.searchPlaceholder,
                      'autocomplete': 'off',
                      'data-arcane-command-input': surfaceId,
                      'data-arcane-autofocus': 'true',
                    },
                    styles: const dom.Styles(
                      raw: <String, String>{
                        'width': '100%',
                        'padding': '0.5rem 0.75rem',
                        'background': 'var(--nb-paper-soft, var(--card))',
                        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                        'font-size': 'var(--font-size-sm)',
                        'color': 'var(--foreground)',
                        'outline': 'none',
                        'transition': 'border-color 0.18s ease',
                      },
                    ),
                    events: props.onSearchChange == null
                        ? null
                        : <String, void Function(dynamic)>{
                            'input': (dynamic e) {
                              final dynamic target = (e as dynamic).target;
                              final String? value = target?.value;
                              if (value != null) props.onSearchChange!(value);
                            },
                          },
                  ),
                ],
              ),

            if (props.loading)
              dom.div(
                classes: 'neubrutalism-select-loading',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'padding': '1.5rem',
                    'text-align': 'center',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                <Component>[Component.text(props.loadingText)],
              )
            else
              dom.div(
                classes: 'neubrutalism-select-options',
                styles: const dom.Styles(raw: <String, String>{'padding': '0.5rem'}),
                <Component>[
                  dom.div(
                    attributes: const <String, String>{
                      'data-arcane-command-empty': '',
                      'hidden': '',
                    },
                    classes: 'neubrutalism-select-empty',
                    styles: const dom.Styles(
                      raw: <String, String>{
                        'padding': '1.5rem',
                        'text-align': 'center',
                        'color': 'var(--muted-foreground)',
                      },
                    ),
                    <Component>[Component.text(props.emptyMessage)],
                  ),
                  if (props.options.isEmpty)
                    dom.div(
                      classes: 'neubrutalism-select-empty',
                      styles: const dom.Styles(
                        raw: <String, String>{
                          'padding': '1.5rem',
                          'text-align': 'center',
                          'color': 'var(--muted-foreground)',
                        },
                      ),
                      <Component>[Component.text(props.emptyMessage)],
                    )
                  else
                    for (final SelectOptionProps<T> option in props.options)
                      _buildOption(
                        option,
                        groupId: groupId,
                        groupMode: groupMode,
                        surfaceId: surfaceId,
                        dismissAction: dismissAction,
                      ),
                ],
              ),
          ],
        ),

        if (hasError)
          dom.div(
            classes: 'neubrutalism-select-error',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
                'margin-top': '0.75rem',
              },
            ),
            <Component>[Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.div(
            classes: 'neubrutalism-select-helper',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
                'margin-top': '0.75rem',
              },
            ),
            <Component>[Component.text(props.helperText!)],
          ),
      ],
    );
  }

  String _getDisplayText() {
    if (props.multiSelect) {
      if (props.values == null || props.values!.isEmpty) {
        return props.placeholder;
      }
      if (props.showSelectedCount) {
        return '${props.values!.length} selected';
      }
      final List<String> labels = props.values!
          .map((T v) => props.options.firstWhere((SelectOptionProps<T> o) => o.value == v).label)
          .toList();
      return labels.join(', ');
    }

    if (props.value == null) {
      return props.placeholder;
    }

    final SelectOptionProps<T>? selectedOption = props.options
        .where((SelectOptionProps<T> o) => o.value == props.value)
        .firstOrNull;

    return selectedOption?.label ?? props.placeholder;
  }

  Component _buildOption(
    SelectOptionProps<T> option, {
    required String groupId,
    required String groupMode,
    required String surfaceId,
    required ArcaneInteraction dismissAction,
  }) {
    final bool isSelected = props.multiSelect
        ? props.values?.contains(option.value) ?? false
        : props.value == option.value;
    final String value = _serializeValue(option.value);

    final ArcaneInteraction selectAction = groupMode == 'multi'
        ? ArcaneInteraction.toggleValue(groupId, value)
        : ArcaneInteraction.selectValue(groupId, value);
    final ArcaneInteraction itemAction =
        props.closeOnSelect && !props.multiSelect
            ? ArcaneInteraction.compose(<ArcaneInteraction>[selectAction, dismissAction])
            : selectAction;

    final List<String> keywords = <String>[
      option.label,
      if (option.description != null) option.description!,
      if (option.subtitle != null) option.subtitle!,
      if (option.searchKeywords != null) ...option.searchKeywords!,
    ];

    return dom.button(
      classes:
          'neubrutalism-select-option ${isSelected ? 'selected' : ''} ${option.disabled ? 'disabled' : ''}',
      attributes: <String, String>{
        'type': 'button',
        if (option.disabled) 'disabled': 'true',
        'data-arcane-command-item': '',
        'data-arcane-command-group-id': '$surfaceId-default',
        'data-label': option.label,
        'data-keywords': keywords.join(' '),
        ...groupItemAttrs(
          groupId: groupId,
          value: value,
          selected: isSelected,
          disabled: option.disabled,
        ),
        if (!option.disabled) ...interactionAttrs(itemAction),
      },
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'align-items': 'center',
          'gap': '0.75rem',
          'width': '100%',
          'padding': '0.625rem 0.875rem',
          'background': isSelected
              ? 'var(--nb-selection-bg, var(--nb-paper-soft, var(--card)))'
              : 'transparent',
          'border': 'none',
          'border-bottom': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
          'font-family': 'var(--font-body)',
          'font-weight': isSelected ? '700' : '600',
          'font-size': 'var(--font-size-sm)',
          'color': 'var(--foreground)',
          'text-align': 'left',
          'cursor': option.disabled ? 'not-allowed' : 'pointer',
          'transition': 'background 0.12s ease',
          if (option.disabled) 'opacity': '0.5',
        },
      ),
      events: option.disabled || props.onSelect == null
          ? null
          : <String, void Function(dynamic)>{
              'click': (_) => props.onSelect!(option.value),
            },
      <Component>[
        if (props.multiSelect && props.showCheckboxes)
          dom.div(
            styles: dom.Styles(
              raw: <String, String>{
                'width': '20px',
                'height': '20px',
                'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'background': isSelected
                    ? 'var(--nb-paper, var(--card))'
                    : 'transparent',
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'flex-shrink': '0',
                'transition': 'background 0.12s ease',
              },
            ),
            <Component>[
              if (isSelected)
                dom.span(
                  styles: const dom.Styles(
                    raw: <String, String>{'color': 'var(--foreground)'},
                  ),
                  <Component>[ArcaneIcon.check(size: IconSize.xs)],
                ),
            ],
          ),

        if (option.icon != null)
          dom.div(
            styles: dom.Styles(
              raw: <String, String>{
                'color': isSelected
                    ? 'var(--foreground)'
                    : 'var(--muted-foreground)',
              },
            ),
            <Component>[option.icon!],
          ),

        // Label and subtitle
        dom.div(
          styles: const dom.Styles(raw: <String, String>{'flex': '1', 'min-width': '0'}),
          <Component>[
            dom.div(
              styles: const dom.Styles(
                raw: <String, String>{
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              <Component>[Component.text(option.label)],
            ),
            if (option.subtitle != null)
              dom.div(
                styles: const dom.Styles(
                  raw: <String, String>{
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                    'margin-top': '0.25rem',
                  },
                ),
                <Component>[Component.text(option.subtitle!)],
              ),
          ],
        ),

        // Description (right side)
        if (option.description != null)
          dom.span(
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-xs)',
                'color': 'var(--muted-foreground)',
                'flex-shrink': '0',
              },
            ),
            <Component>[Component.text(option.description!)],
          ),
      ],
    );
  }
}
