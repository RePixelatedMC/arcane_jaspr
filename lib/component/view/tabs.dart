import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

/// Tab item data
class TabItem {
  /// Unique identifier
  final String id;

  /// Display label
  final String label;

  /// Optional icon
  final Component? icon;

  /// Whether tab is disabled
  final bool disabled;

  /// Badge/count to display
  final String? badge;

  const TabItem({
    required this.id,
    required this.label,
    this.icon,
    this.disabled = false,
    this.badge,
  });
}

/// Tab bar style variants
enum TabsStyle {
  /// Underline indicator style
  underline,

  /// Pill/button style
  pills,

  /// Segmented control style
  segmented,

  /// Boxed/card style
  boxed,
}

/// Tab bar size variants
enum TabsSize {
  sm,
  md,
  lg,
}

/// Simple inline tab bar component
///
/// For switching between different views/content panels.
///
/// ```dart
/// ArcaneTabs(
///   tabs: [
///     TabItem(id: 'overview', label: 'Overview'),
///     TabItem(id: 'settings', label: 'Settings'),
///     TabItem(id: 'logs', label: 'Logs', badge: '3'),
///   ],
///   activeTab: 'overview',
///   onTabChange: (id) => print('Selected: $id'),
/// )
/// ```
class ArcaneTabs extends StatelessComponent {
  /// List of tab items
  final List<TabItem> tabs;

  /// Currently active tab ID
  final String activeTab;

  /// Callback when tab changes
  final void Function(String tabId)? onTabChange;

  /// Style variant
  final TabsStyle style;

  /// Size variant
  final TabsSize size;

  /// Whether tabs should fill available width
  final bool fullWidth;

  /// Custom content for each tab (keyed by tab ID)
  final Map<String, Component>? content;

  const ArcaneTabs({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.style = TabsStyle.underline,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  });

  /// Underline tabs
  const ArcaneTabs.underline({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  }) : style = TabsStyle.underline;

  /// Pill tabs
  const ArcaneTabs.pills({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  }) : style = TabsStyle.pills;

  /// Segmented tabs
  const ArcaneTabs.segmented({
    required this.tabs,
    required this.activeTab,
    this.onTabChange,
    this.size = TabsSize.md,
    this.fullWidth = false,
    this.content,
    super.key,
  }) : style = TabsStyle.segmented;

  (String padding, String fontSize, String gap) get _sizeStyles => switch (size) {
        TabsSize.sm => ('6px 12px', '0.75rem', '0.25rem'),
        TabsSize.md => ('10px 16px', '0.875rem', '0.5rem'),
        TabsSize.lg => ('14px 24px', '1rem', '1rem'),
      };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, gap) = _sizeStyles;

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '1rem',
      }),
      [
        // Tab bar
        div(
          attributes: {'role': 'tablist'},
          styles: Styles(raw: {
            'display': 'flex',
            'gap': style == TabsStyle.segmented ? '0' : gap,
            if (style == TabsStyle.underline)
              'border-bottom': '1px solid var(--border)',
            if (style == TabsStyle.segmented) ...{
              'background': 'var(--muted)',
              'padding': '4px',
              'border-radius': '0.375rem',
            },
            if (style == TabsStyle.boxed) ...{
              'background': 'var(--muted)',
              'padding': '4px',
              'border-radius': '0.375rem',
            },
          }),
          [
            for (final tab in tabs)
              _buildTab(tab, padding, fontSize),
          ],
        ),

        // Content panel
        if (content != null && content!.containsKey(activeTab))
          div(
            attributes: {
              'role': 'tabpanel',
              'aria-labelledby': 'tab-$activeTab',
            },
            styles: const Styles(raw: {}),
            [content![activeTab]!],
          ),
      ],
    );
  }

  Component _buildTab(TabItem tab, String padding, String fontSize) {
    final isActive = tab.id == activeTab;
    final isDisabled = tab.disabled;

    final tabStyles = switch (style) {
      TabsStyle.underline => {
          'background': 'transparent',
          'border': 'none',
          'border-bottom': isActive
              ? '2px solid var(--accent)'
              : '2px solid transparent',
          'margin-bottom': '-1px',
          'color': isActive ? 'var(--accent)' : 'var(--muted-foreground)',
          'border-radius': '0',
        },
      TabsStyle.pills => {
          'background': isActive ? 'var(--accent)' : 'transparent',
          'border': 'none',
          'color': isActive ? 'var(--foreground)' : 'var(--muted-foreground)',
          'border-radius': '9999px',
        },
      TabsStyle.segmented => {
          'background': isActive ? 'var(--card)' : 'transparent',
          'border': 'none',
          'color': isActive ? 'var(--foreground)' : 'var(--muted-foreground)',
          'border-radius': '0.25rem',
          if (isActive) 'box-shadow': '0 1px 2px 0 rgb(0 0 0 / 0.05)',
        },
      TabsStyle.boxed => {
          'background': isActive ? 'var(--card)' : 'transparent',
          'border': isActive
              ? '1px solid var(--border)'
              : '1px solid transparent',
          'color': isActive ? 'var(--foreground)' : 'var(--muted-foreground)',
          'border-radius': '0.25rem',
        },
    };

    return button(
      type: ButtonType.button,
      attributes: {
        'role': 'tab',
        'id': 'tab-${tab.id}',
        'aria-selected': isActive ? 'true' : 'false',
        if (isDisabled) 'disabled': 'true',
      },
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '0.25rem',
        'padding': padding,
        'font-size': fontSize,
        'font-weight': isActive ? '500' : '400',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
        'white-space': 'nowrap',
        if (fullWidth) 'flex': '1',
        ...tabStyles,
      }),
      events: isDisabled
          ? null
          : {
              'click': (_) => onTabChange?.call(tab.id),
            },
      [
        if (tab.icon != null) tab.icon!,
        text(tab.label),
        if (tab.badge != null)
          span(
            styles: const Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'min-width': '18px',
              'height': '18px',
              'padding': '0 6px',
              'background': 'var(--accent)',
              'color': 'var(--foreground)',
              'font-size': '0.75rem',
              'font-weight': '500',
              'border-radius': '9999px',
            }),
            [text(tab.badge!)],
          ),
      ],
    );
  }
}
