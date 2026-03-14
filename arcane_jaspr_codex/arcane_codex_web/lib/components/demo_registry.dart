library;

import 'package:arcane_jaspr/arcane_jaspr.dart';

typedef DemoPreviewBuilder = Widget Function();

class DemoDefinition {
  final String componentType;
  final String symbolName;
  final String sourcePath;
  final String code;
  final DemoPreviewBuilder previewBuilder;

  const DemoDefinition({
    required this.componentType,
    required this.symbolName,
    required this.sourcePath,
    required this.code,
    required this.previewBuilder,
  });
}

List<DemoDefinition> demoDefinitions = <DemoDefinition>[
  DemoDefinition(
    componentType: 'accordion',
    symbolName: 'ArcaneAccordion',
    sourcePath: 'lib/component/interactive/accordion.dart',
    code: '''ArcaneAccordion(
  items: const [
    ArcaneAccordionItem(title: 'What is Arcane Jaspr?', content: 'A Flutter-like DX for Jaspr.'),
  ],
)''',
    previewBuilder: _buildAccordionDemo,
  ),
  DemoDefinition(
    componentType: 'alert',
    symbolName: 'ArcaneAlert',
    sourcePath: 'lib/component/view/alert.dart',
    code: '''const ArcaneAlert.info(
  title: 'Heads up',
  message: 'This is a live alert preview rendered by the current theme.',
)''',
    previewBuilder: _buildAlertDemo,
  ),
  DemoDefinition(
    componentType: 'alert-dialog',
    symbolName: 'ArcaneAlertDialog',
    sourcePath: 'lib/component/dialog/confirm.dart',
    code: '''const ArcaneAlertDialog(
  title: 'Delete Project?',
  message: 'This action cannot be undone.',
  buttonText: 'Understood',
)''',
    previewBuilder: _buildAlertDialogDemo,
  ),
  DemoDefinition(
    componentType: 'aspect-ratio',
    symbolName: 'ArcaneAspectRatio',
    sourcePath: 'lib/component/layout/aspect_ratio.dart',
    code: '''ArcaneAspectRatio.video(
  child: const Card(child: Text('16:9 container')),
)''',
    previewBuilder: _buildAspectRatioDemo,
  ),
  DemoDefinition(
    componentType: 'avatar',
    symbolName: 'ArcaneAvatar',
    sourcePath: 'lib/component/view/avatar.dart',
    code: '''ArcaneAvatarGroup.toRight(
  avatars: const [
    ArcaneAvatar(initials: 'AB'),
    ArcaneAvatar(initials: 'CD'),
  ],
)''',
    previewBuilder: _buildAvatarDemo,
  ),
  DemoDefinition(
    componentType: 'badge',
    symbolName: 'ArcaneStatusBadge',
    sourcePath: 'lib/component/feedback/status_badge.dart',
    code: '''const ArcaneStatusBadge.success('Online')''',
    previewBuilder: _buildBadgeDemo,
  ),
  DemoDefinition(
    componentType: 'breadcrumb',
    symbolName: 'ArcaneBreadcrumbs',
    sourcePath: 'lib/component/navigation/breadcrumbs.dart',
    code: '''ArcaneBreadcrumbs(
  items: const [
    BreadcrumbItem(label: 'Docs', href: '/docs'),
    BreadcrumbItem(label: 'Components'),
  ],
)''',
    previewBuilder: _buildBreadcrumbDemo,
  ),
  DemoDefinition(
    componentType: 'button',
    symbolName: 'Button',
    sourcePath: 'lib/component/input/button.dart',
    code: '''Button.primary(label: 'Primary Action', onPressed: () {})''',
    previewBuilder: _buildButtonDemo,
  ),
  DemoDefinition(
    componentType: 'button-group',
    symbolName: 'ButtonGroup',
    sourcePath: 'lib/component/layout/button_panel.dart',
    code: '''ButtonGroup(
  children: [
    Button.secondary(label: 'Back', onPressed: () {}),
    Button.primary(label: 'Continue', onPressed: () {}),
  ],
)''',
    previewBuilder: _buildButtonGroupDemo,
  ),
  DemoDefinition(
    componentType: 'calendar',
    symbolName: 'ArcaneCalendar',
    sourcePath: 'lib/component/input/calendar.dart',
    code: '''ArcaneCalendar(
  selected: DateTime.now(),
  onSelect: (DateTime date) {},
)''',
    previewBuilder: _buildCalendarDemo,
  ),
  DemoDefinition(
    componentType: 'card',
    symbolName: 'Card',
    sourcePath: 'lib/component/card/card.dart',
    code: '''const Card.elevated(child: Text('Card content'))''',
    previewBuilder: _buildCardDemo,
  ),
  DemoDefinition(
    componentType: 'carousel',
    symbolName: 'CardCarousel',
    sourcePath: 'lib/component/collection/card_carousel.dart',
    code: '''CardCarousel(
  children: const [
    Card(child: Text('Slide 1')),
    Card(child: Text('Slide 2')),
  ],
)''',
    previewBuilder: _buildCarouselDemo,
  ),
  DemoDefinition(
    componentType: 'chart',
    symbolName: 'ArcaneChart',
    sourcePath: 'lib/component/data/chart.dart',
    code: '''ArcaneChart(
  title: 'Revenue',
  points: const [
    ArcaneChartPoint(label: 'Jan', value: 12),
    ArcaneChartPoint(label: 'Feb', value: 18),
  ],
)''',
    previewBuilder: _buildChartDemo,
  ),
  DemoDefinition(
    componentType: 'checkbox',
    symbolName: 'ArcaneCheckbox',
    sourcePath: 'lib/component/input/checkbox.dart',
    code: '''ArcaneCheckbox(
  checked: true,
  label: 'Enable notifications',
  onChanged: (bool value) {},
)''',
    previewBuilder: _buildCheckboxDemo,
  ),
  DemoDefinition(
    componentType: 'collapsible',
    symbolName: 'ArcaneDisclosure',
    sourcePath: 'lib/component/interactive/disclosure.dart',
    code: '''const ArcaneDisclosure(
  summary: Text('Toggle content'),
  child: Text('This disclosure is rendered by the active theme.'),
)''',
    previewBuilder: _buildCollapsibleDemo,
  ),
  DemoDefinition(
    componentType: 'combobox',
    symbolName: 'ArcaneCombobox',
    sourcePath: 'lib/component/input/combobox.dart',
    code: '''ArcaneCombobox(
  value: 'jaspr',
  options: const [
    ComboboxOption(value: 'jaspr', label: 'Jaspr'),
    ComboboxOption(value: 'flutter', label: 'Flutter'),
  ],
  onChanged: (String? value) {},
)''',
    previewBuilder: _buildComboboxDemo,
  ),
  DemoDefinition(
    componentType: 'command',
    symbolName: 'ArcaneCommand',
    sourcePath: 'lib/component/dialog/command.dart',
    code: '''ArcaneCommand(
  isOpen: true,
  groups: const [
    CommandGroup(heading: 'Navigation', items: [CommandItem(label: 'Go to Dashboard')]),
  ],
)''',
    previewBuilder: _buildCommandDemo,
  ),
  DemoDefinition(
    componentType: 'context-menu',
    symbolName: 'ArcaneContextMenu',
    sourcePath: 'lib/component/menu/context_menu.dart',
    code: '''ArcaneContextMenu(
  trigger: Button.secondary(label: 'Right-click me', onPressed: () {}),
  items: const [MenuItemAction(label: 'Copy')],
)''',
    previewBuilder: _buildContextMenuDemo,
  ),
  DemoDefinition(
    componentType: 'data-table',
    symbolName: 'DataTable',
    sourcePath: 'lib/component/view/data_table.dart',
    code: '''DataTable(
  items: const [_DemoUser(name: 'Alex', role: 'Admin', status: 'Active')],
  columns: [
    DataColumn(header: 'Name', builder: (_DemoUser user) => Text(user.name)),
  ],
)''',
    previewBuilder: _buildDataTableDemo,
  ),
  DemoDefinition(
    componentType: 'date-picker',
    symbolName: 'ArcaneDatePicker',
    sourcePath: 'lib/component/input/date_picker.dart',
    code: '''ArcaneDatePicker(
  value: DateTime.now(),
  onChanged: (DateTime? value) {},
)''',
    previewBuilder: _buildDatePickerDemo,
  ),
  DemoDefinition(
    componentType: 'dialog',
    symbolName: 'ArcaneDialog',
    sourcePath: 'lib/component/dialog/dialog.dart',
    code: '''ArcaneDialog(
  title: 'Confirm Settings',
  child: const Text('Apply changes?'),
  actions: [Button.primary(label: 'Apply', onPressed: () {})],
)''',
    previewBuilder: _buildDialogDemo,
  ),
  DemoDefinition(
    componentType: 'direction',
    symbolName: 'ArcaneDirection',
    sourcePath: 'lib/component/layout/direction.dart',
    code: '''const ArcaneDirection(
  value: ArcaneDirectionValue.rtl,
  children: [Text('Right-to-left direction preview')],
)''',
    previewBuilder: _buildDirectionDemo,
  ),
  DemoDefinition(
    componentType: 'drawer',
    symbolName: 'ArcaneDrawer',
    sourcePath: 'lib/component/layout/drawer.dart',
    code: '''ArcaneDrawer.left(
  isOpen: true,
  header: const Text('Navigation'),
  child: const Text('Drawer content'),
)''',
    previewBuilder: _buildDrawerDemo,
  ),
  DemoDefinition(
    componentType: 'dropdown-menu',
    symbolName: 'ArcaneDropdownMenu',
    sourcePath: 'lib/component/menu/dropdown_menu.dart',
    code: '''ArcaneDropdownMenu(
  trigger: Button.secondary(label: 'Open menu', onPressed: () {}),
  items: const [MenuItemAction(label: 'Profile')],
)''',
    previewBuilder: _buildDropdownMenuDemo,
  ),
  DemoDefinition(
    componentType: 'empty',
    symbolName: 'ArcaneEmptyState',
    sourcePath: 'lib/component/view/empty_state.dart',
    code: '''ArcaneEmptyState.noResults()''',
    previewBuilder: _buildEmptyDemo,
  ),
  DemoDefinition(
    componentType: 'field',
    symbolName: 'ArcaneField',
    sourcePath: 'lib/component/form/field.dart',
    code: '''ArcaneFieldWrapper(
  labelText: 'Email',
  field: TextInput(placeholder: 'name@company.com', onChange: (String value) {}),
)''',
    previewBuilder: _buildFieldDemo,
  ),
  DemoDefinition(
    componentType: 'hover-card',
    symbolName: 'ArcaneHoverCard',
    sourcePath: 'lib/component/view/floating.dart',
    code: '''ArcaneHoverCard.hovercard(
  trigger: Button.secondary(label: 'Hover card', onPressed: () {}),
  content: const Card(child: Text('A lightweight profile or preview card.')),
)''',
    previewBuilder: _buildHoverCardDemo,
  ),
  DemoDefinition(
    componentType: 'input',
    symbolName: 'TextInput',
    sourcePath: 'lib/component/input/text_input.dart',
    code: '''TextInput(
  label: 'Email',
  placeholder: 'name@example.com',
  onChange: (String value) {},
)''',
    previewBuilder: _buildInputDemo,
  ),
  DemoDefinition(
    componentType: 'input-group',
    symbolName: 'ArcaneInputGroup',
    sourcePath: 'lib/component/form/field_wrapper.dart',
    code: '''ArcaneInputGroup(
  children: [
    TextInput(placeholder: 'Search', onChange: (String value) {}),
    Button.primary(label: 'Go', onPressed: () {}),
  ],
)''',
    previewBuilder: _buildInputGroupDemo,
  ),
  DemoDefinition(
    componentType: 'input-otp',
    symbolName: 'ArcaneOtpInput',
    sourcePath: 'lib/component/input/otp_input.dart',
    code: '''ArcaneOtpInput.sixDigit(
  value: '123456',
  onChange: (String value) {},
)''',
    previewBuilder: _buildInputOtpDemo,
  ),
  DemoDefinition(
    componentType: 'item',
    symbolName: 'ArcaneItem',
    sourcePath: 'lib/component/view/item.dart',
    code: '''const ArcaneItem(
  child: Text('Clickable item row'),
  href: '/docs',
)''',
    previewBuilder: _buildItemDemo,
  ),
  DemoDefinition(
    componentType: 'kbd',
    symbolName: 'ArcaneKbd',
    sourcePath: 'lib/component/view/kbd.dart',
    code: '''const ArcaneKbd.combo(['Cmd', 'K'])''',
    previewBuilder: _buildKbdDemo,
  ),
  DemoDefinition(
    componentType: 'menubar',
    symbolName: 'ArcaneMenubar',
    sourcePath: 'lib/component/menu/menubar.dart',
    code: '''ArcaneMenubar(
  menus: const [
    ArcaneMenubarMenu(label: 'File', items: [MenuItemAction(label: 'New')]),
  ],
)''',
    previewBuilder: _buildMenubarDemo,
  ),
  DemoDefinition(
    componentType: 'navigation-menu',
    symbolName: 'ArcaneNavDropdown',
    sourcePath: 'lib/component/navigation/nav_dropdown.dart',
    code: '''ArcaneNavDropdown(
  label: 'Products',
  content: const ArcaneBox(children: [Text('Core UI')]),
)''',
    previewBuilder: _buildNavigationMenuDemo,
  ),
  DemoDefinition(
    componentType: 'pagination',
    symbolName: 'ArcanePagination',
    sourcePath: 'lib/component/navigation/pagination.dart',
    code: '''ArcanePagination(
  currentPage: 2,
  totalPages: 8,
  onPageChange: (int page) {},
)''',
    previewBuilder: _buildPaginationDemo,
  ),
  DemoDefinition(
    componentType: 'popover',
    symbolName: 'ArcanePopover',
    sourcePath: 'lib/component/dialog/popover.dart',
    code: '''ArcanePopover(
  trigger: Button.secondary(label: 'Open popover', onPressed: () {}),
  content: const Card(child: Text('Popover content')),
)''',
    previewBuilder: _buildPopoverDemo,
  ),
  DemoDefinition(
    componentType: 'progress',
    symbolName: 'ArcaneProgressBar',
    sourcePath: 'lib/component/view/progress_bar.dart',
    code: '''const ArcaneProgressBar(value: 68, showValue: true)''',
    previewBuilder: _buildProgressDemo,
  ),
  DemoDefinition(
    componentType: 'radio-group',
    symbolName: 'ArcaneRadioGroup',
    sourcePath: 'lib/component/input/radio_group.dart',
    code: '''ArcaneRadioGroup(
  value: 'starter',
  options: const [
    RadioOption(value: 'starter', label: 'Starter'),
    RadioOption(value: 'pro', label: 'Pro'),
  ],
  onChanged: (String value) {},
)''',
    previewBuilder: _buildRadioGroupDemo,
  ),
  DemoDefinition(
    componentType: 'resizable',
    symbolName: 'ArcaneResizable',
    sourcePath: 'lib/component/layout/resizable.dart',
    code: '''ArcaneResizable.sidebarLayout(
  sidebar: const Card(child: Text('Sidebar')),
  content: const Card(child: Text('Main content')),
)''',
    previewBuilder: _buildResizableDemo,
  ),
  DemoDefinition(
    componentType: 'scroll-area',
    symbolName: 'ArcaneScrollArea',
    sourcePath: 'lib/component/layout/scroll_area.dart',
    code: '''ArcaneScrollArea.vertical(
  height: '150px',
  child: ArcaneBox(children: const [Text('Row 1'), Text('Row 2')]),
)''',
    previewBuilder: _buildScrollAreaDemo,
  ),
  DemoDefinition(
    componentType: 'select',
    symbolName: 'ArcaneSelect',
    sourcePath: 'lib/component/input/text_input.dart',
    code: '''ArcaneSelect(
  label: 'Plan',
  value: 'pro',
  options: const [
    ArcaneSelectOption(label: 'Starter', value: 'starter'),
    ArcaneSelectOption(label: 'Pro', value: 'pro'),
  ],
  onChange: (String value) {},
)''',
    previewBuilder: _buildSelectDemo,
  ),
  DemoDefinition(
    componentType: 'separator',
    symbolName: 'ArcaneSeparator',
    sourcePath: 'lib/component/view/separator.dart',
    code: '''const ArcaneSeparator.withLabel(label: 'OR')''',
    previewBuilder: _buildSeparatorDemo,
  ),
  DemoDefinition(
    componentType: 'sheet',
    symbolName: 'ArcaneSheet',
    sourcePath: 'lib/component/layout/sheet.dart',
    code: '''ArcaneSheet.bottom(
  isOpen: true,
  child: const Text('Sheet content'),
)''',
    previewBuilder: _buildSheetDemo,
  ),
  DemoDefinition(
    componentType: 'sidebar',
    symbolName: 'ArcaneSidebar',
    sourcePath: 'lib/component/navigation/sidebar.dart',
    code: '''ArcaneSidebar(
  width: 240,
  children: const [ArcaneSidebarItem(label: 'Dashboard', selected: true)],
)''',
    previewBuilder: _buildSidebarDemo,
  ),
  DemoDefinition(
    componentType: 'skeleton',
    symbolName: 'ArcaneSkeleton',
    sourcePath: 'lib/component/view/skeleton.dart',
    code: '''const ArcaneSkeletonCard()''',
    previewBuilder: _buildSkeletonDemo,
  ),
  DemoDefinition(
    componentType: 'slider',
    symbolName: 'ArcaneSlider',
    sourcePath: 'lib/component/input/slider.dart',
    code: '''ArcaneSlider(
  label: 'Volume',
  value: 42,
  onChanged: (double value) {},
)''',
    previewBuilder: _buildSliderDemo,
  ),
  DemoDefinition(
    componentType: 'sonner',
    symbolName: 'ArcaneSonner',
    sourcePath: 'lib/component/dialog/sonner.dart',
    code: '''ArcaneSonner.success(
  'Sonner-compatible toast stack',
  title: 'Notification',
)''',
    previewBuilder: _buildSonnerDemo,
  ),
  DemoDefinition(
    componentType: 'spinner',
    symbolName: 'ArcaneSpinner',
    sourcePath: 'lib/component/view/spinner.dart',
    code: '''const ArcaneSpinner()''',
    previewBuilder: _buildSpinnerDemo,
  ),
  DemoDefinition(
    componentType: 'switch',
    symbolName: 'ArcaneToggleSwitch',
    sourcePath: 'lib/component/input/toggle_switch.dart',
    code: '''ArcaneToggleSwitch(
  value: true,
  label: 'Enable sync',
  onChanged: (bool value) {},
)''',
    previewBuilder: _buildSwitchDemo,
  ),
  DemoDefinition(
    componentType: 'table',
    symbolName: 'StaticTable',
    sourcePath: 'lib/component/view/static_table.dart',
    code: '''StaticTable(
  headers: const ['Name', 'Role'],
  rows: const [
    [Text('Alex'), Text('Admin')],
  ],
)''',
    previewBuilder: _buildTableDemo,
  ),
  DemoDefinition(
    componentType: 'tabs',
    symbolName: 'ArcaneTabs',
    sourcePath: 'lib/component/layout/tabs.dart',
    code: '''ArcaneTabs(
  tabs: const [
    ArcaneTabItem(label: 'Account', content: Text('Account tab content')),
  ],
)''',
    previewBuilder: _buildTabsDemo,
  ),
  DemoDefinition(
    componentType: 'textarea',
    symbolName: 'TextArea',
    sourcePath: 'lib/component/input/text_input.dart',
    code: '''TextArea(
  label: 'Message',
  placeholder: 'Type your message',
  onChange: (String value) {},
)''',
    previewBuilder: _buildTextareaDemo,
  ),
  DemoDefinition(
    componentType: 'toggle',
    symbolName: 'ArcaneToggleButton',
    sourcePath: 'lib/component/input/cycle_button.dart',
    code: '''ArcaneToggleButton(
  value: true,
  label: 'Bold',
  onChanged: (bool value) {},
)''',
    previewBuilder: _buildToggleDemo,
  ),
  DemoDefinition(
    componentType: 'toggle-group',
    symbolName: 'ArcaneToggleGroup',
    sourcePath: 'lib/component/input/toggle_group.dart',
    code: '''ArcaneToggleGroup(
  value: 'left',
  items: [
    ToggleGroupItem.text('left', label: 'Left'),
    ToggleGroupItem.text('center', label: 'Center'),
  ],
  onChanged: (String? value) {},
)''',
    previewBuilder: _buildToggleGroupDemo,
  ),
  DemoDefinition(
    componentType: 'tooltip',
    symbolName: 'ArcaneTooltip',
    sourcePath: 'lib/component/dialog/tooltip.dart',
    code: '''ArcaneTooltip(
  text: 'This is a tooltip',
  child: Button.secondary(label: 'Hover target', onPressed: () {}),
)''',
    previewBuilder: _buildTooltipDemo,
  ),
  DemoDefinition(
    componentType: 'typography',
    symbolName: 'Text',
    sourcePath: 'lib/component/typography/text.dart',
    code: '''const Text.heading2('Typography Preview')''',
    previewBuilder: _buildTypographyDemo,
  ),
];

