import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/renderers.dart';
import '../../shadcn/renderers/shadcn_renderers.dart';

// Codex-specific renderer imports
import 'accordion.dart';
import 'alert_banner.dart';
import 'alert.dart';
import 'animated_counter.dart';
import 'arrow_link.dart';
import 'auth_branding_panel.dart';
import 'auth_layout.dart';
import 'auth_split_layout.dart';
import 'author_card.dart';
import 'avatar.dart';
import 'badge.dart';
import 'bar.dart';
import 'bottom_navigation.dart';
import 'breadcrumbs.dart';
import 'button.dart';
import 'calendar.dart';
import 'callout.dart';
import 'card_section.dart';
import 'card.dart';
import 'carpet.dart';
import 'center_body.dart';
import 'check_list.dart';
import 'checkbox.dart';
import 'chip.dart';
import 'code_snippet.dart';
import 'code_window.dart';
import 'color_input.dart';
import 'command.dart';
import 'confirm_dialog.dart';
import 'context_menu.dart';
import 'cycle_button.dart';
import 'dashboard_layout.dart';
import 'data_table.dart';
import 'date_picker.dart';
import 'dialog.dart';
import 'disclosure.dart';
import 'dot_indicator.dart';
import 'drawer.dart';
import 'dropdown_menu.dart';
import 'empty_state.dart';
import 'expander.dart';
import 'fab.dart';
import 'fade_edge.dart';
import 'feature_card.dart';
import 'feature_showcase.dart';
import 'field_wrapper.dart';
import 'file_upload.dart';
import 'flexi_cards.dart';
import 'floating.dart';
import 'flow.dart';
import 'footer.dart';
import 'form.dart';
import 'game_tile.dart';
import 'glass.dart';
import 'gradient_text.dart';
import 'gutter.dart';
import 'header.dart';
import 'hero_section.dart';
import 'icon_button.dart';
import 'integration_card.dart';
import 'kbd.dart';
import 'loader.dart';
import 'marquee.dart';
import 'menubar.dart';
import 'meter.dart';
import 'mobile_menu.dart';
import 'newsletter_form.dart';
import 'number_input.dart';
import 'otp_input.dart';
import 'pagination.dart';
import 'pricing_card.dart';
import 'progress.dart';
import 'radio_cards.dart';
import 'radio_group.dart';
import 'rating_stars.dart';
import 'scroll_area.dart';
import 'search.dart';
import 'section.dart';
import 'select.dart';
import 'separator.dart';
import 'settings_section.dart';
import 'sidebar.dart';
import 'skeleton.dart';
import 'slider.dart';
import 'slot_counter.dart';
import 'social_icons.dart';
import 'stat_card.dart';
import 'stat_display.dart';
import 'static_table.dart';
import 'status_indicator.dart';
import 'stepper.dart';
import 'surface_card.dart';
import 'switcher.dart';
import 'tabs.dart';
import 'tag_input.dart';
import 'testimonial_card.dart';
import 'text_input.dart';
import 'tile.dart';
import 'time_dialog.dart';
import 'time_picker.dart';
import 'timeline.dart';
import 'toast.dart';
import 'toggle_group.dart';
import 'toggle_switch.dart';
import 'tracker.dart';
import 'tree_view.dart';
import 'placeholder_image.dart';

/// Codex component renderers.
///
/// Implements all components according to the Codex design language:
/// - OLED-first dark mode with pure black backgrounds
/// - Subtle accent-colored glows
/// - 1.25x spacing compared to ShadCN
/// - Larger border radius (14px default)
/// - Gaming/tech aesthetic
///
/// Components are gradually being migrated from ShadcnRenderers.
/// Non-overridden components fall back to ShadCN implementations.
class CodexRenderers extends ShadcnRenderers {
  const CodexRenderers();

  // ==========================================================================
  // CORE INPUT COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component button(ButtonProps props) => CodexButton(props);

  @override
  Component textInput(TextInputProps props) => CodexTextInput(props);

  // ==========================================================================
  // CORE VIEW COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component card(CardProps props) => CodexCard(props);

  @override
  Component badge(BadgeProps props) => CodexBadge(props);

  @override
  Component alert(AlertProps props) => CodexAlert(props);

  @override
  Component avatar(AvatarProps props) => CodexAvatar(props);

  @override
  Component placeholderImage(PlaceholderImageProps props) =>
      CodexPlaceholderImage(props);

  @override
  Component progress(ProgressProps props) => CodexProgress(props);

  @override
  Component circularProgress(CircularProgressProps props) =>
      CodexCircularProgress(props);

