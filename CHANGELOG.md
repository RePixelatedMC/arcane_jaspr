# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [x.x.x] - Unreleased

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

---

## [2.7.1] - Renderer Architecture Expansion

### Added

#### Renderer-Based Component Architecture (TIER 6-8)

**TIER 6 - ShadCN Primitives:**
- `CalendarProps` with `ShadcnCalendar` renderer for date selection
- `DatePickerProps` with `ShadcnDatePicker` renderer for date input with dropdown
- `LoaderProps`, `LoadingOverlayProps` with `ShadcnLoader` renderer for loading states
- `OtpInputProps` with `ShadcnOtpInput` renderer for one-time password input
- `SelectProps` with `ShadcnSelect` renderer for dropdown selection
- `ContextMenuProps` with `ShadcnContextMenu` renderer for right-click menus
- `HovercardProps` with `ShadcnHovercard` renderer for hover-triggered cards
- `ToggleGroupProps` with `ShadcnToggleGroup` renderer for segmented controls
- `MenubarProps` with `ShadcnMenubar` renderer for application menu bars

**TIER 7 - Input Components:**
- `NumberInputProps` with `ShadcnNumberInput` renderer - increment/decrement controls
- `ColorInputProps` with `ShadcnColorInput` renderer - swatch preview and hex input
- `SearchProps` with `ShadcnSearch` renderer - icon, loading state, clear button
- `FABProps` with `ShadcnFAB` renderer - floating action button with variants
- `CycleButtonProps` with `ShadcnCycleButton` renderer - cycling through options
- `ToggleButtonProps` with `ShadcnToggleButton` renderer - on/off toggle states

**TIER 8 - Layout Components:**
- `ScrollRailProps`, `ScrollRailLayoutProps` - sticky scrollable sidebar rail with scroll persistence
- `ResizableProps`, `ResizablePanelData` - resizable panel groups with draggable dividers
- `RadioCardsProps`, `RadioCardItemData` - selectable card groups
- `SelectableChipGroupProps`, `ArcaneChipProps` - selection chip containers
- `FlowProps` - unified props for `ArcaneFlow`, `ArcaneRow`, `ArcaneColumn`, `ArcaneSpacer`, `ArcaneCenter`, `ArcaneExpanded`, `ArcanePadding`, `ArcaneSizedBox`

#### Additional Component Renderers
- `ChipProps`, `ChipGroupProps` with `ShadcnChip` renderer - tags and labels with removable option
- `KbdProps` with `ShadcnKbd` renderer - keyboard shortcut display
- `ThemeToggleProps`, `ThemeToggleSimpleProps` with theme toggle renderers

#### CSS Variable Namespace Unification
`ShadcnStylesheet` now includes comprehensive `--arcane-xxx` CSS variable aliases ensuring that components using `ArcaneColors` tokens work consistently with the new renderer-based stylesheet system:

**Core Color Aliases:**
- `--arcane-background`, `--arcane-foreground`, `--arcane-card`, `--arcane-surface`
- `--arcane-primary`, `--arcane-secondary`, `--arcane-accent`
- `--arcane-muted`, `--arcane-destructive`

**RGB Channel Variables:**
- `--arcane-background-rgb`, `--arcane-foreground-rgb`, `--arcane-primary-rgb`, etc.
- Enables `rgba()` compositing with CSS variables

**Semantic Status Colors:**
- `--arcane-success`, `--arcane-warning`, `--arcane-info` with `-foreground` variants
- Container variants: `--arcane-success-container`, etc.

**Typography Variables:**
- `--arcane-font-sans`, `--arcane-font-heading`, `--arcane-font-mono`
- Letter spacing: `--arcane-letter-spacing`

**Radius Tokens:**
- `--arcane-radius-xs` through `--arcane-radius-2xl`, `--arcane-radius-full`
- Component-specific: `--arcane-interactive-radius`, `--arcane-container-radius`, `--arcane-input-radius`

**Shadow Tokens:**
- `--arcane-shadow-xs` through `--arcane-shadow-xl`
- Component-specific shadow variables

**Transition Tokens:**
- `--arcane-transition-fast`, `--arcane-transition`, `--arcane-transition-slow`
- Easing: `--arcane-style-easing`, `--arcane-style-easing-bounce`

This ensures theming consistency whether components use the new ShadCN renderer variables (`var(--foreground)`) or legacy ArcaneColors tokens (`var(--arcane-foreground)`).

#### Component Structure Token System
Stylesheets now control ALL component structural properties, enabling radically different design languages:

**Semantic Token Groups:**

| Group | Purpose | Examples |
|-------|---------|----------|
| `InteractiveTokens` | Buttons, toggles, clickable elements | shape, hover effects, gradients |
| `ContainerTokens` | Cards, dialogs, sheets | shape, shadows, backdrop blur |
| `InputTokens` | Text inputs, selects, form fields | shape, borders, focus styles |
| `IndicatorTokens` | Checkboxes, radios, toggle switches | shapes, colors, animations |

