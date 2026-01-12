---
title: ArcaneFlexiCards
description: Interactive card layout where hovering expands the focused card while shrinking others
layout: kb
component: flexi-cards
---

# ArcaneFlexiCards

An interactive card layout where hovering on a card magnifies it while shrinking the others. Perfect for feature showcases, service highlights, and comparison displays.

## Basic Usage

```dart
ArcaneFlexiCards(
  items: [
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.server(),
      shortText: 'Fast Servers',
      longText: 'Enterprise-grade hardware with NVMe SSDs...',
    ),
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.shield(),
      shortText: 'DDoS Protection',
      longText: 'Multi-layer protection against attacks...',
    ),
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.zap(),
      shortText: 'Low Latency',
      longText: 'Optimized routing for minimal ping...',
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `items` | `List<ArcaneFlexiCardItem>` | required | List of card items to display |
| `collapsedFlex` | `double` | `1.0` | Flex-grow value for non-hovered cards |
| `expandedFlex` | `double` | `2.0` | Flex-grow value for hovered card |
| `scaleHeight` | `bool` | `false` | Whether to scale height on hover |
| `heightScaleFactor` | `double` | `1.05` | Height scale factor when scaleHeight is true |
| `gap` | `String` | `ArcaneSpacing.lg` | Gap between cards |
| `minCardWidth` | `String` | `'200px'` | Minimum width of each card |
| `transitionDuration` | `int` | `300` | Transition duration in milliseconds |
| `expandLongTextOnHover` | `bool` | `true` | Show long text only on hover |
| `heightPreLock` | `String?` | `null` | Locked height for collapsed cards |
| `heightPostLock` | `String?` | `null` | Locked height for expanded cards |
| `widthPreLock` | `String?` | `null` | Locked width for collapsed cards |
| `widthPostLock` | `String?` | `null` | Locked width for expanded cards |

## ArcaneFlexiCardItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Icon displayed at the top |
| `shortText` | `String` | required | Title text (always visible) |
| `longText` | `String` | required | Description text |
| `header` | `Component?` | `null` | Optional header component |
| `footer` | `Component?` | `null` | Optional footer component |
| `onTap` | `void Function()?` | `null` | Optional tap handler |
| `href` | `String?` | `null` | Optional link URL |

## Locked Dimensions

Use pre/post lock parameters to constrain card dimensions during hover transitions:

```dart
ArcaneFlexiCards(
  items: items,
  heightPreLock: '200px',   // Height when collapsed
  heightPostLock: '280px',  // Height when expanded
  widthPreLock: '180px',    // Width when collapsed
  widthPostLock: '320px',   // Width when expanded
)
```

When using locked dimensions, the flex behavior is replaced with explicit width/height values that animate smoothly on hover.

## With Footer

Use `ArcaneArrowLink` for clean footer links:

```dart
ArcaneFlexiCards(
  items: [
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.server(size: IconSize.xl),
      shortText: 'Enterprise Hardware',
      longText: 'High-performance processors and NVMe storage.',
      footer: const ArcaneArrowLink(label: 'View specs'),
    ),
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.shield(size: IconSize.xl),
      shortText: 'DDoS Protection',
      longText: 'Enterprise-grade protection included.',
      footer: const ArcaneArrowLink(label: 'Learn more'),
    ),
  ],
)
```

Or use buttons:

```dart
ArcaneFlexiCards(
  items: [
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.server(),
      shortText: 'Starter Plan',
      longText: 'Perfect for small projects and experiments.',
      footer: ArcaneButton.primary(
        label: 'Get Started',
        onPressed: () {},
      ),
    ),
  ],
)
```

## Clickable Cards

```dart
ArcaneFlexiCards(
  items: [
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.book(),
      shortText: 'Documentation',
      longText: 'Read our comprehensive guides.',
      href: '/docs',  // Makes the card a link
    ),
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.messageCircle(),
      shortText: 'Support',
      longText: 'Get help from our team.',
      onTap: () => openSupportChat(),  // Makes the card a button
    ),
  ],
)
```

## Simple Variant

For a pure CSS-based approach without state management (more performant but less customizable):

```dart
ArcaneFlexiCardsSimple(
  items: [
    ArcaneFlexiCardItem(
      icon: ArcaneIcon.star(),
      shortText: 'Feature 1',
      longText: 'Description...',
    ),
    // More items...
  ],
)
```

## Related Components

- [ArcaneFeatureShowcase](/arcane_jaspr/docs/layout/arcane-feature-showcase) - Full section wrapper for FlexiCards
- [ArcaneArrowLink](/arcane_jaspr/docs/view/arcane-arrow-link) - Inline link with arrow for footers
- [ArcaneFeatureCard](/arcane_jaspr/docs/view/arcane-feature-card) - Single feature card
- [ArcaneSurfaceCard](/arcane_jaspr/docs/view/arcane-surface-card) - Card with surface effects
- [ArcaneCard](/arcane_jaspr/docs/layout/arcane-card) - Basic card component
