import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/pagination_props.dart';

/// Codex Pagination renderer.
///
/// Implements the Codex design language:
/// - Larger button sizes
/// - Accent-colored active state with glow
/// - More spacing between items
class CodexPagination extends StatelessComponent {
  final PaginationProps props;

  const CodexPagination(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Codex sizes
    final (String buttonSize, String fontSize, String gap) = switch (props.size) {
      PaginationSizeVariant.sm => ('32px', '0.75rem', '0.375rem'),
      PaginationSizeVariant.md => ('40px', '0.875rem', '0.5rem'), // Codex: larger
      PaginationSizeVariant.lg => ('48px', '1rem', '0.625rem'),
    };

    return dom.nav(
      classes: 'codex-pagination',
      attributes: {'aria-label': 'Pagination'},
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': gap,
      }),
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
            styles: dom.Styles(raw: {
              'margin-left': '0.75rem',
              'font-size': fontSize,
              'color': 'var(--muted-foreground)',
            }),
            [Component.text('Page ${props.currentPage} of ${props.totalPages}')],
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
    // Codex style variants
    final Map<String, String> styleVariant = switch (props.style) {
      PaginationStyleVariant.outline => {
          'background-color': isActive
              ? 'var(--codex-accent)'
              : 'transparent',
          'color': isActive ? '#ffffff' : 'var(--foreground)',
          'border': isActive
              ? '1px solid var(--codex-accent)'
              : '1px solid var(--border)',
          if (isActive) 'box-shadow': 'var(--codex-accent-glow-subtle)',
        },
      PaginationStyleVariant.filled => {
          'background-color': isActive
              ? 'var(--codex-accent)'
              : 'var(--secondary)',
          'color': isActive ? '#ffffff' : 'var(--foreground)',
          'border': 'none',
          if (isActive) 'box-shadow': 'var(--codex-accent-glow-subtle)',
        },
      PaginationStyleVariant.ghost => {
          'background-color': isActive
              ? 'rgba(var(--codex-accent-rgb), 0.15)'
              : 'transparent',
          'color': isActive ? 'var(--codex-accent)' : 'var(--foreground)',
          'border': 'none',
        },
      PaginationStyleVariant.simple => {
          'background-color': 'transparent',
          'color': isActive ? 'var(--codex-accent)' : 'var(--muted-foreground)',
          'border': 'none',
          'font-weight': isActive ? '600' : '400',
        },
    };

    return dom.button(
      classes: 'codex-pagination-button ${isActive ? 'active' : ''} ${disabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        if (disabled) 'disabled': 'true',
        if (isActive) 'aria-current': 'page',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'min-width': buttonSize,
        'height': buttonSize,
        'padding': '0 0.75rem',
        'font-size': fontSize,
        'font-weight': 'var(--arcane-font-weight-medium)',
        'border-radius': 'var(--radius-md)',
        'cursor': disabled ? 'not-allowed' : 'pointer',
        'transition': 'all var(--transition)',
        'opacity': disabled ? '0.5' : '1',
        ...styleVariant,
      }),
      events: disabled || props.onPageChange == null
          ? null
          : {'click': (_) => props.onPageChange!(page)},
      [Component.text(text)],
    );
  }

  Component _buildEllipsis(String fontSize) {
    return dom.span(
      classes: 'codex-pagination-ellipsis',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': '0 0.375rem',
        'font-size': fontSize,
        'color': 'var(--muted-foreground)',
      }),
      [const Component.text('\u2026')], // Ellipsis
    );
  }
}
