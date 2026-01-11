import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tag_input_props.dart';

/// Codex Tag Input renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon tags with gradient backgrounds
/// - Holographic-style input container
/// - Animated tag addition/removal
/// - Neon focus effects
class CodexTagInput extends StatelessComponent {
  final TagInputProps props;

  const CodexTagInput(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final hasError = props.errorText != null;

    // Codex Neon container styles based on variant
    final Map<String, String> containerStyles = switch (props.style) {
      TagInputStyleVariant.outline => {
        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
        'border': hasError
            ? '1px solid var(--destructive)'
            : props.isFocused
                ? '1px solid var(--primary)'
                : '1px solid rgba(var(--primary-rgb), 0.3)',
        'box-shadow': hasError
            ? '0 0 20px rgba(var(--destructive-rgb), 0.2)'
            : props.isFocused
                ? '0 0 20px rgba(var(--primary-rgb), 0.3)'
                : '0 0 10px rgba(var(--primary-rgb), 0.1)',
      },
      TagInputStyleVariant.filled => {
        'background': 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 80%, var(--primary)) 100%)',
        'border': hasError
            ? '1px solid var(--destructive)'
            : props.isFocused
                ? '1px solid var(--primary)'
                : '1px solid transparent',
        'box-shadow': props.isFocused
            ? '0 0 20px rgba(var(--primary-rgb), 0.25)'
            : '0 0 10px rgba(var(--primary-rgb), 0.05)',
      },
      TagInputStyleVariant.ghost => {
        'background': 'transparent',
        'border': hasError
            ? '1px solid var(--destructive)'
            : props.isFocused
                ? '1px solid var(--primary)'
                : '1px solid transparent',
        'box-shadow': props.isFocused
            ? '0 0 15px rgba(var(--primary-rgb), 0.2)'
            : 'none',
      },
    };

    return dom.div(
      classes: 'codex-tag-input-wrapper codex-neon',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.875rem',
      }),
      [
        // Label with neon accent
        if (props.label != null)
          Component.element(
            tag: 'label',
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'line-height': '1',
              'color': 'var(--foreground)',
            }),
            children: [Component.text(props.label!)],
          ),

        // Neon input container
        dom.div(
          classes: 'codex-tag-input codex-neon',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': '0.5rem',
            'padding': '0.75rem',
            'border-radius': 'var(--radius)',
            'min-height': '52px',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            'cursor': props.disabled ? 'not-allowed' : 'text',
            'opacity': props.disabled ? '0.4' : '1',
            ...containerStyles,
          }),
          [
            // Neon tags
            for (var i = 0; i < props.tags.length; i++)
              props.tagBuilder?.call(
                    props.tags[i],
                    () => props.onRemoveTag?.call(i),
                  ) ??
                  _buildNeonTag(props.tags[i], i),

            // Input field
            if (!props.disabled &&
                (props.maxTags == null ||
                    props.tags.length < props.maxTags!))
              dom.input(
                type: dom.InputType.text,
                classes: 'codex-tag-input-field codex-neon',
                attributes: {
                  'placeholder': props.tags.isEmpty ? props.placeholder : '',
                  'value': props.inputValue,
                },
                styles: const dom.Styles(raw: {
                  'flex': '1',
                  'min-width': '120px',
                  'border': 'none',
                  'background': 'transparent',
                  'outline': 'none',
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--foreground)',
                  'padding': '6px',
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

        // Helper/Error text with neon styling
        if (props.helperText != null || hasError)
          dom.span(
            classes: hasError ? 'codex-tag-input-error' : 'codex-tag-input-helper',
            styles: dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': hasError ? 'var(--destructive)' : 'var(--muted-foreground)',
              'text-shadow': hasError ? '0 0 8px rgba(var(--destructive-rgb), 0.4)' : 'none',
            }),
            [Component.text(hasError ? props.errorText! : props.helperText!)],
          ),
      ],
    );
  }

  Component _buildNeonTag(String tag, int index) {
    return dom.span(
      classes: 'codex-tag codex-neon',
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.5rem',
        'padding': '0.375rem 0.75rem',
        'background': 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.25) 0%, rgba(var(--primary-rgb), 0.15) 100%)',
        'border': '1px solid rgba(var(--primary-rgb), 0.4)',
        'color': 'var(--primary)',
        'border-radius': '9999px',
        'font-size': 'var(--font-size-sm)',
        'font-weight': 'var(--font-weight-medium)',
        'line-height': '1.25',
        'box-shadow': '0 0 12px rgba(var(--primary-rgb), 0.2)',
        'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.3)',
      }),
      [
        Component.text(tag),
        if (!props.disabled)
          dom.button(
            type: dom.ButtonType.button,
            classes: 'codex-tag-remove codex-neon',
            attributes: {'aria-label': 'Remove tag'},
            styles: const dom.Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '18px',
              'height': '18px',
              'padding': '0',
              'border': 'none',
              'background': 'rgba(var(--destructive-rgb), 0.2)',
              'border-radius': '50%',
              'color': 'var(--destructive)',
              'cursor': 'pointer',
              'font-size': '11px',
              'line-height': '1',
              'transition': 'all 0.2s ease',
            }),
            events: {
              'click': (_) => props.onRemoveTag?.call(index),
            },
            [const Component.text('\u2715')],
          ),
      ],
    );
  }
}