  @override
  Component loadingSpinner(LoadingSpinnerProps props) =>
      CodexLoadingSpinner(props);

  // ==========================================================================
  // SELECTION & TOGGLE COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component checkbox(CheckboxProps props) => CodexCheckbox(props);

  @override
  Component toggleSwitch(ToggleSwitchProps props) => CodexToggleSwitch(props);

  @override
  Component iconButton(IconButtonProps props) => CodexIconButton(props);

  @override
  Component slider(SliderProps props) => CodexSlider(props);

  // ==========================================================================
  // NAVIGATION COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component tabs(TabsProps props) => CodexTabs(props);

  @override
  Component tabBar(TabBarProps props) => CodexTabBar(props);

  @override
  Component header(HeaderProps props) => CodexHeader(props);

  @override
  Component navLink(NavLinkProps props) => CodexNavLink(props);

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

  // ==========================================================================
  // DIALOG & OVERLAY COMPONENTS (Codex-specific implementations)
  // ==========================================================================

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

  // ==========================================================================
  // ADDITIONAL INPUT COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component radioGroup<T>(RadioGroupProps<T> props) => CodexRadioGroup<T>(props);

  @override
  Component search(SearchProps props) => CodexSearch(props);

  @override
  Component select<T>(SelectProps<T> props) => CodexSelect<T>(props);

  // ==========================================================================
  // DISPLAY COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component separator(SeparatorProps props) => CodexSeparator(props);

  @override
  Component skeleton(SkeletonProps props) => CodexSkeleton(props);

  @override
  Component chip(ChipProps props) => CodexChip(props);

  @override
  Component chipGroup(ChipGroupProps props) => CodexChipGroup(props);

  // ==========================================================================
  // LAYOUT COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component accordion(AccordionProps props) => CodexAccordion(props);

  @override
  Component pagination(PaginationProps props) => CodexPagination(props);

  @override
  Component emptyState(EmptyStateProps props) => CodexEmptyState(props);

  // ==========================================================================
  // CONTENT & CODE COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component callout(CalloutProps props) => CodexCallout(props);

  @override
  Component codeSnippet(CodeSnippetProps props) => CodexCodeSnippet(props);

  @override
  Component inlineCode(InlineCodeProps props) => CodexInlineCode(props);

  @override
  Component terminal(TerminalProps props) => CodexTerminal(props);

  @override
  Component timeline(TimelineProps props) => CodexTimeline(props);

  @override
  Component stepper(StepperProps props) => CodexStepper(props);

  @override
  Component meter(MeterProps props) => CodexMeter(props);

  @override
  Component statusIndicator(StatusIndicatorProps props) =>
      CodexStatusIndicator(props);

  @override
  Component statusBadge(SimpleStatusBadgeProps props) =>
      CodexSimpleStatusBadge(props);

  // ==========================================================================
  // GLASS & EFFECT COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component glass(GlassProps props) => CodexGlass(props);

  @override
  Component glassCard(GlassCardProps props) => CodexGlassCard(props);

  @override
  Component gradientGlass(GradientGlassProps props) => CodexGradientGlass(props);

  // ==========================================================================
  // PAGE LAYOUT COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component heroSection(HeroSectionProps props) => CodexHeroSection(props);

  @override
  Component ctaGroup(CtaGroupProps props) => CodexCtaGroup(props);

  @override
  Component footer(FooterProps props) => CodexFooter(props);

  @override
  Component footerSocialIcon(FooterSocialIconProps props) =>
      CodexFooterSocialIcon(props);

  @override
  Component pricingCard(PricingCardProps props) => CodexPricingCard(props);

  @override
  Component pricingGrid(PricingGridProps props) => CodexPricingGrid(props);

  @override
  Component featureCard(FeatureCardProps props) => CodexFeatureCard(props);

  @override
  Component iconCard(IconCardProps props) => CodexIconCard(props);

  // ==========================================================================
  // LAYOUT PRIMITIVES (Codex-specific implementations)
  // ==========================================================================

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
  Component gap(GapProps props) => CodexGap(props);

  @override
  Component gutter(GutterProps props) => CodexGutter(props);

  @override
  Component paddingWrapper(PaddingWrapperProps props) =>
      CodexPaddingWrapper(props);

  @override
  Component carpet(CarpetProps props) => CodexCarpet(props);

  @override
  Component surface(SurfaceProps props) => CodexSurface(props);

  @override
  Component arcaneDivider(ArcaneDividerProps props) => CodexArcaneDivider(props);

