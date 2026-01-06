import 'package:jaspr/jaspr.dart';

/// Tree node data
class TreeNodeData {
  /// Unique identifier
  final String id;

  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Child nodes
  final List<TreeNodeData> children;

  /// Whether node is disabled
  final bool disabled;

  /// Custom data attached to the node
  final dynamic data;

  const TreeNodeData({
    required this.id,
    required this.label,
    this.icon,
    this.children = const [],
    this.disabled = false,
    this.data,
  });

  bool get hasChildren => children.isNotEmpty;
}

/// Tree view style variants
enum TreeViewStyle {
  /// Default tree style with lines
  lines,

  /// Clean style without lines
  clean,

  /// Compact style
  compact,
}

/// Tree view selection mode
enum TreeSelectionMode {
  /// No selection
  none,

  /// Single node selection
  single,

  /// Multiple node selection
  multiple,
}

/// Properties for tree view components.
class TreeViewProps {
  /// Tree nodes
  final List<TreeNodeData> nodes;

  /// Callback when a node is selected
  final void Function(TreeNodeData node)? onNodeSelect;

  /// Callback when a node is expanded/collapsed
  final void Function(TreeNodeData node, bool expanded)? onNodeToggle;

  /// Style variant
  final TreeViewStyle style;

  /// Selection mode
  final TreeSelectionMode selectionMode;

  /// Initially expanded node IDs
  final Set<String> initiallyExpanded;

  /// Selected node IDs
  final Set<String> selectedNodes;

  /// Whether all nodes are initially expanded
  final bool expandAll;

  const TreeViewProps({
    required this.nodes,
    this.onNodeSelect,
    this.onNodeToggle,
    this.style = TreeViewStyle.lines,
    this.selectionMode = TreeSelectionMode.single,
    this.initiallyExpanded = const {},
    this.selectedNodes = const {},
    this.expandAll = false,
  });
}
