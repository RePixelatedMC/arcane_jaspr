---
title: ArcaneMenubar
description: Horizontal application menu bar
layout: kb
component: menubar
---

# ArcaneMenubar

Horizontal menu bar like in desktop applications.

## Basic Usage

```dart
ArcaneMenubar(
  menus: [
    ArcaneMenubarMenu(
      label: 'File',
      items: [
        ArcaneMenuItem(label: 'New', shortcut: '⌘N', onSelect: () => newFile()),
        ArcaneMenuItem(label: 'Open', shortcut: '⌘O', onSelect: () => open()),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Save', shortcut: '⌘S', onSelect: () => save()),
      ],
    ),
    ArcaneMenubarMenu(
      label: 'Edit',
      items: [
        ArcaneMenuItem(label: 'Undo', shortcut: '⌘Z', onSelect: () => undo()),
        ArcaneMenuItem(label: 'Redo', shortcut: '⇧⌘Z', onSelect: () => redo()),
      ],
    ),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `menus` | `List<ArcaneMenubarMenu>` | required | Top-level menus |

## ArcaneMenubarMenu

Defines a top-level menu with its dropdown items:

```dart
ArcaneMenubarMenu(
  label: 'File',
  items: [
    ArcaneMenuItem(label: 'New', onSelect: newFile),
    ArcaneMenuItem(label: 'Open', onSelect: open),
  ],
)
```

## ArcaneMenuItem

Uses the unified `ArcaneMenuItem` class:

```dart
ArcaneMenuItem(
  label: 'New',
  icon: ArcaneIcon.plus(),
  shortcut: '⌘N',
  onSelect: () => createNew(),
  disabled: false,
  destructive: false,
  submenu: [...],
)

ArcaneMenuItem.separator()
```

## Complete Example

```dart
ArcaneMenubar(
  menus: [
    ArcaneMenubarMenu(
      label: 'File',
      items: [
        ArcaneMenuItem(label: 'New File', shortcut: '⌘N', onSelect: newFile),
        ArcaneMenuItem(label: 'New Window', shortcut: '⇧⌘N', onSelect: newWindow),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Open...', shortcut: '⌘O', onSelect: open),
        ArcaneMenuItem.submenu(
          label: 'Open Recent',
          items: [
            ArcaneMenuItem(label: 'document.txt', onSelect: () => openRecent(0)),
            ArcaneMenuItem(label: 'notes.md', onSelect: () => openRecent(1)),
            ArcaneMenuItem.separator(),
            ArcaneMenuItem(label: 'Clear Recent', onSelect: clearRecent),
          ],
        ),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Save', shortcut: '⌘S', onSelect: save),
        ArcaneMenuItem(label: 'Save As...', shortcut: '⇧⌘S', onSelect: saveAs),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Close', shortcut: '⌘W', onSelect: close),
      ],
    ),
    ArcaneMenubarMenu(
      label: 'Edit',
      items: [
        ArcaneMenuItem(label: 'Undo', shortcut: '⌘Z', onSelect: undo),
        ArcaneMenuItem(label: 'Redo', shortcut: '⇧⌘Z', onSelect: redo),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Cut', shortcut: '⌘X', onSelect: cut),
        ArcaneMenuItem(label: 'Copy', shortcut: '⌘C', onSelect: copy),
        ArcaneMenuItem(label: 'Paste', shortcut: '⌘V', onSelect: paste),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Find...', shortcut: '⌘F', onSelect: find),
        ArcaneMenuItem(label: 'Replace...', shortcut: '⌥⌘F', onSelect: replace),
      ],
    ),
    ArcaneMenubarMenu(
      label: 'View',
      items: [
        ArcaneMenuItem(label: 'Zoom In', shortcut: '⌘+', onSelect: zoomIn),
        ArcaneMenuItem(label: 'Zoom Out', shortcut: '⌘-', onSelect: zoomOut),
        ArcaneMenuItem(label: 'Reset Zoom', shortcut: '⌘0', onSelect: resetZoom),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'Full Screen', shortcut: '⌃⌘F', onSelect: fullScreen),
      ],
    ),
    ArcaneMenubarMenu(
      label: 'Help',
      items: [
        ArcaneMenuItem(label: 'Documentation', onSelect: openDocs),
        ArcaneMenuItem(label: 'Keyboard Shortcuts', shortcut: '⌘/', onSelect: showShortcuts),
        ArcaneMenuItem.separator(),
        ArcaneMenuItem(label: 'About', onSelect: showAbout),
      ],
    ),
  ],
)
```

## Features

- Desktop app-style menu structure
- Hover to switch between open menus
- Click to toggle dropdown
- Submenus with nested items
- Keyboard shortcuts display
- Separators for grouping
- Disabled and destructive items

## Related Components

- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Select dropdown
- [ArcaneContextMenu](/arcane_jaspr/docs/navigation/arcane-context-menu) - Right-click menu