**Component Shape System:**
- `ComponentShape` enum: `sharp`, `rounded`, `softRounded`, `pill`, `circle`, `custom`
- Each component type can have a different shape per stylesheet
- Radio buttons can be circles, rounded-squares, or sharp-squares
- Toggle thumbs can be circles or rounded-squares

**New CSS Variables for Component Structure:**
```css
/* Interactive elements (buttons) */
--arcane-interactive-radius
--arcane-interactive-border-width
--arcane-interactive-hover-shadow
--arcane-interactive-focus-ring-width
--arcane-interactive-focus-ring-offset

/* Containers (cards, dialogs) */
--arcane-container-radius
--arcane-container-shadow
--arcane-container-border-width
--arcane-container-backdrop-blur

/* Input fields */
--arcane-input-radius
--arcane-input-border-width
--arcane-input-focus-shadow

/* Indicators (checkbox, radio, toggle) */
--arcane-indicator-checkbox-radius
--arcane-indicator-radio-radius
--arcane-indicator-toggle-track-radius
--arcane-indicator-toggle-thumb-radius
--arcane-toggle-thumb-on / --arcane-toggle-thumb-off
--arcane-toggle-track-on / --arcane-toggle-track-off
```

**Stylesheet Differences:**

| Property | Codex | ShadCN |
|----------|-------|--------|
| Corner style | Sharp corners | Soft rounded corners |
| Toggle thumb | Rounded-square | Circular |
| Thumb ON color | Light (foreground) | Background-colored |
| Glass effects | Enabled | Disabled |
| Shadows | Rich, dramatic | Minimal, subtle |

#### Stylesheet Folder Reorganization
Stylesheets are now organized into separate folders for better maintainability:
```
lib/util/appearance/stylesheets/
  codex/
    codex_style.dart      # Gaming aesthetic with custom fonts
  shadcn/
    shadcn_style.dart     # Minimal shadcn/ui style
    shadcn_presets.dart   # Color presets (Neutral, Stone, Zinc, Gray, Slate)
  stylesheets.dart        # Barrel export
```

### Changed

#### Components Updated to Use Stylesheet-Reactive Tokens

| Component | Token Used | CSS Variable |
|-----------|------------|--------------|
| Toggle Switch | Track/thumb shapes and colors | `--arcane-indicator-toggle-*` |
| Radio Group | Radio circle shape | `--arcane-indicator-radio-radius` |
| Checkbox | Checkbox shape | `--arcane-indicator-checkbox-radius` |
| Buttons | Border-radius | `--arcane-interactive-radius` |
| Icon Buttons | Border-radius | `--arcane-interactive-radius` |
| Cards | Border-radius | `--arcane-container-radius` |
| Dialogs/Sheets | Border-radius | `--arcane-container-radius` |
| Text Inputs | Border-radius | `--arcane-input-radius` |

#### Input Component API Updates
- `ArcaneTextInput`: Removed old `InputStyle` and `InputSizeStyle` parameters, now uses `TextInputSize` enum
- `ArcaneTextArea`: Removed `style` parameter, now uses CSS variables directly
- `ArcaneSelect`: Replaced `InputSizeStyle` with `TextInputSize`, uses CSS variables directly
- `ArcaneCycleButton`: Changed from `ButtonStyle` to `CycleButtonVariant`, removed `ArcaneCycleOption` (now `CycleOption`)
- `ArcaneFAB`: Changed from `FABStyle` to `FABVariant`

### Breaking Changes

#### Unified Stylesheet System
**BREAKING**: Complete redesign of the theming system. `ArcaneStyleSheet` is now a COMPLETE design system containing ALL colors, typography, layout, and component defaults.

**Migration:**
```dart
// OLD (no longer works)
ArcaneApp(
  theme: ArcaneTheme.green,
  child: MyApp(),
)

// NEW
ArcaneApp(
  theme: ArcaneTheme.codex,  // or ArcaneTheme.shadcn
  child: MyApp(),
)
```

**What Changed:**
- `ThemeSchema` and all color theme presets (`ArcaneTheme.red`, `.green`, `.blue`, etc.) are **REMOVED**
- Stylesheets now define **ALL 38 colors** (19 light mode + 19 dark mode)
- Font loading (Google Fonts or custom @font-face) is built into the stylesheet
- Only two theme presets: `ArcaneTheme.codex` (default) and `ArcaneTheme.shadcn`

**Stylesheet Features:**

| Feature | CodexStyleSheet | ShadcnStyleSheet |
|---------|-----------------|------------------|
| Design style | Gaming aesthetic | Minimal, modern |
| Fonts | Custom (Akzidenz-GroteskPro, ITCAvantGardeStd) | Inter via Google Fonts |
| Accent color | Emerald | Neutral (configurable via presets) |
| Glass effects | Enabled | Disabled |
| Shadows | Rich, dramatic (0.15-0.25 opacity) | Minimal (border-focused) |
| Corner style | Sharp (technical look) | Rounded (friendly look) |

