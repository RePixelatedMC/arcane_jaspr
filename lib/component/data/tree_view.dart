import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/tree_view_props.dart';

/// Tree node data.
class TreeNode {
  final String id;
  final String label;
  final Component? icon;
  final List<TreeNode> children;
  final bool disabled;
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

  TreeNodeData toData() => TreeNodeData(
        id: id,
        label: label,
        icon: icon,
        children: children.map((c) => c.toData()).toList(),
        disabled: disabled,
        data: data,
      );
}

/// Hierarchical tree view component for displaying nested data.
class ArcaneTreeView extends StatelessComponent {
  final List<TreeNode> nodes;
  final void Function(TreeNode node)? onNodeSelect;
  final void Function(TreeNode node, bool expanded)? onNodeToggle;
  final TreeViewStyle style;
  final TreeSelectionMode selectionMode;
  final Set<String> initiallyExpanded;
  final Set<String> selectedNodes;
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