Map<String, DemoDefinition> demoRegistry =
    Map<String, DemoDefinition>.unmodifiable(<String, DemoDefinition>{
      for (DemoDefinition demo in demoDefinitions) demo.componentType: demo,
    });

Widget _buildAccordionDemo() {
  return _surface(
    ArcaneAccordion(
      items: const [
        ArcaneAccordionItem(
          title: 'What is Arcane Jaspr?',
          content: 'A Flutter-like DX for Jaspr with semantic HTML output.',
          defaultOpen: true,
        ),
        ArcaneAccordionItem(
          title: 'Can I swap themes quickly?',
          content: 'Yes. Switch between Shadcn and Codex with one stylesheet.',
        ),
      ],
    ),
  );
}

Widget _buildAlertDemo() {
  return _surface(
    const ArcaneAlert.info(
      title: 'Heads up',
      message: 'This is a live alert preview rendered by the current theme.',
    ),
  );
}

Widget _buildAlertDialogDemo() {
  return _surface(
    const ArcaneAlertDialog(
      title: 'Delete Project?',
      message: 'This action cannot be undone.',
      buttonText: 'Understood',
    ),
  );
}

Widget _buildAspectRatioDemo() {
  return _surface(
    ArcaneAspectRatio.video(
      child: const Card(child: Text('16:9 container')),
    ),
  );
}

