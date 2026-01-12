---
title: ArcaneIconButton
description: Compact icon-only button component
layout: kb
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
| `style` | `IconButtonStyle` | `ghost` | Visual style |
| `disabled` | `bool` | `false` | Disable interaction |
| `tooltip` | `String?` | `null` | Tooltip text |

## Style Constructors

Quick access to common styles:

```dart
// Primary style
ArcaneIconButton.primary(
  icon: ArcaneIcon.plus(),
  onPressed: () {},
)

// Ghost style (default minimal)
ArcaneIconButton.ghost(
  icon: ArcaneIcon.settings(),
  onPressed: () {},
)

// Outline style
ArcaneIconButton.outline(
  icon: ArcaneIcon.search(),
  onPressed: () {},
)

// Destructive style
ArcaneIconButton.destructive(
  icon: ArcaneIcon.trash(),
  onPressed: () {},
)
```

## Styles

### Ghost (Default)

Minimal, transparent background:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.search(),
  style: IconButtonStyle.ghost,
  onPressed: () {},
)
```

### Primary

Solid primary background:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.plus(),
  style: IconButtonStyle.primary,
  onPressed: () {},
)
```

### Outline

Bordered with transparent background:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.settings(),
  style: IconButtonStyle.outline,
  onPressed: () {},
)
```

### Destructive

For delete/remove actions:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.trash(),
  style: IconButtonStyle.destructive,
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
ArcaneRow(
  gapSize: Gap.xs,
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
  ],
)
```

### Close Button

For dialogs and modals, use a ghost icon button with the close icon:

```dart
ArcaneIconButton(
  icon: ArcaneIcon.x(),
  tooltip: 'Close',
  onPressed: () => closeDialog(),
)
```

### Card Actions

```dart
ArcaneRow(
  gapSize: Gap.sm,
  children: [
    ArcaneIconButton(
      icon: ArcaneIcon.edit(),
      tooltip: 'Edit',
      onPressed: () => editItem(),
    ),
    ArcaneIconButton.destructive(
      icon: ArcaneIcon.trash(),
      tooltip: 'Delete',
      onPressed: () => deleteItem(),
    ),
  ],
)
```

## Related Components

- [ArcaneButton](/arcane_jaspr/docs/inputs/arcane-button) - Full button with label
- [ArcaneFAB](/arcane_jaspr/docs/inputs/arcane-fab) - Floating action button
