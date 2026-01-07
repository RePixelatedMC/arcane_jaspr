/// # Arcane Jaspr
///
/// A comprehensive UI component library for building beautiful web applications
/// with [Jaspr](https://pub.dev/packages/jaspr). Inspired by Supabase's design
/// system with full theme customization support.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:arcane_jaspr/arcane_jaspr.dart';
///
/// class MyApp extends StatelessComponent {
///   @override
///   Component build(BuildContext context) {
///     return ArcaneApp(
///       stylesheet: ShadcnStylesheet(),
///       brightness: Brightness.dark,
///       child: ArcaneColumn(
///         gapSize: Gap.md,
///         children: [
///           ArcaneButton.primary(
///             label: 'Click Me',
///             onPressed: () => print('Clicked!'),
///           ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
///
/// ## Key Concepts
///
/// ### Styling with ArcaneStyleData
///
/// All components support type-safe styling through [ArcaneStyleData]:
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     display: Display.flex,
///     flexDirection: FlexDirection.column,
///     gap: Gap.md,
///     padding: PaddingPreset.lg,
///     background: Background.surface,
///     borderRadius: Radius.lg,
///   ),
///   children: [...],
/// )
/// ```
///
/// ### Theming
///
/// Use stylesheets for consistent component rendering:
///
/// ```dart
/// ArcaneApp(
///   stylesheet: ShadcnStylesheet(),  // Modern, accessible design
///   brightness: Brightness.dark,     // or Brightness.light
///   child: myApp,
/// )
/// ```
///
/// ### Component Categories
///
/// - **Layout**: [ArcaneDiv], [ArcaneRow], [ArcaneColumn], [ArcaneCard], [ArcaneTabs]
/// - **Input**: [ArcaneButton], [ArcaneTextInput], [ArcaneCheckbox], [ArcaneSlider]
/// - **View**: [ArcaneBadge], [ArcaneChip], [ArcaneAvatar], [ArcaneDataTable]
/// - **Navigation**: [ArcaneSidebar], [ArcaneHeader], [ArcaneBreadcrumbs]
/// - **Feedback**: [ArcaneDialog], [ArcaneToast], [ArcaneLoader], [ArcaneSkeleton]
/// - **Auth**: [ArcaneLoginCard], [ArcaneSignupCard], social sign-in buttons
///
/// ## Authentication
///
/// Built-in Firebase authentication support:
///
/// ```dart
/// ArcaneAuthProvider(
///   serverApiUrl: 'https://api.example.com',
///   child: AuthGuard(
///     child: ProtectedContent(),
///   ),
/// )
/// ```
///
/// ## See Also
///
/// - [ArcaneStyleData] - Core styling class
/// - [ArcaneTheme] - Theme configuration
/// - [ButtonStyle] - Button style presets
/// - Documentation site: https://arcanearts.github.io/arcane_jaspr/
library arcane_jaspr;

// Re-export Jaspr core for convenience
export 'package:jaspr/jaspr.dart';

// Re-export Lucide icons for convenience
// Hide names that conflict with Dart/jaspr core types
export 'package:jaspr_lucide/jaspr_lucide.dart'
    hide
        Factory,
        Target,
        Key,
        List,
        Timer,
        View,
        Map,
        Import,
        Contrast,
        Radius,
        SpellCheck,
        TextWrap;

// Re-export Jaspr DOM for HTML elements (div, span, button, text, etc.)
// Hide types that conflict with our custom implementations
export 'package:jaspr/dom.dart'
    hide
        Color,
        ColorScheme,
        Colors,
        Selector,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight,
        FontStyle,
        Visibility,
        Display,
        Position,
        Overflow,
        Cursor,
        // Additional hides for style_types enums
        FlexDirection,
        TextDecoration,
        Transition,
        FontFamily,
        Radius,
        JustifyContent,
        AlignItems,
        PointerEvents,
        ZIndex,
        Transform,
        FlexWrap,
        WhiteSpace,
        Spacing,
        TextTransform;

// ============================================================================
// Core System (NEW)
// ============================================================================
export 'core/theme_provider.dart';
export 'core/renderers.dart' hide SheetPosition;
export 'core/props/button_props.dart';

// ============================================================================
// Stylesheets (NEW)
// ============================================================================
export 'stylesheets/stylesheet.dart';
export 'stylesheets/shadcn/shadcn_stylesheet.dart';
export 'stylesheets/codex/codex_stylesheet.dart';

// ============================================================================
// Core Utilities
// ============================================================================
export 'util/appearance/colors.dart';
export 'util/arcane.dart';
export 'util/interactivity/arcane_scripts.dart';

// ============================================================================
// Enum-Based Style Types (Flutter-like declarative styling)
// ============================================================================
export 'util/style_types/index.dart' hide BorderStyle, AlignSelf, UserSelect;