Widget _buildAvatarDemo() {
  return _surface(
    ArcaneAvatarGroup.toRight(
      avatars: const [
        ArcaneAvatar(initials: 'AB'),
        ArcaneAvatar(initials: 'CD'),
        ArcaneAvatar(initials: 'EF'),
      ],
    ),
  );
}

Widget _buildBadgeDemo() {
  return _surface(const ArcaneStatusBadge.success('Online'));
}

Widget _buildBreadcrumbDemo() {
  return _surface(
    ArcaneBreadcrumbs(
      items: const [
        BreadcrumbItem(label: 'Docs', href: '/docs'),
        BreadcrumbItem(label: 'Components', href: '/docs/components-catalog'),
        BreadcrumbItem(label: 'Button'),
      ],
      separator: BreadcrumbSeparator.chevron,
    ),
  );
}

Widget _buildButtonDemo() {
  return _surface(
    Button.primary(label: 'Primary Action', onPressed: () {}),
  );
}

Widget _buildButtonGroupDemo() {
  return _surface(
    ButtonGroup(
      children: [
        Button.secondary(label: 'Back', onPressed: () {}),
        Button.primary(label: 'Continue', onPressed: () {}),
      ],
    ),
  );
}

Widget _buildCalendarDemo() {
  return _surface(
    ArcaneCalendar(selected: DateTime.now(), onSelect: (DateTime date) {}),
  );
}

