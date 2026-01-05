---
title: ArcaneFeatureShowcase
description: Full-page section using FlexiCards for feature highlights
layout: docs
component: feature-showcase
---

# ArcaneFeatureShowcase

A complete section component that wraps `ArcaneFlexiCards` with a title, subtitle, and proper layout. Perfect for landing pages and marketing sections.

## Basic Usage

```dart
ArcaneFeatureShowcase(
  title: 'Why Choose Us?',
  subtitle: 'Hover over any card to learn more.',
  items: [
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.server(size: IconSize.xl),
      title: 'Fast Servers',
      description: 'Enterprise-grade hardware with NVMe SSDs.',
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.shield(size: IconSize.xl),
      title: 'DDoS Protection',
      description: 'Multi-layer protection against attacks.',
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.zap(size: IconSize.xl),
      title: 'Low Latency',
      description: 'Optimized routing for minimal ping.',
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String` | required | Section title |
| `subtitle` | `String?` | `null` | Section subtitle |
| `items` | `List<ArcaneFeatureShowcaseItem>` | required | Feature items |
| `expandedFlex` | `double` | `2.5` | Flex value for hovered card |
| `collapsedFlex` | `double` | `1.0` | Flex value for other cards |
| `gap` | `String` | `ArcaneSpacing.lg` | Gap between cards |
| `minCardWidth` | `String` | `'280px'` | Minimum card width |
| `expandOnHover` | `bool` | `true` | Show description on hover only |
| `background` | `String?` | `null` | Section background color |
| `centerHeader` | `bool` | `true` | Center title and subtitle |

## ArcaneFeatureShowcaseItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Feature icon |
| `title` | `String` | required | Feature title |
| `description` | `String` | required | Feature description |
| `header` | `Component?` | `null` | Optional header badge |
| `footer` | `Component?` | `null` | Footer link/action |
| `onTap` | `VoidCallback?` | `null` | Click handler |
| `href` | `String?` | `null` | Link destination |

## With Footer Links

```dart
ArcaneFeatureShowcase(
  title: 'Our Services',
  subtitle: 'Everything you need to succeed.',
  items: [
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.server(size: IconSize.xl),
      title: 'Enterprise Hardware',
      description: 'High-performance processors and NVMe storage.',
      footer: const ArcaneArrowLink(label: 'View specs'),
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.shield(size: IconSize.xl),
      title: 'Security',
      description: 'Enterprise-grade protection included.',
      footer: const ArcaneArrowLink(label: 'Learn more'),
    ),
  ],
)
```

## Custom Styling

```dart
ArcaneFeatureShowcase(
  title: 'Premium Features',
  subtitle: 'Available on all plans.',
  background: 'var(--arcane-surface-variant)',
  centerHeader: false,  // Left-align header
  expandedFlex: 3.0,
  gap: '32px',
  items: [...],
)
```

## With Header Badges

```dart
ArcaneFeatureShowcase(
  title: 'Pricing Plans',
  items: [
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.rocket(size: IconSize.xl),
      title: 'Starter',
      description: 'For small projects.',
      header: const ArcaneBadge(label: 'Free'),
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.star(size: IconSize.xl),
      title: 'Pro',
      description: 'For growing teams.',
      header: const ArcaneBadge(label: 'Popular', variant: BadgeVariant.accent),
    ),
  ],
)
```

## Full Example

```dart
ArcaneFeatureShowcase(
  title: 'Why Choose QualityNode?',
  subtitle: 'Hover over any card to learn more about our features.',
  expandedFlex: 2.5,
  collapsedFlex: 1.0,
  gap: '24px',
  minCardWidth: '280px',
  items: [
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.server(size: IconSize.xl),
      title: 'Enterprise Hardware',
      description:
          'All servers run on enterprise-grade hardware featuring the latest '
          'AMD EPYC and Intel Xeon processors, ECC memory, and NVMe SSDs.',
      footer: const ArcaneArrowLink(label: 'View specs'),
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.shield(size: IconSize.xl),
      title: 'DDoS Protection',
      description:
          'Every server includes enterprise-grade DDoS protection at no extra '
          'cost. Our multi-layer mitigation handles attacks up to 1+ Tbps.',
      footer: const ArcaneArrowLink(label: 'Learn more'),
    ),
    ArcaneFeatureShowcaseItem(
      icon: ArcaneIcon.zap(size: IconSize.xl),
      title: 'Ultra-Low Latency',
      description:
          'Strategic datacenter locations combined with premium network '
          'providers ensure the lowest possible ping for your players.',
      footer: const ArcaneArrowLink(label: 'Test latency'),
    ),
  ],
)
```

## Related Components

- [ArcaneFlexiCards](/arcane_jaspr/docs/view/arcane-flexi-cards) - Underlying card component
- [ArcaneArrowLink](/arcane_jaspr/docs/view/arcane-arrow-link) - Footer links
- [ArcaneHeroSection](/arcane_jaspr/docs/layout/arcane-hero-section) - Hero sections
- [ArcaneSection](/arcane_jaspr/docs/layout/arcane-section) - Generic sections
