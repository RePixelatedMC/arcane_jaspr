# Arcane Jaspr Props & Renderers Consolidation Plan

## Decisions Made

- **Size convention:** Support BOTH `sm/md/lg` AND `small/medium/large` as aliases
- **Variant naming:** Standardize on "destructive" (not "error")
- **MenuItem refactor:** YES - convert to sealed classes
- **Form consolidation:** YES - merge NewsletterForm/WaitlistForm into generic SimpleForm
- **Backward compatibility:** **NEVER** - no deprecated aliases, no shims, no re-exports. Delete old code completely.

---

## Critical Rule: No Backward Compatibility

**DO NOT:**
- Create deprecated aliases
- Add shims or compatibility layers
- Re-export old names from new locations
- Leave old files behind when moving/renaming
- Add `@deprecated` annotations pointing to new code

**DO:**
- Delete old code completely
- Update all imports directly
- Make breaking changes cleanly
- Remove unused code entirely

---

## Phase 1: Shared Type System

### 1.1 Create Shared Size Enum

Create `lib/core/shared/size.dart`:

```dart
/// Unified size enum supporting both naming conventions.
/// Use whichever style you prefer - they are aliases.
enum ComponentSize {
  sm,
  md,
  lg;

  // Convenience aliases for spelled-out preference
  static const ComponentSize small = sm;
  static const ComponentSize medium = md;
  static const ComponentSize large = lg;
}
```

**Files to UPDATE (delete old enums, use ComponentSize):**
- `lib/core/props/button_props.dart` - delete ButtonSize
- `lib/core/props/badge_props.dart` - delete BadgeSize
- `lib/core/props/chip_props.dart` - delete ChipSize
- `lib/core/props/checkbox_props.dart` - delete CheckboxSize
- `lib/core/props/toggle_switch_props.dart` - delete ToggleSwitchSize
- `lib/core/props/icon_button_props.dart` - delete IconButtonSize
- `lib/core/props/avatar_props.dart` - delete AvatarSize
- `lib/core/props/fab_props.dart` - delete FABSize (note: "regular" becomes "md")
- `lib/core/props/text_input_props.dart` - delete TextInputSize
- `lib/core/props/number_input_props.dart` - delete NumberInputSize
- `lib/core/props/status_badge_props.dart` - delete StatusBadgeSize
- `lib/core/props/color_input_props.dart` - delete ColorInputSize
- `lib/core/props/select_props.dart` - delete SelectSize
- `lib/core/props/search_props.dart` - delete SearchSize
- `lib/core/props/slider_props.dart` - delete SliderSize
- `lib/core/props/time_picker_props.dart` - delete TimePickerSize

**Renderers to UPDATE (both ShadCN and Codex):**
- Update all size switch statements to use `ComponentSize.sm/md/lg`
- `lib/stylesheets/shadcn/renderers/` - all files using size enums
- `lib/stylesheets/codex/renderers/` - all files using size enums

**Special case - ButtonSize icon variants:**
```dart
// Button needs extended sizes for icon-only variants
enum ButtonSize {
  sm,
  md,
  lg,
  iconSm,
  iconMd,
  iconLg;

  static const ButtonSize small = sm;
  static const ButtonSize medium = md;
  static const ButtonSize large = lg;
  static const ButtonSize iconSmall = iconSm;
  static const ButtonSize iconMedium = iconMd;
  static const ButtonSize iconLarge = iconLg;
}
```

---

### 1.2 Create Shared Variant System

Create `lib/core/shared/variants.dart`:

```dart
/// Color variants for semantic meaning
enum ColorVariant {
  primary,
  secondary,
  destructive,  // NOT "error" - standardized
  success,
  warning,
  info;
}

/// Style variants for visual treatment
enum StyleVariant {
  solid,    // filled background
  outline,  // border only
  ghost,    // no background/border, subtle hover
  link,     // text only, link-like
}
```

**Files to UPDATE:**
- `lib/core/props/badge_props.dart` - delete BadgeVariant, use ColorVariant + StyleVariant
- `lib/core/props/chip_props.dart` - delete ChipVariant
- `lib/core/props/checkbox_props.dart` - delete CheckboxVariant
- `lib/core/props/icon_button_props.dart` - delete IconButtonVariant
- `lib/core/props/fab_props.dart` - delete FABVariant
- `lib/core/props/alert_props.dart` - rename AlertSeverity to use ColorVariant

**Note:** ButtonVariant stays as-is since it has component-specific values (accent, link behavior)

