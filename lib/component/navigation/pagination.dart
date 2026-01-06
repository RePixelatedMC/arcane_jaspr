import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export for backwards compatibility
export '../../core/props/pagination_props.dart'
    show PaginationStyleVariant, PaginationSizeVariant;

/// Pagination style variants
enum PaginationStyle {
  /// Default outlined buttons
  outline,

  /// Filled/solid buttons
  filled,

  /// Ghost/minimal buttons
  ghost,

  /// Simple text-only
  simple,
}

/// Pagination size variants
enum PaginationSize {
  sm,
  md,
  lg,
}

/// Page navigation component matching shadcn/ui.
/// ShadCN Reference: https://ui.shadcn.com/docs/components/pagination
///
/// Displays page numbers and navigation controls for paginated content.
///
/// ```dart
/// ArcanePagination(
///   currentPage: 3,
///   totalPages: 10,
///   onPageChange: (page) => print('Go to page $page'),
/// )
/// ```
class ArcanePagination extends StatelessComponent {
  /// Current active page (1-indexed)
  final int currentPage;

  /// Total number of pages
  final int totalPages;

  /// Callback when page changes
  final void Function(int page)? onPageChange;

  /// Style variant
  final PaginationStyle style;

  /// Size variant
  final PaginationSize size;

  /// Number of page buttons to show around current page
  final int siblingCount;

  /// Whether to show first/last page buttons
  final bool showFirstLast;

  /// Whether to show previous/next buttons
  final bool showPrevNext;

  /// Whether to show page count text
  final bool showPageCount;

  /// Custom previous button text
  final String previousText;

  /// Custom next button text
  final String nextText;

  const ArcanePagination({
    required this.currentPage,
    required this.totalPages,
    this.onPageChange,
    this.style = PaginationStyle.outline,
    this.size = PaginationSize.md,
    this.siblingCount = 1,
    this.showFirstLast = true,
    this.showPrevNext = true,
    this.showPageCount = false,
    this.previousText = '\u{2190}', // Left arrow
    this.nextText = '\u{2192}', // Right arrow
    super.key,
  });

  /// Simple pagination with just prev/next
  const ArcanePagination.simple({
    required this.currentPage,
    required this.totalPages,
    this.onPageChange,
    this.size = PaginationSize.md,
    this.previousText = '\u{2190} Previous',
    this.nextText = 'Next \u{2192}',
    super.key,
  })  : style = PaginationStyle.simple,
        siblingCount = 0,
        showFirstLast = false,
        showPrevNext = true,
        showPageCount = true;

  List<int?> _getPageNumbers() {
    final List<int?> pages = [];
    final int leftSiblingIndex = (currentPage - siblingCount).clamp(1, totalPages);
    final int rightSiblingIndex = (currentPage + siblingCount).clamp(1, totalPages);

    final bool showLeftDots = leftSiblingIndex > 2;
    final bool showRightDots = rightSiblingIndex < totalPages - 1;

    if (!showLeftDots && showRightDots) {
      for (var i = 1; i <= 3 + 2 * siblingCount && i <= totalPages; i++) {
        pages.add(i);
      }
      pages.add(null); // dots
      pages.add(totalPages);
    } else if (showLeftDots && !showRightDots) {
      pages.add(1);
      pages.add(null); // dots
      for (var i = totalPages - (2 + 2 * siblingCount); i <= totalPages; i++) {
        if (i > 1) pages.add(i);
      }
    } else if (showLeftDots && showRightDots) {
      pages.add(1);
      pages.add(null); // left dots
      for (var i = leftSiblingIndex; i <= rightSiblingIndex; i++) {
        pages.add(i);
      }
      pages.add(null); // right dots
      pages.add(totalPages);
    } else {
      for (var i = 1; i <= totalPages; i++) {
        pages.add(i);
      }
    }

    return pages;
  }

  @override
  Component build(BuildContext context) {
    // Convert style enum
    final styleVariant = switch (style) {
      PaginationStyle.outline => PaginationStyleVariant.outline,
      PaginationStyle.filled => PaginationStyleVariant.filled,
      PaginationStyle.ghost => PaginationStyleVariant.ghost,
      PaginationStyle.simple => PaginationStyleVariant.simple,
    };

    // Convert size enum
    final sizeVariant = switch (size) {
      PaginationSize.sm => PaginationSizeVariant.sm,
      PaginationSize.md => PaginationSizeVariant.md,
      PaginationSize.lg => PaginationSizeVariant.lg,
    };

    return context.renderers.pagination(PaginationProps(
      currentPage: currentPage,
      totalPages: totalPages,
      onPageChange: onPageChange,
      style: styleVariant,
      size: sizeVariant,
      siblingCount: siblingCount,
      showFirstLast: showFirstLast,
      showPrevNext: showPrevNext,
      showPageCount: showPageCount,
      previousText: previousText,
      nextText: nextText,
      pageNumbers: _getPageNumbers(),
    ));
  }
}