**Color System:**
Each stylesheet defines:
- **Core colors**: background, foreground, card, popover, primary, secondary, muted, accent, destructive, border, input, ring
- **Semantic colors**: success, warning, info (with foreground variants)
- **Chart colors**: 5 colors per mode for data visualization
- **Sidebar colors**: separate palette for sidebar UI

**Typography System:**
- `fontSans` - Body text font stack
- `fontHeading` - Heading font stack
- `fontMono` - Monospace/code font stack
- `googleFontUrl` - Google Fonts URL (ShadcnStyleSheet uses Inter)
- `fontFaceCss` - Custom @font-face CSS (CodexStyleSheet uses custom fonts)

**Creating Custom Stylesheets:**
```dart
class MyStyleSheet extends ArcaneStyleSheet {
  const MyStyleSheet();

  @override String get id => 'my-style';
  @override String get name => 'My Style';

  // Override ALL color properties for light and dark modes
  @override Color get backgroundLight => const Color(0xFFFFFFFF);
  @override Color get backgroundDark => const Color(0xFF000000);
  // ... 36 more color properties

  // Override typography
  @override String get fontSans => "'My Font', sans-serif";
  @override String? get googleFontUrl => 'https://fonts.googleapis.com/...';
}
```

---

## [2.7.0] - Major Feature Release

### Added

#### New Input Components

**ArcaneTimePicker** - Time selection component with hour/minute columns
- 12-hour and 24-hour format support
- Configurable minute intervals (1, 5, 15, 30)
- AM/PM period selection for 12-hour format
- Size variants: `sm`, `md`, `lg`
- `TimeOfDay` class for value representation

```dart
ArcaneTimePicker(
  value: TimeOfDay(hour: 14, minute: 30),
  use24HourFormat: false,
  minuteInterval: 15,
  onChanged: (time) => print('${time.hour}:${time.minute}'),
)
```

**ArcaneFormattedInput** - Patterned input for structured data
- Pre-built patterns: `.date()`, `.time()`, `.phone()`, `.creditCard()`
- Auto-advance between segments when filled
- Backspace navigation between segments
- Arrow key navigation support

```dart
ArcaneFormattedInput.date(
  initialMonth: '01',
  initialDay: '15',
  initialYear: '2024',
  onChanged: (value) => print(value.combinedValue),
)
```

#### New Layout Components

**ArcaneSheet** - Modal sheet sliding from screen edges
- Positions: `bottom`, `top`, `end`, `start`
- Configurable width/height and max constraints
- Backdrop dismiss option
- Close button with title support

**ArcaneActionSheet** - Mobile-style action sheet
- Destructive item styling
- Cancel button at bottom
- Full-width on mobile

```dart
ArcaneSheet(
  position: SheetPosition.bottom,
  title: 'Options',
  child: content,
  onClose: () => closeSheet(),
)
```

#### New View Components

**ArcaneSwitcher** - Animated content transition
- Transition directions: `up`, `down`, `left`, `right`, `fade`
- `ArcaneKeyedSwitcher<T>` for key-based switching
- `ArcaneIndexedStack` for state-preserving indexed children

```dart
ArcaneSwitcher(
  direction: SwitcherDirection.up,
  child: currentView,
)
```

**ArcaneSurfaceCard** - Card with visual effects
- Effects: `none`, `blur`, `frosted`, `gradient`, `glass`, `ice`
- Customizable blur intensity, opacity, and blend color
- `ArcaneThumbHashCard` for placeholder backgrounds

```dart
ArcaneSurfaceCard(
  effect: SurfaceEffect.frosted,
  blurIntensity: 12,
  child: content,
)
```

**ArcaneTracker** - GitHub-style contribution/status grid
- Grid-based tracker with severity levels (fine, warning, critical, unknown)
- Configurable columns, cell size, and gap
- Optional legend display
- Cell click callbacks

**ArcaneUptimeTracker** - Uptime percentage bar chart
- Percentage bars with color coding
- Average uptime calculation
- Hover tooltips with date/percentage

```dart
ArcaneTracker.weekly(
  data: List.generate(90, (i) => TrackerData(
    level: TrackerLevel.fine,
    tooltip: 'Day ${i + 1}: 100% uptime',
  )),
)
```

**ArcaneAvatarBadge** - Status indicator badge for avatars
- Status types: `online`, `offline`, `busy`, `away`, `count`
- Positions: `topLeft`, `topRight`, `bottomLeft`, `bottomRight`
- Pulse animation option

```dart
ArcaneAvatarBadge(
  status: AvatarBadgeStatus.online,
  position: AvatarBadgePosition.bottomRight,
  pulse: true,
  child: ArcaneAvatar(...),
)
```

#### New Navigation Components

**ArcaneDotIndicator** - Carousel/page indicator dots
- Interactive mode with click callbacks
- Customizable dot size, active/inactive colors
- Gap spacing control

**ArcaneStepIndicator** - Step-based progress indicator
- Vertical and horizontal orientations
- Step labels and descriptions
- Clickable navigation for completed steps
- Size variants