**Renderers to UPDATE:**
- `lib/stylesheets/shadcn/renderers/badge.dart`
- `lib/stylesheets/shadcn/renderers/chip.dart`
- `lib/stylesheets/shadcn/renderers/checkbox.dart`
- `lib/stylesheets/shadcn/renderers/icon_button.dart`
- `lib/stylesheets/shadcn/renderers/fab.dart`
- `lib/stylesheets/shadcn/renderers/alert.dart`
- `lib/stylesheets/codex/renderers/` - same files if they exist

---

### 1.3 Fix statusBadge2() Naming

**Action:**
1. Search for why it's named `statusBadge2`
2. If no legacy version exists, rename to `statusBadge()`
3. Update `lib/core/renderers.dart`
4. Update all renderer implementations

---

## Phase 2: Props Consolidation

### 2.1 Create Card Base Mixins

Create `lib/core/props/shared/card_base.dart`:

```dart
/// Mixin for cards with tap/navigation actions
mixin CardActionProps {
  String? get href;
  void Function()? get onTap;
}

/// Mixin for cards with media (icon or image)
mixin CardMediaProps {
  String? get imageUrl;
  Component? get icon;
}

/// Mixin for cards with title/description content
mixin CardContentProps {
  String get title;
  String? get description;
}
```

**Files to REFACTOR (add mixins, remove duplicate fields):**
- `lib/core/props/feature_card_props.dart`
- `lib/core/props/integration_card_props.dart`
- `lib/core/props/testimonial_card_props.dart`
- `lib/core/props/stat_card_props.dart`
- `lib/core/props/game_card_props.dart`

---

### 2.2 Merge Form Components

**DELETE these files:**
- `lib/core/props/newsletter_form_props.dart`
- `lib/core/props/waitlist_form_props.dart`
- `lib/component/form/newsletter_form.dart` (or similar)
- `lib/component/form/waitlist_form.dart` (or similar)
- `lib/stylesheets/shadcn/renderers/newsletter_form.dart`
- `lib/stylesheets/shadcn/renderers/waitlist_form.dart`
- `lib/stylesheets/codex/renderers/newsletter_form.dart` (if exists)
- `lib/stylesheets/codex/renderers/waitlist_form.dart` (if exists)

**CREATE new unified form:**

`lib/core/props/simple_form_props.dart`:
```dart
class SimpleFormProps {
  final String? title;
  final String? description;
  final List<SimpleFormField> fields;
  final String submitLabel;
  final String? cancelLabel;
  final void Function(Map<String, String> values)? onSubmit;
  final void Function()? onCancel;
  final bool loading;
  final String? successMessage;
  final String? errorMessage;

  const SimpleFormProps({
    this.title,
    this.description,
    required this.fields,
    this.submitLabel = 'Submit',
    this.cancelLabel,
    this.onSubmit,
    this.onCancel,
    this.loading = false,
    this.successMessage,
    this.errorMessage,
  });
}

class SimpleFormField {
  final String name;
  final String label;
  final String? placeholder;
  final String? hint;
  final SimpleFormFieldType type;
  final bool required;
  final String? Function(String?)? validator;

  const SimpleFormField({
    required this.name,
    required this.label,
    this.placeholder,
    this.hint,
    this.type = SimpleFormFieldType.text,
    this.required = false,
    this.validator,
  });
}

enum SimpleFormFieldType {
  text,
  email,
  password,
  textarea,
  phone,
  url,
}
```

**UPDATE renderers.dart:** Remove `newsletterForm()` and `waitlistForm()`, add `simpleForm()`

**UPDATE component wrappers:** Create `ArcaneSimpleForm` with convenience constructors:
```dart
class ArcaneSimpleForm extends StatelessComponent {
  // ... props ...

  /// Newsletter signup form with email field
  factory ArcaneSimpleForm.newsletter({...}) => ...

  /// Waitlist form with name and email fields
  factory ArcaneSimpleForm.waitlist({...}) => ...

  /// Contact form with name, email, message fields
  factory ArcaneSimpleForm.contact({...}) => ...
}
```

---

### 2.3 Refactor ArcaneMenuItem to Sealed Classes

**DELETE and REPLACE** `lib/core/props/menu_item_props.dart`:

```dart
/// Sealed class hierarchy for menu items
sealed class ArcaneMenuItem {
  const ArcaneMenuItem();
}

/// Standard clickable menu item
class MenuItemAction extends ArcaneMenuItem {
  final String label;
  final Component? leading;
  final Component? trailing;
  final String? shortcut;
  final bool disabled;
  final void Function()? onTap;
  final String? href;

  const MenuItemAction({
    required this.label,
    this.leading,
    this.trailing,
    this.shortcut,
    this.disabled = false,
    this.onTap,
    this.href,
  });
}

/// Visual separator between menu items
class MenuItemSeparator extends ArcaneMenuItem {
  const MenuItemSeparator();
}

/// Checkbox menu item
class MenuItemCheckbox extends ArcaneMenuItem {
  final String label;
  final bool checked;
  final bool disabled;
  final void Function(bool)? onChanged;

  const MenuItemCheckbox({
    required this.label,
    required this.checked,
    this.disabled = false,
    this.onChanged,
  });
}

/// Radio menu item (part of a group)
class MenuItemRadio extends ArcaneMenuItem {
  final String label;
  final String group;
  final String value;
  final bool selected;
  final bool disabled;
  final void Function(String)? onChanged;

  const MenuItemRadio({
    required this.label,
    required this.group,
    required this.value,
    required this.selected,
    this.disabled = false,
    this.onChanged,
  });
}

/// Submenu with nested items
class MenuItemSubmenu extends ArcaneMenuItem {
  final String label;
  final Component? leading;
  final List<ArcaneMenuItem> children;
  final bool disabled;

  const MenuItemSubmenu({
    required this.label,
    this.leading,
    required this.children,
    this.disabled = false,
  });
}

/// Label/header for grouping items (non-interactive)
class MenuItemLabel extends ArcaneMenuItem {
  final String label;

  const MenuItemLabel({required this.label});
}
```

**UPDATE renderers:**
- `lib/stylesheets/shadcn/renderers/dropdown_menu.dart` - pattern match on sealed types
- `lib/stylesheets/shadcn/renderers/context_menu.dart` - pattern match on sealed types
- `lib/stylesheets/codex/renderers/` - same files if they exist

**Pattern matching example:**
```dart
Component renderMenuItem(ArcaneMenuItem item) {
  return switch (item) {
    MenuItemAction(:final label, :final onTap) => _buildAction(label, onTap),
    MenuItemSeparator() => hr(),
    MenuItemCheckbox(:final label, :final checked) => _buildCheckbox(label, checked),
    MenuItemRadio(:final label, :final selected) => _buildRadio(label, selected),
    MenuItemSubmenu(:final label, :final children) => _buildSubmenu(label, children),
    MenuItemLabel(:final label) => _buildLabel(label),
  };
}
```

---

## Phase 3: Renderer Updates

### 3.1 ShadCN Renderers

**Files to update in `lib/stylesheets/shadcn/renderers/`:**

| File | Changes |
|------|---------|
| `button.dart` | Use new ButtonSize enum |
| `badge.dart` | Use ComponentSize, ColorVariant + StyleVariant |
| `chip.dart` | Use ComponentSize, ColorVariant + StyleVariant |
| `checkbox.dart` | Use ComponentSize, ColorVariant |
| `toggle_switch.dart` | Use ComponentSize |
| `icon_button.dart` | Use ComponentSize, update variant handling |
| `avatar.dart` | Use ComponentSize |
| `fab.dart` | Use ComponentSize (md replaces "regular"), ColorVariant |
| `text_input.dart` | Use ComponentSize |
| `number_input.dart` | Use ComponentSize |
| `status_badge.dart` | Use ComponentSize, rename method |
| `color_input.dart` | Use ComponentSize |
| `select.dart` | Use ComponentSize |
| `search.dart` | Use ComponentSize |
| `slider.dart` | Use ComponentSize |
| `time_picker.dart` | Use ComponentSize |
| `alert.dart` | Use ColorVariant instead of AlertSeverity |
| `dropdown_menu.dart` | Pattern match on sealed ArcaneMenuItem |
| `context_menu.dart` | Pattern match on sealed ArcaneMenuItem |
| `newsletter_form.dart` | DELETE |
| `waitlist_form.dart` | DELETE |
| `simple_form.dart` | CREATE |

### 3.2 Codex Renderers

**Files to update in `lib/stylesheets/codex/renderers/`:**
- Same changes as ShadCN for any files that exist
- May have fewer files since Codex stylesheet might not implement everything

---

## Phase 4: Component Wrapper Updates

Update all component wrappers in `lib/component/` to use new prop types:

