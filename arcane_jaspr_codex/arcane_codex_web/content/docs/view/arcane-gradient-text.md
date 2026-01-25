---
title: ArcaneGradientText
description: Text with gradient color effects
layout: kb
component: gradient-text
---

# ArcaneGradientText

A text component that displays text with gradient color effects. Supports linear gradients with multiple color stops.

## Basic Usage

```dart
ArcaneGradientText(
  text: 'Gradient Text',
  gradient: LinearGradient(
    colors: [ArcaneColor.primary, ArcaneColor.accent],
  ),
)
```

## Preset Gradients

### Brand Gradient

```dart
ArcaneGradientText.brand(text: 'Brand Headline')
```

### Success Gradient

```dart
ArcaneGradientText.success(text: 'Success!')
```

### Warning Gradient

```dart
ArcaneGradientText.warning(text: 'Warning')
```

### Error Gradient

```dart
ArcaneGradientText.error(text: 'Error!')
```

### Rainbow Gradient

```dart
ArcaneGradientText.rainbow(text: 'Rainbow Text')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `text` | `String` | required | The text to display |
| `gradient` | `Gradient?` | `null` | Custom gradient definition |
| `style` | `ArcaneStyleData?` | `null` | Additional text styling |

## From Theme Colors

```dart
ArcaneGradientText.fromColors(
  text: 'Custom Gradient',
  colors: [
    ArcaneColor.info,
    ArcaneColor.success,
    ArcaneColor.primary,
  ],
)
```

## Custom Gradient Stops

```dart
ArcaneGradientText.custom(
  text: 'Custom Stops',
  stops: [
    GradientStop(color: ArcaneColor.primary, position: 0.0),
    GradientStop(color: ArcaneColor.accent, position: 0.3),
    GradientStop(color: ArcaneColor.secondary, position: 1.0),
  ],
)
```

## With Styling

```dart
ArcaneGradientText.brand(
  text: 'Large Headline',
  style: const ArcaneStyleData(
    fontSize: FontSize.xxxl,
    fontWeight: FontWeight.bold,
  ),
)
```

## Gradient Direction

```dart
ArcaneGradientText(
  text: 'Vertical Gradient',
  gradient: LinearGradient(
    colors: [ArcaneColor.primary, ArcaneColor.accent],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ),
)
```

## Use Cases

- Hero headlines
- Brand text
- Feature highlights
- Marketing copy
- Section titles
- Call-to-action text
