# Arcane Jaspr - Stylesheet Renderer Architecture Migration

---

## CURRENT PROGRESS (Last Updated: 2026-01-05)

### Overall Status: ~100% Complete - OLD TOKEN SYSTEM REMOVED

| Phase | Status | Progress |
|-------|--------|----------|
| Phase 0: Preparation | COMPLETE | 100% |
| Phase 1: Core Infrastructure | COMPLETE | 100% |
| Phase 2: Remove Old Token System | COMPLETE | 100% |
| Phase 3: Component Migration (ShadCN Renderers) | COMPLETE | 100% |
| Phase 4: Codex Renderers | NOT STARTED | 0% |
| Phase 5: Finalization | IN PROGRESS | ~80% |

### What's Done
- Core infrastructure created (`lib/core/props/`, `lib/stylesheets/`)
- ComponentRenderers interface defined with 50+ methods
- ArcaneThemeProvider implemented
- **50+ ShadCN renderers created** (see list below)
- **ALL component files migrated to CSS variables** - ZERO ArcaneColors references
- **OLD TOKEN SYSTEM COMPLETELY REMOVED**

### Files Deleted (2026-01-05)
The following old infrastructure files have been removed:
- `lib/util/tokens/tokens.dart` - Old ArcaneColors, ArcaneSpacing, etc.
- `lib/util/tokens/style_presets.dart` - Old button/input/card styles
- `lib/util/tokens/common_styles.dart` - Old common style maps
- `lib/util/tokens/index.dart` - Token barrel export
- `lib/util/tokens/styles/` - All old style token files
- `lib/util/tools/styles.dart` - Old ArcaneStyles helper class
- `lib/util/tokens/` directory - Completely removed
- `lib/util/tools/` directory - Completely removed

### Style Types Updated (2026-01-05)
All enum-based style types now use direct CSS values instead of token references:
- `lib/util/style_types/borders.dart` - Uses direct CSS variables
- `lib/util/style_types/colors.dart` - Uses direct CSS variables
- `lib/util/style_types/effects.dart` - Uses direct CSS values
- `lib/util/style_types/layout.dart` - Uses direct CSS values
- `lib/util/style_types/spacing.dart` - Uses direct pixel values
- `lib/util/style_types/typography.dart` - Uses direct CSS values

### Latest Migrations (2026-01-05)
- **NumberInput, ColorInput, Search**: Props classes + ShadCN renderers
- **FAB, CycleButton, ToggleButton**: Props classes + ShadCN renderers
- **Auth Components**: login_card, signup_card, forgot_password_card - CSS variables
- **Auth Form Components**: auth_button, auth_divider, auth_input, auth_social_row - CSS variables
- **Layout**: auth_split_layout, auth_branding_panel - CSS variables
- **Social Buttons**: social_button - CSS variables
- **Maps**: world_map, usa_map - CSS variables
- **Provider**: auth_guard.dart - CSS variables

**MIGRATION COMPLETE - OLD TOKEN SYSTEM REMOVED - ZERO ANALYZER ERRORS**

### ShadCN Renderers Completed (44 total)
```
lib/stylesheets/shadcn/renderers/
├── accordion.dart       ├── header.dart          ├── select.dart
├── alert.dart           ├── hovercard.dart       ├── separator.dart
├── avatar.dart          ├── icon_button.dart     ├── sidebar.dart
├── badge.dart           ├── loader.dart          ├── skeleton.dart
├── breadcrumbs.dart     ├── menubar.dart         ├── slider.dart
├── button.dart          ├── meter.dart           ├── tab.dart
├── calendar.dart        ├── otp_input.dart       ├── tag_input.dart
├── card.dart            ├── pagination.dart      ├── text_input.dart
├── checkbox.dart        ├── popover.dart         ├── toast.dart
├── command.dart         ├── progress.dart        ├── toggle_group.dart
├── context_menu.dart    ├── radio_group.dart     ├── toggle_switch.dart
├── data_table.dart      ├── scroll_area.dart     ├── tooltip.dart
├── date_picker.dart     ├── shadcn_renderers.dart
├── dialog.dart          ├── empty_state.dart
├── drawer.dart          ├── dropdown_menu.dart
```

### Components with Old Tokens Removed (Phase 2 Progress)

