import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../core/theme_provider.dart';
import '../../util/arcane.dart';

export '../../core/props/static_table_props.dart';

/// Static table component for displaying simple tabular data.
class ArcaneStaticTable extends StatelessComponent {
  final List<String> headers;
  final List<List<Component>> rows;
  final bool showDividers;
  final bool striped;
  final bool stickyHeader;
  final List<TextAlign>? alignments;
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

/// Simple key-value table with two columns.
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

/// Row data for KeyValueTable.
class ArcaneKeyValueRow {
  final String key;
  final Component value;

  const ArcaneKeyValueRow({required this.key, required this.value});

  factory ArcaneKeyValueRow.text(String key, String value) =>
      ArcaneKeyValueRow(key: key, value: dom.span([Component.text(value)]));
}
