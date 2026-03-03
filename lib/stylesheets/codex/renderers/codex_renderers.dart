import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';

// Codex-specific renderer imports
import 'accordion.dart';
import 'alert.dart';
import 'aspect_ratio.dart';
import 'avatar.dart';
import 'breadcrumbs.dart';
import 'button.dart';
import 'button_panel.dart';
import 'calendar.dart';
import 'card.dart';
import 'chart.dart';
import 'check_list.dart';
import 'checkbox.dart';
import 'command.dart';
import 'confirm_dialog.dart';
import 'context_menu.dart';
import 'cycle_button.dart';
import 'data_table.dart';
import 'date_picker.dart';
import 'direction.dart';
import 'dialog.dart';
import 'disclosure.dart';
import 'dropdown_menu.dart';
import 'drawer.dart';
import 'empty_state.dart';
import 'fade_edge.dart';
import 'field_wrapper.dart';
import 'flexi_cards.dart';
import 'floating.dart';
import 'flow.dart';
import 'form.dart';
import 'gutter.dart';
import 'item.dart';
import 'kbd.dart';
import 'menubar.dart';
import 'native_select.dart';
import 'otp_input.dart';
import 'pagination.dart';
import 'progress.dart';
import 'radio_group.dart';
import 'resizable.dart';
import 'scroll_area.dart';
import 'scroll_rail.dart';
import 'select.dart';
import 'separator.dart';
import 'sidebar.dart';
import 'slider.dart';
import 'slot_counter.dart';
import 'spec_row.dart';
import 'static_table.dart';
import 'status_badge.dart';
import 'tabs.dart';
import 'text_input.dart';
import 'time_picker.dart';
import 'toast.dart';
import 'toggle_group.dart';
import 'toggle_switch.dart';
import 'skeleton.dart';
import 'promo/promo.dart';

/// Codex component renderers.
///
/// Implements all components according to the Codex design language:
/// - OLED-first dark mode with pure black backgrounds
/// - Restrained accent emphasis
/// - 1.25x spacing compared to ShadCN
/// - Larger border radius (14px default)
/// - Premium dark, high-contrast aesthetic
class CodexRenderers extends ComponentRenderers {
  const CodexRenderers();

  @override
  Component button(ButtonProps props) => CodexButton(props);

  @override
  Component textInput(TextInputProps props) => CodexTextInput(props);

  @override
  Component card(CardProps props) => CodexCard(props);

  @override
  Component chart(ChartProps props) => CodexChart(props);

  @override
  Component alert(AlertProps props) => CodexAlert(props);

  @override
  Component avatar(AvatarProps props) => CodexAvatar(props);

  @override
  Component progress(ProgressProps props) => CodexProgress(props);

  @override
  Component circularProgress(CircularProgressProps props) =>
      CodexCircularProgress(props);

  @override
  Component loadingSpinner(LoadingSpinnerProps props) =>
      CodexLoadingSpinner(props);

  @override
  Component skeleton(SkeletonProps props) => CodexSkeleton(props);

  @override
  Component checkbox(CheckboxProps props) => CodexCheckbox(props);

  @override
  Component toggleSwitch(ToggleSwitchProps props) => CodexToggleSwitch(props);

  @override
  Component slider(SliderProps props) => CodexSlider(props);

  @override
  Component tabs(TabsProps props) => CodexTabs(props);

  @override
  Component tabBar(TabBarProps props) => CodexTabBar(props);

  @override
  Component breadcrumbs(BreadcrumbsProps props) => CodexBreadcrumbs(props);

  @override
  Component sidebar(SidebarProps props) => CodexSidebar(props);

  @override
  Component sidebarItem(SidebarItemProps props) => CodexSidebarItem(props);

  @override
  Component sidebarGroup(SidebarGroupProps props) => CodexSidebarGroup(props);

  @override
  Component sidebarSubMenu(SidebarSubMenuProps props) =>
      CodexSidebarSubMenu(props);

