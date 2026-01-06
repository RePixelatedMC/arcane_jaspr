/// Style variants for pagination
enum PaginationStyleVariant {
  /// Outlined buttons
  outline,

  /// Filled/solid buttons
  filled,

  /// Ghost/minimal buttons
  ghost,

  /// Simple text-only navigation
  simple,
}

/// Size variants for pagination
enum PaginationSizeVariant {
  sm,
  md,
  lg,
}

/// Props for the pagination component
class PaginationProps {
  /// Current active page (1-indexed)
  final int currentPage;

  /// Total number of pages
  final int totalPages;

  /// Page change callback
  final void Function(int page)? onPageChange;

  /// Style variant
  final PaginationStyleVariant style;

  /// Size variant
  final PaginationSizeVariant size;

  /// Number of page buttons to show around current page
  final int siblingCount;

  /// Whether to show first/last page buttons
  final bool showFirstLast;

  /// Whether to show previous/next buttons
  final bool showPrevNext;

  /// Whether to show "Page X of Y" text
  final bool showPageCount;

  /// Previous button text
  final String previousText;

  /// Next button text
  final String nextText;

  /// Computed list of page numbers to display (null = ellipsis)
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