Widget _buildCardDemo() {
  return _surface(const Card.elevated(child: Text('Card content')));
}

Widget _buildCarouselDemo() {
  return _surface(
    CardCarousel(
      gap: 12,
      children: const [
        Card(child: Text('Slide 1')),
        Card(child: Text('Slide 2')),
        Card(child: Text('Slide 3')),
      ],
    ),
  );
}

Widget _buildChartDemo() {
  return _surface(
    ArcaneChart(
      title: 'Revenue',
      points: const [
        ArcaneChartPoint(label: 'Jan', value: 12),
        ArcaneChartPoint(label: 'Feb', value: 18),
        ArcaneChartPoint(label: 'Mar', value: 16),
        ArcaneChartPoint(label: 'Apr', value: 24),
      ],
    ),
  );
}

Widget _buildCheckboxDemo() {
  return _surface(
    ArcaneCheckbox(
      checked: true,
      label: 'Enable notifications',
      onChanged: (bool value) {},
    ),
  );
}

Widget _buildCollapsibleDemo() {
  return _surface(
    const ArcaneDisclosure(
      summary: Text('Toggle content'),
      child: Text('This disclosure is rendered by the active theme.'),
      open: true,
    ),
  );
}

Widget _buildComboboxDemo() {
  return _surface(
    ArcaneCombobox(
      value: 'jaspr',
      options: const [
        ComboboxOption(value: 'jaspr', label: 'Jaspr'),
        ComboboxOption(value: 'flutter', label: 'Flutter'),
        ComboboxOption(value: 'react', label: 'React'),
      ],
      onChanged: (String? value) {},
      label: 'Framework',
    ),
  );
}

