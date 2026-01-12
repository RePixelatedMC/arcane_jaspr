---
title: ToggleButton
description: Toggle buttons for on/off states and grouped selections
layout: kb
component: toggle-button
---

# ToggleButton

Toggle buttons for binary on/off states and exclusive group selections.

## ArcaneToggleButton

A button that toggles between active and inactive states:

```dart
ArcaneToggleButton(
  value: isActive,
  label: 'Bold',
  onChanged: (selected) => setState(() => isActive = selected),
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `bool` | `false` | Current toggle state |
| `onChanged` | `ValueChanged<bool>?` | `null` | State change handler |
| `label` | `String?` | `null` | Button label |
| `icon` | `Component?` | `null` | Button icon |
| `disabled` | `bool` | `false` | Disable interaction |

### With Icon

```dart
ArcaneToggleButton(
  value: isBold,
  icon: ArcaneIcon.bold(),
  onChanged: (v) => setState(() => isBold = v),
)
```

### Text Formatting Toolbar

```dart
ArcaneRow(
  gapSize: Gap.xs,
  children: [
    ArcaneToggleButton(
      value: isBold,
      icon: ArcaneIcon.bold(),
      onChanged: (v) => setState(() => isBold = v),
    ),
    ArcaneToggleButton(
      value: isItalic,
      icon: ArcaneIcon.italic(),
      onChanged: (v) => setState(() => isItalic = v),
    ),
    ArcaneToggleButton(
      value: isUnderline,
      icon: ArcaneIcon.underline(),
      onChanged: (v) => setState(() => isUnderline = v),
    ),
  ],
)
```

## ArcaneToggleButtonGroup

A group of mutually exclusive toggle buttons (only one can be selected):

```dart
ArcaneToggleButtonGroup(
  options: const ['One', 'Two', 'Three'],
  selectedIndex: selectedIndex,
  onChanged: (index) => setState(() => selectedIndex = index),
)
```

### Group Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `options` | `List<String>` | required | Option labels |
| `selectedIndex` | `int` | `0` | Currently selected index |
| `onChanged` | `ValueChanged<int>?` | `null` | Selection handler |
| `disabled` | `bool` | `false` | Disable all options |

### View Mode Toggle

```dart
ArcaneToggleButtonGroup(
  options: const ['Grid', 'List', 'Table'],
  selectedIndex: viewModeIndex,
  onChanged: (index) => setState(() => viewModeIndex = index),
)
```

### Billing Period Selection

```dart
ArcaneToggleButtonGroup(
  options: const ['Monthly', 'Yearly'],
  selectedIndex: billingIndex,
  onChanged: (index) => setState(() => billingIndex = index),
)
```

## Related Components

- [ArcaneToggleSwitch](/arcane_jaspr/docs/inputs/arcane-toggle-switch) - Switch-style toggle
- [ArcaneCheckbox](/arcane_jaspr/docs/inputs/arcane-checkbox) - Checkbox toggle
- [ArcaneRadio](/arcane_jaspr/docs/inputs/arcane-radio) - Radio selection
