---
title: ArcaneContextMenu
description: Right-click context menu
layout: docs
component: context-menu
---

# ArcaneContextMenu

Context menu that appears on right-click.

## Basic Usage

```dart
ArcaneContextMenu(
  trigger: ArcaneCard(child: content),
  items: [
    ArcaneMenuItem(label: 'Edit', onSelect: () => edit()),
    ArcaneMenuItem(label: 'Copy', onSelect: () => copy()),
    ArcaneMenuItem.separator(),
    ArcaneMenuItem(label: 'Delete', destructive: true, onSelect: () => delete()),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Element to right-click |
| `items` | `List<ArcaneMenuItem>` | required | Menu items |

## ArcaneMenuItem

Uses the unified `ArcaneMenuItem` class:

```dart
ArcaneMenuItem(
  label: 'Edit',
  icon: ArcaneIcon.edit(),
  shortcut: '⌘E',
  onSelect: () => handleEdit(),
  disabled: false,
  destructive: false,
  submenu: [...],
)

ArcaneMenuItem.separator()
```

## With Icons and Shortcuts

```dart
ArcaneContextMenu(
  trigger: FileItem(),
  items: [
    ArcaneMenuItem(
      label: 'Open',
      icon: ArcaneIcon.folderOpen(),
      shortcut: '⌘O',
      onSelect: () => openFile(),
    ),
    ArcaneMenuItem(
      label: 'Rename',
      icon: ArcaneIcon.edit(),
      shortcut: 'F2',
      onSelect: () => renameFile(),
    ),
    ArcaneMenuItem.separator(),
    ArcaneMenuItem(
      label: 'Delete',
      icon: ArcaneIcon.trash(),
      shortcut: '⌫',
      destructive: true,
      onSelect: () => deleteFile(),
    ),
  ],
)
```

## With Submenus

```dart
ArcaneContextMenu(
  trigger: element,
  items: [
    ArcaneMenuItem.submenu(
      label: 'Share',
      icon: ArcaneIcon.share(),
      items: [
        ArcaneMenuItem(label: 'Email', onSelect: shareEmail),
        ArcaneMenuItem(label: 'Link', onSelect: shareLink),
        ArcaneMenuItem(label: 'Twitter', onSelect: shareTwitter),
      ],
    ),
    ArcaneMenuItem.submenu(
      label: 'Export',
      items: [
        ArcaneMenuItem(label: 'PDF', onSelect: exportPdf),
        ArcaneMenuItem(label: 'PNG', onSelect: exportPng),
        ArcaneMenuItem(label: 'SVG', onSelect: exportSvg),
      ],
    ),
  ],
)
```

## Disabled Items

```dart
ArcaneContextMenu(
  trigger: element,
  items: [
    ArcaneMenuItem(label: 'Cut', shortcut: '⌘X', onSelect: cut),
    ArcaneMenuItem(label: 'Copy', shortcut: '⌘C', onSelect: copy),
    ArcaneMenuItem(
      label: 'Paste',
      shortcut: '⌘V',
      disabled: !hasClipboardContent,
      onSelect: paste,
    ),
  ],
)
```

## Features

- Appears at cursor position
- Submenus with nested items
- Separators for grouping
- Disabled items
- Destructive item styling
- Keyboard shortcut hints
- Click outside to close
- Escape key to close

## Related Components

- [ArcaneDropdownMenu](/arcane_jaspr/docs/navigation/arcane-dropdown-menu) - Click-triggered dropdown
- [ArcaneMenubar](/arcane_jaspr/docs/navigation/arcane-menubar) - Application menu bar
