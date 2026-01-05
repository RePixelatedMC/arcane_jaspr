---
title: ArcaneSlotCounter
description: Animated slot machine style counter with customizable formatting
layout: docs
component: slot-counter
---

# ArcaneSlotCounter

An animated counter component with a slot machine style animation. Displays random numbers between a min and max value, perfect for showing latency, uptime percentages, revenue figures, and other dynamic metrics.

## Basic Usage

```dart
ArcaneSlotCounter(
  minValue: 5,
  maxValue: 100,
  suffix: 'ms',
  label: 'Latency',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `minValue` | `int` | required | Minimum value for the counter |
| `maxValue` | `int` | required | Maximum value for the counter |
| `label` | `String?` | `null` | Label text displayed below the value |
| `prefix` | `String?` | `null` | Text shown before the value |
| `suffix` | `String?` | `null` | Text shown after the value |
| `minDigits` | `int` | `1` | Minimum number of digits to display |
| `labelFontSize` | `FontSize` | `FontSize.sm` | Font size for the label |
| `labelColor` | `TextColor` | `TextColor.muted` | Color for the label |
| `valueFontSize` | `FontSize` | `FontSize.xl2` | Font size for the value |
| `valueColor` | `TextColor` | `TextColor.onSurface` | Color for the value |
| `intervalMs` | `int` | `2000` | Interval between value changes in ms |
| `animationDurationMs` | `int` | `500` | Animation duration in ms |

## Factory Constructors

### Latency Counter

Optimized for displaying latency values:

```dart
ArcaneSlotCounter.latency(
  label: 'NYC',
  minLatency: 5,
  maxLatency: 45,
)
```

### Percentage Counter

For displaying percentage values:

```dart
ArcaneSlotCounter.percentage(
  label: 'Uptime',
  minValue: 99,
  maxValue: 100,
  valueColor: TextColor.success,
)
```

### Currency Counter

For displaying currency amounts:

```dart
ArcaneSlotCounter.currency(
  label: 'Revenue',
  minValue: 1000,
  maxValue: 9999,
  valueFontSize: FontSize.xl2,
)
```

## Layout Components

### ArcaneSlotCounterRow

Displays multiple counters in a row:

```dart
ArcaneSlotCounterRow(
  counters: [
    ArcaneSlotCounter.latency(label: 'NYC', minLatency: 5, maxLatency: 45),
    ArcaneSlotCounter.latency(label: 'LON', minLatency: 15, maxLatency: 80),
    ArcaneSlotCounter.latency(label: 'TOK', minLatency: 30, maxLatency: 120),
  ],
)
```

### ArcaneSlotCounterCard

Wraps a counter in a styled card:

```dart
ArcaneSlotCounterCard(
  background: Background.surface,
  border: BorderPreset.subtle,
  counter: ArcaneSlotCounter.percentage(
    label: 'Uptime',
    minValue: 99,
    maxValue: 100,
    valueColor: TextColor.success,
  ),
)
```

## Custom Formatting

Create custom counters with specific formatting:

```dart
ArcaneSlotCounter(
  minValue: 100,
  maxValue: 999,
  prefix: '<',
  suffix: 'ms',
  label: 'Response Time',
  valueFontSize: FontSize.lg,
  valueColor: TextColor.accent,
  minDigits: 3,  // Pads with zeros: 005, 050, 500
)
```

## Animation Timing

Customize the animation behavior:

```dart
ArcaneSlotCounter(
  minValue: 0,
  maxValue: 100,
  intervalMs: 3000,        // Update every 3 seconds
  animationDurationMs: 800, // Slower animation
  label: 'Slow Counter',
)
```

## Related Components

- [ArcaneStatDisplay](/arcane_jaspr/docs/view/arcane-stat-display) - Static stat display
- [ArcaneProgressBar](/arcane_jaspr/docs/view/arcane-progress-bar) - Progress indicator
- [ArcaneMeter](/arcane_jaspr/docs/view/arcane-meter) - Value meter
