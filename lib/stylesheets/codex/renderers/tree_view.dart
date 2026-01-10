import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tree_view_props.dart';

/// Codex Tree View renderer.
class CodexTreeView extends StatefulComponent {
  final TreeViewProps props;

  const CodexTreeView(this.props, {super.key});

  @override
  State<CodexTreeView> createState() => _CodexTreeViewState();
}

class _CodexTreeViewState extends State<CodexTreeView> {
  late Set<String> _expandedNodes;
  late Set<String> _selectedNodes;

  @override
  void initState() {
    super.initState();
    _expandedNodes = {...component.props.initiallyExpanded};
    _selectedNodes = {...component.props.selectedNodes};

    if (component.props.expandAll) {
      _expandAllNodes(component.props.nodes);
    }
  }

  void _expandAllNodes(List<TreeNodeData> nodes) {
    for (final node in nodes) {
      if (node.hasChildren) {
        _expandedNodes.add(node.id);
        _expandAllNodes(node.children);
      }
    }
  }

  void _toggleExpand(TreeNodeData node) {
    setState(() {
      if (_expandedNodes.contains(node.id)) {
        _expandedNodes.remove(node.id);
      } else {
        _expandedNodes.add(node.id);
      }
    });
    component.props.onNodeToggle?.call(node, _expandedNodes.contains(node.id));
  }

  void _selectNode(TreeNodeData node) {
    if (node.disabled) return;

    setState(() {
      if (component.props.selectionMode == TreeSelectionMode.single) {
        _selectedNodes = {node.id};
      } else if (component.props.selectionMode == TreeSelectionMode.multiple) {
        if (_selectedNodes.contains(node.id)) {
          _selectedNodes.remove(node.id);
        } else {
          _selectedNodes.add(node.id);
        }
      }
    });
    component.props.onNodeSelect?.call(node);
  }

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-tree-view',
      attributes: {'role': 'tree'},
      styles: const dom.Styles(raw: {'font-size': 'var(--arcane-font-size-sm)'}),
      [
        for (final node in component.props.nodes) _buildNode(node, 0),
      ],
    );
  }

  Component _buildNode(TreeNodeData node, int level) {
    final isExpanded = _expandedNodes.contains(node.id);
    final isSelected = _selectedNodes.contains(node.id);
    final indent = 24 * level;

    final showLines = component.props.style == TreeViewStyle.lines;
    final isCompact = component.props.style == TreeViewStyle.compact;

    return dom.div(
      styles: const dom.Styles(raw: {}),
      [
        // Node row
        dom.div(
          classes: 'codex-tree-node ${isSelected ? 'selected' : ''}',
          attributes: {
            'role': 'treeitem',
            if (node.hasChildren) 'aria-expanded': isExpanded ? 'true' : 'false',
            'aria-selected': isSelected ? 'true' : 'false',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'padding': isCompact ? '0.375rem 0.75rem' : '0.5rem 1rem',
            'padding-left': '${indent + 16}px',
            'cursor': node.disabled ? 'not-allowed' : 'pointer',
            'opacity': node.disabled ? '0.5' : '1',
            'background': isSelected ? 'rgba(var(--codex-accent-rgb), 0.15)' : 'transparent',
            'border-radius': 'var(--radius-sm)',
            'transition': 'all var(--arcane-transition)',
            'user-select': 'none',
          }),
          events: {
            'click': (_) {
              if (node.hasChildren) {
                _toggleExpand(node);
              }
              _selectNode(node);
            },
          },
          [
            // Expand/collapse icon
            if (node.hasChildren)
              dom.span(
                styles: dom.Styles(raw: {
                  'display': 'inline-flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '18px',
                  'height': '18px',
                  'margin-right': '0.375rem',
                  'font-size': '10px',
                  'color': 'var(--muted-foreground)',
                  'transform': isExpanded ? 'rotate(90deg)' : 'rotate(0deg)',
                  'transition': 'transform var(--arcane-transition-slow)',
                }),
                [const Component.text('\u25B6')],
              )
            else if (showLines)
              const dom.span(
                styles: dom.Styles(raw: {
                  'width': '18px',
                  'margin-right': '0.375rem',
                }),
                [],
              ),

            // Node icon
            if (node.icon != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'margin-right': '0.375rem',
                  'display': 'inline-flex',
                  'align-items': 'center',
                }),
                [node.icon!],
              ),

            // Node label
            dom.span(
              styles: dom.Styles(raw: {
                'color': isSelected ? 'var(--codex-accent)' : 'var(--foreground)',
                'font-weight': isSelected ? '500' : '400',
              }),
              [Component.text(node.label)],
            ),
          ],
        ),

        // Children
        if (node.hasChildren && isExpanded)
          dom.div(
            attributes: {'role': 'group'},
            styles: dom.Styles(raw: {
              if (showLines) 'border-left': '1px solid var(--border)',
              if (showLines) 'margin-left': '${indent + 24}px',
            }),
            [
              for (final child in node.children)
                _buildNode(child, showLines ? 0 : level + 1),
            ],
          ),
      ],
    );
  }
}