  // ==========================================================================
  // TILE COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component tile(TileProps props) => CodexTile(props);

  @override
  Component navTile(NavTileProps props) => CodexNavTile(props);

  // ==========================================================================
  // STAT COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component statDisplay(StatDisplayProps props) => CodexStatDisplay(props);

  @override
  Component statRow(StatRowProps props) => CodexStatRow(props);

  @override
  Component statCard(StatCardProps props) => CodexStatCard(props);

  @override
  Component statCardRow(StatCardRowProps props) => CodexStatCardRow(props);

  // ==========================================================================
  // SETTINGS COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component settingsSection(SettingsSectionProps props) =>
      CodexSettingsSection(props);

  @override
  Component settingsInfoRow(SettingsInfoRowProps props) =>
      CodexSettingsInfoRow(props);

  @override
  Component settingsToggleRow(SettingsToggleRowProps props) =>
      CodexSettingsToggleRow(props);

  @override
  Component settingsSubheader(SettingsSubheaderProps props) =>
      CodexSettingsSubheader(props);

  @override
  Component settingsNote(SettingsNoteProps props) => CodexSettingsNote(props);

  // ==========================================================================
  // FORM COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component fieldWrapper(FieldWrapperProps props) => CodexFieldWrapper(props);

  @override
  Component formSection(FormSectionProps props) => CodexFormSection(props);

  @override
  Component form(FormProps props) => CodexForm(props);

  @override
  Component inputGroup(InputGroupProps props) => CodexInputGroup(props);

  @override
  Component newsletterForm(NewsletterFormProps props) =>
      CodexNewsletterForm(props);

  @override
  Component waitlistForm(WaitlistFormProps props) => CodexWaitlistForm(props);

  // ==========================================================================
  // AUTH COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component authLayout(AuthLayoutProps props) => CodexAuthLayout(props);

  @override
  Component authBackLink(AuthBackLinkProps props) => CodexAuthBackLink(props);

  @override
  Component authSplitLayout(AuthSplitLayoutProps props) =>
      CodexAuthSplitLayout(props);

  @override
  Component authBrandingPanel(AuthBrandingPanelProps props) =>
      CodexAuthBrandingPanel(props);

  // ==========================================================================
  // DASHBOARD COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component dashboardLayout(DashboardLayoutProps props) =>
      CodexDashboardLayout(props);

  @override
  Component dashboardTopBar(DashboardTopBarProps props) =>
      CodexDashboardTopBar(props);

  // ==========================================================================
  // CARD VARIANTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component surfaceCard(SurfaceCardProps props) => CodexSurfaceCard(props);

  @override
  Component thumbHashCard(ThumbHashCardProps props) => CodexThumbHashCard(props);

  @override
  Component cardSection(CardSectionProps props) => CodexCardSection(props);

  @override
  Component listCard(ListCardProps props) => CodexListCard(props);

  @override
  Component section(SectionProps props) => CodexSection(props);

  @override
  Component authorCard(AuthorCardProps props) => CodexAuthorCard(props);

  @override
  Component testimonialCard(TestimonialCardProps props) =>
      CodexTestimonialCard(props);

  @override
  Component ratingStarsSimple(RatingStarsSimpleProps props) =>
      CodexRatingStarsSimple(props);

  @override
  Component integrationCard(IntegrationCardProps props) =>
      CodexIntegrationCard(props);

  @override
  Component integrationGrid(IntegrationGridProps props) =>
      CodexIntegrationGrid(props);

  // ==========================================================================
  // MOBILE NAVIGATION (Codex-specific implementations)
  // ==========================================================================

  @override
  Component bottomNavigationBar(BottomNavigationBarProps props) =>
      CodexBottomNavigationBar(props);

  @override
  Component bottomBar(BottomBarProps props) => CodexBottomBar(props);

  @override
  Component mobileMenu(MobileMenuProps props) => CodexMobileMenu(props);

  @override
  Component hamburgerButton(HamburgerButtonProps props) =>
      CodexHamburgerButton(props);

  @override
  Component dotIndicator(DotIndicatorProps props) => CodexDotIndicator(props);

  @override
  Component stepIndicator(StepIndicatorProps props) =>
      CodexStepIndicator(props);

  // ==========================================================================
  // GAME COMPONENTS (Codex-specific implementations)
  // ==========================================================================

  @override
  Component gameTile(GameTileProps props) => CodexGameTile(props);

  @override
  Component gameSelector(GameSelectorProps props) => CodexGameSelector(props);