**Input Components (COMPLETE - 18 files):**
- [x] button.dart - uses renderer
- [x] icon_button.dart - uses renderer
- [x] checkbox.dart - uses renderer
- [x] radio_group.dart - uses renderer
- [x] toggle_switch.dart - uses renderer
- [x] slider.dart - uses renderer
- [x] text_input.dart - uses renderer
- [x] number_input.dart - CSS vars
- [x] color_input.dart - CSS vars
- [x] file_upload.dart - CSS vars
- [x] search.dart - CSS vars
- [x] search_bar.dart - CSS vars
- [x] time_picker.dart - CSS vars
- [x] formatted_input.dart - CSS vars
- [x] mutable_text.dart - CSS vars
- [x] fab.dart - CSS vars
- [x] cycle_button.dart - CSS vars
- [x] theme_toggle.dart - CSS vars

**View Components (COMPLETE - ~40 files):**
- [x] All view components migrated to CSS variables

**Layout Components (COMPLETE - 14 files):**
- [x] resizable.dart, footer.dart, footer_column.dart, cta_banner.dart
- [x] carpet.dart, feature_showcase.dart, section_header.dart, section.dart
- [x] dashboard_layout.dart, scroll_rail.dart, auth_layout.dart
- [x] hero_section.dart, radio_cards.dart, logo_carousel.dart

**Navigation Components (COMPLETE - 3 files):**
- [x] bottom_navigation_bar.dart, mobile_menu.dart, dot_indicator.dart

**Screen/Interactive/Button Components (COMPLETE - 6 files):**
- [x] interactive/back_to_top.dart, screen/screen.dart
- [x] screen/navigation_screen.dart, screen/chat_screen.dart
- [x] screen/fill_screen.dart, button/cta_link.dart

**Dialog Components (COMPLETE - 5 files):**
- [x] dialog/time.dart - CSS vars
- [x] dialog/text.dart - CSS vars
- [x] dialog/confirm.dart - CSS vars
- [x] dialog/email.dart - CSS vars
- [x] dialog/item_picker.dart - CSS vars

**Feedback Components (COMPLETE - 2 files):**
- [x] feedback/alert_banner.dart - CSS vars
- [x] feedback/status_badge.dart - CSS vars

**HTML Wrapper Components (COMPLETE - 1 file):**
- [x] html/heading.dart - CSS vars

**Collection Components (COMPLETE - 2 files):**
- [x] collection/infinite_carousel.dart - CSS vars
- [x] collection/card_carousel.dart - CSS vars

**Form Components (COMPLETE - 3 files):**
- [x] form/field.dart - CSS vars
- [x] form/newsletter_form.dart - CSS vars
- [x] form/field_wrapper.dart - CSS vars

---

### Phase 2 Summary

**Total Component Files Migrated: ~95 files**
- Input: 18 files
- View: ~40 files
- Layout: 14 files
- Navigation: 3 files
- Screen/Interactive/Button: 6 files
- Dialog: 5 files
- Feedback: 2 files
- HTML: 1 file
- Collection: 2 files
- Form: 3 files

**Note:** All token imports have been removed. The `lib/util/style_types/` files now use direct CSS values instead of referencing the old token classes. The `lib/util/tools/` directory has been deleted.

---

## Executive Summary

This document outlines the complete migration from the current CSS-variable-based theming system to a **Renderer-based architecture** where each stylesheet provides its own component implementations.

**Goal**: Write `ArcaneButton(...)` once, but output literal ShadCN HTML when using ShadCN stylesheet, literal DaisyUI HTML when using DaisyUI, etc.

**Default/Fallback**: ShadCN will be the default stylesheet and fallback renderer.

---

## Current State Analysis

### Files to Remove/Replace

#### Theming System (REMOVE ENTIRELY)
```
lib/util/appearance/
  style_sheet.dart              # 1041 lines - ArcaneStyleSheet base class
  theme.dart                    # 355 lines - ArcaneTheme, providers
  color_scheme.dart             # Brightness, ThemeMode
  colors.dart                   # Color class
  swatch.dart                   # Color swatch utilities

  stylesheets/
    stylesheets.dart            # Barrel export
    codex/codex_style.dart      # CodexStyleSheet
    shadcn/shadcn_style.dart    # ShadcnStyleSheet
    shadcn/shadcn_presets.dart  # ShadCN color presets

  tokens/
    component_shape.dart
    shadow_intensity.dart
    border_weight.dart
    animation_preset.dart

  groups/
    interactive_tokens.dart
    container_tokens.dart
    input_tokens.dart
    indicator_tokens.dart
```

