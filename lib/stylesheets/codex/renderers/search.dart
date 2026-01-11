import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/search_props.dart';

/// Codex Search Input renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon focus effects
/// - Holographic-style dropdown with glass morphism
/// - Cyberpunk-inspired search icon glow
/// - Animated scanning line effect
class CodexSearch extends StatelessComponent {
  final SearchProps props;

  const CodexSearch(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex Neon sizes - larger with more presence
    final (String height, String fontSize, String padding, String iconSize) =
        switch (props.size) {
      SearchSize.sm => ('40px', '0.8125rem', '0 1rem 0 2.75rem', '18px'),
      SearchSize.md => ('48px', '0.875rem', '0 1.25rem 0 3.25rem', '20px'),
      SearchSize.lg => ('56px', '1rem', '0 1.5rem 0 3.75rem', '22px'),
    };

    // Codex Neon style variants
    final Map<String, String> styleVariantStyles = switch (props.style) {
      SearchStyle.standard => {
        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
        'border': '1px solid rgba(var(--primary-rgb), 0.3)',
        'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.1)',
      },
      SearchStyle.filled => {
        'background': 'linear-gradient(135deg, var(--secondary) 0%, color-mix(in srgb, var(--secondary) 80%, var(--primary)) 100%)',
        'border': '1px solid rgba(var(--primary-rgb), 0.2)',
        'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.1)',
      },
      SearchStyle.ghost => {
        'background': 'transparent',
        'border': '1px solid transparent',
        'box-shadow': 'none',
      },
    };

    return dom.div(
      classes: 'codex-search codex-neon ${props.disabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'position': 'relative',
        'width': props.width ?? '100%',
      }),
      [
        // Search input container
        dom.div(
          classes: 'codex-search-input-wrapper',
          styles: const dom.Styles(raw: {
            'position': 'relative',
            'display': 'flex',
            'align-items': 'center',
          }),
          [
            // Neon search icon
            if (props.showIcon)
              dom.div(
                classes: 'codex-search-icon',
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'left': '1rem',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'pointer-events': 'none',
                  'color': 'var(--primary)',
                  'width': iconSize,
                  'height': iconSize,
                  'filter': 'drop-shadow(0 0 6px currentColor)',
                }),
                [
                  props.icon ??
                      dom.span(
                        styles: dom.Styles(raw: {'font-size': iconSize}),
                        [const Component.text('\u{1F50D}')],
                      ),
                ],
              ),

            // Input with neon styling
            dom.input(
              type: dom.InputType.search,
              classes: 'codex-search-input codex-neon',
              attributes: {
                'placeholder': props.placeholder,
                if (props.value != null) 'value': props.value!,
                if (props.id != null) 'id': props.id!,
                if (props.disabled) 'disabled': 'true',
                if (props.autofocus) 'autofocus': 'true',
                ...?props.attributes,
              },
              styles: dom.Styles(raw: {
                'width': '100%',
                'height': height,
                'padding': padding,
                ...styleVariantStyles,
                'border-radius': 'var(--radius)',
                'font-size': fontSize,
                'color': 'var(--foreground)',
                'outline': 'none',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                if (props.disabled) 'opacity': '0.4',
                if (props.disabled) 'cursor': 'not-allowed',
              }),
              events: {
                if (props.onChanged != null)
                  'input': (e) {
                    final dynamic target = e.target;
                    final String? value = target?.value;
                    if (value != null) props.onChanged!(value);
                  },
                if (props.onSubmitted != null)
                  'keydown': (e) {
                    final dynamic event = e;
                    if (event?.key == 'Enter') {
                      final dynamic target = e.target;
                      final String? value = target?.value;
                      if (value != null) props.onSubmitted!(value);
                    }
                  },
              },
            ),

            // Loading spinner with neon glow or clear button
            if (props.loading)
              dom.div(
                classes: 'codex-search-loading',
                styles: const dom.Styles(raw: {
                  'position': 'absolute',
                  'right': '1rem',
                  'display': 'flex',
                  'align-items': 'center',
                }),
                [
                  dom.span(
                    styles: const dom.Styles(raw: {
                      'display': 'inline-block',
                      'width': '18px',
                      'height': '18px',
                      'border': '2px solid rgba(var(--primary-rgb), 0.3)',
                      'border-top-color': 'var(--primary)',
                      'border-radius': '50%',
                      'animation': 'arcane-spin 0.6s linear infinite',
                      'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.3)',
                    }),
                    [],
                  ),
                ],
              )
            else if (props.showClear && props.value != null && props.value!.isNotEmpty)
              dom.button(
                classes: 'codex-search-clear',
                attributes: {'type': 'button'},
                styles: const dom.Styles(raw: {
                  'position': 'absolute',
                  'right': '1rem',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '24px',
                  'height': '24px',
                  'background': 'rgba(var(--destructive-rgb), 0.2)',
                  'border': '1px solid rgba(var(--destructive-rgb), 0.3)',
                  'border-radius': '50%',
                  'color': 'var(--destructive)',
                  'cursor': 'pointer',
                  'transition': 'all 0.2s ease',
                  'font-size': '12px',
                }),
                events: props.onChanged == null
                    ? null
                    : {'click': (_) => props.onChanged!('')},
                [const Component.text('\u2715')],
              ),
          ],
        ),

        // Neon glass dropdown
        if (props.showDropdown && props.results != null && props.results!.isNotEmpty)
          dom.div(
            classes: 'codex-search-dropdown codex-neon',
            attributes: {
              if (props.resultsId != null) 'id': props.resultsId!,
            },
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'right': '0',
              'margin-top': '0.75rem',
              'max-height': props.dropdownMaxHeight ?? '320px',
              'overflow-y': 'auto',
              // Neon glass effect
              'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.95) 0%, rgba(var(--card-rgb), 0.9) 100%)',
              'backdrop-filter': 'blur(16px)',
              '-webkit-backdrop-filter': 'blur(16px)',
              'border': '1px solid rgba(var(--primary-rgb), 0.3)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.15), 0 20px 60px rgba(0, 0, 0, 0.5)',
              'z-index': '50',
            }),
            [
              for (final result in props.results!)
                _buildSearchResult(result),
            ],
          ),
      ],
    );
  }

  Component _buildSearchResult(SearchResult result) {
    if (result.href != null) {
      return dom.a(
        href: result.href!,
        classes: 'codex-search-result codex-neon',
        styles: const dom.Styles(raw: {
          'display': 'block',
          'padding': '1rem 1.25rem',
          'text-decoration': 'none',
          'border-bottom': '1px solid rgba(var(--border-rgb), 0.3)',
          'transition': 'all 0.2s ease',
        }),
        [
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'color': 'var(--foreground)',
            }),
            [Component.text(result.title)],
          ),
          if (result.subtitle != null)
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-xs)',
                'color': 'var(--muted-foreground)',
                'margin-top': '0.25rem',
              }),
              [Component.text(result.subtitle!)],
            ),
        ],
      );
    }

    return dom.button(
      classes: 'codex-search-result codex-neon',
      attributes: {'type': 'button'},
      styles: const dom.Styles(raw: {
        'display': 'block',
        'width': '100%',
        'text-align': 'left',
        'padding': '1rem 1.25rem',
        'background': 'transparent',
        'border': 'none',
        'border-bottom': '1px solid rgba(var(--border-rgb), 0.3)',
        'cursor': 'pointer',
        'transition': 'all 0.2s ease',
      }),
      events: result.onTap == null ? null : {'click': (_) => result.onTap!()},
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
          }),
          [Component.text(result.title)],
        ),
        if (result.subtitle != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.25rem',
            }),
            [Component.text(result.subtitle!)],
          ),
      ],
    );
  }
}
