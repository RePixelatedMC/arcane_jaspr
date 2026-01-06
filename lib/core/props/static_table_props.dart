import 'package:jaspr/jaspr.dart';

import '../../util/arcane.dart';

/// Properties for static table components.
class StaticTableProps {
  /// Table headers
  final List<String> headers;

  /// Table rows (each row is a list of cell contents)
  final List<List<Component>> rows;

  /// Whether to show row dividers
  final bool showDividers;

  /// Whether to stripe alternate rows
  final bool striped;

  /// Whether the header is sticky
  final bool stickyHeader;

  /// Column alignments
  final List<TextAlign>? alignments;

  /// Whether to show the header
  final bool showHeader;

  const StaticTableProps({
    required this.headers,
    required this.rows,
    this.showDividers = true,
    this.striped = false,
    this.stickyHeader = false,
    this.alignments,
    this.showHeader = true,
  });
}

/// Properties for key-value table components.
class KeyValueTableProps {
  final List<KeyValueRowData> rows;
  final double? keyWidth;
  final bool showDividers;

  const KeyValueTableProps({
    required this.rows,
    this.keyWidth,
    this.showDividers = true,
  });
}

/// A row for KeyValueTable
class KeyValueRowData {
  final String key;
  final Component value;

  const KeyValueRowData({required this.key, required this.value});
}