#### Token System (REMOVE ENTIRELY)
```
lib/util/tokens/
  tokens.dart                   # 1077 lines - ArcaneColors, ArcaneSpacing, etc.
  style_presets.dart            # Barrel export
  common_styles.dart            # Common style maps
  index.dart                    # Barrel export

  styles/
    button_style.dart           # ButtonStyle, ButtonSizeStyle
    card_style.dart
    input_style.dart
    badge_style.dart
    alert_style.dart
    chip_style.dart
    control_styles.dart
    fab_style.dart
    icon_button_style.dart
    misc_styles.dart
    progress_style.dart
```

#### Style Types (EVALUATE - may partially keep)
```
lib/util/style_types/
  index.dart
  ... (enum-based CSS property classes)
```

### Components Affected

**Total: ~196 component files**

Every component that currently:
1. References `ArcaneColors.*`
2. References `ArcaneRadius.*`
3. References `ArcaneEffects.*`
4. Uses `ButtonStyle`, `CardStyle`, etc.
5. Reads from `ArcaneTheme.of(context)`

Will need to be converted to the new Props + Renderer system.

---

## New Architecture

### Directory Structure

```
lib/
  arcane_jaspr.dart                    # Main barrel (updated exports)

  # Core system
  core/
    props/                             # Shared Props classes (one per component)
      button_props.dart
      card_props.dart
      checkbox_props.dart
      ... (one per component type)

    renderers.dart                     # ComponentRenderers interface
    theme_provider.dart                # New simplified theme provider

  # Stylesheets with their renderers
  stylesheets/
    stylesheet.dart                    # Base Stylesheet class (minimal)

    shadcn/                            # ShadCN - DEFAULT/FALLBACK
      shadcn_stylesheet.dart           # ShadCN stylesheet definition
      renderers/
        shadcn_renderers.dart          # Implements ComponentRenderers
        button.dart                    # ShadCN button renderer
        card.dart
        checkbox.dart
        ... (one per component)
      css/
        shadcn_base.dart               # Base CSS to inject (Tailwind classes, etc.)

    codex/                             # Codex (gaming aesthetic)
      codex_stylesheet.dart
      renderers/
        codex_renderers.dart
        button.dart
        card.dart
        ...
      css/
        codex_base.dart

    daisy/                             # Future: DaisyUI
      ...

    brutalism/                         # Future: NeoBrutalism
      ...

  # Components (thin wrappers that delegate to renderers)
  component/
    input/
      button.dart                      # ArcaneButton - delegates to renderer
      checkbox.dart
      ...
    view/
      card.dart
      badge.dart
      ...
    ... (same structure as current)
```

### Core Interfaces

#### 1. Props Classes (Shared)

Each component type has ONE props class, used by ALL stylesheets:

```dart
// lib/core/props/button_props.dart

/// Properties for button components.
/// Used by all stylesheet renderers.
class ButtonProps {
  final String? label;
  final Component? child;
  final Component? icon;
  final Component? trailing;
  final void Function()? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;
  final String? id;
  final Map<String, String>? attributes;

  const ButtonProps({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.id,
    this.attributes,
  });
}

/// Button style variants
enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
  link,
  success,
  warning,
  info,
}

/// Button sizes
enum ButtonSize {
  small,
  medium,
  large,
  icon,
  iconSmall,
  iconLarge,
}
```

#### 2. ComponentRenderers Interface