Widget _buildCommandDemo() {
  return _surface(
    ArcaneCommand(
      isOpen: true,
      groups: const [
        CommandGroup(
          heading: 'Navigation',
          items: [
            CommandItem(label: 'Go to Dashboard'),
            CommandItem(label: 'Open Settings', shortcut: '⌘,'),
          ],
        ),
      ],
    ),
    minHeight: '220px',
  );
}

Widget _buildContextMenuDemo() {
  return _surface(
    ArcaneContextMenu(
      trigger: Button.secondary(
        label: 'Right-click me',
        onPressed: () {},
      ),
      items: const [
        MenuItemAction(label: 'Copy'),
        MenuItemAction(label: 'Rename'),
        MenuItemSeparator(),
        MenuItemCheckbox(label: 'Pinned', checked: true),
      ],
    ),
  );
}

Widget _buildDataTableDemo() {
  return _surface(
    DataTable(
      items: const [
        _DemoUser(name: 'Alex', role: 'Admin', status: 'Active'),
        _DemoUser(name: 'Sam', role: 'Editor', status: 'Pending'),
        _DemoUser(name: 'Rae', role: 'Viewer', status: 'Active'),
      ],
      columns: [
        DataColumn(
          header: 'Name',
          builder: (_DemoUser user) => Text(user.name),
        ),
        DataColumn(
          header: 'Role',
          builder: (_DemoUser user) => Text(user.role),
        ),
        DataColumn(
          header: 'Status',
          builder: (_DemoUser user) => Text(user.status),
        ),
      ],
    ),
    minHeight: '220px',
  );
}

