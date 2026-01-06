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
import 'confirm_dialog.dart';
import 'email_dialog.dart';
import 'text_dialog.dart';
import 'item_picker.dart';
import 'time_dialog.dart';
import 'alert_banner.dart';
import 'status_badge.dart' as status_badge_renderer;
import 'kbd.dart';
import 'theme_toggle.dart';
import 'divider.dart';
import 'callout.dart';
import 'disclosure.dart';
import 'expander.dart';
import 'code_snippet.dart';
import 'code_window.dart';
import 'static_table.dart';
import 'timeline.dart';
import 'stepper.dart';
import 'tree_view.dart';
import 'rating_stars.dart';
import 'status_indicator.dart';
import 'check_list.dart';
import 'gradient_text.dart';
import 'glass.dart';
import 'bar.dart';
import 'marquee.dart';
import 'animated_counter.dart';
import 'tracker.dart';
import 'file_upload.dart';
import 'time_picker.dart';
import 'switcher.dart';
import 'stat_display.dart';
import 'tile.dart';
import 'arrow_link.dart';
import 'stat_card.dart';
import 'surface_card.dart';
import 'fade_edge.dart';
import 'center_body.dart';
import 'card_section.dart';
import 'section.dart';
import 'author_card.dart';
import 'feature_card.dart';
import 'testimonial_card.dart';
import 'social_icons.dart';
import 'integration_card.dart';
import 'pricing_card.dart';
import 'auth_branding_panel.dart';
import 'flexi_cards.dart';
import 'game_tile.dart';
import 'settings_section.dart';
import 'slot_counter.dart';
import 'field_wrapper.dart';
import 'form.dart';
import 'newsletter_form.dart';
import 'bottom_navigation.dart';
import 'mobile_menu.dart';
import 'dot_indicator.dart';
import 'auth_layout.dart';
import 'hero_section.dart';
import 'footer.dart';
import 'dashboard_layout.dart';
import 'feature_showcase.dart';
import 'footer_column.dart';
import 'auth_split_layout.dart';
import 'section_header.dart';
import 'cta_banner.dart';
import 'logo_carousel.dart';
import 'carpet.dart';
import 'gutter.dart';
import 'flow.dart';
import 'button_panel.dart';
import 'aspect_ratio.dart';
import 'scroll_rail.dart';
import 'resizable.dart';
import 'radio_cards.dart';

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
  Component fileUpload(FileUploadProps props) => ShadcnFileUpload(props);

  @override
  Component timePicker(TimePickerProps props) => ShadcnTimePicker(props);

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
  Component circularProgress(CircularProgressProps props) => ShadcnCircularProgress(props);

  @override
  Component loadingSpinner(LoadingSpinnerProps props) => ShadcnLoadingSpinner(props);

  @override
  Component alertBanner(AlertBannerProps props) => ShadcnAlertBanner(props);

  @override
  Component statusBadge2(StatusBadgeProps props) => status_badge_renderer.ShadcnStatusBadge(props);

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
  Component divider(DividerProps props) => ShadcnDivider(props);

  @override
  Component callout(CalloutProps props) => ShadcnCallout(props);

  @override
  Component disclosure(DisclosureProps props) => ShadcnDisclosure(props);

  @override
  Component disclosureGroup(DisclosureGroupProps props) => ShadcnDisclosureGroup(props);

  @override
  Component expander(ExpanderProps props) => ShadcnExpander(props);

  @override
  Component codeSnippet(CodeSnippetProps props) => ShadcnCodeSnippet(props);

  @override
  Component inlineCode(InlineCodeProps props) => ShadcnInlineCode(props);

  @override
  Component terminal(TerminalProps props) => ShadcnTerminal(props);

  @override
  Component codeWindow(CodeWindowProps props) => ShadcnCodeWindow(props);

  @override
  Component codePreview(CodePreviewProps props) => ShadcnCodePreview(props);

  @override
  Component staticTable(StaticTableProps props) => ShadcnStaticTable(props);

  @override
  Component keyValueTable(KeyValueTableProps props) => ShadcnKeyValueTable(props);

  @override
  Component timeline(TimelineProps props) => ShadcnTimeline(props);

  @override
  Component stepper(StepperProps props) => ShadcnStepper(props);

  @override
  Component treeView(TreeViewProps props) => ShadcnTreeView(props);

  @override
  Component ratingStars(RatingStarsProps props) => ShadcnRatingStars(props);

  @override
  Component statusIndicator(StatusIndicatorProps props) => ShadcnStatusIndicator(props);

  @override
  Component statusBadge(SimpleStatusBadgeProps props) => ShadcnStatusBadge(props);

  @override
  Component checkItem(CheckItemProps props) => ShadcnCheckItem(props);

  @override
  Component checkList(CheckListProps props) => ShadcnCheckList(props);

  @override
  Component featureRow(FeatureRowProps props) => ShadcnFeatureRow(props);

  @override
  Component gradientText(GradientTextProps props) => ShadcnGradientText(props);

  @override
  Component animatedGradientText(AnimatedGradientTextProps props) => ShadcnAnimatedGradientText(props);

  @override
  Component glowText(GlowTextProps props) => ShadcnGlowText(props);

  @override
  Component outlineText(OutlineTextProps props) => ShadcnOutlineText(props);

  @override
  Component glass(GlassProps props) => ShadcnGlass(props);

  @override
  Component glassCard(GlassCardProps props) => ShadcnGlassCard(props);

  @override
  Component gradientGlass(GradientGlassProps props) => ShadcnGradientGlass(props);

  @override
  Component bar(BarProps props) => ShadcnBar(props);

  @override
  Component dialogBar(DialogBarProps props) => ShadcnDialogBar(props);

  @override
  Component marquee(MarqueeProps props) => ShadcnMarquee(props);

  @override
  Component animatedCounter(AnimatedCounterProps props) => ShadcnAnimatedCounter(props);

  @override
  Component counterRow(CounterRowProps props) => ShadcnCounterRow(props);

  @override
  Component metricDisplay(MetricDisplayProps props) => ShadcnMetricDisplay(props);

  @override
  Component tracker(TrackerProps props) => ShadcnTracker(props);

  @override
  Component uptimeTracker(UptimeTrackerProps props) => ShadcnUptimeTracker(props);

  @override
  Component switcher(SwitcherProps props) => ShadcnSwitcher(props);

  @override
  Component indexedStack(IndexedStackProps props) => ShadcnIndexedStack(props);

  @override
  Component statDisplay(StatDisplayProps props) => ShadcnStatDisplay(props);

  @override
  Component statRow(StatRowProps props) => ShadcnStatRow(props);

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

  // ==========================================================================
  // LAYOUT COMPONENTS
  // ==========================================================================

  @override
  Component authLayout(AuthLayoutProps props) => ShadcnAuthLayout(props);

  @override
  Component authBackLink(AuthBackLinkProps props) => ShadcnAuthBackLink(props);

  @override
  Component heroSection(HeroSectionProps props) => ShadcnHeroSection(props);

  @override
  Component ctaGroup(CtaGroupProps props) => ShadcnCtaGroup(props);

  @override
  Component footer(FooterProps props) => ShadcnFooter(props);

  @override
  Component footerSocialIcon(FooterSocialIconProps props) => ShadcnFooterSocialIcon(props);

  @override
  Component dashboardLayout(DashboardLayoutProps props) => ShadcnDashboardLayout(props);

  @override
  Component dashboardTopBar(DashboardTopBarProps props) => ShadcnDashboardTopBar(props);

  @override
  Component featureShowcase(FeatureShowcaseProps props) => ShadcnFeatureShowcase(props);

  @override
  Component footerColumn(FooterColumnProps props) => renderFooterColumn(props);

  @override
  Component footerBrandColumn(FooterBrandColumnProps props) => renderFooterBrandColumn(props);

  @override
  Component authSplitLayout(AuthSplitLayoutProps props) => renderAuthSplitLayout(props);

  @override
  Component sectionHeader(SectionHeaderProps props) => renderSectionHeader(props);

  @override
  Component ctaBanner(CtaBannerProps props) => renderCtaBanner(props);

  @override
  Component logoCarousel(LogoCarouselProps props) => renderLogoCarousel(props);

  @override
  Component logoGrid(LogoGridProps props) => renderLogoGrid(props);

  @override
  Component carpet(CarpetProps props) => renderCarpet(props);

  @override
  Component surface(SurfaceProps props) => renderSurface(props);

  @override
  Component arcaneDivider(ArcaneDividerProps props) => renderArcaneDivider(props);

  @override
  Component gutter(GutterProps props) => renderGutter(props);

  @override
  Component gap(GapProps props) => renderGap(props);

  @override
  Component flow(FlowProps props) => renderFlow(props);

  @override
  Component row(RowProps props) => renderRow(props);

  @override
  Component column(ColumnProps props) => renderColumn(props);

  @override
  Component center(CenterProps props) => renderCenter(props);

  @override
  Component spacer(SpacerProps props) => renderSpacer(props);

  @override
  Component expanded(ExpandedProps props) => renderExpanded(props);

  @override
  Component sizedBox(SizedBoxProps props) => renderSizedBox(props);

  @override
  Component paddingWrapper(PaddingWrapperProps props) => renderPaddingWrapper(props);

  @override
  Component buttonPanel(ButtonPanelProps props) => renderButtonPanel(props);

  @override
  Component toolbar(ToolbarProps props) => renderToolbar(props);

  @override
  Component buttonGroup(ButtonGroupProps props) => renderButtonGroup(props);

  @override
  Component aspectRatio(AspectRatioProps props) => renderAspectRatio(props);

  @override
  Component confirmDialog(ConfirmDialogProps props) => ShadcnConfirmDialog(props);

  @override
  Component alertDialog(AlertDialogProps props) => ShadcnAlertDialog(props);

  @override
  Component emailDialog(EmailDialogProps props) => ShadcnEmailDialog(props);

  @override
  Component textInputDialog(TextInputDialogProps props) => ShadcnTextInputDialog(props);

  @override
  Component itemPicker<T>(ItemPickerProps<T> props) => ShadcnItemPicker<T>(props);

  @override
  Component timeDialog(TimeDialogProps props) => ShadcnTimeDialog(props);

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

  @override
  Component tile(TileProps props) => ShadcnTile(props);

  @override
  Component navTile(NavTileProps props) => ShadcnNavTile(props);

  @override
  Component arrowLink(ArrowLinkProps props) => ShadcnArrowLink(props);

  @override
  Component statCard(StatCardProps props) => ShadcnStatCard(props);

  @override
  Component statCardRow(StatCardRowProps props) => ShadcnStatCardRow(props);

  @override
  Component surfaceCard(SurfaceCardProps props) => ShadcnSurfaceCard(props);

  @override
  Component thumbHashCard(ThumbHashCardProps props) => ShadcnThumbHashCard(props);

  @override
  Component fadeEdge(FadeEdgeProps props) => ShadcnFadeEdge(props);

  @override
  Component centerBody(CenterBodyProps props) => ShadcnCenterBody(props);

  @override
  Component pageBody(PageBodyProps props) => ShadcnPageBody(props);

  @override
  Component loadingState(LoadingStateProps props) => ShadcnLoadingState(props);

  @override
  Component errorState(ErrorStateProps props) => ShadcnErrorState(props);

  @override
  Component cardSection(CardSectionProps props) => ShadcnCardSection(props);

  @override
  Component listCard(ListCardProps props) => ShadcnListCard(props);

  @override
  Component section(SectionProps props) => ShadcnSection(props);

  @override
  Component authorCard(AuthorCardProps props) => ShadcnAuthorCard(props);

  @override
  Component featureCard(FeatureCardProps props) => ShadcnFeatureCard(props);

  @override
  Component iconCard(IconCardProps props) => ShadcnIconCard(props);

  @override
  Component testimonialCard(TestimonialCardProps props) => ShadcnTestimonialCard(props);

  @override
  Component ratingStarsSimple(RatingStarsSimpleProps props) => ShadcnRatingStarsSimple(props);

  @override
  Component socialIcon(SocialIconProps props) => ShadcnSocialIcon(props);

  @override
  Component socialIconGroup(SocialIconGroupProps props) => ShadcnSocialIconGroup(props);

  @override
  Component socialLinks(SocialLinksProps props) => ShadcnSocialLinks(props);

  @override
  Component integrationCard(IntegrationCardProps props) => ShadcnIntegrationCard(props);

  @override
  Component integrationGrid(IntegrationGridProps props) => ShadcnIntegrationGrid(props);

  @override
  Component pricingCard(PricingCardProps props) => ShadcnPricingCard(props);

  @override
  Component pricingGrid(PricingGridProps props) => ShadcnPricingGrid(props);

  @override
  Component authBrandingPanel(AuthBrandingPanelProps props) => ShadcnAuthBrandingPanel(props);

  @override
  Component flexiCards(FlexiCardsProps props) => ShadcnFlexiCards(props);

  @override
  Component flexiCardsSimple(FlexiCardsSimpleProps props) => ShadcnFlexiCardsSimple(props);

  @override
  Component gameTile(GameTileProps props) => ShadcnGameTile(props);

  @override
  Component gameSelector(GameSelectorProps props) => ShadcnGameSelector(props);

  @override
  Component gameCard(GameCardProps props) => ShadcnGameCard(props);

  @override
  Component settingsSection(SettingsSectionProps props) => ShadcnSettingsSection(props);

  @override
  Component settingsInfoRow(SettingsInfoRowProps props) => ShadcnSettingsInfoRow(props);

  @override
  Component settingsToggleRow(SettingsToggleRowProps props) => ShadcnSettingsToggleRow(props);

  @override
  Component settingsSubheader(SettingsSubheaderProps props) => ShadcnSettingsSubheader(props);

  @override
  Component settingsNote(SettingsNoteProps props) => ShadcnSettingsNote(props);

  @override
  Component slotCounter(SlotCounterProps props) => ShadcnSlotCounter(props);

  @override
  Component slotCounterRow(SlotCounterRowProps props) => ShadcnSlotCounterRow(props);

  @override
  Component slotCounterCard(SlotCounterCardProps props) => ShadcnSlotCounterCard(props);

  @override
  Component fieldWrapper(FieldWrapperProps props) => ShadcnFieldWrapper(props);

  @override
  Component formSection(FormSectionProps props) => ShadcnFormSection(props);

  @override
  Component form(FormProps props) => ShadcnForm(props);

  @override
  Component inputGroup(InputGroupProps props) => ShadcnInputGroup(props);

  @override
  Component newsletterForm(NewsletterFormProps props) => ShadcnNewsletterForm(props);

  @override
  Component waitlistForm(WaitlistFormProps props) => ShadcnWaitlistForm(props);

  @override
  Component bottomNavigationBar(BottomNavigationBarProps props) => ShadcnBottomNavigationBar(props);

  @override
  Component bottomBar(BottomBarProps props) => ShadcnBottomBar(props);

  @override
  Component mobileMenu(MobileMenuProps props) => ShadcnMobileMenu(props);

  @override
  Component hamburgerButton(HamburgerButtonProps props) => ShadcnHamburgerButton(props);

  @override
  Component dotIndicator(DotIndicatorProps props) => ShadcnDotIndicator(props);

  @override
  Component stepIndicator(StepIndicatorProps props) => ShadcnStepIndicator(props);

  // ==========================================================================
  // SCROLL RAIL COMPONENTS
  // ==========================================================================

  @override
  Component scrollRail(ScrollRailProps props) => renderScrollRail(props);

  @override
  Component scrollRailLayout(ScrollRailLayoutProps props) => renderScrollRailLayout(props);

  // ==========================================================================
  // RESIZABLE COMPONENTS
  // ==========================================================================

  @override
  Component resizable(ResizableProps props) => renderResizable(props);

  // ==========================================================================
  // RADIO CARDS COMPONENTS
  // ==========================================================================

  @override
  Component radioCards<T>(RadioCardsProps<T> props) => ShadcnRadioCards<T>(props);

  @override
  Component selectableChipGroup(SelectableChipGroupProps props) => renderSelectableChipGroup(props);

  @override
  Component arcaneChip(ArcaneChipProps props) => renderArcaneChip(props);
}
