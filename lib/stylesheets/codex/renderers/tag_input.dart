import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tag_input_props.dart';

/// Codex Tag Input renderer.
class CodexTagInput extends StatelessComponent {
  final TagInputProps props;

  const CodexTagInput(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final hasError = props.errorText != null;

    // Container styles based on variant
    final Map<String, String> containerStyles = switch (props.style) {
      TagInputStyleVariant.outline => {
          'background-color': 'var(--input)',
          'border': hasError
              ? '1px solid var(--destructive)'
              : props.isFocused
                  ? '1px solid var(--codex-accent)'
                  : '1px solid var(--border)',
        },
      TagInputStyleVariant.filled => {
          'background-color': 'var(--secondary)',
          'border': hasError
              ? '1px solid var(--destructive)'
              : props.isFocused
                  ? '1px solid var(--codex-accent)'
                  : '1px solid transparent',
        },
      TagInputStyleVariant.ghost => {
          'background-color': 'transparent',
          'border': hasError
              ? '1px solid var(--destructive)'
              : props.isFocused
                  ? '1px solid var(--codex-accent)'
                  : '1px solid transparent',
        },
    };

    return dom.div(
      classes: 'codex-tag-input-wrapper',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.75rem',
      }),
      [
        // Label
        if (props.label != null)
          Component.element(
            tag: 'label',
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [Component.text(props.label!)],
          ),

        // Input container
        dom.div(
          classes: 'codex-tag-input',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': '0.5rem',
            'padding': '0.625rem',
            'border-radius': 'var(--radius)',
            'min-height': '48px',
            'transition': 'border-color 150ms ease, box-shadow 150ms ease',
            'cursor': props.disabled ? 'not-allowed' : 'text',
            'opacity': props.disabled ? '0.5' : '1',
            if (props.isFocused) 'box-shadow': '0 0 0 2px rgba(var(--codex-accent-rgb), 0.2)',
            ...containerStyles,
          }),
          [
            // Tags
            for (var i = 0; i < props.tags.length; i++)
              props.tagBuilder?.call(
                    props.tags[i],
                    () => props.onRemoveTag?.call(i),
                  ) ??
                  _buildDefaultTag(props.tags[i], i),

            // Input field
            if (!props.disabled &&
                (props.maxTags == null ||
                    props.tags.length < props.maxTags!))
              dom.input(
                type: dom.InputType.text,
                classes: 'codex-tag-input-field',
                attributes: {
                  'placeholder': props.tags.isEmpty ? props.placeholder : '',
                  'value': props.inputValue,
                },
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'min-width': '100px',
                  'border': 'none',
                  'background': 'transparent',
                  'outline': 'none',
                  'font-size': '0.875rem',
                  'color': 'var(--foreground)',
                  'padding': '4px',
                }),
                events: {
                  'focus': (_) => props.onFocusChange?.call(true),
                  'blur': (_) => props.onFocusChange?.call(false),
                  'input': (event) {
                    final target = event.target;
                    if (target != null) {
                      props.onInputChange?.call((target as dynamic).value ?? '');
                    }
                  },
                  'keydown': (event) {
                    final key = (event as dynamic).key;
                    if (key == 'Enter') {
                      event.preventDefault();
                      props.onKeyDown?.call('Enter');
                    } else if (key == 'Backspace') {
                      props.onKeyDown?.call('Backspace');
                    } else if (key == ',') {
                      event.preventDefault();
                      props.onKeyDown?.call(',');
                    }
                  },
                },
              ),
          ],
        ),

        // Helper/Error text
        if (props.helperText != null || hasError)
          dom.span(
            classes: hasError ? 'codex-tag-input-error' : 'codex-tag-input-helper',
            styles: dom.Styles(raw: {
              'font-size': '0.75rem',
              'color': hasError ? 'var(--destructive)' : 'var(--muted-foreground)',
            }),
            [Component.text(hasError ? props.errorText! : props.helperText!)],
          ),
      ],
    );
  }

  Component _buildDefaultTag(String tag, int index) {
    return dom.span(
      classes: 'codex-tag',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.375rem',
        'padding': '0.25rem 0.625rem',
        'background-color': 'rgba(var(--codex-accent-rgb), 0.15)',
        'color': 'var(--codex-accent)',
        'border-radius': '9999px',
        'font-size': '0.75rem',
        'font-weight': '500',
        'line-height': '1.25',
      }),
      [
        Component.text(tag),
        if (!props.disabled)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'codex-tag-remove',
            attributes: {'aria-label': 'Remove tag'},
            styles: const dom.Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '16px',
              'height': '16px',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'border-radius': '9999px',
              'color': 'var(--codex-accent)',
              'cursor': 'pointer',
              'font-size': '12px',
              'line-height': '1',
              'opacity': '0.7',
              'transition': 'opacity 150ms ease',
            }),
            events: {
              'click': (_) => props.onRemoveTag?.call(index),
            },
            [const Component.text('\u00D7')],
          ),
      ],
    );
  }
}
