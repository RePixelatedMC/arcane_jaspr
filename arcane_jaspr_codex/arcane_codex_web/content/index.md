---
title: Arcane Jaspr
description: A Flutter-like UI component library for Dart web applications
layout: docs
---

# Arcane Jaspr

A Flutter-like component library that brings type-safe, enumerated styling to Dart web development. Write familiar code, get semantic HTML + CSS.

## The Abstraction Journey

Web development in Dart has historically meant choosing between Flutter Web's poor SEO or wrestling with raw HTML strings. Arcane Jaspr offers a third path: Flutter-like ergonomics with native web output.

### Level 0: Raw HTML + CSS

The traditional approach. Verbose, error-prone, no IDE support:

```html
<div style="display: flex; flex-direction: column; gap: 8px; width: 100%;">
  <label style="font-size: 0.875rem; font-weight: 500; color: var(--text-secondary);">
    Username
  </label>
  <input
    type="text"
    placeholder="Enter username"
    style="
      padding: 10px 14px;
      font-size: 0.875rem;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      background: var(--surface);
      color: var(--text-primary);
      outline: none;
      transition: border-color 0.15s ease, box-shadow 0.15s ease;
    "
  />
  <span style="font-size: 0.75rem; color: var(--text-muted);">
    Choose a unique username
  </span>
</div>
```

**Problems:** No autocomplete, typos become runtime bugs, copy-paste styling, no theming.

### Level 1: Jaspr

Dart code, but still string-based CSS:

```dart
div(
  styles: Styles(raw: {
    'display': 'flex',
    'flex-direction': 'column',
    'gap': '8px',
    'width': '100%',
  }),
  [
    label(
      styles: Styles(raw: {
        'font-size': '0.875rem',
        'font-weight': '500',
        'color': 'var(--text-secondary)',
      }),
      [text('Username')],
    ),
    input(
      type: InputType.text,
      attributes: {'placeholder': 'Enter username'},
      styles: Styles(raw: {
        'padding': '10px 14px',
        'font-size': '0.875rem',
        'border': '1px solid var(--border-color)',
        'border-radius': '8px',
        // ... and on it goes
      }),
      [],
    ),
  ],
)
```

**Better:** It's Dart. **Still painful:** CSS property names as strings, magic values, manual theming.

### Level 2: Arcane Jaspr

One component. Type-safe. Themed. Accessible:

```dart
ArcaneTextInput(
  label: 'Username',
  placeholder: 'Enter username',
  helperText: 'Choose a unique username',
  onChanged: (value) => print(value),
)
```

**That's it.** The component handles:
- Proper HTML structure (`label`, `input`, helper `span`)
- Theme-aware colors (automatically switches in dark mode)
- Focus states, error states, disabled states
- Keyboard navigation and ARIA attributes
- Consistent sizing across your app

## Flutter Developers: You Already Know This

If you've written Flutter, Arcane Jaspr will feel instantly familiar:

| Flutter | Arcane Jaspr |
|---------|-------------|
| `TextField(decoration: InputDecoration(labelText: 'Name'))` | `ArcaneTextInput(label: 'Name')` |
| `DropdownButton<T>(items: [...], onChanged: ...)` | `ArcaneSelector<T>(options: [...], onChanged: ...)` |
| `Column(children: [...])` | `ArcaneColumn(children: [...])` |
| `Row(mainAxisAlignment: ...)` | `ArcaneRow(mainAxisAlignment: ...)` |
| `Container(padding: EdgeInsets.all(16))` | `ArcaneDiv(styles: ArcaneStyleData(padding: PaddingPreset.lg))` |
| `ElevatedButton(onPressed: ..., child: Text('Go'))` | `ArcaneButton.primary(onPressed: ..., label: 'Go')` |

### Enums Replace Magic Strings

In Flutter, you use `EdgeInsets.all(16)` not `'padding': '16px'`. Arcane Jaspr brings the same pattern to web:

