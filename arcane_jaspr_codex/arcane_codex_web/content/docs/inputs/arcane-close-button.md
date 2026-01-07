---
title: Close Button
description: Close/dismiss button for dialogs and panels
layout: docs
component: close-button
---

# Close Button

A pre-styled close button with an X icon, commonly used to dismiss dialogs, modals, alerts, and panels.

> **Note:** The `ArcaneCloseButton` class has been consolidated into `ArcaneIconButton.close()`. Use the factory constructor for all close button needs.

## Basic Usage

```dart
ArcaneIconButton.close(
  onPressed: () {
    closeDialog();
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `VoidCallback?` | `null` | Click handler |

## Examples

### Dialog Header

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    justifyContent: JustifyContent.spaceBetween,
    alignItems: AlignItems.center,
    padding: PaddingPreset.md,
    borderBottom: BorderPreset.subtle,
  ),
  children: [
    ArcaneHeadline(text: 'Dialog Title'),
    ArcaneIconButton.close(
      onPressed: () => Navigator.pop(context),
    ),
  ],
)
```

### Alert Banner

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.center,
    gap: Gap.md,
    padding: PaddingPreset.md,
    background: Background.warning,
    borderRadius: Radius.md,
  ),
  children: [
    ArcaneIcon.alertTriangle(),
    ArcaneDiv(
      styles: const ArcaneStyleData(flexGrow: 1),
      children: [ArcaneText('This is a warning message')],
    ),
    ArcaneIconButton.close(
      onPressed: () => dismissAlert(),
    ),
  ],
)
```

### Modal Overlay

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    position: Position.fixed,
    raw: {'inset': '0'},
    display: Display.flex,
    alignItems: AlignItems.center,
    justifyContent: JustifyContent.center,
    background: Background.overlay,
  ),
  children: [
    ArcaneCard(
      styles: const ArcaneStyleData(
        position: Position.relative,
        maxWidth: MaxWidth.form,
        width: Size.full,
      ),
      children: [
        // Close button in corner
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.absolute,
            raw: {'top': '12px', 'right': '12px'},
          ),
          children: [
            ArcaneIconButton.close(onPressed: closeModal),
          ],
        ),
        // Modal content...
      ],
    ),
  ],
)
```

### Toast Notification

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    alignItems: AlignItems.flexStart,
    gap: Gap.sm,
    padding: PaddingPreset.md,
    background: Background.card,
    borderRadius: Radius.lg,
    shadow: Shadow.lg,
  ),
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(flexGrow: 1),
      children: [
        ArcaneText('File uploaded successfully'),
      ],
    ),
    ArcaneIconButton.close(
      onPressed: dismissToast,
    ),
  ],
)
```

## Related Components

- [ArcaneIconButton](/arcane_jaspr/docs/inputs/arcane-icon-button) - Generic icon button with `.close()` factory
- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Dialog component
- [ArcaneToast](/arcane_jaspr/docs/feedback/arcane-toast) - Toast notifications