Widget _buildDatePickerDemo() {
  return _surface(
    ArcaneDatePicker(
      value: DateTime.now(),
      label: 'Start date',
      onChanged: (DateTime? value) {},
    ),
  );
}

Widget _buildDialogDemo() {
  return _surface(
    ArcaneDialog(
      title: 'Confirm Settings',
      child: const Text('Apply changes to your current workspace?'),
      actions: [
        Button.secondary(label: 'Cancel', onPressed: () {}),
        Button.primary(label: 'Apply', onPressed: () {}),
      ],
    ),
    minHeight: '220px',
  );
}

Widget _buildDirectionDemo() {
  return _surface(
    const ArcaneDirection(
      value: ArcaneDirectionValue.rtl,
      children: [Text('Right-to-left direction preview')],
    ),
  );
}

Widget _buildDrawerDemo() {
  return _surface(
    ArcaneDrawer.left(
      isOpen: true,
      showBackdrop: false,
      closeOnBackdropClick: false,
      header: const Text('Navigation'),
      child: const Text('Drawer content'),
    ),
    minHeight: '220px',
  );
}

Widget _buildDropdownMenuDemo() {
  return _surface(
    ArcaneDropdownMenu(
      trigger: Button.secondary(label: 'Open menu', onPressed: () {}),
      items: const [
        MenuItemAction(label: 'Profile'),
        MenuItemAction(label: 'Billing'),
        MenuItemSeparator(),
        MenuItemAction(label: 'Sign out', destructive: true),
      ],
    ),
  );
}