```dart
// Flutter
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
  ),
  child: child,
)

// Arcane Jaspr - same energy
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,        // Not 'padding': '16px'
    background: Background.surface,   // Not 'background': 'var(--surface)'
    borderRadius: Radius.md,          // Not 'border-radius': '8px'
    shadow: Shadow.md,                // Not 'box-shadow': '0 4px 6px...'
  ),
  children: [child],
)
```

Every CSS property is type-safe:

```dart
// Display
display: Display.flex,
display: Display.grid,
display: Display.block,

// Flex
flexDirection: FlexDirection.column,
flex: FlexPreset.expand,          // flex: 1 1 0%
justifyContent: MainAxisAlignment.spaceBetween,

// Grid
gridColumns: GridColumns.three,   // repeat(3, 1fr)
gridColumns: GridColumns.autoFitMd,  // repeat(auto-fit, minmax(280px, 1fr))

// Spacing
padding: PaddingPreset.lg,
margin: MarginPreset.bottomMd,
gap: Gap.lg,

// Colors
background: Background.surface,
textColor: TextColor.primary,
borderColor: BorderColor.accent,

// And 50+ more...
```

## Real Components, Real Productivity

### ArcaneSelector - Searchable Dropdowns Made Easy

Building a searchable dropdown from scratch? That's ~150 lines of HTML, CSS, JavaScript, and state management.

With Arcane Jaspr:

```dart
ArcaneSelector<String>(
  label: 'Country',
  options: [
    ArcaneSelectorOption(value: 'us', label: 'United States'),
    ArcaneSelectorOption(value: 'uk', label: 'United Kingdom'),
    ArcaneSelectorOption(value: 'ca', label: 'Canada'),
  ],
  value: selectedCountry,
  onChanged: (value) => setState(() => selectedCountry = value),

  // All of these are built-in
  searchable: true,
  clearable: true,
  multiSelect: false,
  size: SelectorSize.md,
  dropdownDirection: DropdownDirection.down,
)
```

### ArcaneMutableText - Click-to-Edit Text

Need inline editing? Typically you'd build: a display mode, an edit mode, toggle logic, keyboard handlers (Enter to save, Escape to cancel), focus management...

With Arcane Jaspr:

```dart
ArcaneMutableText(
  value: documentTitle,
  placeholder: 'Untitled Document',
  onSave: (newTitle) => updateTitle(newTitle),

  // Type-safe behavior options
  trigger: MutableTextTrigger.click,        // or .doubleClick, .icon
  inputType: MutableTextInputType.text,     // or .multiline, .number
  displayStyle: MutableTextStyle.subtle,    // or .prominent, .minimal
  selectAllOnEdit: true,
  saveOnBlur: true,
)
```

## Why Jaspr over Flutter Web?

| Feature | Flutter Web | Jaspr + Arcane Jaspr |
|---------|-------------|----------------------|
| SEO | Poor (canvas-based) | Excellent (semantic HTML) |
| Bundle Size | 2-5MB+ | 100-500KB |
| Time to First Paint | 2-5 seconds | Under 1 second |
| Browser DevTools | Limited | Full support |
| Text Selection | Custom implementation | Native browser |
| Accessibility | Manual work | Built-in ARIA |

## Quick Start

The fastest way to get started:

```bash
dart pub global activate oracular

# Create a web app
oracular create app --template arcane_jaspr_app --name my_app

# Create a documentation site
oracular create app --template arcane_jaspr_docs --name my_docs
```

Or add to an existing project:

```yaml
dependencies:
  arcane_jaspr: ^2.7.0
```

## Quick Links

- [Installation](/arcane_jaspr/docs/installation) - Add Arcane Jaspr to your project
- [Quick Start](/arcane_jaspr/docs/quick-start) - Build something in 5 minutes
- [Styling Guide](/arcane_jaspr/docs/concepts/styling) - Master ArcaneStyleData
- [Components](/arcane_jaspr/docs/layout/arcane-card) - Browse the component library
