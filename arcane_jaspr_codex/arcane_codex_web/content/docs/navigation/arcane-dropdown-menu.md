---
title: ArcaneDropdownMenu
description: Contextual dropdown menu with items
layout: docs
component: dropdown-menu
---

# ArcaneDropdownMenu

A dropdown menu component that displays a list of actions when triggered.

## Basic Usage

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton.secondary(label: 'Options'),
  items: [
    ArcaneMenuItem(label: 'Edit', onSelect: edit),
    ArcaneMenuItem(label: 'Duplicate', onSelect: duplicate),
    ArcaneMenuItem(label: 'Delete', onSelect: delete),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Trigger element |
| `items` | `List<ArcaneMenuItem>` | required | Menu items |
| `align` | `DropdownAlign` | `start` | Menu alignment |
| `position` | `DropdownPosition` | `bottom` | Menu position |
| `width` | `String?` | `null` | Custom width |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## ArcaneMenuItem

The unified menu item class used across all menu components:

```dart
ArcaneMenuItem(
  label: 'Edit',
  icon: ArcaneIcon.edit(),
  shortcut: '⌘E',
  onSelect: () => handleEdit(),
  disabled: false,
  destructive: false,
)

// Separator
ArcaneMenuItem.separator()

// With submenu
ArcaneMenuItem.submenu(
  label: 'Share',
  icon: ArcaneIcon.share(),
  items: [
    ArcaneMenuItem(label: 'Email', onSelect: shareEmail),
    ArcaneMenuItem(label: 'Link', onSelect: shareLink),
  ],
)
```

### ArcaneMenuItem Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String` | required | Item text |
| `icon` | `Component?` | `null` | Leading icon |
| `onSelect` | `VoidCallback?` | `null` | Click handler |
| `href` | `String?` | `null` | Navigation URL |
| `description` | `String?` | `null` | Item description |
| `shortcut` | `String?` | `null` | Keyboard shortcut hint |
| `disabled` | `bool` | `false` | Disabled state |
| `destructive` | `bool` | `false` | Destructive style |
| `submenu` | `List<ArcaneMenuItem>?` | `null` | Nested items |
| `isSeparator` | `bool` | `false` | Is separator item |

## With Icons

```dart
ArcaneDropdownMenu(
  trigger: ArcaneIconButton(icon: ArcaneIcon.moreVertical()),
  items: [
    ArcaneMenuItem(
      icon: ArcaneIcon.edit(),
      label: 'Edit',
      onSelect: edit,
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.copy(),
      label: 'Copy',
      onSelect: copy,
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.share(),
      label: 'Share',
      onSelect: share,
    ),
    ArcaneMenuItem.separator(),
    ArcaneMenuItem(
      icon: ArcaneIcon.trash(),
      label: 'Delete',
      onSelect: delete,
      destructive: true,
    ),
  ],
)
```

## Alignment

```dart
// Start aligned (default)
ArcaneDropdownMenu(
  align: DropdownAlign.start,
  trigger: Trigger(),
  items: items,
)

// End aligned
ArcaneDropdownMenu(
  align: DropdownAlign.end,
  trigger: Trigger(),
  items: items,
)

// Center aligned
ArcaneDropdownMenu(
  align: DropdownAlign.center,
  trigger: Trigger(),
  items: items,
)
```

## Position

```dart
// Bottom (default)
ArcaneDropdownMenu(
  position: DropdownPosition.bottom,
  trigger: Trigger(),
  items: items,
)

// Top
ArcaneDropdownMenu(
  position: DropdownPosition.top,
  trigger: Trigger(),
  items: items,
)
```

## Examples

### User Profile Menu

```dart
ArcaneDropdownMenu(
  trigger: ArcaneRow(
    gapSize: Gap.sm,
    children: [
      ArcaneAvatar(imageUrl: user.avatar, size: AvatarSize.sm),
      ArcaneText(user.name),
      ArcaneIcon.chevronDown(size: IconSize.sm),
    ],
  ),
  items: [
    ArcaneMenuItem(
      icon: ArcaneIcon.user(),
      label: 'Profile',
      href: '/profile',
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.settings(),
      label: 'Settings',
      href: '/settings',
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.helpCircle(),
      label: 'Help',
      href: '/help',
    ),
    ArcaneMenuItem.separator(),
    ArcaneMenuItem(
      icon: ArcaneIcon.logOut(),
      label: 'Sign Out',
      onSelect: signOut,
    ),
  ],
)
```

### Table Row Actions

```dart
ArcaneDropdownMenu(
  trigger: ArcaneIconButton(icon: ArcaneIcon.moreVertical()),
  align: DropdownAlign.end,
  items: [
    ArcaneMenuItem(
      icon: ArcaneIcon.eye(),
      label: 'View',
      onSelect: () => view(item),
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.edit(),
      label: 'Edit',
      onSelect: () => edit(item),
    ),
    ArcaneMenuItem.separator(),
    ArcaneMenuItem(
      icon: ArcaneIcon.trash(),
      label: 'Delete',
      onSelect: () => delete(item),
      destructive: true,
    ),
  ],
)
```

### File Operations

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton.secondary(
    leading: ArcaneIcon.folder(),
    label: 'File',
  ),
  width: '200px',
  items: [
    ArcaneMenuItem(
      icon: ArcaneIcon.filePlus(),
      label: 'New File',
      shortcut: '⌘N',
      onSelect: newFile,
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.folderOpen(),
      label: 'Open...',
      shortcut: '⌘O',
      onSelect: openFile,
    ),
    ArcaneMenuItem.separator(),
    ArcaneMenuItem(
      icon: ArcaneIcon.save(),
      label: 'Save',
      shortcut: '⌘S',
      onSelect: save,
    ),
    ArcaneMenuItem(
      icon: ArcaneIcon.download(),
      label: 'Save As...',
      shortcut: '⇧⌘S',
      onSelect: saveAs,
    ),
  ],
)
```

## Related Components

- [ArcaneButton](/arcane_jaspr/docs/inputs/arcane-button) - Button trigger
- [ArcaneSelect](/arcane_jaspr/docs/inputs/arcane-select) - Form select input
- [ArcaneContextMenu](/arcane_jaspr/docs/navigation/arcane-context-menu) - Right-click menu
- [ArcaneMenubar](/arcane_jaspr/docs/navigation/arcane-menubar) - Application menu bar