// ============================================================================
// Support components
// ============================================================================
export 'component/support/app.dart';

// ============================================================================
// Typography components
// ============================================================================
export 'component/typography/headline.dart';
export 'component/typography/text.dart';

// ============================================================================
// Layout components
// ============================================================================
export 'component/layout/section.dart';
export 'component/layout/gutter.dart';
export 'component/layout/flow.dart';
export 'component/layout/carpet.dart';
export 'component/layout/button_panel.dart';
export 'component/layout/radio_cards.dart';
export 'component/layout/tabs.dart';
export 'component/layout/hero_section.dart';
export 'component/layout/footer.dart';
export 'component/layout/logo_carousel.dart';
export 'component/layout/cta_banner.dart';
export 'component/layout/dashboard_layout.dart';
export 'component/layout/auth_layout.dart';
export 'component/layout/drawer.dart';
export 'component/layout/sheet.dart';
export 'component/layout/scroll_rail.dart';
export 'component/layout/scroll_area.dart';
export 'component/layout/aspect_ratio.dart';
export 'component/layout/resizable.dart';
export 'component/layout/section_header.dart';
export 'component/layout/footer_column.dart' hide FooterLink;
export 'component/layout/feature_showcase.dart';

// ============================================================================
// Input components
// ============================================================================
export 'component/input/button.dart';
export 'component/input/icon_button.dart';
export 'component/input/cycle_button.dart';
export 'component/input/search.dart';
export 'component/input/selector.dart';
export 'component/input/fab.dart';
export 'component/input/toggle_switch.dart';
export 'component/input/toggle_group.dart';
export 'component/input/text_input.dart' hide TextInput;
export 'component/input/slider.dart';
export 'component/input/checkbox.dart';
export 'component/input/tag_input.dart';
export 'component/input/number_input.dart';
export 'component/input/file_upload.dart';
export 'component/input/color_input.dart';
export 'component/input/mutable_text.dart';
export 'component/input/radio_group.dart';
export 'component/input/otp_input.dart';
export 'component/input/combobox.dart';
export 'component/input/calendar.dart';
export 'component/input/date_picker.dart';
export 'component/input/time_picker.dart';
export 'component/input/datetime_picker.dart';
export 'component/input/formatted_input.dart';

// ============================================================================
// View components
// ============================================================================
export 'component/view/bar.dart';
export 'component/view/glass.dart';
export 'component/view/tile.dart';
export 'component/view/center_body.dart';
export 'component/view/badge.dart';
export 'component/view/game_tile.dart';
export 'component/view/divider.dart' hide ArcaneDivider;
export 'component/view/code_snippet.dart';
export 'component/view/avatar.dart';
export 'component/view/progress_bar.dart';
export 'component/view/rating_stars.dart';
export 'component/view/stepper.dart';
export 'component/view/skeleton.dart';
export 'component/view/chip.dart' hide ArcaneChip, ArcaneChipGroup;
export 'component/view/status_indicator.dart' hide ArcaneStatusBadge;
export 'component/view/animated_counter.dart';
export 'component/view/slot_counter.dart';
export 'component/view/gradient_text.dart';
export 'component/view/social_icons.dart' hide ArcaneSocialIcon;
export 'component/view/settings_section.dart';
export 'component/view/empty_state.dart' hide ArcaneEmptyState;
export 'component/view/callout.dart';
export 'component/view/kbd.dart';
export 'component/view/meter.dart';
export 'component/view/alert.dart';
export 'component/view/popover.dart';
export 'component/view/hovercard.dart';
export 'component/view/separator.dart';
export 'component/view/fade_edge.dart';
export 'component/view/marquee.dart';
export 'component/view/stat_display.dart';
export 'component/view/code_window.dart';
export 'component/view/check_list.dart';
export 'component/view/switcher.dart';
export 'component/view/icon.dart';
export 'component/view/arrow_link.dart';
export 'component/view/world_map/world_map.dart';
export 'component/view/world_map/world_map_data.dart';
export 'component/view/world_map/world_map_paths.dart';
export 'component/view/usa_map/usa_map.dart';
export 'component/view/usa_map/usa_map_data.dart';
export 'component/view/usa_map/usa_map_paths.dart';

// ============================================================================
// Card components
// ============================================================================
export 'component/card/card.dart';
export 'component/card/card_section.dart';
export 'component/card/author_card.dart';
export 'component/card/feature_card.dart';
export 'component/card/integration_card.dart';
export 'component/card/pricing_card.dart';
export 'component/card/stat_card.dart';
export 'component/card/surface_card.dart' hide ShadowIntensity;
export 'component/card/testimonial_card.dart';
export 'component/card/flexi_cards.dart';

