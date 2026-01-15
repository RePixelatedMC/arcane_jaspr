import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/tabs_props.dart';

/// Codex Tabs renderer.
///
/// Implements the Codex design language:
/// - Modern pill-style container with gradient border
/// - Accent-colored active state with glow effects
/// - Clean gaming aesthetic
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
        'align-items': 'center',
      }),
      [
        // Tab list with styled container
        _buildTabList(),
        // Tab content - full width
        if (props.selectedIndex >= 0 &&
            props.selectedIndex < props.tabs.length)
          dom.div(
            classes: 'codex-tabs-content',
            styles: const dom.Styles(raw: {
              'padding-top': '1.25rem',
              'width': '100%',
            }),
            [props.tabs[props.selectedIndex].content],
          ),
      ],
    );
  }

  Component _buildTabList() {
    // Outer wrapper with gradient border
    return dom.div(
      classes: 'codex-tabs-list-wrapper',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'border-radius': '12px',
        'padding': '1px',
        'background':
            'linear-gradient(90deg, rgba(5, 150, 105, 0.3), rgba(139, 92, 246, 0.2))',
        if (props.fill) 'width': '100%',
      }),
      [
        // Inner container
        dom.div(
          classes: 'codex-tabs-list',
          attributes: {'role': 'tablist'},
          styles: dom.Styles(raw: {
            'display': 'inline-flex',
            'gap': '4px',
            'padding': '4px',
            'background': 'var(--card)',
            'border-radius': '11px',
            if (props.fill) 'width': '100%',
          }),
          [
            for (var i = 0; i < props.tabs.length; i++)
              _buildTab(props.tabs[i], i),
          ],
        ),
      ],
    );
  }

  Component _buildTab(TabItemProps tab, int index) {
    final bool isSelected = index == props.selectedIndex;
    final bool isDisabled = tab.disabled;

    return dom.button(
      classes:
          'codex-tab ${isSelected ? 'active' : ''} ${isDisabled ? 'disabled' : ''}',
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
        'gap': '8px',
        'padding': '0.625rem 1.25rem',
        'font-size': 'var(--font-size-sm)',
        'font-weight': isSelected ? '600' : '500',
        'color': isSelected
            ? 'var(--primary)'
            : isDisabled
                ? 'var(--muted-foreground)'
                : 'var(--muted-foreground)',
        'background': isSelected
            ? 'linear-gradient(135deg, rgba(5, 150, 105, 0.15), rgba(139, 92, 246, 0.1))'
            : 'transparent',
        'border': isSelected
            ? '1px solid rgba(5, 150, 105, 0.3)'
            : '1px solid transparent',
        'border-radius': '8px',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 0.2s ease',
        'white-space': 'nowrap',
        if (props.fill) 'flex': '1',
        if (isSelected)
          'box-shadow': '0 0 12px rgba(5, 150, 105, 0.2), inset 0 0 8px rgba(5, 150, 105, 0.05)',
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
              'background': 'linear-gradient(135deg, #059669, #8b5cf6)',
              'color': '#ffffff',
              'font-size': '0.625rem',
              'font-weight': '600',
              'padding': '0.125rem 0.5rem',
              'border-radius': '9999px',
              'margin-left': '0.375rem',
            }),
            [Component.text(tab.badge!)],
          ),
      ],
    );
  }
}

/// Codex Tab Bar renderer (tabs without content).
///
/// Modern pill-style tabs with gradient accents.
class CodexTabBar extends StatelessComponent {
  final TabBarProps props;

  const CodexTabBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Outer wrapper with gradient border
    return dom.div(
      classes: 'codex-tab-bar-wrapper',
      styles: dom.Styles(raw: {
        'display': 'inline-flex',
        'border-radius': '12px',
        'padding': '1px',
        'background':
            'linear-gradient(90deg, rgba(5, 150, 105, 0.3), rgba(139, 92, 246, 0.2))',
        if (props.fill) 'width': '100%',
      }),
      [
        // Inner container
        dom.div(
          classes: 'codex-tab-bar',
          attributes: {'role': 'tablist'},
          styles: dom.Styles(raw: {
            'display': 'flex',
            'gap': '4px',
            'padding': '4px',
            'background': 'var(--card)',
            'border-radius': '11px',
            if (props.fill) 'width': '100%',
          }),
          [
            for (var i = 0; i < props.tabs.length; i++) _buildTab(props.tabs[i], i),
          ],
        ),
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
        'gap': '8px',
        'padding': '0.625rem 1.25rem',
        'font-size': 'var(--font-size-sm)',
        'font-weight': isSelected ? '600' : '500',
        'color': isSelected ? 'var(--primary)' : 'var(--muted-foreground)',
        'background': isSelected
            ? 'linear-gradient(135deg, rgba(5, 150, 105, 0.15), rgba(139, 92, 246, 0.1))'
            : 'transparent',
        'border': isSelected
            ? '1px solid rgba(5, 150, 105, 0.3)'
            : '1px solid transparent',
        'border-radius': '8px',
        'cursor': 'pointer',
        'transition': 'all 0.2s ease',
        'white-space': 'nowrap',
        if (props.fill) 'flex': '1',
        if (isSelected)
          'box-shadow':
              '0 0 12px rgba(5, 150, 105, 0.2), inset 0 0 8px rgba(5, 150, 105, 0.05)',
      }),
      events: {'click': (_) => props.onChanged(index)},
      [
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
      ],
    );
  }
}
