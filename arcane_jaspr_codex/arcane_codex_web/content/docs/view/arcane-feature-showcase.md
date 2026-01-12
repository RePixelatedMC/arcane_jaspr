---
title: ArcaneFeatureShowcase
description: A feature showcase section using expandable FlexiCards
layout: kb
component: feature-showcase
---

# ArcaneFeatureShowcase

A feature showcase section that displays a collection of features using interactive FlexiCards. Cards expand on hover to reveal detailed descriptions.

## Features

- Section with title and subtitle
- Interactive flexi cards that expand on hover
- Configurable card expansion ratios
- Centered or left-aligned header
- Optional click handlers and links

## Usage

```dart
ArcaneFeatureShowcase(
  title: 'Why Choose Us?',
  subtitle: 'Hover over any card to learn more.',
  items: [
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.server(size: IconSize.xl),
      title: 'Fast Servers',
      description: 'Enterprise-grade hardware with NVMe SSDs and DDR5 RAM.',
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.shield(size: IconSize.xl),
      title: 'DDoS Protection',
      description: 'Multi-layer protection against volumetric attacks.',
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.zap(size: IconSize.xl),
      title: 'Low Latency',
      description: 'Optimized network routing for minimal ping.',
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Section title |
| `subtitle` | `String?` | null | Section subtitle |
| `items` | `List<ArcaneFeatureShowcaseItem>` | required | Feature items to display |
| `expandedFlex` | `double` | `2.5` | Flex value for expanded cards |
| `collapsedFlex` | `double` | `1.0` | Flex value for collapsed cards |
| `gap` | `String` | `ArcaneSpacing.lg` | Gap between cards |
| `minCardWidth` | `String` | `'280px'` | Minimum width of each card |
| `expandOnHover` | `bool` | `true` | Show long text only on hover |
| `background` | `String?` | null | Custom background color |
| `centerHeader` | `bool` | `true` | Center the title/subtitle |

## ArcaneFeatureShowcaseItem

```dart
ArcaneFeatureShowcaseItem(
  icon: Component,       // Icon displayed at top
  title: String,         // Feature title (always visible)
  description: String,   // Description (shown on hover)
  header: Component?,    // Optional header component
  footer: Component?,    // Optional footer (e.g., "Learn more" link)
  onTap: VoidCallback?,  // Optional click handler
  href: String?,         // Optional link href
)
```

## Layout Customization

The showcase uses FlexiCards internally, so you can control the expansion behavior:

```dart
ArcaneFeatureShowcase(
  title: 'Features',
  expandedFlex: 3.0,    // More dramatic expansion
  collapsedFlex: 0.8,   // Smaller collapsed state
  gap: ArcaneSpacing.xl,
  items: [...],
)
```
