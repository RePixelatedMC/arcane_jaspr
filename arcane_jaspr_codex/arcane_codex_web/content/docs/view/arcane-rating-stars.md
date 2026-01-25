---
title: ArcaneRatingStars
description: Star rating display and input component
layout: kb
component: rating-stars
---

# ArcaneRatingStars

A star rating component for displaying and collecting ratings. Supports both read-only display and interactive input modes.

## Basic Usage

### Display Mode

```dart
ArcaneRatingStars(
  value: 4.5,
)
```

### Interactive Mode

```dart
ArcaneRatingStars(
  value: userRating,
  interactive: true,
  onChanged: (rating) => setState(() => userRating = rating),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `double` | required | Current rating (0-5) |
| `maxValue` | `int` | `5` | Maximum stars |
| `interactive` | `bool` | `false` | Allow user interaction |
| `onChanged` | `Function(double)?` | `null` | Rating change callback |
| `size` | `ComponentSize` | `md` | Star size |
| `color` | `String?` | `null` | Star fill color |
| `emptyColor` | `String?` | `null` | Empty star color |
| `allowHalf` | `bool` | `true` | Allow half-star ratings |

## Sizes

```dart
// Small
ArcaneRatingStars(value: 4, size: ComponentSize.sm)

// Medium (default)
ArcaneRatingStars(value: 4, size: ComponentSize.md)

// Large
ArcaneRatingStars(value: 4, size: ComponentSize.lg)
```

## Custom Colors

```dart
ArcaneRatingStars(
  value: 3.5,
  color: 'var(--warning)',
  emptyColor: 'var(--muted)',
)
```

## Integer Only

```dart
ArcaneRatingStars(
  value: userRating,
  interactive: true,
  allowHalf: false,
  onChanged: (rating) => setRating(rating),
)
```

## Custom Max Value

```dart
// 10-star rating
ArcaneRatingStars(
  value: 7,
  maxValue: 10,
)
```

## With Label

```dart
ArcaneRow(
  gap: Gap.sm,
  children: [
    ArcaneRatingStars(value: 4.2),
    ArcaneText('4.2 out of 5'),
  ],
)
```

## Use Cases

- Product reviews
- Service ratings
- User feedback
- Quality indicators
- Skill level displays