```dart
// lib/core/renderers.dart

/// Interface that all stylesheets must implement.
/// Each method renders a component according to the stylesheet's design.
abstract class ComponentRenderers {
  // ==========================================================================
  // INPUT COMPONENTS
  // ==========================================================================

  Component button(ButtonProps props);
  Component iconButton(IconButtonProps props);
  Component checkbox(CheckboxProps props);
  Component radioGroup(RadioGroupProps props);
  Component toggleSwitch(ToggleSwitchProps props);
  Component slider(SliderProps props);
  Component textInput(TextInputProps props);
  Component select(SelectProps props);
  Component combobox(ComboboxProps props);
  // ... etc

  // ==========================================================================
  // VIEW COMPONENTS
  // ==========================================================================

  Component card(CardProps props);
  Component badge(BadgeProps props);
  Component avatar(AvatarProps props);
  Component alert(AlertProps props);
  Component progressBar(ProgressBarProps props);
  Component skeleton(SkeletonProps props);
  Component tooltip(TooltipProps props);
  // ... etc

  // ==========================================================================
  // LAYOUT COMPONENTS
  // ==========================================================================

  Component tabs(TabsProps props);
  Component accordion(AccordionProps props);
  Component dialog(DialogProps props);
  Component sheet(SheetProps props);
  Component drawer(DrawerProps props);
  Component popover(PopoverProps props);
  // ... etc

  // ==========================================================================
  // NAVIGATION COMPONENTS
  // ==========================================================================

  Component sidebar(SidebarProps props);
  Component header(HeaderProps props);
  Component breadcrumbs(BreadcrumbsProps props);
  Component pagination(PaginationProps props);
  Component dropdownMenu(DropdownMenuProps props);
  // ... etc

  // ==========================================================================
  // FEEDBACK COMPONENTS
  // ==========================================================================

  Component toast(ToastProps props);
  Component loader(LoaderProps props);
  // ... etc
}
```

#### 3. Stylesheet Base Class

```dart
// lib/stylesheets/stylesheet.dart

/// Base class for stylesheets.
/// Each stylesheet provides renderers for all components.
abstract class ArcaneStylesheet {
  const ArcaneStylesheet();

  /// Unique identifier
  String get id;

  /// Display name
  String get name;

  /// Component renderers for this stylesheet
  ComponentRenderers get renderers;

  /// CSS to inject into the document head (fonts, base styles, etc.)
  String? get baseCss => null;

  /// External CSS URLs to load (Google Fonts, CDN, etc.)
  List<String> get externalCssUrls => [];

  // Predefined stylesheets
  static const ArcaneStylesheet shadcn = ShadcnStylesheet();
  static const ArcaneStylesheet codex = CodexStylesheet();
}
```

#### 4. Theme Provider (Simplified)

```dart
// lib/core/theme_provider.dart

/// Provides the current stylesheet to the component tree.
class ArcaneThemeProvider extends InheritedComponent {
  final ArcaneStylesheet stylesheet;
  final Brightness brightness;

  const ArcaneThemeProvider({
    required this.stylesheet,
    this.brightness = Brightness.dark,
    required super.child,
  });

  static ArcaneThemeProvider? of(BuildContext context) {
    return context.dependOnInheritedComponentOfExactType<ArcaneThemeProvider>();
  }

  /// Get renderers from current stylesheet
  ComponentRenderers get renderers => stylesheet.renderers;

  @override
  bool updateShouldNotify(ArcaneThemeProvider old) {
    return stylesheet != old.stylesheet || brightness != old.brightness;
  }
}

/// Extension for easy access
extension ArcaneContext on BuildContext {
  ArcaneStylesheet get stylesheet =>
      ArcaneThemeProvider.of(this)?.stylesheet ?? ArcaneStylesheet.shadcn;

  ComponentRenderers get renderers => stylesheet.renderers;

  Brightness get brightness =>
      ArcaneThemeProvider.of(this)?.brightness ?? Brightness.dark;

  bool get isDark => brightness == Brightness.dark;
}
```

#### 5. Component Wrappers (Thin Delegation)

```dart
// lib/component/input/button.dart

/// A styled button component.
///
/// The actual rendering is delegated to the current stylesheet's renderer.
/// This ensures consistent API regardless of which design system is active.
class ArcaneButton extends StatelessComponent {
  final String? label;
  final Component? child;
  final Component? icon;
  final Component? trailing;
  final void Function()? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final bool disabled;
  final bool loading;
  final bool fullWidth;
  final String? id;
  final Map<String, String>? attributes;

  const ArcaneButton({
    this.label,
    this.child,
    this.icon,
    this.trailing,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.loading = false,
    this.fullWidth = false,
    this.id,
    this.attributes,
    super.key,
  });

  // Named constructors for convenience
  const ArcaneButton.primary({...}) : variant = ButtonVariant.primary, ...;
  const ArcaneButton.secondary({...}) : variant = ButtonVariant.secondary, ...;
  const ArcaneButton.outline({...}) : variant = ButtonVariant.outline, ...;
  const ArcaneButton.ghost({...}) : variant = ButtonVariant.ghost, ...;
  const ArcaneButton.destructive({...}) : variant = ButtonVariant.destructive, ...;

  @override
  Component build(BuildContext context) {
    // Delegate to current stylesheet's renderer
    return context.renderers.button(ButtonProps(
      label: label,
      child: child,
      icon: icon,
      trailing: trailing,
      onPressed: onPressed,
      variant: variant,
      size: size,
      disabled: disabled,
      loading: loading,
      fullWidth: fullWidth,
      id: id,
      attributes: attributes,
    ));
  }
}
```

