---
title: ArcaneAnimatedCounter
description: Animated number counter with smooth transitions
layout: kb
component: animated-counter
---

# ArcaneAnimatedCounter

An animated counter component that smoothly transitions between numeric values. Great for dashboards, stats displays, and metrics.

## Basic Usage

```dart
ArcaneAnimatedCounter(
  value: 1234,
)
```

## With Formatting

```dart
ArcaneAnimatedCounter(
  value: 9876543,
  formatter: (value) => '\$${value.toStringAsFixed(0)}',
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `num` | required | The target number |
| `duration` | `Duration` | `500ms` | Animation duration |
| `formatter` | `String Function(num)?` | `null` | Custom number formatting |
| `style` | `ArcaneStyleData?` | `null` | Text styling |
| `curve` | `String` | `'ease-out'` | Animation easing |

## Currency Display

```dart
ArcaneAnimatedCounter(
  value: totalRevenue,
  formatter: (value) => '\$${value.toStringAsFixed(2)}',
  style: const ArcaneStyleData(
    fontSize: FontSize.xl,
    fontWeight: FontWeight.bold,
  ),
)
```

## Percentage Display

```dart
ArcaneAnimatedCounter(
  value: progressPercent,
  formatter: (value) => '${value.toStringAsFixed(1)}%',
)
```

## Custom Duration

```dart
ArcaneAnimatedCounter(
  value: count,
  duration: const Duration(milliseconds: 1500),
)
```

## Compact Numbers

```dart
ArcaneAnimatedCounter(
  value: followers,
  formatter: (value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toStringAsFixed(0);
  },
)
```

## Use Cases

- Dashboard metrics
- Real-time statistics
- Progress indicators
- Score displays
- Financial summaries
- User counts