```dart
ArcaneDotIndicator(
  count: 5,
  currentIndex: 2,
  interactive: true,
  onDotTap: (index) => goToPage(index),
)
```

#### New Dialog Components

**ArcaneEmailDialog** - Email input dialog with validation
- Work email requirement option
- Blocked domains configuration
- Real-time validation feedback

**ArcaneTimeDialog** - Time picker dialog
- Column-based hour/minute selection
- 12/24 hour format support
- Visual time display

**ArcaneItemPicker** - General-purpose item picker dialog
- Single and multi-select modes
- Search/filter support
- Immediate or confirm-based selection

```dart
ArcaneItemPicker<String>(
  title: 'Select Country',
  items: ['USA', 'Canada', 'UK'],
  itemBuilder: (item) => text(item),
  onSelect: (country) => handleSelection(country),
)
```

#### New Screen Components

**ArcaneChatScreen** - Full chat interface
- Chat styles: `bubbles` (WhatsApp) and `tiles` (Slack)
- Message input with auto-resize textarea
- Timestamp and avatar display
- Abstract interfaces for custom message/user types

```dart
ArcaneChatScreen(
  style: ChatStyle.bubbles,
  provider: myChatProvider,
  currentUserId: 'user123',
)
```

#### JavaScript Fallback Scripts for Static Sites

New JavaScript fallback scripts for static site support (works without Jaspr hydration):
- `TimePickerScripts` - Time picker column selection
- `FormattedInputScripts` - Auto-advance and navigation between segments
- `SheetScripts` - Sheet open/close and backdrop dismiss
- `DotIndicatorScripts` - Dot and step indicator interactions
- `TrackerScripts` - Tracker cell hover and click
- `ChatScripts` - Chat input resize, send, and scroll
- `EmailDialogScripts` - Email validation and submission
- `TimeDialogScripts` - Time selection in dialogs
- `ItemPickerScripts` - Search filtering and item selection

#### Theme Enhancement: `uniformBackgrounds`

New theme option for sleek, uniform dark designs without section contrast:

- `uniformBackgrounds` boolean field on `ArcaneTheme` (default: `false`)
- When enabled, `--arcane-background-secondary` and `--arcane-background-tertiary` equal the base background
- Perfect for OLED/pure-black design aesthetics

```dart
ArcaneApp(
  theme: ArcaneTheme.oledGreen.copyWith(
    themeMode: ThemeMode.dark,
    uniformBackgrounds: true,
  ),
  child: ...
)
```

#### New Tokens and Components

**ArcaneColors.accentGradient** - Standard gradient token:
```dart
ArcaneColors.accentGradient
// Returns: 'linear-gradient(135deg, var(--arcane-accent) 0%, var(--arcane-secondary) 100%)'
```

**ArcaneCtaLink** - Call-to-action link buttons:
- `ArcaneCtaLink.primary()` - Solid accent background
- `ArcaneCtaLink.secondary()` - Outline/border style
- `ArcaneCtaLink.ghost()` - Text-only style
- `ArcaneCtaLink.accent()` - Gradient background
- Sizes: `CtaLinkSize.sm`, `md`, `lg`
- `showArrow` parameter for arrow indicator

```dart
ArcaneCtaLink.primary(
  label: 'Get Started',
  href: '/signup',
  showArrow: true,
  size: CtaLinkSize.lg,
)
```

**ArcaneSectionHeader** - Reusable section headers:
- Uppercase accent label
- Large heading text
- Muted description
- Alignment options: `left`, `center`, `right`

```dart
ArcaneSectionHeader(
  label: 'Features',
  heading: 'Why Choose Us',
  description: 'Discover what makes us different.',
  align: SectionHeaderAlign.center,
)
```

**ArcaneStatusBadge** - Status indicator badges with pulse animation:
- `ArcaneStatusBadge.success()` - Green, operational
- `ArcaneStatusBadge.warning()` - Yellow, degraded
- `ArcaneStatusBadge.error()` - Red, down
- `ArcaneStatusBadge.info()` - Blue, informational
- `ArcaneStatusBadge.offline()` - Gray, offline
- Configurable glow and pulse effects
- Size variants: `sm`, `md`, `lg`

```dart
ArcaneStatusBadge.success('All Systems Operational')
```

**ArcaneFadeEdge** - Gradient fade overlays for carousels:
- Directions: `.left()`, `.right()`, `.top()`, `.bottom()`
- Customizable color, width/height, and z-index

```dart
Stack([
  ScrollContent(...),
  ArcaneFadeEdge.left(color: '#09090b'),
  ArcaneFadeEdge.right(color: '#09090b'),
])
```

**ArcaneMarquee** - Infinite scrolling marquee/carousel:
- Automatic content duplication for seamless looping
- Configurable speed via `duration`
- Optional fade edges
- Pause on hover support
- `ArcaneMarqueeReverse` for opposite direction