  @override
  Component sidebarSection(SidebarSectionProps props) =>
      CodexSidebarSection(props);

  @override
  Component sidebarExpanded(List<Component> children) =>
      dom.div(classes: 'arcane-sidebar-expanded-only', children);

  @override
  Component sidebarCollapsed(List<Component> children) =>
      dom.div(classes: 'arcane-sidebar-collapsed-only', children);

  @override
  Component sidebarSeparator() => const CodexSidebarSeparator();

  @override
  Component dialog(DialogProps props) => CodexDialog(props);

  @override
  Component sheet(SheetProps props) => CodexSheet(props);

  @override
  Component drawer(DrawerProps props) => CodexDrawer(props);

  @override
  Component toast(ToastProps props) => CodexToast(props);

  @override
  Component toastContainer(ToastContainerProps props) =>
      CodexToastContainer(props);

  @override
  Component floating(FloatingProps props) => CodexFloating(props);

  @override
  Component radioGroup<T>(RadioGroupProps<T> props) =>
      CodexRadioGroup<T>(props);

  @override
  Component select<T>(SelectProps<T> props) => CodexSelect<T>(props);

  @override
  Component separator(SeparatorProps props) => CodexSeparator(props);

  @override
  Component accordion(AccordionProps props) => CodexAccordion(props);

  @override
  Component pagination(PaginationProps props) => CodexPagination(props);

  @override
  Component emptyState(EmptyStateProps props) => CodexEmptyState(props);

  @override
  Component statusBadge(StatusBadgeProps props) => CodexStatusBadge(props);

  @override
  Component row(RowProps props) => CodexRow(props);

  @override
  Component column(ColumnProps props) => CodexColumn(props);

  @override
  Component center(CenterProps props) => CodexCenter(props);

  @override
  Component spacer(SpacerProps props) => CodexSpacer(props);

  @override
  Component expanded(ExpandedProps props) => CodexExpanded(props);

  @override
  Component sizedBox(SizedBoxProps props) => CodexSizedBox(props);

  @override
  Component flow(FlowProps props) => CodexFlow(props);

  @override
  Component direction(DirectionProps props) => CodexDirection(props);

  @override
  Component gap(GapProps props) => CodexGap(props);

  @override
  Component buttonPanel(ButtonPanelProps props) => CodexButtonPanel(props);

  @override
  Component toolbar(ToolbarProps props) => CodexToolbar(props);

  @override
  Component buttonGroup(ButtonGroupProps props) => CodexButtonGroup(props);

  @override
  Component aspectRatio(AspectRatioProps props) => CodexAspectRatio(props);

  @override
  Component gutter(GutterProps props) => CodexGutter(props);

  @override
  Component paddingWrapper(PaddingWrapperProps props) =>
      CodexPaddingWrapper(props);

  @override
  Component fieldWrapper(FieldWrapperProps props) => CodexFieldWrapper(props);

  @override
  Component formSection(FormSectionProps props) => CodexFormSection(props);

  @override
  Component form(FormProps props) => CodexForm(props);

  @override
  Component inputGroup(InputGroupProps props) => CodexInputGroup(props);

  @override
  Component resizable(ResizableProps props) => CodexResizable(props);

  @override
  Component item(ItemProps props) => CodexItem(props);

  @override
  Component flexiCards(FlexiCardsProps props) => CodexFlexiCards(props);

  @override
  Component flexiCardsSimple(FlexiCardsSimpleProps props) =>
      CodexFlexiCardsSimple(props);

  @override
  Component checkItem(CheckItemProps props) => CodexCheckItem(props);

  @override
  Component checkList(CheckListProps props) => CodexCheckList(props);

  @override
  Component featureRow(FeatureRowProps props) => CodexFeatureRow(props);

  @override
  Component specRow(SpecRowProps props) => CodexSpecRow(props);

  @override
  Component calendar(CalendarProps props) => CodexCalendar(props);

  @override
  Component command(CommandProps props) => CodexCommand(props);

