---
title: ArcaneCombobox
description: Searchable dropdown select with autocomplete functionality
layout: kb
component: combobox
---

# ArcaneCombobox

A searchable dropdown select component that combines text input with a filterable list of options. Ideal for selecting from large lists of options.

## Basic Usage

```dart
ArcaneCombobox(
  placeholder: 'Select a country...',
  options: [
    ComboboxOption(value: 'us', label: 'United States'),
    ComboboxOption(value: 'uk', label: 'United Kingdom'),
    ComboboxOption(value: 'ca', label: 'Canada'),
    ComboboxOption(value: 'au', label: 'Australia'),
  ],
  onSelected: (option) => print('Selected: ${option.label}'),
)
```

## With Search

The combobox filters options as you type:

```dart
ArcaneCombobox(
  placeholder: 'Search frameworks...',
  searchPlaceholder: 'Type to search...',
  options: frameworks.map((f) => ComboboxOption(
    value: f.id,
    label: f.name,
    description: f.description,
  )).toList(),
  onSelected: (option) => selectFramework(option.value),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `options` | `List<ComboboxOption>` | required | Available options |
| `placeholder` | `String` | `'Select...'` | Placeholder when no selection |
| `searchPlaceholder` | `String?` | `null` | Search input placeholder |
| `value` | `String?` | `null` | Currently selected value |
| `disabled` | `bool` | `false` | Disable the combobox |
| `onSelected` | `Function(ComboboxOption)?` | `null` | Selection callback |

## ComboboxOption

| Property | Type | Description |
|----------|------|-------------|
| `value` | `String` | Unique identifier |
| `label` | `String` | Display text |
| `description` | `String?` | Optional secondary text |
| `icon` | `Component?` | Optional icon |
| `disabled` | `bool` | Disable this option |

## With Icons

```dart
ArcaneCombobox(
  placeholder: 'Select status...',
  options: [
    ComboboxOption(
      value: 'active',
      label: 'Active',
      icon: ArcaneIcon.checkCircle(),
    ),
    ComboboxOption(
      value: 'pending',
      label: 'Pending',
      icon: ArcaneIcon.clock(),
    ),
    ComboboxOption(
      value: 'inactive',
      label: 'Inactive',
      icon: ArcaneIcon.xCircle(),
    ),
  ],
  onSelected: (option) => updateStatus(option.value),
)
```

## Controlled Value

```dart
ArcaneCombobox(
  value: selectedValue,
  options: options,
  onSelected: (option) {
    setState(() => selectedValue = option.value);
  },
)
```

## Use Cases

- Country/region selectors
- Framework/library pickers
- Tag selection with search
- User mention autocomplete
- Command palettes