```dart
ArcaneMarquee(
  children: [
    for (final item in items) ItemCard(item),
  ],
  duration: '30s',
  showFadeEdges: true,
  pauseOnHover: true,
)
```

**ArcaneFooterColumn** - Footer columns with title and link lists:
- `ArcaneFooterColumn` - Column with title and `FooterLink` items
- `ArcaneFooterBrandColumn` - Brand section with logo, description, and optional bottom content

```dart
ArcaneFooterColumn(
  title: 'Resources',
  links: [
    FooterLink(label: 'Documentation', href: '/docs'),
    FooterLink(label: 'API Reference', href: '/api'),
  ],
)

ArcaneFooterBrandColumn(
  logo: MyLogo(),
  description: 'Premium game server hosting.',
  bottomContent: ArcaneStatusBadge.success('All Systems Operational'),
)
```

**ArcaneStatDisplay** - Metric/stat display for trust indicators:
- `ArcaneStatDisplay.accent()` - Accent-colored value
- `ArcaneStatDisplay.brand()` - Brand-colored value
- `ArcaneStatRow` - Container for multiple stats
- Layouts: `vertical` (default), `horizontal`

```dart
ArcaneStatRow(
  stats: [
    ArcaneStatDisplay(value: '99.9%', label: 'Uptime SLA'),
    ArcaneStatDisplay(value: '10K+', label: 'Active Servers'),
    ArcaneStatDisplay(value: '<60s', label: 'Deploy Time'),
  ],
)
```

**ArcaneAuthorCard** - Author attribution card:
- Size variants: `sm`, `md`, `lg`
- Supports avatar URL or initials fallback
- Customizable colors

```dart
ArcaneAuthorCard(
  avatarUrl: 'https://example.com/avatar.jpg',
  name: 'John Doe',
  role: 'Software Engineer',
  size: AuthorCardSize.md,
)
```

**ArcaneCodeWindow** - Code display with macOS-style window chrome:
- `ArcaneCodeWindow` - Full window with header and code
- `ArcaneCodeWindow.terminal()` - Terminal style with green text
- Styles: `dark`, `light`, `terminal`

```dart
ArcaneCodeWindow(
  title: 'main.dart',
  code: '''
void main() {
  print('Hello, World!');
}
''',
)
```

**ArcaneCheckList** - Lists with checkmark icons:
- `ArcaneCheckItem` - Single item with icon and text
- `ArcaneCheckList` - List of check items
- `ArcaneCheckList.brand()` - Brand/accent colored icons
- `ArcaneCheckList.success()` - Success/green colored icons
- `ArcaneFeatureRow` - Feature row with included/excluded state
- Icon styles: `check`, `bullet`, `arrow`, `plus`, `star`

```dart
ArcaneCheckList.brand(
  items: [
    'Shared models across web and server',
    'Type-safe API calls',
    'Hot reload in development',
  ],
)

ArcaneFeatureRow(
  feature: 'Unlimited API calls',
  included: true,
)
```

#### Map Components

**ArcaneUSAMap** - Interactive SVG map of the United States:
- Interactive state hover and click with `onStateTap` and `onStateHover` callbacks
- Location pins with tooltips via `ArcaneUSAMapLocation` data model
- State highlighting with `activeStates` set
- Style presets: `standard`, `subtle`, `prominent`
- Full customization via `ArcaneUSAMapStyle`

```dart
ArcaneUSAMap(
  locations: [
    ArcaneUSAMapLocation(
      id: 'nyc',
      name: 'New York City',
      latitude: 40.7128,
      longitude: -74.0060,
      code: 'NYC',
      state: 'NY',
    ),
  ],
  activeStates: {'CA', 'TX', 'NY'},
  onStateTap: (stateCode) => print('Tapped $stateCode'),
  onLocationTap: (location) => print('Tapped ${location.name}'),
)
```

#### ShadCN Color Presets

Added `ShadcnColorPreset` system for selecting different gray scale palettes. ShadCN supports five gray scale options matching the official ui.shadcn.com theming:

| Preset | Description |
|--------|-------------|
| `neutral` | Pure grayscale with no color tint (default) |
| `stone` | Warm gray with yellow/brown undertones |
| `zinc` | Cool gray with purple undertones |
| `gray` | Balanced gray with slight blue undertones |
| `slate` | Blue-tinted gray |

All colors use oklch color space directly from the Tailwind CSS v4 palette.

```dart
// Default (Neutral)
ArcaneApp(
  theme: ArcaneTheme(styleSheet: ShadcnStyleSheet()),
  child: MyApp(),
)

// Zinc preset (cool gray with purple tint)
ArcaneApp(
  theme: ArcaneTheme(
    styleSheet: ShadcnStyleSheet(colorPreset: ShadcnColorPreset.zinc),
  ),
  child: MyApp(),
)
```

#### Complete Lucide Icons Integration

Full programmatic wrapping of all 1,666 Lucide icons with clean API:

- Added `jaspr_lucide` (^0.21.0) dependency for complete icon library
- `ArcaneIcon` wrapper class provides semantic, discoverable icon methods for ALL icons
- `IconSize` enum for consistent sizing: `xs` (12px), `sm` (16px), `md` (20px), `lg` (24px), `xl` (32px), `xl2` (48px)
- `AIcon` and `AIconSize` aliases in `aliases.dart`
- Generator tool at `tool/generate_icons.dart` for regeneration when jaspr_lucide updates

**Usage:**
```dart
ArcaneIcon.home()                    // Semantic alias for house()
ArcaneIcon.search(size: IconSize.lg) // Large size (24px)
ArcaneIcon.settings()                // Settings gear
ArcaneIcon.user()                    // User profile
ArcaneIcon.edit()                    // Semantic alias for pencil()
ArcaneIcon.close()                   // Semantic alias for x()
ArcaneIcon.delete()                  // Semantic alias for trash2()
// ... all 1,666 Lucide icons available!
```

**Semantic aliases for intuitive naming:**
```dart
ArcaneIcon.home()         // -> house()
ArcaneIcon.edit()         // -> pencil()
ArcaneIcon.close()        // -> x()
ArcaneIcon.delete()       // -> trash2()
ArcaneIcon.success()      // -> circleCheck()
ArcaneIcon.error()        // -> circleX()
ArcaneIcon.warning()      // -> triangleAlert()
ArcaneIcon.loading()      // -> loaderCircle()
ArcaneIcon.grid()         // -> grid3x3()
ArcaneIcon.moreHorizontal() // -> ellipsis()
// ... 70+ semantic aliases
```

**Icons with Dart naming conflicts use suffix:**
```dart
ArcaneIcon.keyIcon()      // Key shape (key is reserved)
ArcaneIcon.mapIcon()      // Map (map is reserved)
ArcaneIcon.factoryIcon()  // Factory building
ArcaneIcon.targetIcon()   // Crosshair target
ArcaneIcon.contrastIcon() // Contrast circle
```

### Changed

#### Automatic Fallback Scripts for Static Sites

`ArcaneApp` now automatically injects JavaScript fallback scripts when Jaspr client hydration is unavailable (e.g., on static sites built with `jaspr build`).

- **Zero configuration**: Just use `ArcaneApp` and interactivity works on static sites
- **Hydration-aware**: Scripts detect if Jaspr hydration is active and skip themselves
- **Comprehensive coverage**: All interactive components (sliders, checkboxes, toggles, inputs, accordions, tabs, etc.)
- **Opt-out available**: Set `includeFallbackScripts: false` if not needed

```dart
// Works automatically on static sites
ArcaneApp(
  theme: ArcaneTheme.green,
  child: MyContent(),
)

// Opt out if using full Jaspr hydration
ArcaneApp(
  includeFallbackScripts: false,
  child: MyContent(),
)
```

**Modular Script Organization:**
- `SliderScripts` - Range sliders
- `InputScripts` - Checkboxes, toggles, color pickers, file uploads, tag inputs, number inputs
- `ButtonScripts` - Buttons, toggle buttons, cycle buttons, theme toggles
- `NavigationScripts` - Tabs, accordions, dropdowns, selectors, tree views, pagination, chips
- `DialogScripts` - Dialogs, toasts, popovers, tooltips, drawers, mobile menus

#### ArcaneTimeline Redesign

Complete redesign of the timeline component with multiple layout options:

- **Layout options**: `vertical` (default), `horizontal`, and `alternating` layouts
- **Size variants**: `sm`, `md`, `lg` sizes
- **Status types**: `complete`, `current`, `pending`, `error`, and `default_`
- **Named constructors**: `ArcaneTimeline.vertical()`, `ArcaneTimeline.horizontal()`, `ArcaneTimeline.alternating()`
- **Custom icons**: Support for custom icons in timeline items
- **Rich content**: Support for custom content in timeline items via `content` property
- **Date display**: Built-in date/time display with `date` property
- **Alias**: Added `ATimeline` alias

```dart
ArcaneTimeline.alternating(
  items: [
    ArcaneTimelineItem(
      title: 'Project Started',
      date: 'Jan 1, 2024',
      status: TimelineStatus.complete,
    ),
    ArcaneTimelineItem(
      title: 'In Progress',
      status: TimelineStatus.current,
    ),
  ],
)
```

#### ArcaneSteps Component

New numbered steps component for multi-step processes (replaces ArcaneStepper):

- **Layout options**: `horizontal` (default) and `vertical` layouts
- **Size variants**: `sm`, `md`, `lg` sizes
- **Auto-status**: Use `currentStep` to automatically set step statuses
- **Clickable navigation**: Click completed steps to navigate back
- **Named constructors**: `ArcaneSteps.horizontal()`, `ArcaneSteps.vertical()`
- **Alias**: Added `ASteps` alias