// ============================================================================
// Data components
// ============================================================================
export 'component/data/data_table.dart';
export 'component/data/static_table.dart';
export 'component/data/tree_view.dart';
export 'component/data/timeline.dart';
export 'component/data/tracker.dart';

// ============================================================================
// Menu components
// ============================================================================
export 'component/menu/dropdown_menu.dart';
export 'component/menu/context_menu.dart';
export 'component/menu/menubar.dart';

// ============================================================================
// Navigation components
// ============================================================================
export 'component/navigation/sidebar.dart';
export 'component/navigation/bottom_navigation_bar.dart';
export 'component/navigation/header.dart';
export 'component/navigation/mobile_menu.dart';
export 'component/navigation/breadcrumbs.dart';
export 'component/navigation/pagination.dart';
export 'component/navigation/dot_indicator.dart';

// ============================================================================
// Screen components
// ============================================================================
export 'component/screen/screen.dart';
export 'component/screen/fill_screen.dart';
export 'component/screen/navigation_screen.dart';
export 'component/screen/chat_screen.dart';

// ============================================================================
// Dialog components
// ============================================================================
export 'component/dialog/dialog.dart';
export 'component/dialog/confirm.dart';
export 'component/dialog/input.dart';
export 'component/dialog/toast.dart';
export 'component/dialog/command.dart';
export 'component/dialog/time.dart';
export 'component/dialog/item_picker.dart';

// ============================================================================
// Form components
// ============================================================================
export 'component/form/field.dart';
export 'component/form/field_wrapper.dart';
export 'component/form/provider.dart';
export 'component/form/newsletter_form.dart';

// ============================================================================
// Feedback components
// ============================================================================
export 'component/feedback/alert_banner.dart';
export 'component/feedback/tooltip.dart';
export 'component/feedback/loader.dart';
export 'component/feedback/status_badge.dart' hide StatusType;

// ============================================================================
// Interactive components
// ============================================================================
export 'component/interactive/accordion.dart';
export 'component/interactive/back_to_top.dart';
export 'component/interactive/disclosure.dart';
export 'component/interactive/expander.dart';

// ============================================================================
// Collection components
// ============================================================================
export 'component/collection/collection.dart' hide Axis;
export 'component/collection/card_carousel.dart';
export 'component/collection/infinite_carousel.dart';

// ============================================================================
// HTML wrapper components (Flutter-like API for HTML elements)
// ============================================================================
export 'component/html/arcane_button.dart';
export 'component/html/arcane_image.dart';
export 'component/html/arcane_input.dart';
export 'component/html/arcane_label.dart';
export 'component/html/arcane_link.dart';
export 'component/html/arcane_text.dart' hide ArcaneText;
export 'component/html/code_block.dart'; // ArcaneCodeBlock (and legacy ArcanePre, PreStyle)
export 'component/html/div.dart';
export 'component/html/footer.dart' show ArcaneHtmlFooter;
export 'component/html/header.dart' hide ArcaneHeader;
export 'component/html/heading.dart';
export 'component/html/lists.dart'; // ArcaneBulletList, ArcaneNumberedList (and legacy ArcaneUnorderedList, ArcaneOrderedList)
export 'component/html/main_element.dart';
export 'component/html/nav.dart';
export 'component/html/paragraph.dart';
export 'component/html/quote.dart'; // ArcaneQuote (and legacy ArcaneBlockquote)
export 'component/html/section.dart';
export 'component/html/side_content.dart'; // ArcaneSideContent (and legacy ArcaneAside)
export 'component/html/table.dart';
export 'component/html/arcane_span.dart'; // ArcaneSpan (inline styling)
export 'component/html/svg.dart'; // ArcaneSvg and SVG primitives

// ============================================================================
// Authentication - Service & State
// ============================================================================
export 'service/auth_state.dart';
export 'service/auth_service_export.dart';

// ============================================================================
// Authentication - Provider & Guards
// ============================================================================
export 'provider/auth_provider_export.dart';
export 'provider/auth_guard_export.dart';

// ============================================================================
// Authentication - Components
// ============================================================================
export 'component/auth/login_card.dart';
export 'component/auth/signup_card.dart';
export 'component/auth/forgot_password_card.dart';

// ============================================================================
// Authentication - Social Sign-In Buttons
// ============================================================================
export 'component/button/social_button.dart';

// ============================================================================
// Authentication - Form Components
// ============================================================================
export 'component/form/auth/auth_input.dart';
export 'component/form/auth/auth_button.dart';
export 'component/form/auth/auth_divider.dart';
export 'component/form/auth/auth_social_row.dart';
export 'component/form/auth/auth_form_card.dart';

// ============================================================================
// Authentication - Layout & View
// ============================================================================
export 'component/layout/auth_split_layout.dart';
export 'component/view/auth_branding_panel.dart';

// ============================================================================
// Authentication - Utilities
// ============================================================================
export 'util/auth/password_policy.dart';
