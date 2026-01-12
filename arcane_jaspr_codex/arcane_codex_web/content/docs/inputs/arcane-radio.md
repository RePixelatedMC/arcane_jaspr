---
title: Radio
description: Radio buttons and radio groups for single selection from options
layout: kb
component: radio
---

# Radio

Radio buttons for selecting a single option from a group of mutually exclusive choices. Use `ArcaneRadioGroup` for managed radio groups with multiple display variants.

## ArcaneRadioGroup

The recommended way to create radio selections with built-in state management and multiple visual variants.

### Standard Variant

```dart
ArcaneRadioGroup<String>(
  value: selectedOption,
  options: const [
    RadioOption(value: 'option1', label: 'Option 1', description: 'First option'),
    RadioOption(value: 'option2', label: 'Option 2', description: 'Second option'),
    RadioOption(value: 'option3', label: 'Option 3', disabled: true),
  ],
  onChanged: (v) => setState(() => selectedOption = v),
  label: 'Choose an option',
)
```

### Cards Variant

Display options as selectable cards in a grid layout:

```dart
ArcaneRadioGroup<String>(
  value: selectedSize,
  variant: RadioGroupVariant.cards,
  layout: RadioGroupLayout.grid,
  gridColumns: 3,
  options: const [
    RadioOption(value: 'small', label: 'Small', description: '8GB RAM'),
    RadioOption(value: 'medium', label: 'Medium', description: '16GB RAM'),
    RadioOption(value: 'large', label: 'Large', description: '32GB RAM'),
  ],
  onChanged: (v) => setState(() => selectedSize = v),
)
```

### Buttons Variant (Segmented Control)

Compact button-style selection:

```dart
ArcaneRadioGroup<String>(
  value: billingPeriod,
  variant: RadioGroupVariant.buttons,
  layout: RadioGroupLayout.horizontal,
  options: const [
    RadioOption(value: 'monthly', label: 'Monthly'),
    RadioOption(value: 'yearly', label: 'Yearly'),
    RadioOption(value: 'lifetime', label: 'Lifetime'),
  ],
  onChanged: (v) => setState(() => billingPeriod = v),
)
```

### Chips Variant

Filter-style chip selection:

```dart
ArcaneRadioGroup<String>(
  value: filter,
  variant: RadioGroupVariant.chips,
  layout: RadioGroupLayout.horizontal,
  options: const [
    RadioOption(value: 'all', label: 'All'),
    RadioOption(value: 'active', label: 'Active'),
    RadioOption(value: 'completed', label: 'Completed'),
    RadioOption(value: 'archived', label: 'Archived'),
  ],
  onChanged: (v) => setState(() => filter = v),
)
```

## RadioGroup Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T?` | `null` | Currently selected value |
| `options` | `List<RadioOption<T>>` | required | Available options |
| `onChanged` | `ValueChanged<T?>?` | `null` | Selection handler |
| `variant` | `RadioGroupVariant` | `standard` | Visual variant |
| `layout` | `RadioGroupLayout` | `vertical` | Layout direction |
| `gridColumns` | `int` | `2` | Columns for grid layout |
| `label` | `String?` | `null` | Group label |
| `disabled` | `bool` | `false` | Disable all options |

## RadioOption Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `T` | required | Option value |
| `label` | `String` | required | Display label |
| `description` | `String?` | `null` | Optional description |
| `disabled` | `bool` | `false` | Disable this option |

## ArcaneRadio (Basic)

For simple cases where you need individual radio buttons:

```dart
ArcaneRadio(
  selected: selectedOption == 'a',
  label: 'Option A',
  onSelected: () => setState(() => selectedOption = 'a'),
)
```

### Basic Radio Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `selected` | `bool` | `false` | Whether selected |
| `label` | `String?` | `null` | Label text |
| `onSelected` | `VoidCallback?` | `null` | Selection handler |
| `disabled` | `bool` | `false` | Disable interaction |

## Related Components

- [ArcaneCheckbox](/arcane_jaspr/docs/inputs/arcane-checkbox) - Multiple selection
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Dropdown selection
- [ArcaneToggleButton](/arcane_jaspr/docs/inputs/arcane-toggle-button) - Button-style selection