```dart
ArcaneSteps(
  currentStep: 1,
  onStepTap: (index) => setState(() => _step = index),
  items: [
    ArcaneStepItem(title: 'Account', description: 'Create account'),
    ArcaneStepItem(title: 'Profile', description: 'Set up profile'),
    ArcaneStepItem(title: 'Complete', description: 'Start using app'),
  ],
)
```

#### Component File Refactoring

Split large component files for better maintainability:

| File | Before | After | Extracted |
|------|--------|-------|-----------|
| `toast.dart` | 872 lines | 590 lines | `toast_types.dart`, `toast_manager.dart` |
| `selector.dart` | - | - | `selector_types.dart` (enums, option classes) |
| `slider.dart` | - | - | `slider_types.dart` (SliderSize enum) |
| `sheet.dart` | - | - | `sheet_types.dart` (SheetPosition, SheetSize enums) |
| `mutable_text.dart` | - | - | `mutable_text_types.dart` (trigger/input/style enums) |

All types are re-exported from their parent files, so imports remain unchanged.

### Deprecated

- **ArcaneStepper** - Use `ArcaneSteps` instead
- **ArcaneVerticalStepper** - Use `ArcaneSteps.vertical()` instead

### Fixed

#### Color Contrast Improvements
- Fixed `IconButtonStyle.ghost` using `ArcaneColors.muted` (invisible) - now uses `ArcaneColors.mutedForeground`
- Fixed `ArcaneStyles.bodyText`, `.mutedText`, `.tinyText` using invisible muted color
- These fixes improve visibility of `ArcaneIconButton`, `ArcaneCloseButton`, and text using common style presets

#### Map Component Demo Fixes
- Fixed map pin positioning in demos by correcting location IDs to match pre-calculated SVG coordinates:
  - World map: `tok` -> `tyo`, `sgp` -> `sin`, `sf` -> `sfo`
  - USA map: `sf` -> `sfo`
- Removed unintended `isActive: true` flags that caused pins to appear green

---

## [2.4.1]

### Added

- `ArcaneHovercard` - Hover-triggered floating card with rich interactive content, configurable delays, and multiple positions

### Enhanced

- `ArcanePopover`: Added `openDelay` and `closeDelay` parameters for delayed opening/closing in hover mode

---

## [2.4.0]

### Added

#### New Input Components
- `ArcaneTagInput` - Tag/chip input for collecting multiple values with add/remove functionality
- `ArcaneNumberInput` - Numeric input with increment/decrement controls and prefix/suffix support
- `ArcaneFileUpload` - File upload component with drag-and-drop support, dropzone/button/inline styles, and `helperText` parameter
- `ArcaneColorInput` - Color picker with swatch display, hex input, and preset color swatches

#### New View Components
- `ArcaneCallout` - Inline notice box for tips, warnings, and contextual information (info, success, warning, error, tip, note styles)
- `ArcaneKbd` - Keyboard shortcut display with raised, flat, and outline styles, plus `combo()` factory for key combinations
- `ArcaneMeter` - Progress meter/gauge with bar, gradient, segmented, and circular styles
- `ArcaneAlert` - Inline alert for status messages with subtle, solid, outline, and accent styles
- `ArcaneTreeView` - Hierarchical tree structure with expand/collapse, selection modes, and line/clean/compact styles
- `ArcanePopover` - Floating content panel with click/hover/manual triggers and multiple positions

#### New Navigation Components
- `ArcaneBreadcrumbs` - Navigation breadcrumb trail with chevron, slash, arrow, and dot separators
- `ArcanePagination` - Page navigation controls with outline, filled, ghost, and simple styles

#### New Layout Components
- `ArcaneDrawer` - Slide-in side panel from any screen edge (left, right, top, bottom) with multiple sizes
- `ArcaneTabBar` - Simple inline tab bar for view switching

#### SVG Abstractions
- `ArcaneSvg` - SVG wrapper component with size presets (xs, sm, md, lg, xl, xxl)
- `ArcaneSvgPath` - SVG path element with fill, stroke, and line cap/join attributes
- `ArcaneSvgCircle` - SVG circle element
- `ArcaneSvgRect` - SVG rect element with corner radius support
- `ArcaneSvgLine` - SVG line element
- `ArcaneSvgPolyline` - SVG polyline element
- `ArcaneSvgPolygon` - SVG polygon element
- `ArcaneSvgGroup` - SVG group element with transform support

#### Enhanced ArcaneIcon
Added 30+ new icon factory constructors: `plus`, `minus`, `trash`, `edit`, `download`, `upload`, `user`, `mail`, `heart`, `star`, `lock`, `bell`, `calendar`, `folder`, `file`, `image`, `code`, `terminal`, `link`, `globe`, `info`, `warning`, `error`, `success`, `refresh`, `filter`, `moreHorizontal`, `moreVertical`, `eye`, `eyeOff`, `send`, `loader`

---

## [2.2.0]

### Added

