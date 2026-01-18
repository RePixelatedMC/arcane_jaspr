import 'package:jaspr/jaspr.dart';

enum PaginationStyleVariant {
  outline,
  filled,
  ghost,
  simple,
}

enum PaginationSizeVariant {
  sm,
  md,
  lg,
}

/// Pagination component properties.
class PaginationProps {
  final int currentPage;
  final int totalPages;
  final void Function(int page)? onPageChange;
  final PaginationStyleVariant style;
  final PaginationSizeVariant size;
  final int siblingCount;
  final bool showFirstLast;
  final bool showPrevNext;
  final bool showPageCount;
  final String previousText;
  final String nextText;
  final List<int?> pageNumbers;

  const PaginationProps({
    required this.currentPage,
    required this.totalPages,
    this.onPageChange,
    this.style = PaginationStyleVariant.outline,
    this.size = PaginationSizeVariant.md,
    this.siblingCount = 1,
    this.showFirstLast = true,
    this.showPrevNext = true,
    this.showPageCount = false,
    this.previousText = '<-',
    this.nextText = '->',
    this.pageNumbers = const [],
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for pagination components.
mixin PaginationRendererContract {
  /// Renders a pagination control.
  Component pagination(PaginationProps props);
}
