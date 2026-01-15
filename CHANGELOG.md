# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.9.1] - Unreleased

### Fixed

**Browser Scrollbar Styling**
- `ArcaneApp` now injects stylesheet CSS into the document `<head>` using `Document.head()` instead of inside the `#arcane-root` div
- `ArcaneApp` now adds the brightness class (`dark`/`light`) to the `<html>` element using `Document.html()`
- `CssGenerator` now outputs CSS variables on `html.dark`/`html.light` selectors in addition to `.dark`/`.light`, enabling scrollbar pseudo-elements to access theme variables
- Document-level scrollbars now properly inherit theme colors (`--background`, `--primary`) and match the styling of other scrollbars

### Changed

**Redesigned Light Themes for Richer Surfaces**
- `PaletteGenerator` light mode tinting increased for more visible surface contrast:
  - Secondary: 6% darken + 12% primary blend (was 4%/8%)
  - Accent: 10% darken + 18% primary blend (was 6%/12%)
  - Border: 18% darken + 10% primary blend (was 12%/6%)
  - Card: 2% darken + 5% primary blend (was 1%/3%)
  - Muted: 5% darken + 10% primary blend (was 3%/6%)
- `ShadcnTheme` pastel themes now use white backgrounds with richer tinted surfaces:
  - All pastel themes changed from tinted backgrounds to clean white (`0xFFffffff`)
  - Explicit secondary/accent colors provide visible contrast against white
  - Professional aesthetic with clearly distinguishable surface layers
- `CodexTheme` now includes bold, gaming-inspired light surface colors:
  - Each theme (green, red, blue, purple, cyan, pink, orange, rainbow) defines explicit `lightSecondary`, `lightAccent`, and `lightBorder`
  - Light surfaces are intentionally more saturated for gaming aesthetic
  - Example: green theme uses mint surfaces (`0xFFd1fae5`, `0xFFa7f3d0`, `0xFF6ee7b7`)
- `CodexStylesheet.lightSeed` updated to use explicit theme colors instead of auto-derivation

**ArcaneMap Theme Integration**
- `MapStyle` now uses CSS variables by default for theme-aware styling:
  - Default constructor uses `var(--card)`, `var(--muted)`, `var(--border)`, `var(--primary)`, etc.
  - Added `MapStyle.themed` constant (default behavior, uses CSS variables)
  - Existing `MapStyle.dark` and `MapStyle.light` still available with explicit hex colors
- Added `arcaneMapCss` constant with comprehensive styling:
  - **ShadCN (base)**: Clean map styling with theme variable integration
  - Hover effects on regions and location pins
  - Debug tooltip styling using theme colors
  - **Codex (overrides)**: Neon cyberpunk map effects
  - Glowing region hover effects with `drop-shadow`
  - Pulsing pin animation (`arcane-map-pin-pulse`)
  - Neon-styled debug tooltips with text shadows
- Added `data-active="true"` attribute to active regions for CSS targeting

**ArcaneFlexiCards Smooth Animation**
- Redesigned height animation to use CSS Grid `grid-template-rows` technique:
  - `0fr` to `1fr` transition provides smooth, natural height animation
  - No more abrupt "jumping" when long text is revealed
  - Footer animates smoothly alongside text content
- Text no longer "shuffles" during resize:
  - Inner content wrapper with `overflow: hidden` and `min-height: 0`
  - Opacity fades in sync with height animation
- Improved transition timing with `cubic-bezier(0.4, 0, 0.2, 1)` easing
- Non-hovered cards now shrink to `0.8x` when another card is hovered
- Added `.hovered` CSS class for additional styling hooks
- **Codex renderer enhancements**:
  - Icon glows on hover with `box-shadow`
  - Title changes to primary color with text shadow on hover
  - Card background tints toward primary on hover
  - Border glows with neon effect

