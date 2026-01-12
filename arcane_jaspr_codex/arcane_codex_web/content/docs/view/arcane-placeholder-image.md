---
title: ArcanePlaceholderImage
description: Display placeholder images from various sources
layout: kb
component: placeholder-image
---

# ArcanePlaceholderImage

A component for displaying placeholder images from various external services including cat images, stock photos, and solid color placeholders.

## Basic Usage

```dart
ArcanePlaceholderImage(
  seed: 'my-unique-seed',
  size: PlaceholderSize.md,
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `source` | `PlaceholderSource` | `cat` | Image source provider |
| `seed` | `String?` | `null` | Seed for consistent images |
| `size` | `PlaceholderSize` | `md` | Size preset |
| `width` | `int?` | `null` | Custom width (overrides size) |
| `height` | `int?` | `null` | Custom height (overrides size) |
| `shape` | `PlaceholderShape` | `rounded` | Image shape |
| `fit` | `PlaceholderFit` | `cover` | Object fit behavior |
| `alt` | `String?` | `null` | Alt text for accessibility |
| `text` | `String?` | `null` | Text overlay (cat source only) |
| `animated` | `bool` | `false` | Use GIF (cat source only) |
| `grayscale` | `bool` | `false` | Grayscale filter |
| `blur` | `int?` | `null` | Blur amount (picsum only, 0-10) |
| `lazy` | `bool` | `true` | Use lazy loading |
| `onTap` | `VoidCallback?` | `null` | Click handler |

## Image Sources

### Cat Images (Default)

Random cat images from [cataas.com](https://cataas.com).

```dart
// Default cat image
ArcanePlaceholderImage.cat(seed: 'cat-1')

// With text overlay
ArcanePlaceholderImage.cat(
  seed: 'cat-2',
  text: 'Hello!',
)

// Animated GIF
ArcanePlaceholderImage.cat(
  seed: 'cat-3',
  animated: true,
)
```

### Photo Images

Stock photos from [picsum.photos](https://picsum.photos).

```dart
// Random photo
ArcanePlaceholderImage.photo(seed: 'photo-1')

// Grayscale
ArcanePlaceholderImage.photo(
  seed: 'photo-2',
  grayscale: true,
)

// Blurred
ArcanePlaceholderImage.photo(
  seed: 'photo-3',
  blur: 3,
)
```

### Solid Color Placeholders

Solid color images from [placeholder.com](https://placeholder.com).

```dart
ArcanePlaceholderImage(
  source: PlaceholderSource.placeholder,
  backgroundColor: '#1e1e2e',
  textColor: '#f8f8f2',
  text: '256x256',
)
```

## Sizes

```dart
// Extra small (64x64)
ArcanePlaceholderImage(seed: 'xs', size: PlaceholderSize.xs)

// Small (128x128)
ArcanePlaceholderImage(seed: 'sm', size: PlaceholderSize.sm)

// Medium (256x256) - default
ArcanePlaceholderImage(seed: 'md', size: PlaceholderSize.md)

// Large (512x512)
ArcanePlaceholderImage(seed: 'lg', size: PlaceholderSize.lg)

// Extra large (1024x1024)
ArcanePlaceholderImage(seed: 'xl', size: PlaceholderSize.xl)
```

## Shapes

```dart
// Square (no border radius)
ArcanePlaceholderImage(
  seed: 'square',
  shape: PlaceholderShape.square,
)

// Rounded (default)
ArcanePlaceholderImage(
  seed: 'rounded',
  shape: PlaceholderShape.rounded,
)

// Circle
ArcanePlaceholderImage(
  seed: 'circle',
  shape: PlaceholderShape.circle,
)
```

## Examples

### Image Gallery

```dart
ArcaneRow(
  gapSize: Gap.md,
  children: [
    ArcanePlaceholderImage.photo(seed: 'gallery-1', size: PlaceholderSize.sm),
    ArcanePlaceholderImage.photo(seed: 'gallery-2', size: PlaceholderSize.sm),
    ArcanePlaceholderImage.photo(seed: 'gallery-3', size: PlaceholderSize.sm),
  ],
)
```

### Avatar Fallback

```dart
ArcanePlaceholderImage.cat(
  seed: 'user-avatar',
  size: PlaceholderSize.xs,
  shape: PlaceholderShape.circle,
)
```

### Thumbnail Grid

```dart
ArcaneFlow(
  gapSize: Gap.sm,
  children: [
    for (var i = 0; i < 6; i++)
      ArcanePlaceholderImage.photo(
        seed: 'thumb-$i',
        size: PlaceholderSize.sm,
      ),
  ],
)
```

## Related Components

- [ArcaneAvatar](/arcane_jaspr/docs/view/arcane-avatar) - User avatars with initials fallback
- [ArcaneSkeleton](/arcane_jaspr/docs/view/arcane-skeleton) - Loading placeholders
