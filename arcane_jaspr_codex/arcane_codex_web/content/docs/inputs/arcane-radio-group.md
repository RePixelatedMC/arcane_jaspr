---
title: ArcaneRadioGroup
description: Group of mutually exclusive radio button options
layout: kb
component: radio-group
---

# ArcaneRadioGroup

A group of radio buttons for selecting a single option from multiple choices. Options are mutually exclusive.

## Basic Usage

```dart
ArcaneRadioGroup(
  options: [
    RadioOption(value: 'small', label: 'Small'),
    RadioOption(value: 'medium', label: 'Medium'),
    RadioOption(value: 'large', label: 'Large'),
  ],
  value: selectedSize,
  onChanged: (value) => setState(() => selectedSize = value),
)
```

## With Descriptions

```dart
ArcaneRadioGroup(
  options: [
    RadioOption(
      value: 'free',
      label: 'Free',
      description: 'Basic features for personal use',
    ),
    RadioOption(
      value: 'pro',
      label: 'Pro',
      description: 'Advanced features for professionals',
    ),
    RadioOption(
      value: 'enterprise',
      label: 'Enterprise',
      description: 'Full suite with dedicated support',
    ),
  ],
  value: selectedPlan,
  onChanged: (value) => selectPlan(value),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `options` | `List<RadioOption>` | required | Available radio options |
| `value` | `String?` | `null` | Currently selected value |
| `onChanged` | `Function(String)?` | `null` | Selection change callback |
| `disabled` | `bool` | `false` | Disable all options |
| `orientation` | `Axis` | `vertical` | Layout direction |

## RadioOption

| Property | Type | Description |
|----------|------|-------------|
| `value` | `String` | Unique identifier |
| `label` | `String` | Display text |
| `description` | `String?` | Optional helper text |
| `disabled` | `bool` | Disable this option |

## Horizontal Layout

```dart
ArcaneRadioGroup(
  orientation: Axis.horizontal,
  options: [
    RadioOption(value: 'left', label: 'Left'),
    RadioOption(value: 'center', label: 'Center'),
    RadioOption(value: 'right', label: 'Right'),
  ],
  value: alignment,
  onChanged: (value) => setAlignment(value),
)
```

## Disabled Options

```dart
ArcaneRadioGroup(
  options: [
    RadioOption(value: 'a', label: 'Option A'),
    RadioOption(value: 'b', label: 'Option B', disabled: true),
    RadioOption(value: 'c', label: 'Option C'),
  ],
  value: selected,
  onChanged: (value) => setSelected(value),
)
```

## Use Cases

- Pricing plan selection
- Size/variant pickers
- Settings preferences
- Survey single-choice questions
- Payment method selection
