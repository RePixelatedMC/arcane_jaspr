import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tabs_props.dart';

/// Codex Tabs renderer.
///
/// Implements the Codex design language:
/// - Larger tab buttons with more padding
/// - Accent-colored active state with subtle glow
/// - Gaming aesthetic with clean lines
class CodexTabs extends StatelessComponent {
  final TabsProps props;

  const CodexTabs(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-tabs',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'width': '100%',
      }),
      [
        // Tab list
        _buildTabList(),
        // Tab content
        if (props.selectedIndex >= 0 &&
            props.selectedIndex < props.tabs.length)
          dom.div(
            classes: 'codex-tabs-content',
            styles: const dom.Styles(raw: {
              'padding-top': '1.25rem', // Codex: more padding
            }),
            [props.tabs[props.selectedIndex].content],
          ),
      ],
    );
  }

  Component _buildTabList() {
    return dom.div(
      classes: 'codex-tabs-list',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '0.25rem', // Codex: small gap between tabs
        'border-bottom': '1px solid var(--border)',
        'padding-bottom': '1px', // Space for active indicator
        if (props.fill) 'width': '100%',
      }),
      [
        for (var i = 0; i < props.tabs.length; i++)
          _buildTab(props.tabs[i], i),
      ],
    );
  }

  Component _buildTab(TabItemProps tab, int index) {
    final bool isSelected = index == props.selectedIndex;
    final bool isDisabled = tab.disabled;

    return dom.button(
      classes: 'codex-tab ${isSelected ? 'active' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: {
        'type': 'button',
        'role': 'tab',
        'aria-selected': isSelected.toString(),
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.5rem',
        // Codex: larger padding
        'padding': '0.75rem 1.25rem',
        'font-size': '0.875rem',
        'font-weight': isSelected ? '600' : '500',
        'color': isSelected
            ? 'var(--codex-accent)'
            : isDisabled
                ? 'var(--muted-foreground)'
                : 'var(--foreground)',
        'background': 'transparent',
        'border': 'none',
        // Codex: accent bottom border when selected with glow
        'border-bottom': isSelected
            ? '2px solid var(--codex-accent)'
            : '2px solid transparent',
        'margin-bottom': '-1px',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all var(--transition)',
        if (props.fill) 'flex': '1',
        // Codex: subtle glow on active tab
        if (isSelected) 'text-shadow': '0 0 10px rgba(var(--codex-accent-rgb), 0.5)',
      }),
      events: isDisabled || props.onChanged == null
          ? null
          : {'click': (_) => props.onChanged!(index)},
      [
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
        if (tab.badge != null)
          dom.span(
            classes: 'codex-tab-badge',
            styles: const dom.Styles(raw: {
              'background-color': 'var(--codex-accent)',
              'color': '#ffffff',
              'font-size': '0.625rem',
              'font-weight': '600',
              'padding': '0.125rem 0.375rem',
              'border-radius': '9999px',
              'margin-left': '0.25rem',
            }),
            [Component.text(tab.badge!)],
          ),
      ],
    );
  }
}

/// Codex Tab Bar renderer (tabs without content).
class CodexTabBar extends StatelessComponent {
  final TabBarProps props;

  const CodexTabBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-tab-bar',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'gap': '0.25rem',
        // Codex: contained tab bar with background
        'background-color': 'var(--muted)',
        'padding': '0.25rem',
        'border-radius': 'var(--radius)',
        if (props.fill) 'width': '100%',
      }),
      [
        for (var i = 0; i < props.tabs.length; i++)
          _buildTab(props.tabs[i], i),
      ],
    );
  }

  Component _buildTab(TabBarItemProps tab, int index) {
    final bool isSelected = index == props.selectedIndex;

    return dom.button(
      classes: 'codex-tab-bar-item ${isSelected ? 'active' : ''}',
      attributes: {
        'type': 'button',
        'role': 'tab',
        'aria-selected': isSelected.toString(),
      },
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.5rem',
        // Codex: larger padding
        'padding': '0.625rem 1rem',
        'font-size': '0.875rem',
        'font-weight': isSelected ? '600' : '500',
        'color': isSelected ? 'var(--foreground)' : 'var(--muted-foreground)',
        'background-color': isSelected ? 'var(--card)' : 'transparent',
        'border': 'none',
        'border-radius': 'var(--radius-md)',
        'cursor': 'pointer',
        'transition': 'all var(--transition)',
        if (props.fill) 'flex': '1',
        // Codex: subtle shadow when selected
        if (isSelected) 'box-shadow': '0 1px 3px rgba(0, 0, 0, 0.2)',
      }),
      events: {'click': (_) => props.onChanged(index)},
      [
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
      ],
    );
  }
}