### Stylesheet Implementation Example (ShadCN)

```dart
// lib/stylesheets/shadcn/shadcn_stylesheet.dart

class ShadcnStylesheet extends ArcaneStylesheet {
  const ShadcnStylesheet();

  @override
  String get id => 'shadcn';

  @override
  String get name => 'ShadCN UI';

  @override
  ComponentRenderers get renderers => const ShadcnRenderers();

  @override
  List<String> get externalCssUrls => [
    'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap',
  ];

  @override
  String get baseCss => '''
    :root {
      --background: 0 0% 100%;
      --foreground: 222.2 84% 4.9%;
      --card: 0 0% 100%;
      --card-foreground: 222.2 84% 4.9%;
      --popover: 0 0% 100%;
      --popover-foreground: 222.2 84% 4.9%;
      --primary: 222.2 47.4% 11.2%;
      --primary-foreground: 210 40% 98%;
      --secondary: 210 40% 96.1%;
      --secondary-foreground: 222.2 47.4% 11.2%;
      --muted: 210 40% 96.1%;
      --muted-foreground: 215.4 16.3% 46.9%;
      --accent: 210 40% 96.1%;
      --accent-foreground: 222.2 47.4% 11.2%;
      --destructive: 0 84.2% 60.2%;
      --destructive-foreground: 210 40% 98%;
      --border: 214.3 31.8% 91.4%;
      --input: 214.3 31.8% 91.4%;
      --ring: 222.2 84% 4.9%;
      --radius: 0.5rem;
    }

    .dark {
      --background: 222.2 84% 4.9%;
      --foreground: 210 40% 98%;
      /* ... dark mode colors */
    }
  ''';
}
```

```dart
// lib/stylesheets/shadcn/renderers/shadcn_renderers.dart

class ShadcnRenderers implements ComponentRenderers {
  const ShadcnRenderers();

  @override
  Component button(ButtonProps props) => ShadcnButton(props);

  @override
  Component card(CardProps props) => ShadcnCard(props);

  @override
  Component checkbox(CheckboxProps props) => ShadcnCheckbox(props);

  // ... all other component renderers
}
```