  @override
  Component gameCard(GameCardProps props) => CodexGameCard(props);

  // ==========================================================================
  // MISC COMPONENTS (Codex-specific implementations)
  // ==========================================================================

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

  // ==========================================================================
  // NEWLY PORTED COMPONENTS
  // ==========================================================================

  @override
  Component alertBanner(AlertBannerProps props) => CodexAlertBanner(props);

  @override
  Component animatedCounter(AnimatedCounterProps props) =>
      CodexAnimatedCounter(props);

  @override
  Component counterRow(CounterRowProps props) => CodexCounterRow(props);

  @override
  Component metricDisplay(MetricDisplayProps props) =>
      CodexMetricDisplay(props);

  @override
  Component arrowLink(ArrowLinkProps props) => CodexArrowLink(props);

  @override
  Component bar(BarProps props) => CodexBar(props);

  @override
  Component dialogBar(DialogBarProps props) => CodexDialogBar(props);

  @override
  Component calendar(CalendarProps props) => CodexCalendar(props);

  @override
  Component centerBody(CenterBodyProps props) => CodexCenterBody(props);

  @override
  Component pageBody(PageBodyProps props) => CodexPageBody(props);

  @override
  Component loadingState(LoadingStateProps props) => CodexLoadingState(props);

  @override
  Component errorState(ErrorStateProps props) => CodexErrorState(props);

  @override
  Component codeWindow(CodeWindowProps props) => CodexCodeWindow(props);

  @override
  Component codePreview(CodePreviewProps props) => CodexCodePreview(props);

  @override
  Component colorInput(ColorInputProps props) => CodexColorInput(props);

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
  Component expander(ExpanderProps props) => CodexExpander(props);

  @override
  Component fab(FABProps props) => CodexFAB(props);

  @override
  Component fadeEdge(FadeEdgeProps props) => CodexFadeEdge(props);

  @override
  Component featureShowcase(FeatureShowcaseProps props) =>
      CodexFeatureShowcase(props);

  @override
  Component fileUpload(FileUploadProps props) => CodexFileUpload(props);

  @override
  Component gradientText(GradientTextProps props) => CodexGradientText(props);

  @override
  Component animatedGradientText(AnimatedGradientTextProps props) =>
      CodexAnimatedGradientText(props);

  @override
  Component glowText(GlowTextProps props) => CodexGlowText(props);

  @override
  Component outlineText(OutlineTextProps props) => CodexOutlineText(props);

  @override
  Component kbd(KbdProps props) => CodexKbd(props);

  @override
  Component loader(LoaderProps props) => CodexLoader(props);

  @override
  Component loadingOverlay(LoadingOverlayProps props) =>
      CodexLoadingOverlay(props);

  @override
  Component marquee(MarqueeProps props) => CodexMarquee(props);

  @override
  Component menubar(MenubarProps props) => CodexMenubar(props);

  @override
  Component numberInput(NumberInputProps props) => CodexNumberInput(props);

  @override
  Component otpInput(OtpInputProps props) => CodexOtpInput(props);

  @override
  Component radioCards<T>(RadioCardsProps<T> props) =>
      CodexRadioCards<T>(props);

  @override
  Component scrollArea(ScrollAreaProps props) => CodexScrollArea(props);

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
  Component socialIcon(SocialIconProps props) => CodexSocialIcon(props);

  @override
  Component socialIconGroup(SocialIconGroupProps props) =>
      CodexSocialIconGroup(props);

  @override
  Component socialLinks(SocialLinksProps props) => CodexSocialLinks(props);

  @override
  Component staticTable(StaticTableProps props) => CodexStaticTable(props);

  @override
  Component keyValueTable(KeyValueTableProps props) =>
      CodexKeyValueTable(props);

  @override
  Component switcher(SwitcherProps props) => CodexSwitcher(props);

  @override
  Component indexedStack(IndexedStackProps props) => CodexIndexedStack(props);

  @override
  Component tagInput(TagInputProps props) => CodexTagInput(props);

  @override
  Component timeDialog(TimeDialogProps props) => CodexTimeDialog(props);

  @override
  Component timePicker(TimePickerProps props) => CodexTimePicker(props);

  @override
  Component toggleGroup(ToggleGroupProps props) => CodexToggleGroup(props);

  @override
  Component tracker(TrackerProps props) => CodexTracker(props);

  @override
  Component uptimeTracker(UptimeTrackerProps props) =>
      CodexUptimeTracker(props);

  @override
  Component treeView(TreeViewProps props) => CodexTreeView(props);
}
