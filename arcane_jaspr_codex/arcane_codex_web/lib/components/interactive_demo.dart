import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/component/view/empty_state.dart'
    show ArcaneEmptyState;

// Renderer stylesheet for client-side hydration
const ArcaneStylesheet _clientStylesheet = ShadcnStylesheet();

/// Client-hydrated wrapper for interactive demos
/// Only primitive parameters are allowed for @client components
@client
class InteractiveDemo extends StatefulComponent {
  final String componentType;

  const InteractiveDemo({required this.componentType, super.key});

  @override
  State<InteractiveDemo> createState() => _InteractiveDemoState();
}

class _InteractiveDemoState extends State<InteractiveDemo> {
  bool _isDark = true;

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }

  Component _buildPreview(String componentType) {
    switch (componentType) {
      case 'accordion':
        return _withSurface(
          ArcaneAccordion(
            items: const <ArcaneAccordionItem>[
              ArcaneAccordionItem(
                title: 'What is Arcane Jaspr?',
                content:
                    'A Flutter-like DX for Jaspr with semantic HTML output.',
                defaultOpen: true,
              ),
              ArcaneAccordionItem(
                title: 'Can I swap themes quickly?',
                content:
                    'Yes. Switch between Shadcn and Codex with one stylesheet.',
              ),
            ],
          ),
        );
      case 'alert':
        return _withSurface(
          const ArcaneAlert.info(
            title: 'Heads up',
            message:
                'This is a live alert preview rendered by the current theme.',
          ),
        );
      case 'alert-dialog':
        return _withSurface(
          const ArcaneAlertDialog(
            title: 'Delete Project?',
            message: 'This action cannot be undone.',
            buttonText: 'Understood',
          ),
        );
      case 'aspect-ratio':
        return _withSurface(
          ArcaneAspectRatio.video(
            child: const ArcaneCard(child: ArcaneText('16:9 container')),
          ),
        );
      case 'avatar':
        return _withSurface(
          ArcaneAvatarGroup.toRight(
            avatars: const <ArcaneAvatar>[
              ArcaneAvatar(initials: 'AB'),
              ArcaneAvatar(initials: 'CD'),
              ArcaneAvatar(initials: 'EF'),
            ],
          ),
        );
      case 'badge':
        return _withSurface(const ArcaneStatusBadge.success('Online'));
      case 'breadcrumb':
        return _withSurface(
          ArcaneBreadcrumbs(
            items: const <BreadcrumbItem>[
              BreadcrumbItem(label: 'Docs', href: '/docs'),
              BreadcrumbItem(
                label: 'Components',
                href: '/docs/components-catalog',
              ),
              BreadcrumbItem(label: 'Button'),
            ],
            separator: BreadcrumbSeparator.chevron,
          ),
        );
      case 'button':
        return _withSurface(
          ArcaneButton.primary(label: 'Primary Action', onPressed: () {}),
        );
      case 'button-group':
        return _withSurface(
          ArcaneButtonGroup(
            children: <Component>[
              ArcaneButton.secondary(label: 'Back', onPressed: () {}),
              ArcaneButton.primary(label: 'Continue', onPressed: () {}),
            ],
          ),
        );
      case 'calendar':
        return _withSurface(
          ArcaneCalendar(
            selected: DateTime.now(),
            onSelect: (DateTime date) {},
          ),
        );
      case 'card':
        return _withSurface(
          const ArcaneCard.elevated(child: ArcaneText('Card content')),
        );
      case 'carousel':
        return _withSurface(
          ArcaneCardCarousel(
            gap: 12,
            children: const <Component>[
              ArcaneCard(child: ArcaneText('Slide 1')),
              ArcaneCard(child: ArcaneText('Slide 2')),
              ArcaneCard(child: ArcaneText('Slide 3')),
            ],
          ),
        );
      case 'chart':
        return _withSurface(
          ArcaneChart(
            title: 'Revenue',
            points: const <ArcaneChartPoint>[
              ArcaneChartPoint(label: 'Jan', value: 12),
              ArcaneChartPoint(label: 'Feb', value: 18),
              ArcaneChartPoint(label: 'Mar', value: 16),
              ArcaneChartPoint(label: 'Apr', value: 24),
            ],
          ),
        );
      case 'checkbox':
        return _withSurface(
          ArcaneCheckbox(
            checked: true,
            label: 'Enable notifications',
            onChanged: (bool value) {},
          ),
        );
      case 'collapsible':
        return _withSurface(
          const ArcaneDisclosure(
            summary: ArcaneText('Toggle content'),
            child: ArcaneText(
              'This disclosure is rendered by the active theme.',
            ),
            open: true,
          ),
        );
      case 'combobox':
        return _withSurface(
          ArcaneCombobox<String>(
            value: 'jaspr',
            options: const <ComboboxOption<String>>[
              ComboboxOption<String>(value: 'jaspr', label: 'Jaspr'),
              ComboboxOption<String>(value: 'flutter', label: 'Flutter'),
              ComboboxOption<String>(value: 'react', label: 'React'),
            ],
            onChanged: (String? value) {},
            label: 'Framework',
          ),
        );
      case 'command':
        return _withSurface(
          ArcaneCommand(
            isOpen: true,
            groups: const <CommandGroup>[
              CommandGroup(
                heading: 'Navigation',
                items: <CommandItem>[
                  CommandItem(label: 'Go to Dashboard'),
                  CommandItem(label: 'Open Settings', shortcut: '⌘,'),
                ],
              ),
            ],
          ),
          minHeight: '220px',
        );
      case 'context-menu':
        return _withSurface(
          ArcaneContextMenu(
            trigger: ArcaneButton.secondary(
              label: 'Right-click me',
              onPressed: () {},
            ),
            items: const <ArcaneMenuItem>[
              MenuItemAction(label: 'Copy'),
              MenuItemAction(label: 'Rename'),
              MenuItemSeparator(),
              MenuItemCheckbox(label: 'Pinned', checked: true),
            ],
          ),
        );
      case 'data-table':
        return _withSurface(
          ArcaneDataTable<_DemoUser>(
            items: const <_DemoUser>[
              _DemoUser(name: 'Alex', role: 'Admin', status: 'Active'),
              _DemoUser(name: 'Sam', role: 'Editor', status: 'Pending'),
              _DemoUser(name: 'Rae', role: 'Viewer', status: 'Active'),
            ],
            columns: <ArcaneDataColumn<_DemoUser>>[
              ArcaneDataColumn<_DemoUser>(
                header: 'Name',
                builder: (_DemoUser user) => ArcaneText(user.name),
              ),
              ArcaneDataColumn<_DemoUser>(
                header: 'Role',
                builder: (_DemoUser user) => ArcaneText(user.role),
              ),
              ArcaneDataColumn<_DemoUser>(
                header: 'Status',
                builder: (_DemoUser user) => ArcaneText(user.status),
              ),
            ],
          ),
          minHeight: '220px',
        );
      case 'date-picker':
        return _withSurface(
          ArcaneDatePicker(
            value: DateTime.now(),
            label: 'Start date',
            onChanged: (DateTime? value) {},
          ),
        );
      case 'dialog':
        return _withSurface(
          ArcaneDialog(
            title: 'Confirm Settings',
            child: const ArcaneText('Apply changes to your current workspace?'),
            actions: <Component>[
              ArcaneButton.secondary(label: 'Cancel', onPressed: () {}),
              ArcaneButton.primary(label: 'Apply', onPressed: () {}),
            ],
          ),
          minHeight: '220px',
        );
      case 'direction':
        return _withSurface(
          const ArcaneDirection(
            value: ArcaneDirectionValue.rtl,
            children: <Component>[
              ArcaneText('Right-to-left direction preview'),
            ],
          ),
        );
      case 'drawer':
        return _withSurface(
          ArcaneDrawer.left(
            isOpen: true,
            showBackdrop: false,
            closeOnBackdropClick: false,
            header: const ArcaneText('Navigation'),
            child: const ArcaneText('Drawer content'),
          ),
          minHeight: '220px',
        );
      case 'dropdown-menu':
        return _withSurface(
          ArcaneDropdownMenu(
            trigger: ArcaneButton.secondary(
              label: 'Open menu',
              onPressed: () {},
            ),
            items: const <ArcaneMenuItem>[
              MenuItemAction(label: 'Profile'),
              MenuItemAction(label: 'Billing'),
              MenuItemSeparator(),
              MenuItemAction(label: 'Sign out', destructive: true),
            ],
          ),
        );
      case 'empty':
        return _withSurface(const ArcaneEmptyState.noResults());
      case 'field':
        return _withSurface(
          ArcaneFieldWrapper(
            labelText: 'Email',
            description: 'We only use this for account notices.',
            field: ArcaneTextInput(
              placeholder: 'name@company.com',
              onChange: (String value) {},
            ),
          ),
        );
      case 'hover-card':
        return _withSurface(
          ArcaneFloating.hovercard(
            trigger: ArcaneButton.secondary(
              label: 'Hover card',
              onPressed: () {},
            ),
            content: const ArcaneCard(
              child: ArcaneText('A lightweight profile or preview card.'),
            ),
            isOpen: true,
          ),
          minHeight: '180px',
        );
      case 'input':
        return _withSurface(
          ArcaneTextInput(
            label: 'Email',
            placeholder: 'name@example.com',
            onChange: (String value) {},
          ),
        );
      case 'input-group':
        return _withSurface(
          ArcaneInputGroup(
            children: <Component>[
              ArcaneTextInput(
                placeholder: 'Search',
                onChange: (String value) {},
              ),
              ArcaneButton.primary(label: 'Go', onPressed: () {}),
            ],
          ),
        );
      case 'input-otp':
        return _withSurface(
          ArcaneOtpInput.sixDigit(value: '123456', onChange: (String value) {}),
        );
      case 'item':
        return _withSurface(
          const ArcaneItem(
            child: ArcaneText('Clickable item row'),
            href: '/docs',
          ),
        );
      case 'kbd':
        return _withSurface(const ArcaneKbd.combo(<String>['Cmd', 'K']));
      case 'label':
        return _withSurface(
          const ArcaneLabel(
            child: ArcaneText('Email address'),
            htmlFor: 'demo-email',
          ),
        );
      case 'menubar':
        return _withSurface(
          ArcaneMenubar(
            menus: const <ArcaneMenubarMenu>[
              ArcaneMenubarMenu(
                label: 'File',
                items: <ArcaneMenuItem>[
                  MenuItemAction(label: 'New'),
                  MenuItemAction(label: 'Open'),
                  MenuItemSeparator(),
                  MenuItemAction(label: 'Exit'),
                ],
              ),
              ArcaneMenubarMenu(
                label: 'Edit',
                items: <ArcaneMenuItem>[
                  MenuItemAction(label: 'Undo'),
                  MenuItemAction(label: 'Redo'),
                ],
              ),
            ],
          ),
        );
      case 'native-select':
        return _withSurface(
          ArcaneNativeSelect(
            label: 'Framework',
            value: 'jaspr',
            options: const <ArcaneNativeSelectOption>[
              ArcaneNativeSelectOption(label: 'Jaspr', value: 'jaspr'),
              ArcaneNativeSelectOption(label: 'Flutter', value: 'flutter'),
              ArcaneNativeSelectOption(label: 'React', value: 'react'),
            ],
            onChange: (String value) {},
          ),
        );
      case 'navigation-menu':
        return _withSurface(
          ArcaneNavDropdown(
            label: 'Products',
            width: '280px',
            content: const ArcaneDiv(
              styles: ArcaneStyleData(
                padding: PaddingPreset.md,
                display: Display.flex,
                flexDirection: FlexDirection.column,
                gap: Gap.sm,
              ),
              children: <Component>[
                ArcaneText('Core UI'),
                ArcaneText('Documentation'),
                ArcaneText('Templates'),
              ],
            ),
          ),
        );
      case 'pagination':
        return _withSurface(
          ArcanePagination(
            currentPage: 2,
            totalPages: 8,
            onPageChange: (int page) {},
          ),
        );
      case 'popover':
        return _withSurface(
          ArcanePopover(
            isOpen: true,
            trigger: ArcaneButton.secondary(
              label: 'Open popover',
              onPressed: () {},
            ),
            content: const ArcaneCard(child: ArcaneText('Popover content')),
          ),
          minHeight: '180px',
        );
      case 'progress':
        return _withSurface(
          const ArcaneProgressBar(value: 68, showValue: true),
        );
      case 'radio-group':
        return _withSurface(
          ArcaneRadioGroup<String>(
            value: 'starter',
            options: const <RadioOption<String>>[
              RadioOption<String>(value: 'starter', label: 'Starter'),
              RadioOption<String>(value: 'pro', label: 'Pro'),
              RadioOption<String>(value: 'enterprise', label: 'Enterprise'),
            ],
            onChanged: (String value) {},
          ),
        );
      case 'resizable':
        return _withSurface(
          ArcaneResizable.sidebarLayout(
            sidebar: const ArcaneCard(child: ArcaneText('Sidebar')),
            content: const ArcaneCard(child: ArcaneText('Main content')),
          ),
          minHeight: '220px',
        );
      case 'scroll-area':
        return _withSurface(
          ArcaneScrollArea.vertical(
            height: '150px',
            child: ArcaneDiv(
              styles: const ArcaneStyleData(
                display: Display.flex,
                flexDirection: FlexDirection.column,
                gap: Gap.sm,
              ),
              children: const <Component>[
                ArcaneText('Row 1'),
                ArcaneText('Row 2'),
                ArcaneText('Row 3'),
                ArcaneText('Row 4'),
                ArcaneText('Row 5'),
                ArcaneText('Row 6'),
                ArcaneText('Row 7'),
              ],
            ),
          ),
        );
      case 'select':
        return _withSurface(
          ArcaneSelect(
            label: 'Plan',
            value: 'pro',
            options: const <ArcaneSelectOption>[
              ArcaneSelectOption(label: 'Starter', value: 'starter'),
              ArcaneSelectOption(label: 'Pro', value: 'pro'),
              ArcaneSelectOption(label: 'Enterprise', value: 'enterprise'),
            ],
            onChange: (String value) {},
          ),
        );
      case 'separator':
        return _withSurface(const ArcaneSeparator.withLabel(label: 'OR'));
      case 'sheet':
        return _withSurface(
          ArcaneSheet.bottom(
            isOpen: true,
            showBackdrop: false,
            showCloseButton: false,
            child: const ArcaneText('Sheet content'),
          ),
          minHeight: '220px',
        );
      case 'sidebar':
        return _withSurface(
          ArcaneSidebar(
            width: 240,
            showCollapseToggle: false,
            header: const ArcaneText('Workspace'),
            footer: const ArcaneText('v2.9'),
            children: const <Component>[
              ArcaneSidebarItem(label: 'Dashboard', selected: true),
              ArcaneSidebarItem(label: 'Projects'),
              ArcaneSidebarItem(label: 'Settings'),
            ],
          ),
          minHeight: '260px',
        );
      case 'skeleton':
        return _withSurface(const ArcaneSkeletonCard());
      case 'slider':
        return _withSurface(
          ArcaneSlider(
            label: 'Volume',
            value: 42,
            onChanged: (double value) {},
          ),
        );
      case 'sonner':
        return _withSurface(
          ArcaneDiv(
            children: const <Component>[
              ArcaneSonner(position: ToastPosition.topRight),
              ArcaneToast(
                title: 'Notification',
                message: 'Sonner-compatible toast stack',
                duration: 0,
              ),
            ],
          ),
          minHeight: '180px',
        );
      case 'spinner':
        return _withSurface(const ArcaneSpinner());
      case 'switch':
        return _withSurface(
          ArcaneToggleSwitch(
            value: true,
            label: 'Enable sync',
            onChanged: (bool value) {},
          ),
        );
      case 'table':
        return _withSurface(
          ArcaneStaticTable(
            headers: const <String>['Name', 'Role'],
            rows: const <List<Component>>[
              <Component>[ArcaneText('Alex'), ArcaneText('Admin')],
              <Component>[ArcaneText('Sam'), ArcaneText('Editor')],
              <Component>[ArcaneText('Rae'), ArcaneText('Viewer')],
            ],
          ),
          minHeight: '220px',
        );
      case 'tabs':
        return _withSurface(
          ArcaneTabs(
            tabs: const <ArcaneTabItem>[
              ArcaneTabItem(
                label: 'Account',
                content: ArcaneText('Account tab content'),
              ),
              ArcaneTabItem(
                label: 'Billing',
                content: ArcaneText('Billing tab content'),
              ),
            ],
          ),
        );
      case 'textarea':
        return _withSurface(
          ArcaneTextArea(
            label: 'Message',
            placeholder: 'Type your message',
            rows: 4,
            onChange: (String value) {},
          ),
        );
      case 'toast':
        return _withSurface(
          const ArcaneToast(
            title: 'Saved',
            message: 'Your settings have been updated.',
            duration: 0,
          ),
          minHeight: '180px',
        );
      case 'toggle':
        return _withSurface(
          ArcaneToggleButton(
            value: true,
            label: 'Bold',
            onChanged: (bool value) {},
          ),
        );
      case 'toggle-group':
        return _withSurface(
          ArcaneToggleGroup(
            value: 'left',
            items: <ToggleGroupItem>[
              ToggleGroupItem.text('left', label: 'Left'),
              ToggleGroupItem.text('center', label: 'Center'),
              ToggleGroupItem.text('right', label: 'Right'),
            ],
            onChanged: (String? value) {},
          ),
        );
      case 'tooltip':
        return _withSurface(
          ArcaneTooltip(
            text: 'This is a tooltip',
            child: ArcaneButton.secondary(
              label: 'Hover target',
              onPressed: () {},
            ),
          ),
        );
      case 'typography':
        return _withSurface(
          const ArcaneDiv(
            styles: ArcaneStyleData(
              display: Display.flex,
              flexDirection: FlexDirection.column,
              gap: Gap.sm,
            ),
            children: <Component>[
              ArcaneHeadline.h2('Typography Preview'),
              ArcaneSubheadline('Readable hierarchy and spacing.'),
            ],
          ),
        );
      default:
        return _withSurface(
          ArcaneAlert.warning(
            title: 'No Demo Found',
            message: 'No live preview is registered for "$componentType".',
          ),
        );
    }
  }

  Component _withSurface(Component child, {String minHeight = '140px'}) {
    return ArcaneDiv(
      styles: ArcaneStyleData(
        padding: PaddingPreset.lg,
        border: BorderPreset.subtle,
        borderRadius: Radius.lg,
        background: Background.backgroundSecondary,
        minHeight: minHeight,
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
      ),
      children: <Component>[child],
    );
  }

  @override
  Component build(BuildContext context) {
    final Component preview = _buildPreview(component.componentType);

    return ArcaneThemeProvider(
      stylesheet: _clientStylesheet,
      brightness: _isDark ? Brightness.dark : Brightness.light,
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          margin: MarginPreset.bottomXl,
          padding: PaddingPreset.lg,
          borderRadius: Radius.lg,
          background: Background.transparent,
          border: BorderPreset.subtle,
        ),
        children: [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              fontWeight: FontWeight.w600,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.bottomMd,
              textTransform: TextTransform.uppercase,
              letterSpacing: LetterSpacing.wide,
            ),
            children: [ArcaneText('Live Demo')],
          ),
          ArcaneDiv(
            styles: const ArcaneStyleData(
              display: Display.flex,
              alignItems: AlignItems.center,
              gap: Gap.md,
              margin: MarginPreset.bottomMd,
            ),
            children: [
              ArcaneButton.secondary(
                label: _isDark ? 'Switch to Light' : 'Switch to Dark',
                onPressed: _toggleTheme,
              ),
              ArcaneText(
                'Component: ${component.componentType}',
                size: FontSize.sm,
                color: TextColor.mutedForeground,
              ),
            ],
          ),
          preview,
        ],
      ),
    );
  }
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
