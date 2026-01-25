---
title: ArcaneFloating
description: Unified floating UI component for tooltips, popovers, and hovercards
layout: kb
component: floating
---

# ArcaneFloating

A unified floating UI component that combines tooltip, popover, and hovercard functionality into a single component with named constructors.

## Basic Usage

### Tooltip

Simple text tooltip on hover:

```dart
ArcaneFloating.tooltip(
  message: 'This is a helpful tip',
  child: ArcaneButton(label: 'Hover me'),
)
```

### Custom Tooltip

Tooltip with custom content:

```dart
ArcaneFloating.tooltipCustom(
  content: ArcaneRow(
    children: [
      ArcaneIcon.info(),
      ArcaneText('Custom tooltip content'),
    ],
  ),
  child: ArcaneIconButton(icon: ArcaneIcon.helpCircle()),
)
```

### Popover

Click-triggered floating content:

```dart
ArcaneFloating.popover(
  content: ArcaneColumn(
    children: [
      ArcaneText('Popover Title', style: TextStyle.heading),
      ArcaneText('Popover content goes here'),
      ArcaneButton(label: 'Action'),
    ],
  ),
  child: ArcaneButton(label: 'Click me'),
)
```

### Hovercard

Hover-triggered card with rich content:

```dart
ArcaneFloating.hovercard(
  content: ArcaneCard(
    children: [
      ArcaneAvatar(imageUrl: user.avatarUrl),
      ArcaneText(user.name),
      ArcaneText(user.bio),
    ],
  ),
  child: ArcaneLink(label: user.name),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `content` | `Component` | required | The floating content to display |
| `child` | `Component` | required | The trigger element |
| `trigger` | `FloatingTrigger` | varies | How to trigger the floating content |
| `position` | `FloatingPosition` | `bottom` | Where to position the floating content |
| `offset` | `double` | `8.0` | Distance from trigger element |
| `showArrow` | `bool` | `true` | Whether to show pointing arrow |

## Trigger Types

```dart
enum FloatingTrigger {
  hover,   // Show on mouse hover
  click,   // Show on click (toggle)
  manual,  // Controlled programmatically
}
```

## Position Options

```dart
enum FloatingPosition {
  top,
  topStart,
  topEnd,
  bottom,
  bottomStart,
  bottomEnd,
  left,
  right,
}
```

## Migration Guide

If you were using the old separate components:

```dart
// Old: ArcaneTooltip
ArcaneTooltip(message: 'Tip', child: ...)

// New: ArcaneFloating.tooltip
ArcaneFloating.tooltip(message: 'Tip', child: ...)

// Old: ArcanePopover
ArcanePopover(content: ..., child: ...)

// New: ArcaneFloating.popover
ArcaneFloating.popover(content: ..., child: ...)

// Old: ArcaneHovercard
ArcaneHovercard(content: ..., child: ...)

// New: ArcaneFloating.hovercard
ArcaneFloating.hovercard(content: ..., child: ...)
```

## Use Cases

- Info tooltips on form fields
- User profile hovercards
- Settings popovers
- Help text explanations
- Action menus