Widget _buildEmptyDemo() {
  return _surface(ArcaneEmptyState.noResults());
}

Widget _buildFieldDemo() {
  return _surface(
    ArcaneFieldWrapper(
      labelText: 'Email',
      description: 'We only use this for account notices.',
      field: TextInput(
        placeholder: 'name@company.com',
        onChange: (String value) {},
      ),
    ),
  );
}

Widget _buildHoverCardDemo() {
  return _surface(
    ArcaneHoverCard.hovercard(
      trigger: Button.secondary(label: 'Hover card', onPressed: () {}),
      content: const Card(
        child: Text('A lightweight profile or preview card.'),
      ),
      isOpen: true,
    ),
    minHeight: '180px',
  );
}

Widget _buildInputDemo() {
  return _surface(
    TextInput(
      label: 'Email',
      placeholder: 'name@example.com',
      onChange: (String value) {},
    ),
  );
}

Widget _buildInputGroupDemo() {
  return _surface(
    ArcaneInputGroup(
      children: [
        TextInput(placeholder: 'Search', onChange: (String value) {}),
        Button.primary(label: 'Go', onPressed: () {}),
      ],
    ),
  );
}

Widget _buildInputOtpDemo() {
  return _surface(
    ArcaneOtpInput.sixDigit(value: '123456', onChange: (String value) {}),
  );
}

Widget _buildItemDemo() {
  return _surface(
    const ArcaneItem(child: Text('Clickable item row'), href: '/docs'),
  );
}

Widget _buildKbdDemo() {
  return _surface(const ArcaneKbd.combo(['Cmd', 'K']));
}

Widget _buildMenubarDemo() {
  return _surface(
    ArcaneMenubar(
      menus: const [
        ArcaneMenubarMenu(
          label: 'File',
          items: [
            MenuItemAction(label: 'New'),
            MenuItemAction(label: 'Open'),
            MenuItemSeparator(),
            MenuItemAction(label: 'Exit'),
          ],
        ),
        ArcaneMenubarMenu(
          label: 'Edit',
          items: [
            MenuItemAction(label: 'Undo'),
            MenuItemAction(label: 'Redo'),
          ],
        ),
      ],
    ),
  );
}

Widget _buildNavigationMenuDemo() {
  return _surface(
    ArcaneNavDropdown(
      label: 'Products',
      width: '280px',
      content: const ArcaneBox(
        style: ArcaneStyleData(
          padding: PaddingPreset.md,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.sm,
        ),
        children: [
          Text('Core UI'),
          Text('Documentation'),
          Text('Templates'),
        ],
      ),
    ),
  );
}

Widget _buildPaginationDemo() {
  return _surface(
    ArcanePagination(
      currentPage: 2,
      totalPages: 8,
      onPageChange: (int page) {},
    ),
  );
}

Widget _buildPopoverDemo() {
  return _surface(
    ArcanePopover(
      isOpen: true,
      trigger: Button.secondary(label: 'Open popover', onPressed: () {}),
      content: const Card(child: Text('Popover content')),
    ),
    minHeight: '180px',
  );
}

Widget _buildProgressDemo() {
  return _surface(const ArcaneProgressBar(value: 68, showValue: true));
}

Widget _buildRadioGroupDemo() {
  return _surface(
    ArcaneRadioGroup(
      value: 'starter',
      options: const [
        RadioOption(value: 'starter', label: 'Starter'),
        RadioOption(value: 'pro', label: 'Pro'),
        RadioOption(value: 'enterprise', label: 'Enterprise'),
      ],
      onChanged: (String value) {},
    ),
  );
}

Widget _buildResizableDemo() {
  return _surface(
    ArcaneResizable.sidebarLayout(
      sidebar: const Card(child: Text('Sidebar')),
      content: const Card(child: Text('Main content')),
    ),
    minHeight: '220px',
  );
}

Widget _buildScrollAreaDemo() {
  return _surface(
    ArcaneScrollArea.vertical(
      height: '150px',
      child: ArcaneBox(
        style: const ArcaneStyleData(
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.sm,
        ),
        children: const [
          Text('Row 1'),
          Text('Row 2'),
          Text('Row 3'),
          Text('Row 4'),
          Text('Row 5'),
          Text('Row 6'),
          Text('Row 7'),
        ],
      ),
    ),
  );
}