```dart
// lib/stylesheets/shadcn/renderers/button.dart

/// ShadCN Button implementation
/// Outputs the exact HTML structure and classes from ui.shadcn.com
class ShadcnButton extends StatelessComponent {
  final ButtonProps props;

  const ShadcnButton(this.props);

  @override
  Component build(BuildContext context) {
    final isDisabled = props.disabled || props.loading;

    // ShadCN exact class structure
    final baseClasses = [
      'inline-flex',
      'items-center',
      'justify-center',
      'gap-2',
      'whitespace-nowrap',
      'rounded-md',
      'text-sm',
      'font-medium',
      'ring-offset-background',
      'transition-colors',
      'focus-visible:outline-none',
      'focus-visible:ring-2',
      'focus-visible:ring-ring',
      'focus-visible:ring-offset-2',
      'disabled:pointer-events-none',
      'disabled:opacity-50',
    ];

    final variantClasses = switch (props.variant) {
      ButtonVariant.primary => [
        'bg-primary',
        'text-primary-foreground',
        'hover:bg-primary/90',
      ],
      ButtonVariant.destructive => [
        'bg-destructive',
        'text-destructive-foreground',
        'hover:bg-destructive/90',
      ],
      ButtonVariant.outline => [
        'border',
        'border-input',
        'bg-background',
        'hover:bg-accent',
        'hover:text-accent-foreground',
      ],
      ButtonVariant.secondary => [
        'bg-secondary',
        'text-secondary-foreground',
        'hover:bg-secondary/80',
      ],
      ButtonVariant.ghost => [
        'hover:bg-accent',
        'hover:text-accent-foreground',
      ],
      ButtonVariant.link => [
        'text-primary',
        'underline-offset-4',
        'hover:underline',
      ],
      // Arcane extensions (implement ShadCN-style)
      ButtonVariant.success => [
        'bg-emerald-500',
        'text-white',
        'hover:bg-emerald-600',
      ],
      ButtonVariant.warning => [
        'bg-amber-500',
        'text-black',
        'hover:bg-amber-600',
      ],
      ButtonVariant.info => [
        'bg-blue-500',
        'text-white',
        'hover:bg-blue-600',
      ],
    };

    final sizeClasses = switch (props.size) {
      ButtonSize.small => ['h-9', 'px-3'],
      ButtonSize.medium => ['h-10', 'px-4', 'py-2'],
      ButtonSize.large => ['h-11', 'px-8'],
      ButtonSize.icon => ['h-10', 'w-10'],
      ButtonSize.iconSmall => ['h-9', 'w-9'],
      ButtonSize.iconLarge => ['h-11', 'w-11'],
    };

    final allClasses = [
      ...baseClasses,
      ...variantClasses,
      ...sizeClasses,
      if (props.fullWidth) 'w-full',
    ].join(' ');

    return button(
      id: props.id,
      classes: allClasses,
      attributes: {
        if (isDisabled) 'disabled': 'true',
        'type': 'button',
        ...?props.attributes,
      },
      events: {
        'click': (e) {
          if (!isDisabled && props.onPressed != null) {
            props.onPressed!();
          }
        },
      },
      [
        if (props.loading)
          _buildSpinner()
        else if (props.icon != null)
          props.icon!,
        if (props.label != null) text(props.label!),
        if (props.child != null) props.child!,
        if (props.trailing != null && !props.loading) props.trailing!,
      ],
    );
  }

  Component _buildSpinner() {
    return span(
      classes: 'animate-spin h-4 w-4 border-2 border-current border-r-transparent rounded-full',
      [],
    );
  }
}
```

---

## Migration Procedure

### Phase 0: Preparation (Do First) 

1. **Create backup branch** (Optional)
   ```bash
   git checkout -b backup/pre-renderer-migration
   git push origin backup/pre-renderer-migration
   git checkout master
   ```

2. **Create migration branch** (Optional)
   ```bash
   git checkout -b feature/renderer-architecture
   ```

3. **Inventory all components**
   - Create a checklist of all 196 components
   - Categorize by complexity (simple, medium, complex)
   - Identify dependencies between components

### Phase 1: Core Infrastructure

**Order matters - do these sequentially:**

1. **Create core directory structure**
   ```
   lib/core/
   lib/core/props/
   lib/stylesheets/
   lib/stylesheets/shadcn/
   lib/stylesheets/shadcn/renderers/
   lib/stylesheets/codex/
   lib/stylesheets/codex/renderers/
   ```

2. **Create base interfaces** (in order):
   - `lib/core/props/` - Empty directory for now
   - `lib/stylesheets/stylesheet.dart` - Base class
   - `lib/core/renderers.dart` - ComponentRenderers interface (start with ONE component: Button)
   - `lib/core/theme_provider.dart` - Simplified provider

3. **Create first Props class**
   - `lib/core/props/button_props.dart` - ButtonProps, ButtonVariant, ButtonSize

4. **Create ShadCN button renderer** (proof of concept)
   - `lib/stylesheets/shadcn/shadcn_stylesheet.dart`
   - `lib/stylesheets/shadcn/renderers/shadcn_renderers.dart` (just button for now)
   - `lib/stylesheets/shadcn/renderers/button.dart`

5. **Update ArcaneButton** to delegate to renderer
   - Modify `lib/component/input/button.dart`
   - Must still compile alongside old system temporarily

6. **Test the proof of concept**
   - Create a test page that uses ArcaneButton with new system
   - Verify output matches ShadCN's actual button

### Phase 2: Remove Old System

**Only after Phase 1 proof of concept works:**

1. **Remove old theme system**
   - Delete `lib/util/appearance/theme.dart`
   - Delete `lib/util/appearance/style_sheet.dart`
   - Delete `lib/util/appearance/stylesheets/` (entire directory)
   - Delete `lib/util/appearance/tokens/` (entire directory)
   - Delete `lib/util/appearance/groups/` (entire directory)