**Improved TOC and Sidebar Tree Styles**
- `arcaneTocTreeLinesCss` - Complete rewrite with proper tree line visualization:
  - **ShadCN (base)**: Clean, subtle tree lines using `var(--border)` color
  - Added scrollbar styling for `.kb-toc` and `.toc-container` classes
  - Uses `::before` for horizontal branches and `::after` for vertical connectors
  - Proper last-child handling with L-bend effect (vertical line stops at center for last item)
  - Fading tree lines at deeper nesting levels
  - Single-child detection to hide unnecessary tree lines
  - Smaller, more subtle link styling (12px font, refined padding)
  - **Codex (overrides)**: Glowing neon tree lines with `var(--primary)` color
  - Thicker 2px lines with `box-shadow` glow effects
  - Border-left accent on links with glowing active states
  - Monospace font for headers
- `arcaneSidebarTreeStyles` - Complete rewrite matching Codex website patterns:
  - **ShadCN (base)**: Clean tree lines with subtle borders
  - Added `.sidebar-tree` container class support
  - Consistent tree line implementation using `::before`/`::after` pseudo-elements
  - Added collapsible section styles (`.sidebar-details`, `.sidebar-summary`, `.sidebar-chevron`)
  - Added animated chevron icon for expand/collapse
  - Proper `.sidebar-link` styling with hover and active states
  - Fading tree lines at deeper nesting levels
  - **Codex (overrides)**: Cyberpunk glowing tree lines
  - Thicker 2px primary-colored lines with glow effects
  - Border-left accent styling with straight left edges
  - Prominent glow on active states with inset box-shadow
  - Monospace font for section headers and summaries

### Added

**Project Conventions**
- Documented sitemap generation: Use `--sitemap-domain=<domain>` with `jaspr build`
- Documented favicon convention: Place `icon.png` in `web/assets/` directory
- Updated `ArcaneDocsLayout` to use `assets/icon.png` for favicon with apple-touch-icon support

**Documentation Components (migrated from arcane_inkwell)**
- `ArcaneDocsLayout` - Documentation-style layout with fixed header, sidebar, main content, and optional TOC
- `ArcaneToc` - Table of contents component with tree-line visual connectors
- `ArcanePageNav` - Previous/Next page navigation component for documentation
- `TocEntry` and `PageNavItem` data classes for navigation

**Content Utilities**
- `calculateReadingTime()` - Calculate estimated reading time from markdown content
- `ReadingTimeResult` class with minutes, wordCount, and formatted text getter
- `String.readingTime` extension for convenient reading time calculation

**Prose CSS Styles**
- `arcaneProseStyles` - Typography styles for markdown content (headings, paragraphs, lists, links, blockquotes, tables)
- `arcaneProseCodeStyles` - Syntax highlighting for code blocks (light/dark modes with GitHub-inspired colors)
- `arcaneCodeCopyButtonStyles` - Copy button styles for code blocks
- `arcaneCalloutStyles` - Callout/admonition block styles (note, tip, important, warning, caution)
- `arcaneSidebarTreeStyles` - Tree-line navigation styles for sidebars
- `arcaneTocTreeLinesCss` - Tree-line styles for table of contents
- `arcaneAllDocsStyles` - Combined constant with all documentation styles
- `arcaneDocsLayoutResponsiveCss` - Responsive breakpoint styles for docs layout
- `arcanePageNavCss` - Hover styles for page navigation

## [2.9.0] - Unreleased

### Added

**ArcaneColor Type-Safe Theme Colors**
- Added `ArcaneColor` enum with all theme color references (primary, accent, success, warning, info, destructive, etc.)
- `.css` getter returns CSS variable reference (e.g., `var(--accent)`)
- `.withOpacity(double)` returns proper `color-mix()` syntax for transparency
- Added `GradientStop` class for gradient color stops with optional positions
- Added `GradientBuilder` class for fluent gradient building API
- Added `List<ArcaneColor>.toGradient()` extension for easy gradient creation