#### Renamed HTML Components (with backwards-compatible aliases)
- `ArcaneCodeBlock` - Renamed from `ArcanePre` for clarity, with `CodeBlockStyle` enum
- `ArcaneQuote` - Renamed from `ArcaneBlockquote`
- `ArcaneBulletList` - Renamed from `ArcaneUnorderedList`
- `ArcaneNumberedList` - Renamed from `ArcaneOrderedList`
- `ArcaneSideContent` - Renamed from `ArcaneAside`

#### New Style Enums
- `PaddingPreset.badge` - Compact padding for badge/tag elements (2px 8px)
- `PaddingPreset.inlineCode` - Padding for inline code snippets (2px 6px)
- `PaddingPreset.chip` - Padding for chip/pill elements (4px 12px)
- `Background.glassTint`, `.glassHeader`, `.glassOverlay` - Glass effects
- `Background.destructive` - Alias for error background
- `MaxHeight` enum - Preset max-heights (none, sm, md, lg, codeBlock, xl, modal, screen)
- `MinWidth` enum - Preset min-widths (none, touchTarget, sm, md, lg)

---

## [2.1.0]

### Added

#### Authentication System
- `ArcaneAuthProvider` - Context provider for Firebase authentication
- `AuthGuard` - Route protection for authenticated users
- `GuestGuard` - Route protection for unauthenticated users
- `JasprAuthService` - Firebase Auth service via JS interop

#### Auth UI Components
- `ArcaneLoginCard` - Complete login form with email/password and social options
- `ArcaneSignupCard` - Registration form with terms acceptance and password policy
- `ArcaneForgotPasswordCard` - Password reset request form

#### Social Sign-in Buttons
- `GithubSignInButton`, `GoogleSignInButton`, `AppleSignInButton`

#### Auth Layouts
- `AuthSplitLayout` - Two-column layout for auth pages
- `AuthBrandingPanel` - Branding content panel

#### Auth Form Primitives
- `AuthInput`, `AuthButton`, `AuthDivider`, `AuthSocialRow`, `AuthFormCard`

#### Auth Utilities
- `PasswordPolicy` - Password validation with presets (weak, medium, strong)
- `AuthState`, `AuthUser`, `AuthMethod`, `AuthStatus`

#### Context Extensions
- `context.authState`, `context.currentUser`, `context.isAuthenticated`
- `context.signInWithGitHub()`, `context.signInWithGoogle()`, `context.signInWithApple()`, `context.signOut()`

---

## [2.0.0]

### Breaking Changes

All components now use the `Arcane*` prefix consistently. This is a breaking change that removes backwards compatibility.

**Migration:** Components have been renamed from their short names to the full `Arcane*` prefix.

Examples:
- `Button` -> `ArcaneButton`
- `Card` -> `ArcaneCard`
- `Div` -> `ArcaneDiv`
- `Checkbox` -> `ArcaneCheckbox`
- ... and all other components

### Added

- `aliases.dart` - Shorthand `A*` typedefs for all components (e.g., `AButton = ArcaneButton`)

---

## [1.0.0]

### Added

Initial release with complete component library:

#### Core
- `ArcaneApp` - Main application wrapper with theme support
- `ArcaneTheme` - Theming system with Supabase-style dark-first design
- `ContrastedColorScheme` - Comprehensive color scheme with accent themes

#### Input Components
- `ArcaneButton`, `ArcaneIconButton`, `Checkbox`, `CycleButton`, `FAB`, `Search`, `Selector`, `Slider`, `TextInput`, `ThemeToggle`, `ToggleSwitch`

#### View Components
- `AnimatedCounter`, `Avatar`, `Badge`, `Bar`, `ArcaneCard`, `Chip`, `CodeSnippet`, `DataTable`, `Divider`, `Expander`, `FeatureCard`, `GameTile`, `Glass`, `GradientText`, `IntegrationCard`, `PricingCard`, `ProgressBar`, `RatingStars`, `Skeleton`, `SocialIcons`, `StatCard`, `StaticTable`, `StatusIndicator`, `Stepper`, `TestimonialCard`, `Tile`, `Timeline`

#### Layout Components
- `ButtonPanel`, `Carpet`, `CTABanner`, `Flow`, `Footer`, `Gutter`, `HeroSection`, `LogoCarousel`, `RadioCards`, `Section`, `ArcaneTabs`

#### Navigation Components
- `BottomNavigationBar`, `DropdownMenu`, `Header`, `MobileMenu`, `Sidebar`

#### Screen Components
- `Screen`, `FillScreen`, `NavigationScreen`

#### Dialog Components
- `ArcaneDialog`, `ConfirmDialog`, `TextInputDialog`, `Toast`

#### Feedback Components
- `AlertBanner`, `Loader`, `Tooltip`

#### Form Components
- `Field`, `FieldWrapper`, `FormProvider`, `NewsletterForm`

#### Interactive Components
- `Accordion`, `BackToTop`

#### Typography
- `Headline`

#### Collection Components
- `CardCarousel`, `Collection`

#### Design Tokens
- `ArcaneTokens` - Spacing, radius, shadows, transitions
- `CommonStyles` - Reusable style maps
- `StylePresets` - Pre-built component styles
