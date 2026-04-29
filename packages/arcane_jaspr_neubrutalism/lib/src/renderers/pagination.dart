import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/pagination_props.dart';

/// Neubrutalism Pagination renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger button sizes
/// - Accent-colored active state with glow
/// - More spacing between items
class NeubrutalismPagination extends StatelessComponent {
  final PaginationProps props;

  const NeubrutalismPagination(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Neubrutalism sizes
    final (
      String buttonSize,
      String fontSize,
      String gap,
    ) = switch (props.size) {
      PaginationSizeVariant.sm => ('32px', '0.75rem', '0.375rem'),
      PaginationSizeVariant.md => (
        '40px',
        '0.875rem',
        '0.5rem',
      ), // Neubrutalism: larger
      PaginationSizeVariant.lg => ('48px', '1rem', '0.625rem'),
    };

    return dom.nav(
      classes: 'neubrutalism-pagination',
      attributes: {'aria-label': 'Pagination'},
      styles: dom.Styles(
        raw: {'display': 'flex', 'align-items': 'center', 'gap': gap},
      ),
      [
        // First page button
        if (props.showFirstLast && props.totalPages > 2)
          _buildButton(
            text: '\u00AB', // Double left arrow
            page: 1,
            disabled: props.currentPage == 1,
            buttonSize: buttonSize,
            fontSize: fontSize,
          ),

        // Previous button
        if (props.showPrevNext)
          _buildButton(
            text: props.previousText,
            page: props.currentPage - 1,
            disabled: props.currentPage == 1,
            buttonSize: buttonSize,
            fontSize: fontSize,
          ),

        // Page numbers
        for (final pageNum in props.pageNumbers)
          if (pageNum == null)
            _buildEllipsis(fontSize)
          else
            _buildButton(
              text: '$pageNum',
              page: pageNum,
              isActive: pageNum == props.currentPage,
              buttonSize: buttonSize,
              fontSize: fontSize,
            ),

        // Next button
        if (props.showPrevNext)
          _buildButton(
            text: props.nextText,
            page: props.currentPage + 1,
            disabled: props.currentPage == props.totalPages,
            buttonSize: buttonSize,
            fontSize: fontSize,
          ),

        // Last page button
        if (props.showFirstLast && props.totalPages > 2)
          _buildButton(
            text: '\u00BB', // Double right arrow
            page: props.totalPages,
            disabled: props.currentPage == props.totalPages,
            buttonSize: buttonSize,
            fontSize: fontSize,
          ),

        // Page count text
        if (props.showPageCount)
          dom.span(
            styles: dom.Styles(
              raw: {
                'margin-left': '0.75rem',
                'font-size': fontSize,
                'color': 'var(--muted-foreground)',
              },
            ),
            [
              Component.text(
                'Page ${props.currentPage} of ${props.totalPages}',
              ),
            ],
          ),
      ],
    );
  }

  Component _buildButton({
    required String text,
    required int page,
    bool isActive = false,
    bool disabled = false,
    required String buttonSize,
    required String fontSize,
  }) {
    final Map<String, String> styleVariant = switch (props.style) {
      PaginationStyleVariant.outline => {
        'background': isActive ? 'var(--nb-accent, var(--primary))' : 'var(--nb-paper, var(--card))',
        'color': isActive ? 'var(--nb-ink, #000)' : 'var(--nb-ink, var(--foreground))',
        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'box-shadow': 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
      },
      PaginationStyleVariant.filled => {
        'background':
            isActive ? 'var(--nb-accent, var(--primary))' : 'transparent',
        'color': isActive ? 'var(--nb-ink, #000)' : 'var(--foreground)',
        'border': 'none',
        if (isActive) 'box-shadow': 'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      },
      PaginationStyleVariant.ghost => {
        'background': isActive ? 'var(--nb-accent, var(--primary))' : 'transparent',
        'color': isActive ? 'var(--nb-ink, #000)' : 'var(--foreground)',
        'border': 'none',
      },
      PaginationStyleVariant.simple => {
        'background': 'transparent',
        'color':
            isActive ? 'var(--nb-accent, var(--primary))' : 'var(--muted-foreground)',
        'border': 'none',
        'font-weight': isActive ? '700' : '500',
      },
    };

    return dom.button(
      classes:
          'neubrutalism-pagination-button ${isActive ? 'active' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
        if (isActive) 'aria-current': 'page',
      },
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'min-width': buttonSize,
          'height': buttonSize,
          'padding': '0 0.75rem',
          'font-size': fontSize,
          'font-weight': '600',
          'font-variant-numeric': 'tabular-nums',
          'cursor': disabled ? 'not-allowed' : 'pointer',
          'transition':
              'background 0.18s ease, color 0.18s ease, box-shadow 0.18s ease, border-color 0.18s ease',
          'opacity': disabled ? '0.45' : '1',
          ...styleVariant,
        },
      ),
      events: disabled || props.onPageChange == null
          ? null
          : {'click': (_) => props.onPageChange!(page)},
      [Component.text(text)],
    );
  }

  Component _buildEllipsis(String fontSize) {
    return dom.span(
      classes: 'neubrutalism-pagination-ellipsis',
      styles: dom.Styles(
        raw: {
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '0 0.375rem',
          'font-size': fontSize,
          'color': 'var(--muted-foreground)',
        },
      ),
      [const Component.text('\u2026')], // Ellipsis
    );
  }
}
