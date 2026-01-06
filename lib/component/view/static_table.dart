import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

// Re-export props for usage
export '../../core/props/static_table_props.dart';

/// A static table component for displaying simple tabular data.
class ArcaneStaticTable extends StatelessComponent {
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

  const ArcaneStaticTable({
    required this.headers,
    required this.rows,
    this.showDividers = true,
    this.striped = false,
    this.stickyHeader = false,
    this.alignments,
    this.showHeader = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.staticTable(StaticTableProps(
      headers: headers,
      rows: rows,
      showDividers: showDividers,
      striped: striped,
      stickyHeader: stickyHeader,
      alignments: alignments,
      showHeader: showHeader,
    ));
  }
}

/// A simple key-value table (two columns)
class ArcaneKeyValueTable extends StatelessComponent {
  final List<ArcaneKeyValueRow> rows;
  final double? keyWidth;
  final bool showDividers;

  const ArcaneKeyValueTable({
    required this.rows,
    this.keyWidth,
    this.showDividers = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.keyValueTable(KeyValueTableProps(
      rows: rows.map((r) => KeyValueRowData(key: r.key, value: r.value)).toList(),
      keyWidth: keyWidth,
      showDividers: showDividers,
    ));
  }
}

/// A row for KeyValueTable
class ArcaneKeyValueRow {
  final String key;
  final Component value;

  const ArcaneKeyValueRow({required this.key, required this.value});

  /// Create from a string value
  factory ArcaneKeyValueRow.text(String key, String value) =>
      ArcaneKeyValueRow(key: key, value: dom.span([Component.text(value)]));
}
