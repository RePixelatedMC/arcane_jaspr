# Stylesheet Authoring Guide

This guide explains how to create custom stylesheets (theme schemas) for Arcane Jaspr using the renderer-based architecture.

---

## Architecture Overview

Arcane Jaspr uses a **dual-system architecture** for theming:

### 1. CSS Variable System (`ArcaneStyleSheet`)
Generates CSS custom properties for colors, spacing, and effects.
- Location: `lib/util/appearance/style_sheet.dart`
- Purpose: CSS generation, color presets, variant switching
- Used by: Static CSS output, `ArcaneStyleData` enums

### 2. Renderer System (`ArcaneStylesheet`)
Provides component renderers that output design-system-specific HTML.
- Location: `lib/stylesheets/stylesheet.dart`
- Purpose: Component rendering, HTML structure, class names
- Used by: Components via `context.renderers.xxx(props)`

**Both systems work together:** CSS variables define the colors/spacing, renderers define the HTML structure.

---

## Creating a New Stylesheet

### Step 1: Create Directory Structure

```
lib/stylesheets/your_style/
├── your_stylesheet.dart       # Main stylesheet class
└── renderers/
    ├── your_renderers.dart    # Implements ComponentRenderers
    ├── button.dart            # Individual component renderers
    ├── card.dart
    ├── checkbox.dart
    └── ... (one per component)
```

### Step 2: Create the Stylesheet Class

```dart
// lib/stylesheets/your_style/your_stylesheet.dart

import '../stylesheet.dart';
import 'renderers/your_renderers.dart';

class YourStylesheet extends ArcaneStylesheet {
  const YourStylesheet();

  @override
  String get id => 'your-style';

  @override
  String get name => 'Your Style';

  @override
  ComponentRenderers get renderers => const YourRenderers();

  @override
  List<String> get externalCssUrls => const [
    // Google Fonts, CDN stylesheets, etc.
    'https://fonts.googleapis.com/css2?family=YourFont&display=swap',
  ];

  @override
  String get baseCss => '''
/* Your base CSS here */

:root {
  /* Light mode CSS variables */
  --background: #ffffff;
  --foreground: #000000;
  --primary: #3b82f6;
  /* ... */

  /* Arcane token aliases (required for ArcaneStyleData compatibility) */
  --arcane-background: var(--background);
  --arcane-foreground: var(--foreground);
  --arcane-primary: var(--primary);
  /* ... see ShadcnStylesheet for full list */
}

.dark {
  /* Dark mode CSS variables */
  --background: #0a0a0a;
  --foreground: #fafafa;
  /* ... */
}
''';
}
```

### Step 3: Create the Renderers Class

```dart
// lib/stylesheets/your_style/renderers/your_renderers.dart

import '../../stylesheet.dart';
import 'button.dart';
import 'card.dart';
// ... import all component renderers

class YourRenderers implements ComponentRenderers {
  const YourRenderers();

  // ==========================================================================
  // INPUT COMPONENTS
  // ==========================================================================

  @override
  Component button(ButtonProps props) => YourButton(props);

  @override
  Component iconButton(IconButtonProps props) => YourIconButton(props);

  @override
  Component checkbox(CheckboxProps props) => YourCheckbox(props);

  // ... implement ALL 60+ methods from ComponentRenderers

  // ==========================================================================
  // VIEW COMPONENTS
  // ==========================================================================

  @override
  Component card(CardProps props) => YourCard(props);

  @override
  Component badge(BadgeProps props) => YourBadge(props);

  // ... etc
}
```

### Step 4: Create Individual Component Renderers

Each component renderer receives a Props object and returns a Component:

```dart
// lib/stylesheets/your_style/renderers/button.dart

import 'package:jaspr/jaspr.dart';
import '../../../core/props/button_props.dart';

class YourButton extends StatelessComponent {
  final ButtonProps props;

  const YourButton(this.props);

  @override
  Component build(BuildContext context) {
    final isDisabled = props.disabled || props.loading;

    // Build your design-system-specific classes
    final classes = _buildClasses();

    return button(
      id: props.id,
      classes: classes,
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
        if (props.loading) _buildSpinner(),
        if (props.icon != null && !props.loading) props.icon!,
        if (props.label != null) text(props.label!),
        if (props.child != null) props.child!,
        if (props.trailing != null && !props.loading) props.trailing!,
      ],
    );
  }

  String _buildClasses() {
    final base = ['your-btn'];

    // Add variant classes
    base.add(switch (props.variant) {
      ButtonVariant.primary => 'your-btn-primary',
      ButtonVariant.secondary => 'your-btn-secondary',
      ButtonVariant.destructive => 'your-btn-destructive',
      ButtonVariant.outline => 'your-btn-outline',
      ButtonVariant.ghost => 'your-btn-ghost',
      ButtonVariant.link => 'your-btn-link',
      _ => 'your-btn-primary',
    });

    // Add size classes
    base.add(switch (props.size) {
      ButtonSize.small => 'your-btn-sm',
      ButtonSize.medium => 'your-btn-md',
      ButtonSize.large => 'your-btn-lg',
      _ => 'your-btn-md',
    });

    if (props.fullWidth) base.add('your-btn-full');

    return base.join(' ');
  }

  Component _buildSpinner() {
    return span(classes: 'your-spinner', []);
  }
}
```

---

## Required CSS Variables

Your stylesheet's `baseCss` must define these Arcane token aliases for `ArcaneStyleData` to work:

### Core Colors
```css
--arcane-background: ...;
--arcane-foreground: ...;
--arcane-on-background: ...;
--arcane-primary: ...;
--arcane-primary-foreground: ...;
--arcane-secondary: ...;
--arcane-secondary-foreground: ...;
--arcane-accent: ...;
--arcane-accent-foreground: ...;
--arcane-muted: ...;
--arcane-muted-foreground: ...;
```

### Semantic Colors
```css
--arcane-destructive: ...;
--arcane-destructive-foreground: ...;
--arcane-success: ...;
--arcane-success-foreground: ...;
--arcane-warning: ...;
--arcane-warning-foreground: ...;
--arcane-info: ...;
--arcane-info-foreground: ...;
```

### Surface Colors
```css
--arcane-surface: ...;
--arcane-on-surface: ...;
--arcane-card: ...;
--arcane-card-foreground: ...;
--arcane-popover: ...;
--arcane-popover-foreground: ...;
```

### Borders & Inputs
```css
--arcane-border: ...;
--arcane-border-subtle: ...;
--arcane-input: ...;
--arcane-ring: ...;
```

### Typography
```css
--arcane-font-sans: ...;
--arcane-font-heading: ...;
--arcane-font-mono: ...;
```

### Radius & Shadows
```css
--arcane-radius: ...;
--arcane-radius-sm: ...;
--arcane-radius-md: ...;
--arcane-radius-lg: ...;
--arcane-shadow-sm: ...;
--arcane-shadow-md: ...;
--arcane-shadow-lg: ...;
```

### RGB Channels (for rgba compositing)
```css
--arcane-background-rgb: r, g, b;
--arcane-foreground-rgb: r, g, b;
--arcane-primary-rgb: r, g, b;
/* ... etc */
```

See `lib/stylesheets/shadcn/shadcn_stylesheet.dart` for the complete list.

---

## ComponentRenderers Interface

Your renderers class must implement ALL methods. Here's the full list:

### Input Components (23 methods)
```dart
Component button(ButtonProps props);
Component iconButton(IconButtonProps props);
Component checkbox(CheckboxProps props);
Component radioGroup(RadioGroupProps props);
Component toggleSwitch(ToggleSwitchProps props);
Component toggleGroup(ToggleGroupProps props);
Component slider(SliderProps props);
Component textInput(TextInputProps props);
Component numberInput(NumberInputProps props);
Component otpInput(OtpInputProps props);
Component tagInput(TagInputProps props);
Component colorInput(ColorInputProps props);
Component select(SelectProps props);
Component search(SearchProps props);
Component calendar(CalendarProps props);
Component datePicker(DatePickerProps props);
Component fab(FabProps props);
Component cycleButton(CycleButtonProps props);
Component themeToggle(ThemeToggleProps props);
Component themeToggleSimple(ThemeToggleSimpleProps props);
Component chip(ChipProps props);
Component chipGroup(ChipGroupProps props);
Component kbd(KbdProps props);
```