**ArcaneGradientText Enhancements**
- Added `.success` constructor (success to accent gradient)
- Added `.warning` constructor (warning to destructive gradient)
- Added `.error` constructor (destructive to warning gradient)
- Added `.rainbow` constructor (multi-color theme gradient)
- Added `.fromColors()` factory for `List<ArcaneColor>` with even distribution
- Added `.custom()` constructor for `List<GradientStop>` with custom positions
- Added `GradientTextProps.buildGradient()` method for unified gradient building

**ArcaneButton CTA Enhancements**
- Added `ButtonVariant.accent` for gradient background buttons (green-to-cyan in Codex, primary-to-secondary in ShadCN)
- Added `href` property to render button as anchor tag (`<a>`) for navigation CTAs
- Added `showArrow` property to display arrow indicator after label
- Added `ArcaneButton.accent()` named constructor
- Updated both Codex and ShadCN renderers

**CodexStylesheet Accent Variables**
- Added `--codex-accent-gradient` CSS variable for gradient backgrounds
- Added `--codex-accent-glow-medium` CSS variable for button glows
- Added `--codex-accent-border` CSS variable for accent-colored borders
- Variables defined for all accent presets (green, red, blue, purple)

**ArcaneCatImage Component**
- Added `ArcaneCatImage` component for placeholder/testing images using cataas.com API
- Supports `seed` parameter for consistent random cats
- Named constructors: `.gif()` for animated cats, `.says()` for text overlay, `.lazy()` for lazy loading
- Optional `apiWidth` and `apiHeight` parameters for custom dimensions

**CSS Design Token System**
- Added spacing scale CSS variables (`--arcane-space-0` through `--arcane-space-32`)
- Added font size CSS variables (`--arcane-font-size-xs` through `--arcane-font-size-5xl`)
- Added font weight CSS variables (`--arcane-font-weight-normal`, `medium`, `semibold`, `bold`)
- Added `--arcane-transition-slower` (300ms) for slower animations
- Updated transitions to use `ease` timing function for consistency

**Unified Floating Component**
- Added `ArcaneFloating` component that consolidates Tooltip, Popover, and Hovercard into one
- Named constructors: `.tooltip()`, `.tooltipCustom()`, `.popover()`, `.hovercard()`
- Unified `FloatingProps` with `FloatingTrigger` (hover, click, manual) and `FloatingPosition` (8 positions)

**Unified Separator Component**
- Merged `ArcaneDivider` and `ArcaneSeparator` into single `ArcaneSeparator` component
- Named constructors: `.vertical()`, `.withLabel()`, `.withIcon()`, `.dashed()`, `.subtle()`, `.bold()`
- Combined feature sets: variants (standard/subtle/bold), dashed lines, labels, icons, custom colors
- Unified `SeparatorProps` with `SeparatorVariant` and `SeparatorOrientation` enums

### Changed

**CodexStylesheet API Consistency**
- Renamed `CodexAccent` enum to `CodexTheme` for consistency with `ShadcnTheme`
- Renamed `accent` parameter to `theme` in `CodexStylesheet` constructor
- Migration: `CodexStylesheet(accent: CodexAccent.orange)` -> `CodexStylesheet(theme: CodexTheme.orange)`

**Renderer CSS Variable Migration**
- Migrated 800+ hardcoded style values across 60+ renderer files to use CSS variables
- All `transition` values now use `var(--arcane-transition-*)` variables
- All `border-radius` values now use `var(--arcane-radius-*)` variables
- All `gap` values now use `var(--arcane-space-*)` variables
- All `font-size` values now use `var(--arcane-font-size-*)` variables
- All `font-weight` values now use `var(--arcane-font-weight-*)` variables
- Updated both ShadCN and Codex stylesheets and renderers

### Breaking Changes

**Stylesheet Now Required**
- `ArcaneApp` and `ArcaneWindow` now require the `stylesheet` parameter (previously defaulted to `ShadcnStylesheet`)
- You must now explicitly choose a stylesheet for your app
- No fallback stylesheet behavior - explicit configuration required

### Removed

