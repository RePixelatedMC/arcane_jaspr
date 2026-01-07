---
title: ArcaneArrowLink
description: Inline text link with arrow icon
layout: docs
component: arrow-link
---

# ArcaneArrowLink

A simple inline text link with an arrow icon. Perfect for card footers, "Learn more" links, and inline CTAs.

## Basic Usage

```dart
const ArcaneArrowLink(label: 'Learn more')
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Link text |
| `href` | `String?` | `null` | Navigation URL |
| `onTap` | `VoidCallback?` | `null` | Click handler |
| `size` | `ArrowLinkSize` | `sm` | Text size |
| `showArrow` | `bool` | `true` | Show arrow icon |
| `arrowBefore` | `bool` | `false` | Arrow before text (back link) |
| `accent` | `bool` | `true` | Use accent color |

## Sizes

```dart
const ArcaneArrowLink(label: 'Extra small', size: ArrowLinkSize.xs)
const ArcaneArrowLink(label: 'Small', size: ArrowLinkSize.sm)       // default
const ArcaneArrowLink(label: 'Medium', size: ArrowLinkSize.md)
const ArcaneArrowLink(label: 'Large', size: ArrowLinkSize.lg)
```

## Variants

### Accent (Default)

```dart
const ArcaneArrowLink(label: 'View details')
// or explicitly:
const ArcaneArrowLink.accent(label: 'View details')
```

### Muted

```dart
const ArcaneArrowLink.muted(label: 'Skip for now')
```

## With Navigation

```dart
const ArcaneArrowLink(
  label: 'Read the docs',
  href: '/docs',
)
```

## With Click Handler

```dart
ArcaneArrowLink(
  label: 'Show details',
  onTap: () => showDetails(),
)
```

## Back Link (Arrow Before)

```dart
const ArcaneArrowLink(
  label: 'Go back',
  arrowBefore: true,
)
```

## Without Arrow

```dart
const ArcaneArrowLink(
  label: 'Simple link',
  showArrow: false,
)
```

## In Card Footer

```dart
ArcaneFlexiCardItem(
  icon: ArcaneIcon.server(size: IconSize.xl),
  shortText: 'Enterprise Hardware',
  longText: 'High-performance processors and NVMe storage.',
  footer: const ArcaneArrowLink(label: 'View specs'),
)
```

## In Feature Showcase

```dart
ArcaneFeatureShowcaseItem(
  icon: ArcaneIcon.shield(size: IconSize.xl),
  title: 'DDoS Protection',
  description: 'Enterprise-grade protection included.',
  footer: const ArcaneArrowLink(label: 'Learn more'),
)
```

## Navigation Links

```dart
ArcaneRow(
  gap: Gap.lg,
  children: [
    const ArcaneArrowLink(
      label: 'Previous',
      arrowBefore: true,
      href: '/page/1',
    ),
    const ArcaneArrowLink(
      label: 'Next',
      href: '/page/3',
    ),
  ],
)
```

## Related Components

- [ArcaneFlexiCards](/arcane_jaspr/docs/view/arcane-flexi-cards) - Interactive card layout
- [ArcaneFeatureShowcase](/arcane_jaspr/docs/layout/arcane-feature-showcase) - Feature sections
- [ArcaneButton](/arcane_jaspr/docs/inputs/arcane-button) - Full button component
