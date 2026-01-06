import 'package:jaspr/jaspr.dart';

import '../../../core/renderers.dart';
import 'alert.dart';
import 'avatar.dart';
import 'badge.dart';
import 'button.dart';
import 'calendar.dart';
import 'card.dart';
import 'checkbox.dart';
import 'color_input.dart';
import 'command.dart';
import 'context_menu.dart';
import 'data_table.dart';
import 'date_picker.dart';
import 'dialog.dart';
import 'drawer.dart';
import 'dropdown_menu.dart';
import 'empty_state.dart';
import 'header.dart';
import 'hovercard.dart';
import 'icon_button.dart';
import 'loader.dart';
import 'menubar.dart';
import 'meter.dart';
import 'number_input.dart';
import 'otp_input.dart';
import 'pagination.dart';
import 'popover.dart';
import 'progress.dart';
import 'radio_group.dart';
import 'scroll_area.dart';
import 'search.dart';
import 'select.dart';
import 'separator.dart';
import 'sidebar.dart';
import 'skeleton.dart';
import 'slider.dart';
import 'tabs.dart';
import 'tag_input.dart';
import 'text_input.dart';
import 'toast.dart';
import 'toggle_group.dart';
import 'toggle_switch.dart';
import 'tooltip.dart';
import 'accordion.dart';
import 'breadcrumbs.dart';
import 'fab.dart';
import 'cycle_button.dart';
import 'chip.dart';
import 'kbd.dart';
import 'theme_toggle.dart';

/// ShadCN component renderers.
///
/// Implements all components according to the ShadCN/ui design language.
/// Reference: https://ui.shadcn.com
class ShadcnRenderers extends ComponentRenderers {
  const ShadcnRenderers();

  @override
  Component button(ButtonProps props) => ShadcnButton(props);

  @override
  Component iconButton(IconButtonProps props) => ShadcnIconButton(props);

  @override
  Component checkbox(CheckboxProps props) => ShadcnCheckbox(props);

  @override
  Component toggleSwitch(ToggleSwitchProps props) => ShadcnToggleSwitch(props);

  @override
  Component slider(SliderProps props) => ShadcnSlider(props);

  @override
  Component textInput(TextInputProps props) => ShadcnTextInput(props);

  @override
  Component radioGroup<T>(RadioGroupProps<T> props) => ShadcnRadioGroup<T>(props);

  @override
  Component tagInput(TagInputProps props) => ShadcnTagInput(props);

  @override
  Component numberInput(NumberInputProps props) => ShadcnNumberInput(props);

  @override
  Component colorInput(ColorInputProps props) => ShadcnColorInput(props);

  @override
  Component search(SearchProps props) => ShadcnSearch(props);

  @override
  Component fab(FABProps props) => ShadcnFAB(props);

  @override
  Component cycleButton<T>(CycleButtonProps<T> props) => ShadcnCycleButton<T>(props);

  @override
  Component toggleButton(ToggleButtonProps props) => ShadcnToggleButton(props);

  @override
  Component alert(AlertProps props) => ShadcnAlert(props);

  @override
  Component avatar(AvatarProps props) => ShadcnAvatar(props);

  @override
  Component badge(BadgeProps props) => ShadcnBadge(props);

  @override
  Component card(CardProps props) => ShadcnCard(props);

  @override
  Component progress(ProgressProps props) => ShadcnProgress(props);

  @override
  Component separator(SeparatorProps props) => ShadcnSeparator(props);

  @override
  Component skeleton(SkeletonProps props) => ShadcnSkeleton(props);

  @override
  Component emptyState(EmptyStateProps props) => ShadcnEmptyState(props);

  @override
  Component meter(MeterProps props) => ShadcnMeter(props);

  @override
  Component scrollArea(ScrollAreaProps props) => ShadcnScrollArea(props);

  @override
  Component virtualScroll<T>(VirtualScrollProps<T> props) => ShadcnVirtualScroll<T>(props);

  @override
  Component chip(ChipProps props) => ShadcnChip(props);

  @override
  Component chipGroup(ChipGroupProps props) => ShadcnChipGroup(props);

  @override
  Component kbd(KbdProps props) => ShadcnKbd(props);

  @override
  Component themeToggle(ThemeToggleProps props) => ShadcnThemeToggle(props);

  @override
  Component themeToggleSimple(ThemeToggleSimpleProps props) => ShadcnThemeToggleSimple(props);

  @override
  Component tabs(TabsProps props) => ShadcnTabs(props);

  @override
  Component tabBar(TabBarProps props) => ShadcnTabBar(props);

  @override
  Component accordion(AccordionProps props) => ShadcnAccordion(props);

  @override
  Component tooltip(TooltipProps props) => ShadcnTooltip(props);

  @override
  Component popover(PopoverProps props) => ShadcnPopover(props);

  @override
  Component dropdownMenu(DropdownMenuProps props) => ShadcnDropdownMenu(props);

  @override
  Component dialog(DialogProps props) => ShadcnDialog(props);

  @override
  Component sheet(SheetProps props) => ShadcnSheet(props);

  @override
  Component drawer(DrawerProps props) => ShadcnDrawer(props);

  @override
  Component toast(ToastProps props) => ShadcnToast(props);

  @override
  Component toastContainer(ToastContainerProps props) => ShadcnToastContainer(props);

  @override
  Component command(CommandProps props) => ShadcnCommand(props);

  @override
  Component dataTable<T>(DataTableProps<T> props) => ShadcnDataTable<T>(props);

  @override
  Component sidebar(SidebarProps props) => ShadcnSidebar(props);

  @override
  Component sidebarItem(SidebarItemProps props) => ShadcnSidebarItem(props);

  @override
  Component sidebarGroup(SidebarGroupProps props) => ShadcnSidebarGroup(props);

  @override
  Component header(HeaderProps props) => ShadcnHeader(props);

  @override
  Component navLink(NavLinkProps props) => ShadcnNavLink(props);

  @override
  Component breadcrumbs(BreadcrumbsProps props) => ShadcnBreadcrumbs(props);

  @override
  Component pagination(PaginationProps props) => ShadcnPagination(props);

  @override
  Component select<T>(SelectProps<T> props) => ShadcnSelect<T>(props);

  @override
  Component contextMenu(ContextMenuProps props) => ShadcnContextMenu(props);

  @override
  Component hovercard(HovercardProps props) => ShadcnHovercard(props);

  @override
  Component toggleGroup(ToggleGroupProps props) => ShadcnToggleGroup(props);

  @override
  Component menubar(MenubarProps props) => ShadcnMenubar(props);

  @override
  Component calendar(CalendarProps props) => ShadcnCalendar(props);

  @override
  Component datePicker(DatePickerProps props) => ShadcnDatePicker(props);

  @override
  Component loader(LoaderProps props) => ShadcnLoader(props);

  @override
  Component loadingOverlay(LoadingOverlayProps props) => ShadcnLoadingOverlay(props);

  @override
  Component otpInput(OtpInputProps props) => ShadcnOtpInput(props);
}