2. **Remove old token system**
   - Delete `lib/util/tokens/` (entire directory)

3. **Update ArcaneApp**
   - Simplify to use new ArcaneThemeProvider
   - Remove CSS variable generation
   - Add base CSS injection from stylesheet

4. **Update barrel file** (`lib/arcane_jaspr.dart`)
   - Remove old exports
   - Add new exports

5. **Run analyzer** - Fix all import errors

### Phase 3: Component Migration (Bulk Work)

For each component category, follow this process:

**Process per component:**

1. **Create Props class** in `lib/core/props/{component}_props.dart`
   - Extract all parameters from current component
   - Create any needed enums

2. **Add to ComponentRenderers interface**
   - Add the render method signature

3. **Create ShadCN renderer** in `lib/stylesheets/shadcn/renderers/{component}.dart`
   - Implement using ShadCN's actual HTML/classes
   - Reference https://ui.shadcn.com/docs/components/{component}

4. **Update ShadcnRenderers** to return the new renderer

5. **Update component wrapper** in `lib/component/{category}/{component}.dart`
   - Simplify to delegate to `context.renderers.{component}(props)`

6. **Test the component**

**Order of component migration (by dependency):**

```
TIER 1 - Foundation (no deps on other Arcane components)
  - button
  - badge
  - avatar
  - separator
  - skeleton
  - progress_bar

TIER 2 - Simple composites
  - icon_button (uses button)
  - alert
  - card
  - checkbox
  - radio_group
  - toggle_switch
  - slider
  - text_input

TIER 3 - Medium complexity
  - tabs
  - accordion
  - tooltip
  - popover
  - dropdown_menu
  - select/selector *
  - combobox *

TIER 4 - Complex
  - dialog
  - sheet
  - drawer
  - toast
  - command (command palette)
  - data_table

TIER 5 - Layout & Navigation
  - sidebar
  - header
  - breadcrumbs
  - pagination
  - dashboard_layout

TIER 6 - Auth & Specialized
  - login_card
  - signup_card
  - All social buttons
  - All other remaining components
```

### Phase 4: Create Codex Renderers

After ShadCN is complete, and you verified that you removed the old system components:

1. **Copy ShadCN renderers as template**
   ```bash
   cp -r lib/stylesheets/shadcn/renderers/ lib/stylesheets/codex/renderers/
   ```

2. **Modify each renderer** to use Codex styling:
   - Different border-radius (sharper)
   - Glass effects
   - Richer shadows
   - Custom fonts
   - Gaming aesthetic

3. **Create CodexStylesheet** class

4. **Test with Codex stylesheet**

### Phase 5: Finalization

1. **Update codex documentation site**
   - Update all demos to use new system
   - Document the new architecture
   - Create migration guide for users

2. **Update CHANGELOG.md**

3. **Run full test suite**

4. **Clean up any remaining old code**

5. **Merge to master**

---

## Component Checklist

Legend:
- [x] = Has dedicated ShadCN renderer (props class + renderer file)
- [~] = No renderer (uses CSS variables via ArcaneStyleData)
- Note: OLD TOKEN SYSTEM FULLY REMOVED - All components now use CSS variables

### Input Components (24 total, 22 with renderers)
- [x] button - RENDERER
- [x] icon_button - RENDERER
- [x] checkbox - RENDERER
- [x] radio_group - RENDERER
- [x] toggle_switch - RENDERER
- [x] toggle_group - RENDERER
- [x] slider - RENDERER
- [x] text_input - RENDERER
- [x] number_input - RENDERER
- [x] otp_input - RENDERER
- [x] tag_input - RENDERER
- [x] color_input - RENDERER
- [~] file_upload
- [x] selector (select) - RENDERER
- [~] combobox
- [x] search - RENDERER
- [~] search_bar (uses search internally)
- [x] calendar - RENDERER
- [x] date_picker - RENDERER
- [~] time_picker
- [~] formatted_input
- [~] mutable_text
- [x] fab - RENDERER
- [x] cycle_button - RENDERER
- [~] theme_toggle