  @override
  Component confirmDialog(ConfirmDialogProps props) =>
      CodexConfirmDialog(props);

  @override
  Component alertDialog(AlertDialogProps props) => CodexAlertDialog(props);

  @override
  Component contextMenu(ContextMenuProps props) => CodexContextMenu(props);

  @override
  Component cycleButton<T>(CycleButtonProps<T> props) =>
      CodexCycleButton<T>(props);

  @override
  Component toggleButton(ToggleButtonProps props) => CodexToggleButton(props);

  @override
  Component dataTable<T>(DataTableProps<T> props) => CodexDataTable<T>(props);

  @override
  Component datePicker(DatePickerProps props) => CodexDatePicker(props);

  @override
  Component disclosure(DisclosureProps props) => CodexDisclosure(props);

  @override
  Component disclosureGroup(DisclosureGroupProps props) =>
      CodexDisclosureGroup(props);

  @override
  Component dropdownMenu(DropdownMenuProps props) => CodexDropdownMenu(props);

  @override
  Component fadeEdge(FadeEdgeProps props) => CodexFadeEdge(props);

  @override
  Component kbd(KbdProps props) => CodexKbd(props);

  @override
  Component menubar(MenubarProps props) => CodexMenubar(props);

  @override
  Component nativeSelect(NativeSelectProps props) => CodexNativeSelect(props);

  @override
  Component otpInput(OtpInputProps props) => CodexOtpInput(props);

  @override
  Component scrollArea(ScrollAreaProps props) => CodexScrollArea(props);

  @override
  Component scrollRail(ScrollRailProps props) => CodexScrollRail(props);

  @override
  Component scrollRailLayout(ScrollRailLayoutProps props) =>
      CodexScrollRailLayout(props);

  @override
  Component virtualScroll<T>(VirtualScrollProps<T> props) =>
      CodexVirtualScroll<T>(props);

  @override
  Component slotCounter(SlotCounterProps props) => CodexSlotCounter(props);

  @override
  Component slotCounterRow(SlotCounterRowProps props) =>
      CodexSlotCounterRow(props);

  @override
  Component slotCounterCard(SlotCounterCardProps props) =>
      CodexSlotCounterCard(props);

  @override
  Component staticTable(StaticTableProps props) => CodexStaticTable(props);

  @override
  Component keyValueTable(KeyValueTableProps props) =>
      CodexKeyValueTable(props);

  @override
  Component timePicker(TimePickerProps props) => CodexTimePicker(props);

  @override
  Component toggleGroup(ToggleGroupProps props) => CodexToggleGroup(props);

  @override
  Component topAnnouncementBar(TopAnnouncementBarProps props) =>
      CodexTopAnnouncementBar(props);

  @override
  Component bottomFloatingBanner(BottomFloatingBannerProps props) =>
      CodexBottomFloatingBanner(props);

  @override
  Component cornerPromoToast(CornerPromoToastProps props) =>
      CodexCornerPromoToast(props);

  @override
  Component promoModal(PromoModalProps props) => CodexPromoModal(props);

  @override
  Component inlineHeroBanner(InlineHeroBannerProps props) =>
      CodexInlineHeroBanner(props);

  @override
  Component slidingSidebarBanner(SlidingSidebarBannerProps props) =>
      CodexSlidingSidebarBanner(props);

  @override
  Component marqueeTickerBar(MarqueeTickerBarProps props) =>
      CodexMarqueeTickerBar(props);

  @override
  Component expandingFabPromo(ExpandingFabPromoProps props) =>
      CodexExpandingFabPromo(props);

  @override
  Component progressClaimBanner(ProgressClaimBannerProps props) =>
      CodexProgressClaimBanner(props);

  @override
  Component minimizablePromo(MinimizablePromoProps props) =>
      CodexMinimizablePromo(props);

  @override
  Component fullscreenTakeover(FullscreenTakeoverProps props) =>
      CodexFullscreenTakeover(props);
}