- `lib/component/input/button.dart`
- `lib/component/view/badge.dart`
- `lib/component/view/chip.dart`
- `lib/component/input/checkbox.dart`
- `lib/component/input/toggle_switch.dart`
- `lib/component/input/icon_button.dart`
- `lib/component/view/avatar.dart`
- `lib/component/input/fab.dart`
- `lib/component/input/text_input.dart`
- `lib/component/input/number_input.dart`
- `lib/component/view/status_badge.dart`
- `lib/component/input/color_input.dart`
- `lib/component/input/select.dart`
- `lib/component/input/search.dart`
- `lib/component/input/slider.dart`
- `lib/component/input/time_picker.dart`
- `lib/component/feedback/alert.dart`
- `lib/component/navigation/dropdown_menu.dart`
- `lib/component/navigation/context_menu.dart`
- `lib/component/form/newsletter_form.dart` - DELETE
- `lib/component/form/waitlist_form.dart` - DELETE
- `lib/component/form/simple_form.dart` - CREATE

---

## Phase 5: Exports and Cleanup

### 5.1 Update Main Barrel Export

`lib/arcane_jaspr.dart`:
- Export new shared types from `lib/core/shared/`
- Remove exports for deleted props/components
- Add exports for new SimpleForm

### 5.2 Update renderers.dart

`lib/core/renderers.dart`:
- Remove `newsletterForm()` method
- Remove `waitlistForm()` method
- Add `simpleForm()` method
- Rename `statusBadge2()` to `statusBadge()`

### 5.3 Delete Unused Files

After all updates, delete:
- Any orphaned props files
- Any orphaned renderer files
- Any leftover aliases or shims

---

## Files to Create (Summary)

```
lib/core/shared/
├── size.dart              # ComponentSize enum with aliases
├── variants.dart          # ColorVariant, StyleVariant enums
└── shared.dart            # Barrel export

lib/core/props/shared/
├── card_base.dart         # Card mixins
└── props_shared.dart      # Barrel export

lib/core/props/
├── simple_form_props.dart # New unified form props
└── menu_item_props.dart   # Rewritten with sealed classes

lib/stylesheets/shadcn/renderers/
└── simple_form.dart       # New renderer

lib/stylesheets/codex/renderers/
└── simple_form.dart       # New renderer (if codex implements forms)

lib/component/form/
└── simple_form.dart       # New component wrapper
```

---

## Files to Delete (Summary)

```
lib/core/props/
├── newsletter_form_props.dart
└── waitlist_form_props.dart

lib/stylesheets/shadcn/renderers/
├── newsletter_form.dart
└── waitlist_form.dart

lib/stylesheets/codex/renderers/
├── newsletter_form.dart   # if exists
└── waitlist_form.dart     # if exists

lib/component/form/
├── newsletter_form.dart   # if exists
└── waitlist_form.dart     # if exists
```

---

## CHANGELOG Entry

Add to `x.x.x` section:

```markdown
### Changed
- Standardized size enums to `ComponentSize` with `sm/md/lg` values (aliases for `small/medium/large`)
- Standardized variant enums to `ColorVariant` and `StyleVariant`
- Renamed `statusBadge2()` to `statusBadge()` in ComponentRenderers
- Refactored `ArcaneMenuItem` to sealed class hierarchy for type safety

### Added
- `ComponentSize` shared enum in `lib/core/shared/size.dart`
- `ColorVariant` and `StyleVariant` shared enums in `lib/core/shared/variants.dart`
- `SimpleFormProps` and `ArcaneSimpleForm` replacing newsletter/waitlist forms
- Card base mixins: `CardActionProps`, `CardMediaProps`, `CardContentProps`
- Sealed menu item types: `MenuItemAction`, `MenuItemSeparator`, `MenuItemCheckbox`, `MenuItemRadio`, `MenuItemSubmenu`, `MenuItemLabel`

### Removed
- Individual size enums (ButtonSize, BadgeSize, TextInputSize, etc.) - use `ComponentSize`
- Individual variant enums (BadgeVariant, ChipVariant, etc.) - use `ColorVariant`/`StyleVariant`
- `NewsletterFormProps` and `WaitlistFormProps` - use `SimpleFormProps`
- `ArcaneNewsletterForm` and `ArcaneWaitlistForm` - use `ArcaneSimpleForm.newsletter()` / `.waitlist()`
- Old `ArcaneMenuItem` class with boolean flags
```

---

## Execution Order

1. Create shared type files (`size.dart`, `variants.dart`)
2. Create card base mixins
3. Create sealed `ArcaneMenuItem` classes
4. Create `SimpleFormProps` and renderer
5. Update all props files to use shared types
6. Update all ShadCN renderers
7. Update all Codex renderers
8. Update all component wrappers
9. Update `renderers.dart` interface
10. Update `arcane_jaspr.dart` exports
11. Delete old files
12. Update CHANGELOG.md
13. Run `dart analyze` and fix any issues
14. Test build with `dart pub get && dart run build_runner build`
