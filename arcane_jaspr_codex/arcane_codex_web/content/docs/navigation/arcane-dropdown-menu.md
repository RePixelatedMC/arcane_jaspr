---
title: ArcaneDropdownMenu
description: Dropdown menu with actions, checkboxes, radios, and submenus
layout: kb
component: dropdown-menu
---

# ArcaneDropdownMenu

A dropdown menu component that supports various menu item types including actions, checkboxes, radio buttons, separators, and nested submenus.

## Basic Usage

```dart
ArcaneDropdownMenu(
  trigger: ArcaneButton(label: 'Open Menu'),
  items: [
    MenuItemAction(label: 'Edit', icon: ArcaneIcon.edit()),
    MenuItemAction(label: 'Duplicate', icon: ArcaneIcon.copy()),
    MenuItemSeparator(),
    MenuItemAction(
      label: 'Delete',
      icon: ArcaneIcon.trash(),
      destructive: true,
    ),
  ],
)
```

## Menu Item Types

### Action Items

Standard clickable menu items:

```dart
MenuItemAction(
  label: 'Save',
  icon: ArcaneIcon.save(),
  shortcut: 'Cmd+S',
  onTap: () => saveDocument(),
)
```

### Separator

Visual divider between groups:

```dart
MenuItemSeparator()
```

### Label

Non-interactive section header:

```dart
MenuItemLabel(label: 'Actions')
```

### Checkbox

Toggleable checkbox item:

```dart
MenuItemCheckbox(
  label: 'Show Hidden Files',
  checked: showHidden,
  onChanged: (value) => setShowHidden(value),
)
```

### Radio

Mutually exclusive selection:

```dart
MenuItemRadio(
  label: 'Small',
  value: 'small',
  groupValue: selectedSize,
  onChanged: (value) => setSize(value),
)
```

### Submenu

Nested menu:

```dart
MenuItemSubmenu(
  label: 'Share',
  icon: ArcaneIcon.share(),
  items: [
    MenuItemAction(label: 'Email', onTap: () => shareEmail()),
    MenuItemAction(label: 'Link', onTap: () => shareLink()),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `trigger` | `Component` | required | Element that opens menu |
| `items` | `List<ArcaneMenuItem>` | required | Menu items |
| `align` | `MenuAlignment` | `start` | Menu alignment |
| `side` | `MenuSide` | `bottom` | Menu position |

## Complete Example

```dart
ArcaneDropdownMenu(
  trigger: ArcaneIconButton(icon: ArcaneIcon.moreVertical()),
  items: [
    MenuItemLabel(label: 'File'),
    MenuItemAction(
      label: 'New',
      icon: ArcaneIcon.plus(),
      shortcut: 'Cmd+N',
      onTap: () => newFile(),
    ),
    MenuItemAction(
      label: 'Open',
      icon: ArcaneIcon.folder(),
      shortcut: 'Cmd+O',
      onTap: () => openFile(),
    ),
    MenuItemSeparator(),
    MenuItemLabel(label: 'View'),
    MenuItemCheckbox(
      label: 'Show Sidebar',
      checked: showSidebar,
      onChanged: (v) => toggleSidebar(v),
    ),
    MenuItemSubmenu(
      label: 'Theme',
      icon: ArcaneIcon.palette(),
      items: [
        MenuItemRadio(label: 'Light', value: 'light', groupValue: theme),
        MenuItemRadio(label: 'Dark', value: 'dark', groupValue: theme),
        MenuItemRadio(label: 'System', value: 'system', groupValue: theme),
      ],
    ),
    MenuItemSeparator(),
    MenuItemAction(
      label: 'Delete',
      icon: ArcaneIcon.trash(),
      destructive: true,
      onTap: () => deleteFile(),
    ),
  ],
)
```

## Use Cases

- File/edit menus
- Settings dropdowns
- Action menus
- User account menus
- Context-aware options
