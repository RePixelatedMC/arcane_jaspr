import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/tree_view_props.dart';

/// Tree node data (convenience class for the component wrapper)
class TreeNode {
  /// Unique identifier
  final String id;

  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Child nodes
  final List<TreeNode> children;

  /// Whether node is disabled
  final bool disabled;

  /// Custom data attached to the node
  final dynamic data;

  const TreeNode({
    required this.id,
    required this.label,
    this.icon,
    this.children = const [],
    this.disabled = false,
    this.data,
  });

  bool get hasChildren => children.isNotEmpty;

  /// Convert to TreeNodeData for the renderer
  TreeNodeData toData() => TreeNodeData(
        id: id,
        label: label,
        icon: icon,
        children: children.map((c) => c.toData()).toList(),
        disabled: disabled,
        data: data,
      );
}

/// Hierarchical tree view component
///
/// Displays hierarchical data in a collapsible tree structure.
///
/// ```dart
/// ArcaneTreeView(
///   nodes: [
///     TreeNode(
///       id: 'src',
///       label: 'src',
///       icon: Text('folder'),
///       children: [
///         TreeNode(id: 'main', label: 'main.dart', icon: Text('file')),
///       ],
///     ),
///   ],
///   onNodeSelect: (node) => print('Selected: \${node.label}'),
/// )
/// ```
class ArcaneTreeView extends StatelessComponent {
  /// Tree nodes
  final List<TreeNode> nodes;

  /// Callback when a node is selected
  final void Function(TreeNode node)? onNodeSelect;

  /// Callback when a node is expanded/collapsed
  final void Function(TreeNode node, bool expanded)? onNodeToggle;

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

  const ArcaneTreeView({
    required this.nodes,
    this.onNodeSelect,
    this.onNodeToggle,
    this.style = TreeViewStyle.lines,
    this.selectionMode = TreeSelectionMode.single,
    this.initiallyExpanded = const {},
    this.selectedNodes = const {},
    this.expandAll = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Build a lookup map for TreeNode by id for callback mapping
    final nodeMap = <String, TreeNode>{};
    void buildMap(List<TreeNode> nodeList) {
      for (final n in nodeList) {
        nodeMap[n.id] = n;
        if (n.hasChildren) buildMap(n.children);
      }
    }
    buildMap(nodes);

    return context.renderers.treeView(TreeViewProps(
      nodes: nodes.map((n) => n.toData()).toList(),
      onNodeSelect: onNodeSelect != null
          ? (nodeData) {
              final original = nodeMap[nodeData.id];
              if (original != null) onNodeSelect!(original);
            }
          : null,
      onNodeToggle: onNodeToggle != null
          ? (nodeData, expanded) {
              final original = nodeMap[nodeData.id];
              if (original != null) onNodeToggle!(original, expanded);
            }
          : null,
      style: style,
      selectionMode: selectionMode,
      initiallyExpanded: initiallyExpanded,
      selectedNodes: selectedNodes,
      expandAll: expandAll,
    ));
  }
}
