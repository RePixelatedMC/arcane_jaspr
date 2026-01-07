# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [x.x.x] - Unreleased

### Changed

#### Component Consolidation and Folder Reorganization

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

**Icon Button Close Factory**
- Added `ArcaneIconButton.close()` factory constructor
- Removed standalone `ArcaneCloseButton` class

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

### Added

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
