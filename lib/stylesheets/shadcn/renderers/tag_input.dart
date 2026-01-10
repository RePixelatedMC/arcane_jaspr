import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tag_input_props.dart';

/// ShadCN Tag Input renderer.
///
/// Based on shadcn/ui Input with Tag/Badge styling.
/// Reference: https://ui.shadcn.com/docs/components/input
/// Reference: https://ui.shadcn.com/docs/components/badge
class ShadcnTagInput extends StatelessComponent {
  final TagInputProps props;

  const ShadcnTagInput(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final hasError = props.errorText != null;

    // Container styles based on variant
    final Map<String, String> containerStyles = switch (props.style) {
      TagInputStyleVariant.outline => {
          'background-color': 'var(--background)',
          'border': hasError
              ? '1px solid var(--destructive)'
              : props.isFocused
                  ? '1px solid var(--ring)'
                  : '1px solid var(--input)',
        },
      TagInputStyleVariant.filled => {
          'background-color': 'var(--muted)',
          'border': hasError
              ? '1px solid var(--destructive)'
              : props.isFocused
                  ? '1px solid var(--ring)'
                  : '1px solid transparent',
        },
      TagInputStyleVariant.ghost => {
          'background-color': 'transparent',
          'border': hasError
              ? '1px solid var(--destructive)'
              : props.isFocused
                  ? '1px solid var(--ring)'
                  : '1px solid transparent',
        },
    };

    return dom.div(
      classes: 'arcane-tag-input-wrapper',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
      }),
      [
        // Label
        if (props.label != null)
          Component.element(
            tag: 'label',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [Component.text(props.label!)],
          ),

        // Input container
        dom.div(
          classes: 'arcane-tag-input',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': '0.375rem',
            'padding': '0.5rem',
            'border-radius': 'var(--arcane-radius-sm)',
            'min-height': '44px',
            'transition': 'border-color var(--arcane-transition), box-shadow var(--arcane-transition)',
            'cursor': props.disabled ? 'not-allowed' : 'text',
            'opacity': props.disabled ? '0.5' : '1',
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
                classes: 'arcane-tag-input-field',
                attributes: {
                  'placeholder': props.tags.isEmpty ? props.placeholder : '',
                  'value': props.inputValue,
                },
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'min-width': '80px',
                  'border': 'none',
                  'background': 'transparent',
                  'outline': 'none',
                  'font-size': 'var(--font-size-sm)',
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
            classes: hasError ? 'arcane-tag-input-error' : 'arcane-tag-input-helper',
            styles: dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': hasError ? 'var(--destructive)' : 'var(--muted-foreground)',
            }),
            [Component.text(hasError ? props.errorText! : props.helperText!)],
          ),
      ],
    );
  }

  Component _buildDefaultTag(String tag, int index) {
    // ShadCN Badge: secondary variant for tags
    return dom.span(
      classes: 'arcane-tag',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--space-1)',
        'padding': '0.125rem 0.5rem',
        'background-color': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border-radius': 'var(--arcane-radius-full)',
        'font-size': 'var(--font-size-xs)',
        'font-weight': 'var(--font-weight-medium)',
        'line-height': '1.25',
      }),
      [
        Component.text(tag),
        if (!props.disabled)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'arcane-tag-remove',
            attributes: {'aria-label': 'Remove tag'},
            styles: const dom.Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '14px',
              'height': '14px',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'border-radius': 'var(--arcane-radius-full)',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'font-size': '10px',
              'line-height': '1',
              'opacity': '0.7',
              'transition': 'opacity var(--arcane-transition), color var(--arcane-transition)',
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