### View Components (21 methods)
```dart
Component card(CardProps props);
Component badge(BadgeProps props);
Component avatar(AvatarProps props);
Component avatarGroup(AvatarGroupProps props);
Component alert(AlertProps props);
Component progressBar(ProgressBarProps props);
Component skeleton(SkeletonProps props);
Component tooltip(TooltipProps props);
Component popover(PopoverProps props);
Component hovercard(HovercardProps props);
Component separator(SeparatorProps props);
Component accordion(AccordionProps props);
Component tabs(TabsProps props);
Component dataTable(DataTableProps props);
Component meter(MeterProps props);
Component emptyState(EmptyStateProps props);
```

### Layout Components (4 methods)
```dart
Component drawer(DrawerProps props);
Component scrollArea(ScrollAreaProps props);
```

### Dialog Components (3 methods)
```dart
Component dialog(DialogProps props);
Component toast(ToastProps props);
Component command(CommandProps props);
```

### Navigation Components (8 methods)
```dart
Component sidebar(SidebarProps props);
Component sidebarItem(SidebarItemProps props);
Component header(HeaderProps props);
Component dropdownMenu(DropdownMenuProps props);
Component breadcrumbs(BreadcrumbsProps props);
Component pagination(PaginationProps props);
Component contextMenu(ContextMenuProps props);
Component menubar(MenubarProps props);
```

### Feedback Components (1 method)
```dart
Component loader(LoaderProps props);
```

---

## Using Your Stylesheet

### In an App

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:your_package/stylesheets/your_style/your_stylesheet.dart';

class MyApp extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return ArcaneThemeProvider(
      stylesheet: const YourStylesheet(),
      brightness: Brightness.dark,
      child: ArcaneDiv(
        children: [
          // Components now use your renderers!
          ArcaneButton.primary(label: 'Click me', onPressed: () {}),
        ],
      ),
    );
  }
}
```

### In a Static Site (like Codex)

```dart
// In your layout, use both systems:

// 1. Old system for CSS generation
const ArcaneStyleSheet _cssSheet = ShadcnStyleSheet();

// 2. New system for renderers
const ArcaneStylesheet _rendererSheet = YourStylesheet();

@override
Component build(BuildContext context) {
  return ArcaneThemeProvider(
    stylesheet: _rendererSheet,
    brightness: _isDark ? Brightness.dark : Brightness.light,
    child: ArcaneDiv(
      classes: '${_cssSheet.cssClassForVariant(variant)} ${_isDark ? 'dark' : ''}',
      children: [...],
    ),
  );
}
```

---

## Props Classes Reference

All props classes are in `lib/core/props/`. Each defines:
- Properties the component needs
- Enums for variants/sizes
- Optional `copyWith` method

Example:
```dart
// lib/core/props/button_props.dart

enum ButtonVariant {
  primary, secondary, outline, ghost, destructive, link,
  success, warning, info,
}

enum ButtonSize { small, medium, large, icon, iconSmall, iconLarge }

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

  const ButtonProps({...});
}
```

---

## Best Practices

1. **Start from ShadCN**: Copy `lib/stylesheets/shadcn/` as a template
2. **Match the HTML structure**: ShadCN renderers are the reference implementation
3. **Test each component**: Build incrementally, testing as you go
4. **Use CSS variables**: Let the CSS system handle colors, your renderers handle structure
5. **Keep renderers stateless**: Use `StatelessComponent` for simple components
6. **Support all variants**: Every ButtonVariant, BadgeVariant, etc. should have styling

---

## Existing Stylesheets

### ShadCN (`lib/stylesheets/shadcn/`)
- Minimal, modern, accessible
- Based on https://ui.shadcn.com
- Default/fallback stylesheet
- 60 component renderers

### Codex (Future: `lib/stylesheets/codex/`)
- Gaming aesthetic
- Glass effects, rich shadows
- Sharp corners, premium fonts
- Not yet implemented

---

## File Reference

```
lib/
├── core/
│   ├── props/                    # Shared props classes
│   │   ├── button_props.dart
│   │   ├── card_props.dart
│   │   └── ...
│   ├── renderers.dart            # ComponentRenderers interface
│   └── theme_provider.dart       # ArcaneThemeProvider
│
├── stylesheets/
│   ├── stylesheet.dart           # ArcaneStylesheet base class
│   └── shadcn/
│       ├── shadcn_stylesheet.dart
│       └── renderers/
│           ├── shadcn_renderers.dart
│           ├── button.dart
│           └── ...
│
└── component/                    # Component wrappers (thin delegation)
    ├── input/button.dart         # ArcaneButton -> context.renderers.button(props)
    └── ...
```