**Dialog Component Consolidation**
- Removed `ArcaneInputDialog` component - use `ArcaneDialog` with form inputs as children
- Removed `ArcaneItemPicker` component - use `ArcaneDialog` with custom list content
- Removed `InputDialogProps` and `ItemPickerProps` classes
- Removed `inputDialog()` and `itemPicker()` methods from `ComponentRenderers`
- Removed ShadCN and Codex renderer implementations for `inputDialog` and `itemPicker`
- The unified `ArcaneDialog` now handles all dialog use cases through composition

**Divider Component Consolidation**
- Removed `ArcaneDivider` component - use `ArcaneSeparator` with appropriate named constructor
- Removed `ArcaneVerticalDivider` - use `ArcaneSeparator.vertical()`
- Removed `DividerProps` and `DividerVariant`/`DividerOrientation` enums
- Removed `divider()` method from `ComponentRenderers`
- Removed ShadCN and Codex renderer implementations for `divider`
- The unified `ArcaneSeparator` now handles all divider/separator use cases

**Floating Component Consolidation**
- Removed `ArcaneTooltip` component - use `ArcaneFloating.tooltip()`
- Removed `ArcaneTooltipCustom` component - use `ArcaneFloating.tooltipCustom()`
- Removed `ArcaneInfoTooltip` component
- Removed `ArcanePopover` component - use `ArcaneFloating.popover()`
- Removed `ArcaneHovercard` component - use `ArcaneFloating.hovercard()`
- Removed `TooltipProps`, `PopoverProps`, `HovercardProps` classes
- Removed `tooltip()`, `popover()`, `hovercard()` methods from `ComponentRenderers`
- Removed ShadCN and Codex renderer implementations for `tooltip`, `popover`, `hovercard`
- The unified `ArcaneFloating` now handles all floating UI patterns

### Fixed

**Theme Color Consistency**
- Fixed hardcoded HSL colors across 20+ component files to use theme CSS variables
- Replaced `hsl(142 76% 36%)` with `var(--success)`
- Replaced `hsl(38 92% 50%)` with `var(--warning)`
- Replaced `hsl(199 89% 48%)` with `var(--info)`
- Fixed invalid `hsl(var(--x) / opacity)` CSS syntax to use `color-mix(in srgb, var(--x) X%, transparent)` pattern
- Fixed `ArcaneGradientText.brand` to use `var(--primary)` to `var(--accent)` instead of info color

## [2.8.0] - Unreleased

### Changed

#### Component Consolidation and Folder Reorganization, and more! Check out the docs for new usage

**Social Sign-In Buttons Consolidated (11 -> 1)**
- Merged 10 individual social button files into single `SocialSignInButton` component
- New factory constructors: `.google()`, `.github()`, `.apple()`, `.microsoft()`, `.discord()`, `.twitter()`, `.facebook()`, `.linkedin()`, `.slack()`, `.gitlab()`
- Added `SocialProvider` enum for programmatic provider selection

**Menu System Unified**
- Created shared `ArcaneMenuItem` class in `core/props/menu_item_props.dart`
- Unified menu items across `ArcaneDropdownMenu`, `ArcaneContextMenu`, and `ArcaneMenubar`
- Removed redundant `DropdownItemProps`, `ContextMenuItemProps`, and `MenubarItemProps`

**Dialog Components Consolidated**
- Merged `ArcaneEmailDialog` and `ArcaneTextInputDialog` into `ArcaneInputDialog`
- New factory constructors: `.text()`, `.email()`, `.password()`, `.multiline()`, `.number()`
- Added `InputDialogType` enum

### Removed

**Icon Button Close Factory**
- Removed `ArcaneIconButton.close()` factory constructor (redundant - use `ArcaneIconButton(icon: ArcaneIcon.x())` instead)

**Dropdown Menu Component**
- Removed `ArcaneDropdownMenu` from navigation (consolidated with Select functionality)

