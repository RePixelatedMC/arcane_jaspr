import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/tabs_props.dart';

class NeubrutalismTabs extends StatelessComponent {
  final TabsProps props;

  const NeubrutalismTabs(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-tabs',
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '1.25rem',
          'width': '100%',
        },
      ),
      <Component>[
        _buildTabList(),
        if (props.selectedIndex >= 0 && props.selectedIndex < props.tabs.length)
          dom.div(
            classes: 'neubrutalism-tabs-content',
            styles: const dom.Styles(
              raw: <String, String>{'width': '100%'},
            ),
            <Component>[props.tabs[props.selectedIndex].content],
          ),
      ],
    );
  }

  Component _buildTabList() {
    return dom.div(
      classes: 'neubrutalism-tabs-list',
      attributes: const <String, String>{'role': 'tablist'},
      styles: dom.Styles(
        raw: <String, String>{
          'display': props.fill ? 'flex' : 'inline-flex',
          'align-items': 'stretch',
          'gap': '0.25rem',
          'padding': '0.25rem',
          if (props.fill) 'width': '100%',
          'align-self': props.fill ? 'stretch' : 'flex-start',
        },
      ),
      <Component>[
        for (int i = 0; i < props.tabs.length; i++)
          _buildTab(props.tabs[i], i),
      ],
    );
  }

  Component _buildTab(TabItemProps tab, int index) {
    bool isSelected = index == props.selectedIndex;
    bool isDisabled = tab.disabled;

    return dom.button(
      classes:
          'neubrutalism-tabs-trigger ${isSelected ? 'active' : ''} ${isDisabled ? 'disabled' : ''}',
      attributes: <String, String>{
        'type': 'button',
        'role': 'tab',
        'aria-selected': isSelected.toString(),
        'data-state': isSelected ? 'active' : 'inactive',
        'data-disabled': '$isDisabled',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.5rem',
          'padding': '0.625rem 1.125rem',
          'font-size': 'var(--font-size-sm)',
          'font-weight': '800',
          'letter-spacing': '0',
          'text-transform': 'none',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'opacity': isDisabled ? '0.5' : '1',
          'white-space': 'nowrap',
          'outline': 'none',
          if (props.fill) 'flex': '1',
        },
      ),
      events: isDisabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (dynamic _) => props.onChanged!(index),
            },
      <Component>[
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
        if (tab.badge != null)
          dom.span(
            classes: 'neubrutalism-tabs-badge',
            styles: const dom.Styles(
              raw: <String, String>{
                'background-color': 'var(--nb-accent, var(--primary))',
                'color': 'var(--nb-ink, #000)',
                'font-size': '0.6875rem',
                'font-weight': '900',
                'padding': '0.125rem 0.5rem',
                'border':
                    'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
                'border-radius': '9999px',
                'margin-left': '0.375rem',
                'line-height': '1.2',
              },
            ),
            <Component>[Component.text(tab.badge!)],
          ),
      ],
    );
  }
}

class NeubrutalismTabBar extends StatelessComponent {
  final TabBarProps props;

  const NeubrutalismTabBar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'neubrutalism-tab-bar',
      attributes: const <String, String>{'role': 'tablist'},
      styles: dom.Styles(
        raw: <String, String>{
          'display': props.fill ? 'flex' : 'inline-flex',
          'align-items': 'stretch',
          'gap': '0.25rem',
          'padding': '0.25rem',
          if (props.fill) 'width': '100%',
        },
      ),
      <Component>[
        for (int i = 0; i < props.tabs.length; i++)
          _buildTab(props.tabs[i], i),
      ],
    );
  }

  Component _buildTab(TabBarItemProps tab, int index) {
    bool isSelected = index == props.selectedIndex;

    return dom.button(
      classes: 'neubrutalism-tab-bar-item ${isSelected ? 'active' : ''}',
      attributes: <String, String>{
        'type': 'button',
        'role': 'tab',
        'aria-selected': isSelected.toString(),
        'data-state': isSelected ? 'active' : 'inactive',
      },
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.5rem',
          'padding': '0.625rem 1.125rem',
          'font-size': 'var(--font-size-sm)',
          'font-weight': '800',
          'letter-spacing': '0',
          'text-transform': 'none',
          'cursor': 'pointer',
          'white-space': 'nowrap',
          'outline': 'none',
          if (props.fill) 'flex': '1',
        },
      ),
      events: <String, EventCallback>{
        'click': (dynamic _) => props.onChanged(index),
      },
      <Component>[
        if (tab.icon != null) tab.icon!,
        Component.text(tab.label),
      ],
    );
  }
}