Widget _buildSelectDemo() {
  return _surface(
    ArcaneSelect(
      label: 'Plan',
      value: 'pro',
      options: const [
        ArcaneSelectOption(label: 'Starter', value: 'starter'),
        ArcaneSelectOption(label: 'Pro', value: 'pro'),
        ArcaneSelectOption(label: 'Enterprise', value: 'enterprise'),
      ],
      onChange: (String value) {},
    ),
  );
}

Widget _buildSeparatorDemo() {
  return _surface(const ArcaneSeparator.withLabel(label: 'OR'));
}

Widget _buildSheetDemo() {
  return _surface(
    ArcaneSheet.bottom(
      isOpen: true,
      showBackdrop: false,
      showCloseButton: false,
      child: const Text('Sheet content'),
    ),
    minHeight: '220px',
  );
}

Widget _buildSidebarDemo() {
  return _surface(
    ArcaneSidebar(
      width: 240,
      showCollapseToggle: false,
      header: const Text('Workspace'),
      footer: const Text('v2.9'),
      children: const [
        ArcaneSidebarItem(label: 'Dashboard', selected: true),
        ArcaneSidebarItem(label: 'Projects'),
        ArcaneSidebarItem(label: 'Settings'),
      ],
    ),
    minHeight: '260px',
  );
}

Widget _buildSkeletonDemo() {
  return _surface(const ArcaneSkeletonCard());
}

Widget _buildSliderDemo() {
  return _surface(
    ArcaneSlider(label: 'Volume', value: 42, onChanged: (double value) {}),
  );
}

Widget _buildSonnerDemo() {
  return _surface(
    ArcaneBox(
      style: const ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        gap: Gap.sm,
      ),
      children: [
        const ArcaneSonner(position: ToastPosition.topRight),
        Button.secondary(
          label: 'Show toast',
          onPressed: () {
            ArcaneSonner.success(
              'Sonner-compatible toast stack',
              title: 'Notification',
            );
          },
        ),
      ],
    ),
    minHeight: '180px',
  );
}

Widget _buildSpinnerDemo() {
  return _surface(const ArcaneSpinner());
}

Widget _buildSwitchDemo() {
  return _surface(
    ArcaneToggleSwitch(
      value: true,
      label: 'Enable sync',
      onChanged: (bool value) {},
    ),
  );
}

Widget _buildTableDemo() {
  return _surface(
    StaticTable(
      headers: const ['Name', 'Role'],
      rows: const [
        [Text('Alex'), Text('Admin')],
        [Text('Sam'), Text('Editor')],
        [Text('Rae'), Text('Viewer')],
      ],
    ),
    minHeight: '220px',
  );
}

Widget _buildTabsDemo() {
  return _surface(
    ArcaneTabs(
      tabs: const [
        ArcaneTabItem(
          label: 'Account',
          content: Text('Account tab content'),
        ),
        ArcaneTabItem(
          label: 'Billing',
          content: Text('Billing tab content'),
        ),
      ],
    ),
  );
}

Widget _buildTextareaDemo() {
  return _surface(
    TextArea(
      label: 'Message',
      placeholder: 'Type your message',
      rows: 4,
      onChange: (String value) {},
    ),
  );
}

Widget _buildToggleDemo() {
  return _surface(
    ArcaneToggleButton(value: true, label: 'Bold', onChanged: (bool value) {}),
  );
}

Widget _buildToggleGroupDemo() {
  return _surface(
    ArcaneToggleGroup(
      value: 'left',
      items: [
        ToggleGroupItem.text('left', label: 'Left'),
        ToggleGroupItem.text('center', label: 'Center'),
        ToggleGroupItem.text('right', label: 'Right'),
      ],
      onChanged: (String? value) {},
    ),
  );
}

Widget _buildTooltipDemo() {
  return _surface(
    ArcaneTooltip(
      text: 'This is a tooltip',
      child: Button.secondary(label: 'Hover target', onPressed: () {}),
    ),
  );
}

Widget _buildTypographyDemo() {
  return _surface(
    ArcaneBox(
      style: const ArcaneStyleData(
        display: Display.flex,
        flexDirection: FlexDirection.column,
        gap: Gap.sm,
      ),
      children: [
        const Text.heading2('Typography Preview'),
        const Text.body('Readable hierarchy and spacing.'),
      ],
    ),
  );
}

Widget _surface(Widget child, {String minHeight = '140px'}) {
  return ArcaneBox(
    style: ArcaneStyleData(
      padding: PaddingPreset.lg,
      border: BorderPreset.subtle,
      borderRadius: Radius.lg,
      background: Background.backgroundSecondary,
      minHeight: minHeight,
      display: Display.flex,
      alignItems: AlignItems.center,
      justifyContent: JustifyContent.center,
    ),
    children: [child],
  );
}

class _DemoUser {
  final String name;
  final String role;
  final String status;

  const _DemoUser({
    required this.name,
    required this.role,
    required this.status,
  });
}