**Search Components Consolidated**
- Merged `ArcaneSearchBar` into `ArcaneSearch`
- Added `ArcaneSearch.withResults()` factory for dropdown results
- Added `SearchResult` class (replacing `ArcaneSearchResult`)
- Extended `SearchProps` with results, resultsId, showDropdown, dropdownMaxHeight, width

**Slider Components Consolidated**
- Merged `ArcaneRangeSlider` into `ArcaneSlider`
- Added `ArcaneSlider.range()` factory for range selection with two handles
- Extended `SliderProps` with isRange, rangeMin, rangeMax, onRangeChanged
- `ArcaneRangeSlider` is now a deprecated typedef pointing to `ArcaneSlider.range()`

**DateTime Picker Components Consolidated**
- Merged `ArcaneDatePicker` and `ArcaneTimePicker` into `ArcaneDateTimePicker`
- New factory constructors: `.date()` for date-only, `.time()` for time-only
- Default constructor provides combined date and time picker
- Added `DateTimePickerMode` enum (date, time, dateTime)
- Added `DateTimePickerSize` enum (sm, md, lg)

**Folder Reorganization**
- New `component/menu/` folder: `dropdown_menu.dart`, `context_menu.dart`, `menubar.dart`
- New `component/card/` folder: `card.dart`, `feature_card.dart`, `pricing_card.dart`, `testimonial_card.dart`, `integration_card.dart`, `stat_card.dart`, `author_card.dart`, `surface_card.dart`, `flexi_cards.dart`, `card_section.dart`
- New `component/data/` folder: `data_table.dart`, `static_table.dart`, `tree_view.dart`, `timeline.dart`, `tracker.dart`
- Moved `disclosure.dart` and `expander.dart` to `component/interactive/`

### Removed

- Individual social button files (`google_button.dart`, `github_button.dart`, etc.)
- `ArcaneEmailDialog` (use `ArcaneInputDialog.email()`)
- `ArcaneTextInputDialog` (use `ArcaneInputDialog.text()`)
- `ArcaneCloseButton` (use `ArcaneIconButton.close()`)
- Duplicate `ArcaneAccordion` from `expander.dart` (keep version in `interactive/accordion.dart`)
- Duplicate `ArcaneProgressBar` and `ArcaneLoader` from `alert_banner.dart`
- `ArcaneCtaLink` (use `ArcaneButton` with `href` parameter or `ArcaneLink` for links)
- `ArcaneSearchBar` (consolidated into `ArcaneSearch` - use `ArcaneSearch.withResults()` for dropdown results)
- `ArcaneRangeSlider` (consolidated into `ArcaneSlider` - use `ArcaneSlider.range()` for range mode)
- `ArcaneDatePicker` (consolidated into `ArcaneDateTimePicker` - use `.date()` factory)
- `ArcaneTimePicker` (consolidated into `ArcaneDateTimePicker` - use `.time()` factory)

### Added

**Map Debug Mode**
- Added `debugMode` parameter to `ArcaneWorldMap` and `ArcaneUSAMap`
- When enabled, hovering anywhere on the map shows lat/lng and SVG coordinates in a tooltip
- Clicking copies the coordinates to clipboard for easy location calibration
- Added `svgToLatLng()` reverse conversion method to `ArcaneUSAMapProjection`

**Sidebar Enhancement**
- `ArcaneSidebarSubMenu` - Collapsible nested submenu items
- `ArcaneSidebarExpanded` - Content visible only when sidebar is expanded
- `ArcaneSidebarCollapsed` - Content visible only when sidebar is collapsed
- `ArcaneSidebarSeparator` - Visual separator between groups
- Added `href` and `tooltip` properties to `ArcaneSidebarItem`

#### Architecture Migration Complete
The renderer-based architecture is now complete with **204 renderer methods** in the interface and **123 component files** using the renderer pattern. All visual components now delegate to `context.renderers.xxx()` for stylesheet-specific rendering.

**One line changes your entire app's design:**
```dart
ArcaneApp(
  styleSheet: ShadcnStyleSheet(),  // or CodexStyleSheet()
  child: MyApp(),
)
```

