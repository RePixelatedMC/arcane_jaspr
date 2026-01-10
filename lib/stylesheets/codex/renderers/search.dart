import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/search_props.dart';

/// Codex Search Input renderer.
///
/// Implements the Codex design language:
/// - Larger sizes (1.25x)
/// - Accent focus ring with subtle glow
/// - Glass effect on dropdown
class CodexSearch extends StatelessComponent {
  final SearchProps props;

  const CodexSearch(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes - 1.25x larger
    final (String height, String fontSize, String padding, String iconSize) =
        switch (props.size) {
      SearchSize.sm => ('36px', '0.8125rem', '0 0.75rem 0 2.25rem', '16px'),
      SearchSize.md => ('44px', '0.875rem', '0 1rem 0 2.75rem', '18px'), // vs 40px
      SearchSize.lg => ('52px', '1rem', '0 1.25rem 0 3rem', '20px'), // vs 48px
    };

    // Codex style variants
    final Map<String, String> styleVariantStyles = switch (props.style) {
      SearchStyle.standard => {
          'background-color': 'var(--input)',
          'border': '1px solid var(--border)',
        },
      SearchStyle.filled => {
          'background-color': 'var(--secondary)',
          'border': '1px solid transparent',
        },
      SearchStyle.ghost => {
          'background-color': 'transparent',
          'border': '1px solid transparent',
        },
    };

    return dom.div(
      classes: 'codex-search ${props.disabled ? 'disabled' : ''}',
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
            // Search icon
            if (props.showIcon)
              dom.div(
                classes: 'codex-search-icon',
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'left': '0.875rem',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'pointer-events': 'none',
                  'color': 'var(--muted-foreground)',
                  'width': iconSize,
                  'height': iconSize,
                }),
                [
                  props.icon ??
                      dom.span(
                        styles: dom.Styles(raw: {'font-size': iconSize}),
                        [const Component.text('\u{1F50D}')], // Magnifying glass
                      ),
                ],
              ),

            // Input
            dom.input(
              type: dom.InputType.search,
              classes: 'codex-search-input',
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
                'border-radius': 'var(--radius)', // Codex: larger radius
                'font-size': fontSize,
                'color': 'var(--foreground)',
                'outline': 'none',
                'transition': 'all var(--transition)',
                if (props.disabled) 'opacity': '0.5',
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

            // Loading spinner or clear button
            if (props.loading)
              const dom.div(
                classes: 'codex-search-loading',
                styles: dom.Styles(raw: {
                  'position': 'absolute',
                  'right': '0.875rem',
                  'display': 'flex',
                  'align-items': 'center',
                }),
                [
                  dom.span(
                    styles: dom.Styles(raw: {
                      'display': 'inline-block',
                      'width': '16px',
                      'height': '16px',
                      'border': '2px solid var(--muted)',
                      'border-top-color': 'var(--codex-accent)',
                      'border-radius': 'var(--arcane-radius-full)',
                      'animation': 'arcane-spin 0.75s linear infinite',
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
                  'right': '0.875rem',
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '20px',
                  'height': '20px',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': 'var(--arcane-radius-full)',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'all var(--transition)',
                }),
                events: props.onChanged == null
                    ? null
                    : {'click': (_) => props.onChanged!('')},
                [const Component.text('\u2715')],
              ),
          ],
        ),

        // Search results dropdown
        if (props.showDropdown && props.results != null && props.results!.isNotEmpty)
          dom.div(
            classes: 'codex-search-dropdown',
            attributes: {
              if (props.resultsId != null) 'id': props.resultsId!,
            },
            styles: dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'right': '0',
              'margin-top': '0.5rem',
              'max-height': props.dropdownMaxHeight ?? '300px',
              'overflow-y': 'auto',
              // Codex: glass effect
              'background-color': 'rgba(10, 10, 10, 0.95)',
              'backdrop-filter': 'blur(12px)',
              '-webkit-backdrop-filter': 'blur(12px)',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 10px 40px rgba(0, 0, 0, 0.3)',
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
        classes: 'codex-search-result',
        styles: const dom.Styles(raw: {
          'display': 'block',
          'padding': '0.75rem 1rem',
          'text-decoration': 'none',
          'transition': 'background-color var(--transition)',
        }),
        [
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-sm)',
              'font-weight': 'var(--arcane-font-weight-medium)',
              'color': 'var(--foreground)',
            }),
            [Component.text(result.title)],
          ),
          if (result.subtitle != null)
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-xs)',
                'color': 'var(--muted-foreground)',
                'margin-top': '0.125rem',
              }),
              [Component.text(result.subtitle!)],
            ),
        ],
      );
    }

    return dom.button(
      classes: 'codex-search-result',
      attributes: {'type': 'button'},
      styles: const dom.Styles(raw: {
        'display': 'block',
        'width': '100%',
        'text-align': 'left',
        'padding': '0.75rem 1rem',
        'background': 'transparent',
        'border': 'none',
        'cursor': 'pointer',
        'transition': 'background-color var(--transition)',
      }),
      events: result.onTap == null ? null : {'click': (_) => result.onTap!()},
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--foreground)',
          }),
          [Component.text(result.title)],
        ),
        if (result.subtitle != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--muted-foreground)',
              'margin-top': '0.125rem',
            }),
            [Component.text(result.subtitle!)],
          ),
      ],
    );
  }
}