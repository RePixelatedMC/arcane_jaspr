import 'package:jaspr/jaspr.dart';

import 'props/alert_props.dart';
import 'props/avatar_props.dart';
import 'props/badge_props.dart';
import 'props/button_props.dart';
import 'props/card_props.dart';
import 'props/checkbox_props.dart';
import 'props/color_input_props.dart';
import 'props/icon_button_props.dart';
import 'props/number_input_props.dart';
import 'props/progress_props.dart';
import 'props/search_props.dart';
import 'props/slider_props.dart';
import 'props/radio_group_props.dart';
import 'props/text_input_props.dart';
import 'props/toggle_switch_props.dart';
import 'props/separator_props.dart';
import 'props/skeleton_props.dart';
import 'props/tabs_props.dart';
import 'props/accordion_props.dart';
import 'props/tooltip_props.dart';
import 'props/popover_props.dart';
import 'props/dropdown_menu_props.dart';
import 'props/dialog_props.dart';
import 'props/drawer_props.dart';
import 'props/toast_props.dart';
import 'props/command_props.dart';
import 'props/data_table_props.dart';
import 'props/sidebar_props.dart';
import 'props/header_props.dart';
import 'props/breadcrumbs_props.dart';
import 'props/pagination_props.dart';
import 'props/select_props.dart';
import 'props/context_menu_props.dart';
import 'props/hovercard_props.dart';
import 'props/toggle_group_props.dart';
import 'props/menubar_props.dart';
import 'props/calendar_props.dart';
import 'props/date_picker_props.dart';
import 'props/loader_props.dart';
import 'props/otp_input_props.dart';
import 'props/tag_input_props.dart';
import 'props/empty_state_props.dart';
import 'props/meter_props.dart';
import 'props/scroll_area_props.dart';
import 'props/fab_props.dart';
import 'props/cycle_button_props.dart';
import 'props/chip_props.dart';
import 'props/kbd_props.dart';
import 'props/theme_toggle_props.dart';

export 'props/alert_props.dart';
export 'props/avatar_props.dart';
export 'props/badge_props.dart';
export 'props/button_props.dart';
export 'props/card_props.dart';
export 'props/checkbox_props.dart';
export 'props/color_input_props.dart';
export 'props/icon_button_props.dart';
export 'props/number_input_props.dart';
export 'props/progress_props.dart';
export 'props/radio_group_props.dart';
export 'props/search_props.dart';
export 'props/slider_props.dart';
export 'props/text_input_props.dart';
export 'props/toggle_switch_props.dart';
export 'props/separator_props.dart';
export 'props/skeleton_props.dart';
export 'props/tabs_props.dart';
export 'props/accordion_props.dart';
export 'props/tooltip_props.dart';
export 'props/popover_props.dart';
export 'props/dropdown_menu_props.dart';
export 'props/dialog_props.dart';
export 'props/drawer_props.dart';
export 'props/toast_props.dart';
export 'props/command_props.dart';
export 'props/data_table_props.dart';
export 'props/sidebar_props.dart';
export 'props/header_props.dart';
export 'props/breadcrumbs_props.dart';
export 'props/pagination_props.dart';
export 'props/select_props.dart';
export 'props/context_menu_props.dart';
export 'props/hovercard_props.dart';
export 'props/toggle_group_props.dart';
export 'props/menubar_props.dart';
export 'props/calendar_props.dart';
export 'props/date_picker_props.dart';
export 'props/loader_props.dart';
export 'props/otp_input_props.dart';
export 'props/tag_input_props.dart';
export 'props/empty_state_props.dart';
export 'props/meter_props.dart';
export 'props/scroll_area_props.dart';
export 'props/fab_props.dart';
export 'props/cycle_button_props.dart';
export 'props/chip_props.dart';
export 'props/kbd_props.dart';
export 'props/theme_toggle_props.dart';

/// Interface that all stylesheets must implement.
///
/// Each method renders a component according to the stylesheet's design language.
/// Stylesheets MUST implement ALL methods - there are no optional components.
///
/// When a design system doesn't have a native concept for a component,
/// the stylesheet must create an appropriate implementation that fits
/// the design language.
abstract class ComponentRenderers {
  const ComponentRenderers();

  // ==========================================================================
  // INPUT COMPONENTS
  // ==========================================================================

  /// Render a button component
  Component button(ButtonProps props);

  /// Render an icon button component
  Component iconButton(IconButtonProps props);

  /// Render a checkbox component
  Component checkbox(CheckboxProps props);

  /// Render a toggle switch component
  Component toggleSwitch(ToggleSwitchProps props);

  /// Render a slider component
  Component slider(SliderProps props);

  /// Render a text input component
  Component textInput(TextInputProps props);

  /// Render a radio group component
  Component radioGroup<T>(RadioGroupProps<T> props);

  /// Render a tag input component
  Component tagInput(TagInputProps props);

  /// Render a number input component
  Component numberInput(NumberInputProps props);

  /// Render a color input component
  Component colorInput(ColorInputProps props);

  /// Render a search input component
  Component search(SearchProps props);

  /// Render a floating action button component
  Component fab(FABProps props);

  /// Render a cycle button component
  Component cycleButton<T>(CycleButtonProps<T> props);