#### Convenience Factory Methods for SlotCounterProps
Added factory constructors to `SlotCounterProps` for common use cases:
- `SlotCounterProps.latency()` - Pre-configured for latency/ping displays with `ms` suffix
- `SlotCounterProps.percentage()` - Pre-configured for percentage displays with `%` suffix
- `SlotCounterProps.currency()` - Pre-configured for currency displays with `$` prefix

### Changed

#### Layout Components Migrated to Renderer Architecture
All layout components now delegate to the renderer system:

| Component | Renderer Method | Props Class |
|-----------|-----------------|-------------|
| `ArcaneScrollRail` | `context.renderers.scrollRail()` | `ScrollRailProps` |
| `ArcaneScrollRailLayout` | `context.renderers.scrollRailLayout()` | `ScrollRailLayoutProps` |
| `ArcaneResizable` | `context.renderers.resizable()` | `ResizableProps` |
| `ArcaneRadioCards` | `context.renderers.radioCards()` | `RadioCardsProps` |
| `ArcaneChip` | `context.renderers.arcaneChip()` | `ArcaneChipProps` |
| `ArcaneFlow` | `context.renderers.flow()` | `FlowProps` |
| `ArcaneRow` | `context.renderers.flow()` | `FlowProps` |
| `ArcaneColumn` | `context.renderers.flow()` | `FlowProps` |

#### Naming Clarifications
- `ChipGroupProps` renamed to `SelectableChipGroupProps` to avoid conflict with existing `ChipGroupProps`
- `ArcaneResizable` factory constructors (`sidebarLayout`, `splitView`) now return proper `ArcaneResizable` instances

### Fixed

#### Codex Demo API Corrections
- `ArcaneFlexiCardItem` corrected to `FlexiCardItem` (class was renamed)
- `ArcanePre` corrected to `ArcaneCodeBlock` (legacy name removed)
- `CalloutStyle` corrected to `CalloutVariant` (enum renamed)
- `SlotCounterColor` usage in demos now uses correct enum type
- `ArcaneSlotCounterRow.counters` now correctly uses `List<SlotCounterProps>` instead of component list

### Removed

#### Dead Code Cleanup
- Removed unused `Arcane` class from `lib/util/arcane.dart` (had stale references to old theme system)
- Removed empty `lib/stylesheets/codex/` directory (was just a placeholder)
- Removed hidden name warnings in `arcane_jaspr.dart` for non-existent exports

#### Old Token System (Fully Removed)
The legacy token system has been completely removed. Components now use CSS variables directly.

**Deleted Files:**
- `lib/util/tokens/tokens.dart` - Old `ArcaneColors`, `ArcaneSpacing`, `ArcaneTypography`, `ArcaneRadius`, `ArcaneEffects`, `ArcaneLayout`, `ArcaneZIndex` classes
- `lib/util/tokens/style_presets.dart` - Old `ButtonStyle`, `InputStyle`, `CardStyle`, etc.
- `lib/util/tokens/common_styles.dart` - Old common style maps
- `lib/util/tokens/index.dart` - Token barrel export
- `lib/util/tokens/styles/` - All old style token files
- `lib/util/tools/styles.dart` - Old `ArcaneStyles` helper class
- `lib/util/tokens/` directory - Completely removed
- `lib/util/tools/` directory - Completely removed

**Updated Style Type Files:**
All enum-based style types now use direct CSS values instead of token references:
- `lib/util/style_types/borders.dart` - Direct CSS variables (`var(--border)`, etc.)
- `lib/util/style_types/colors.dart` - Direct CSS variables (`var(--foreground)`, etc.)
- `lib/util/style_types/effects.dart` - Direct CSS values for shadows, transitions
- `lib/util/style_types/layout.dart` - Direct pixel/string values for z-index, max-width
- `lib/util/style_types/spacing.dart` - Direct pixel values for spacing
- `lib/util/style_types/typography.dart` - Direct rem values for font sizes
