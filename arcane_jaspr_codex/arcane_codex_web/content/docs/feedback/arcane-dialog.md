---
title: ArcaneDialog
description: Modal dialog for important content and actions
layout: docs
component: dialog
---

# ArcaneDialog

A flexible modal dialog component for displaying content, confirmations, forms, or any custom UI.

## Basic Usage

```dart
ArcaneDialog(
  title: 'Dialog Title',
  children: [
    ArcaneText('Dialog content goes here.'),
  ],
  actions: [
    ArcaneButton(label: 'Cancel', variant: ButtonVariant.outline, onPressed: close),
    ArcaneButton(label: 'Confirm', variant: ButtonVariant.primary, onPressed: confirm),
  ],
  onClose: close,
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String?` | `null` | Dialog title text |
| `child` | `Component?` | `null` | Single content component |
| `children` | `List<Component>?` | `null` | Multiple content components |
| `actions` | `List<Component>?` | `null` | Action buttons in footer |
| `showCloseButton` | `bool` | `true` | Show X close button |
| `onClose` | `VoidCallback?` | `null` | Called when dialog closes |
| `maxWidth` | `double` | `500` | Maximum dialog width in pixels |
| `barrierDismissible` | `bool` | `true` | Click outside to close |

## Confirmation Dialog

```dart
ArcaneDialog(
  title: 'Delete Project?',
  children: [
    ArcaneText('Are you sure you want to delete this project?'),
    ArcaneText(
      'This action cannot be undone.',
      styles: ArcaneStyleData(color: 'var(--destructive)'),
    ),
  ],
  actions: [
    ArcaneButton(
      label: 'Cancel',
      variant: ButtonVariant.outline,
      onPressed: close,
    ),
    ArcaneButton(
      label: 'Delete',
      variant: ButtonVariant.destructive,
      onPressed: () {
        deleteProject();
        close();
      },
    ),
  ],
  onClose: close,
)
```

## Form Dialog

Compose any form inputs inside the dialog content:

```dart
ArcaneDialog(
  title: 'Edit Profile',
  maxWidth: 450,
  children: [
    ArcaneTextInput(
      label: 'Display Name',
      value: displayName,
      onChanged: (value) => setState(() => displayName = value),
    ),
    ArcaneTextInput(
      label: 'Email',
      value: email,
      onChanged: (value) => setState(() => email = value),
    ),
    ArcaneTextArea(
      label: 'Bio',
      value: bio,
      maxLines: 4,
      onChanged: (value) => setState(() => bio = value),
    ),
  ],
  actions: [
    ArcaneButton(
      label: 'Cancel',
      variant: ButtonVariant.outline,
      onPressed: close,
    ),
    ArcaneButton(
      label: 'Save Changes',
      variant: ButtonVariant.primary,
      onPressed: saveProfile,
    ),
  ],
  onClose: close,
)
```

## Item Selection Dialog

Build custom item pickers by composing your own list:

```dart
ArcaneDialog(
  title: 'Select Theme',
  maxWidth: 400,
  children: [
    for (final theme in themes)
      ArcaneButton(
        label: theme.name,
        variant: selectedTheme == theme
          ? ButtonVariant.primary
          : ButtonVariant.ghost,
        onPressed: () => setState(() => selectedTheme = theme),
        fullWidth: true,
      ),
  ],
  actions: [
    ArcaneButton(
      label: 'Cancel',
      variant: ButtonVariant.outline,
      onPressed: close,
    ),
    ArcaneButton(
      label: 'Apply',
      variant: ButtonVariant.primary,
      onPressed: () {
        applyTheme(selectedTheme);
        close();
      },
    ),
  ],
  onClose: close,
)
```

## Dialog Without Title

```dart
ArcaneDialog(
  showCloseButton: true,
  child: ArcaneColumn(
    gap: Gap.lg,
    children: [
      ArcaneAvatar(src: user.avatarUrl, size: AvatarSize.xl),
      ArcaneText(user.name, styles: ArcaneStyleData(fontWeight: FontWeight.bold)),
      ArcaneText(user.bio),
    ],
  ),
  onClose: close,
)
```

## Non-Dismissible Dialog

Prevent closing by clicking outside:

```dart
ArcaneDialog(
  title: 'Terms of Service',
  barrierDismissible: false,
  showCloseButton: false,
  children: [
    ArcaneText('Please read and accept the terms to continue.'),
    // ... terms content
  ],
  actions: [
    ArcaneButton(
      label: 'I Accept',
      variant: ButtonVariant.primary,
      onPressed: acceptTerms,
    ),
  ],
)
```

## With Search and Filtering

```dart
class ItemPickerDialog extends StatefulComponent {
  final List<Item> items;
  final void Function(Item) onSelect;
  final VoidCallback onClose;

  @override
  State createState() => _ItemPickerDialogState();
}

class _ItemPickerDialogState extends State<ItemPickerDialog> {
  String query = '';

  List<Item> get filteredItems => widget.items
      .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
      .toList();

  @override
  Component build(BuildContext context) {
    return ArcaneDialog(
      title: 'Select Item',
      maxWidth: 480,
      children: [
        ArcaneTextInput(
          placeholder: 'Search...',
          value: query,
          onChanged: (value) => setState(() => query = value),
        ),
        ArcaneDiv(
          styles: ArcaneStyleData(
            maxHeight: '300px',
            overflowY: Overflow.auto,
          ),
          children: [
            for (final item in filteredItems)
              ArcaneButton(
                label: item.name,
                variant: ButtonVariant.ghost,
                onPressed: () {
                  widget.onSelect(item);
                  widget.onClose();
                },
                fullWidth: true,
              ),
          ],
        ),
      ],
      actions: [
        ArcaneButton(
          label: 'Cancel',
          variant: ButtonVariant.outline,
          onPressed: widget.onClose,
        ),
      ],
      onClose: widget.onClose,
    );
  }
}
```

## Related Components

- [ArcaneConfirmDialog](/arcane_jaspr/docs/feedback/arcane-confirm-dialog) - Pre-built confirmation dialog
- [ArcaneToast](/arcane_jaspr/docs/feedback/arcane-toast) - Temporary notifications
- [ArcaneAlertBanner](/arcane_jaspr/docs/feedback/arcane-alert-banner) - Inline alerts
- [ArcaneSheet](/arcane_jaspr/docs/layout/arcane-sheet) - Slide-in panel
