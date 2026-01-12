---
title: Introduction
description: A Flutter-like UI component library for Dart web applications
layout: kb
---

# Introduction

Arcane Jaspr brings Flutter-like ergonomics to Dart web development. Write familiar component code, get semantic HTML + CSS.

## The Abstraction Journey

Web development in Dart has historically meant choosing between Flutter Web's poor SEO or wrestling with raw HTML strings. Arcane Jaspr offers a third path.

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

## Flutter Developers: You Already Know This

If you've written Flutter, Arcane Jaspr will feel instantly familiar:

| Flutter | Arcane Jaspr |
|---------|-------------|
| `TextField(decoration: InputDecoration(labelText: 'Name'))` | `ArcaneTextInput(label: 'Name')` |
| `DropdownButton<T>(items: [...], onChanged: ...)` | `ArcaneSelector<T>(options: [...], onChanged: ...)` |
| `Column(children: [...])` | `ArcaneColumn(children: [...])` |
| `Container(padding: EdgeInsets.all(16))` | `ArcaneDiv(styles: ArcaneStyleData(padding: PaddingPreset.lg))` |

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

## Real Components, Real Productivity

### ArcaneSelector - Searchable Dropdowns

Building a searchable dropdown from scratch? ~150 lines of HTML, CSS, JavaScript.

With Arcane Jaspr:

```dart
ArcaneSelector<String>(
  label: 'Country',
  options: [
    ArcaneSelectorOption(value: 'us', label: 'United States'),
    ArcaneSelectorOption(value: 'uk', label: 'United Kingdom'),
  ],
  value: selectedCountry,
  onChanged: (value) => setState(() => selectedCountry = value),
  searchable: true,
  clearable: true,
  size: SelectorSize.md,
)
```

### ArcaneMutableText - Click-to-Edit

Need inline editing? Typically: display mode, edit mode, toggle logic, keyboard handlers...

With Arcane Jaspr:

```dart
ArcaneMutableText(
  value: documentTitle,
  placeholder: 'Untitled Document',
  onSave: (newTitle) => updateTitle(newTitle),
  trigger: MutableTextTrigger.click,
  displayStyle: MutableTextStyle.subtle,
)
```

## Next Steps

- [Why Jaspr?](/arcane_jaspr/docs/why-jaspr) - When to choose Jaspr over Flutter Web
- [Installation](/arcane_jaspr/docs/installation) - Add Arcane Jaspr to your project
- [Styling Guide](/arcane_jaspr/docs/concepts/styling) - Master ArcaneStyleData
- [Browse Components](/arcane_jaspr/docs/inputs/arcane-button) - See everything available
