---
title: ArcaneIconButton
description: Compact icon-only button component
layout: docs
component: icon-button
---

# ArcaneIconButton

A compact button that displays only an icon, ideal for toolbars, action menus, and space-constrained interfaces.

## Basic Usage

```dart
ArcaneIconButton(
  icon: ArcaneIcon.x(),
  onPressed: () {
    print('Icon button pressed');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `icon` | `Component` | required | Icon to display |
| `onPressed` | `VoidCallback?` | `null` | Click handler |
| `size` | `IconButtonSize` | `medium` | Button size |
| `variant` | `IconButtonVariant` | `ghost` | Visual variant |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `tooltip` | `String?` | `null` | Tooltip text |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Factory Constructors

### Close Button

Pre-configured close button with X icon:

```dart
ArcaneIconButton.close(
  onPressed: () => closeDialog(),
)
```

This is a convenience factory for the common pattern of close/dismiss buttons.

## Variants

### Ghost (Default)

Minimal, transparent background:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.search(),
  variant: IconButtonVariant.ghost,
  onPressed: () {},
)
```

### Filled

Solid background:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.plus(),
  variant: IconButtonVariant.filled,
  onPressed: () {},
)
```

### Outline

Bordered with transparent background:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.settings(),
  variant: IconButtonVariant.outline,
  onPressed: () {},
)
```

## Sizes

```dart
// Small
ArcaneIconButton(
  icon: ArcaneIcon.check(),
  size: IconButtonSize.small,
  onPressed: () {},
)

// Medium (default)
ArcaneIconButton(
  icon: ArcaneIcon.check(),
  size: IconButtonSize.medium,
  onPressed: () {},
)

// Large
ArcaneIconButton(
  icon: ArcaneIcon.check(),
  size: IconButtonSize.large,
  onPressed: () {},
)
```

## With Tooltip

```dart
ArcaneIconButton(
  icon: ArcaneIcon.trash(),
  tooltip: 'Delete item',
  onPressed: () {},
)
```

## Examples

### Toolbar

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.xs,
    padding: PaddingPreset.sm,
    background: Background.surface,
    borderRadius: Radius.md,
  ),
  children: [
    ArcaneIconButton(
      icon: ArcaneIcon.bold(),
      tooltip: 'Bold',
      onPressed: () => toggleBold(),
    ),
    ArcaneIconButton(
      icon: ArcaneIcon.italic(),
      tooltip: 'Italic',
      onPressed: () => toggleItalic(),
    ),
    ArcaneIconButton(
      icon: ArcaneIcon.underline(),
      tooltip: 'Underline',
      onPressed: () => toggleUnderline(),
    ),
    ArcaneDivider(direction: DividerDirection.vertical),
    ArcaneIconButton(
      icon: ArcaneIcon.link(),
      tooltip: 'Insert link',
      onPressed: () => insertLink(),
    ),
  ],
)
```

### Card Actions

```dart
ArcaneCard(
  children: [
    // Card content...
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.flexEnd,
        gap: Gap.sm,
      ),
      children: [
        ArcaneIconButton(
          icon: ArcaneIcon.edit(),
          tooltip: 'Edit',
          onPressed: () => editItem(),
        ),
        ArcaneIconButton(
          icon: ArcaneIcon.trash(),
          tooltip: 'Delete',
          onPressed: () => deleteItem(),
        ),
      ],
    ),
  ],
)
```

### Dialog with Close Button

```dart
ArcaneDialog(
  isOpen: showDialog,
  onClose: () => close(),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
      ),
      children: [
        ArcaneHeadline('Dialog Title'),
        ArcaneIconButton.close(onPressed: () => close()),
      ],
    ),
    // Dialog content...
  ],
)
```

### Table Row Actions

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.xs,
  ),
  children: [
    ArcaneIconButton(
      icon: ArcaneIcon.eye(),
      size: IconButtonSize.small,
      tooltip: 'View',
      onPressed: () => viewItem(id),
    ),
    ArcaneIconButton(
      icon: ArcaneIcon.edit(),
      size: IconButtonSize.small,
      tooltip: 'Edit',
      onPressed: () => editItem(id),
    ),
    ArcaneIconButton(
      icon: ArcaneIcon.moreVertical(),
      size: IconButtonSize.small,
      tooltip: 'More',
      onPressed: () => showMenu(id),
    ),
  ],
)
```

## Related Components

- [ArcaneButton](/arcane_jaspr/docs/inputs/arcane-button) - Full button with label
- [ArcaneFAB](/arcane_jaspr/docs/inputs/arcane-fab) - Floating action button