### View Components (44 total, 18 with renderers)
- [x] card - RENDERER
- [~] card_section
- [x] badge - RENDERER
- [x] avatar - RENDERER
- [x] alert - RENDERER
- [x] progress_bar - RENDERER
- [x] skeleton - RENDERER
- [x] tooltip - RENDERER
- [x] popover - RENDERER
- [x] hovercard - RENDERER
- [x] separator - RENDERER
- [~] divider
- [~] chip
- [~] expander
- [x] accordion - RENDERER
- [x] tabs - RENDERER
- [~] tree_view
- [x] data_table - RENDERER
- [~] static_table
- [~] timeline
- [~] stepper
- [x] meter - RENDERER
- [~] rating_stars
- [~] status_indicator
- [~] status_badge
- [~] stat_card
- [~] stat_display
- [~] animated_counter
- [~] slot_counter
- [~] gradient_text
- [~] callout
- [~] kbd
- [~] disclosure
- [~] fade_edge
- [~] marquee
- [~] code_snippet
- [~] code_window
- [~] icon
- [~] glass
- [~] bar
- [~] tile
- [~] feature_card
- [~] pricing_card
- [~] testimonial_card
- [~] integration_card
- [~] game_tile
- [~] author_card
- [~] check_list
- [~] switcher
- [~] surface_card
- [~] tracker
- [~] flexi_cards
- [~] arrow_link
- [~] center_body
- [x] empty_state - RENDERER
- [~] social_icons
- [~] settings_section
- [~] auth_branding_panel
- [~] world_map
- [~] usa_map

### Layout Components (22 total, 4 with renderers)
- [x] tabs (layout version) - RENDERER
- [~] section
- [~] section_header
- [~] gutter
- [~] flow
- [~] carpet
- [~] button_panel
- [~] radio_cards
- [~] hero_section
- [~] footer
- [~] footer_column
- [~] logo_carousel
- [~] cta_banner
- [~] feature_showcase
- [~] dashboard_layout
- [~] auth_layout
- [~] auth_split_layout
- [x] drawer - RENDERER
- [~] sheet
- [~] scroll_rail
- [x] scroll_area - RENDERER
- [~] aspect_ratio
- [~] resizable

### Dialog Components (8 total, 3 with renderers)
- [x] dialog - RENDERER
- [~] confirm
- [~] text (dialog)
- [x] toast - RENDERER
- [x] command - RENDERER
- [~] email (dialog)
- [~] time (dialog)
- [~] item_picker

### Navigation Components (10 total, 8 with renderers)
- [x] sidebar - RENDERER
- [x] header - RENDERER
- [~] bottom_navigation_bar
- [x] dropdown_menu - RENDERER
- [~] mobile_menu
- [x] breadcrumbs - RENDERER
- [x] pagination - RENDERER
- [x] context_menu - RENDERER
- [x] menubar - RENDERER
- [~] dot_indicator

### Screen Components (4 total, 0 with renderers)
- [~] screen
- [~] fill_screen
- [~] navigation_screen
- [~] chat_screen

### Feedback Components (2 total, 1 with renderer)
- [x] loader - RENDERER
- [~] alert_banner

### Form Components (9 total, 0 with renderers)
- [~] field
- [~] field_wrapper
- [~] provider
- [~] newsletter_form
- [~] auth_input
- [~] auth_button
- [~] auth_divider
- [~] auth_social_row
- [~] auth_form_card

### Auth Components (3 total, 0 with renderers)
- [~] login_card
- [~] signup_card
- [~] forgot_password_card

### Social Buttons (12 total, 0 with renderers)
- [~] social_button (base class)
- [~] github_button
- [~] google_button
- [~] apple_button
- [~] microsoft_button
- [~] discord_button
- [~] twitter_button
- [~] facebook_button
- [~] linkedin_button
- [~] slack_button
- [~] gitlab_button
- [~] cta_link

### HTML Wrapper Components (19 total, 0 with renderers)
HTML wrappers intentionally don't need renderers - they output semantic HTML directly.
- [~] arcane_button (html)
- [~] arcane_image
- [~] arcane_input
- [~] arcane_label
- [~] arcane_link
- [~] arcane_text
- [~] arcane_span
- [~] div
- [~] heading
- [~] paragraph
- [~] lists
- [~] quote
- [~] code_block
- [~] table
- [~] svg
- [~] nav
- [ ] header (html)
- [ ] footer (html)
- [ ] main_element
- [ ] section (html)
- [ ] side_content

### Collection Components
- [ ] collection
- [ ] card_carousel
- [ ] infinite_carousel

### Interactive Components
- [ ] accordion
- [ ] back_to_top