  /// Render a toggle button component
  Component toggleButton(ToggleButtonProps props);

  // ==========================================================================
  // VIEW COMPONENTS
  // ==========================================================================

  /// Render an alert component
  Component alert(AlertProps props);

  /// Render an avatar component
  Component avatar(AvatarProps props);

  /// Render a badge component
  Component badge(BadgeProps props);

  /// Render a card component
  Component card(CardProps props);

  /// Render a progress bar component
  Component progress(ProgressProps props);

  /// Render a separator component
  Component separator(SeparatorProps props);

  /// Render a skeleton component
  Component skeleton(SkeletonProps props);

  /// Render an empty state component
  Component emptyState(EmptyStateProps props);

  /// Render a meter/gauge component
  Component meter(MeterProps props);

  /// Render a scroll area component
  Component scrollArea(ScrollAreaProps props);

  /// Render a virtual scroll component
  Component virtualScroll<T>(VirtualScrollProps<T> props);

  /// Render a chip component
  Component chip(ChipProps props);

  /// Render a chip group component
  Component chipGroup(ChipGroupProps props);

  /// Render a keyboard shortcut display component
  Component kbd(KbdProps props);

  /// Render a theme toggle component
  Component themeToggle(ThemeToggleProps props);

  /// Render a simple theme toggle component
  Component themeToggleSimple(ThemeToggleSimpleProps props);

  // ==========================================================================
  // LAYOUT COMPONENTS
  // ==========================================================================

  /// Render a tabs component (tab bar + content panel)
  Component tabs(TabsProps props);

  /// Render a tab bar component (tabs only, no content)
  Component tabBar(TabBarProps props);

  // ==========================================================================
  // INTERACTIVE COMPONENTS
  // ==========================================================================

  /// Render an accordion component
  Component accordion(AccordionProps props);

  // ==========================================================================
  // FEEDBACK COMPONENTS
  // ==========================================================================

  /// Render a tooltip component
  Component tooltip(TooltipProps props);

  /// Render a popover component
  Component popover(PopoverProps props);

  // ==========================================================================
  // NAVIGATION COMPONENTS
  // ==========================================================================

  /// Render a dropdown menu component
  Component dropdownMenu(DropdownMenuProps props);

  /// Render a sidebar component
  Component sidebar(SidebarProps props);

  /// Render a sidebar item component
  Component sidebarItem(SidebarItemProps props);

  /// Render a sidebar group component
  Component sidebarGroup(SidebarGroupProps props);

  /// Render a header/navbar component
  Component header(HeaderProps props);

  /// Render a standalone nav link component
  Component navLink(NavLinkProps props);

  /// Render a breadcrumbs component
  Component breadcrumbs(BreadcrumbsProps props);

  /// Render a pagination component
  Component pagination(PaginationProps props);

  // ==========================================================================
  // DIALOG COMPONENTS
  // ==========================================================================

  /// Render a dialog component
  Component dialog(DialogProps props);

  /// Render a sheet/drawer component
  Component sheet(SheetProps props);

  /// Render a drawer component
  Component drawer(DrawerProps props);

  // ==========================================================================
  // TOAST COMPONENTS
  // ==========================================================================

  /// Render a toast notification component
  Component toast(ToastProps props);

  /// Render a toast container component
  Component toastContainer(ToastContainerProps props);

  // ==========================================================================
  // COMMAND COMPONENTS
  // ==========================================================================

  /// Render a command palette component
  Component command(CommandProps props);

  // ==========================================================================
  // DATA TABLE COMPONENTS
  // ==========================================================================

  /// Render a data table component
  Component dataTable<T>(DataTableProps<T> props);

  // ==========================================================================
  // SELECT COMPONENTS
  // ==========================================================================

  /// Render a select/selector component
  Component select<T>(SelectProps<T> props);

  // ==========================================================================
  // CONTEXT MENU COMPONENTS
  // ==========================================================================

  /// Render a context menu component
  Component contextMenu(ContextMenuProps props);

  // ==========================================================================
  // HOVERCARD COMPONENTS
  // ==========================================================================

  /// Render a hovercard component
  Component hovercard(HovercardProps props);

  // ==========================================================================
  // TOGGLE GROUP COMPONENTS
  // ==========================================================================

  /// Render a toggle group component
  Component toggleGroup(ToggleGroupProps props);

  // ==========================================================================
  // MENUBAR COMPONENTS
  // ==========================================================================

  /// Render a menubar component
  Component menubar(MenubarProps props);

  // ==========================================================================
  // CALENDAR COMPONENTS
  // ==========================================================================

  /// Render a calendar component
  Component calendar(CalendarProps props);

  // ==========================================================================
  // DATE PICKER COMPONENTS
  // ==========================================================================

  /// Render a date picker component
  Component datePicker(DatePickerProps props);

  // ==========================================================================
  // LOADER COMPONENTS
  // ==========================================================================

  /// Render a loader component
  Component loader(LoaderProps props);

  /// Render a loading overlay component
  Component loadingOverlay(LoadingOverlayProps props);

  // ==========================================================================
  // OTP INPUT COMPONENTS
  // ==========================================================================

  /// Render an OTP input component
  Component otpInput(OtpInputProps props);
}
