---
title: ArcaneInputDialog
description: Dialog for collecting user input with type-specific validation
layout: docs
component: input-dialog
---

# ArcaneInputDialog

A dialog component for collecting user input with built-in validation for different input types.

## Basic Usage

Use factory constructors for different input types:

```dart
// Text input
ArcaneInputDialog.text(
  isOpen: showDialog,
  onClose: () => setState(() => showDialog = false),
  onSubmit: (value) {
    print('Submitted: $value');
  },
)

// Email input with validation
ArcaneInputDialog.email(
  isOpen: showEmailDialog,
  onClose: () => close(),
  onSubmit: (email) => submitEmail(email),
)

// Password input
ArcaneInputDialog.password(
  isOpen: showPasswordDialog,
  onClose: () => close(),
  onSubmit: (password) => submitPassword(password),
)
```

## Factory Constructors

### Text

```dart
ArcaneInputDialog.text(
  isOpen: showDialog,
  title: 'Enter Text',
  placeholder: 'Type here...',
  onClose: () => close(),
  onSubmit: (text) => handleText(text),
)
```

### Email

```dart
ArcaneInputDialog.email(
  isOpen: showDialog,
  title: 'Enter Email',
  placeholder: 'you@example.com',
  onClose: () => close(),
  onSubmit: (email) => handleEmail(email),
)
```

### Password

```dart
ArcaneInputDialog.password(
  isOpen: showDialog,
  title: 'Enter Password',
  onClose: () => close(),
  onSubmit: (password) => handlePassword(password),
)
```

### Multiline

```dart
ArcaneInputDialog.multiline(
  isOpen: showDialog,
  title: 'Enter Message',
  placeholder: 'Type your message...',
  maxLines: 5,
  onClose: () => close(),
  onSubmit: (message) => handleMessage(message),
)
```

### Number

```dart
ArcaneInputDialog.number(
  isOpen: showDialog,
  title: 'Enter Amount',
  minValue: 0,
  maxValue: 100,
  onClose: () => close(),
  onSubmit: (value) => handleNumber(value),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isOpen` | `bool` | required | Whether dialog is visible |
| `onClose` | `VoidCallback?` | `null` | Close handler |
| `onSubmit` | `ValueChanged<String>` | required | Submit handler |
| `title` | `String` | Type-specific | Dialog title |
| `message` | `String?` | `null` | Description text |
| `placeholder` | `String` | Type-specific | Input placeholder |
| `initialValue` | `String?` | `null` | Pre-filled value |
| `submitLabel` | `String` | `'Submit'` | Submit button text |
| `cancelLabel` | `String` | `'Cancel'` | Cancel button text |
| `maxLength` | `int?` | `null` | Maximum input length |
| `maxLines` | `int` | `1` | Lines for multiline type |

## Examples

### Password Reset

```dart
ArcaneButton.secondary(
  label: 'Forgot Password?',
  onPressed: () => setState(() => showResetDialog = true),
),
ArcaneInputDialog.email(
  isOpen: showResetDialog,
  title: 'Reset Password',
  message: 'Enter your email to receive a password reset link.',
  submitLabel: 'Send Reset Link',
  onClose: () => setState(() => showResetDialog = false),
  onSubmit: (email) {
    sendResetEmail(email);
    setState(() => showResetDialog = false);
  },
)
```

### Invite User

```dart
ArcaneInputDialog.email(
  isOpen: showInviteDialog,
  title: 'Invite Team Member',
  message: 'They will receive an invitation email.',
  submitLabel: 'Send Invite',
  onClose: () => close(),
  onSubmit: (email) => sendInvite(email),
)
```

### Feedback Form

```dart
ArcaneInputDialog.multiline(
  isOpen: showFeedbackDialog,
  title: 'Send Feedback',
  message: 'Let us know how we can improve.',
  placeholder: 'Your feedback...',
  maxLines: 4,
  submitLabel: 'Submit Feedback',
  onClose: () => close(),
  onSubmit: (feedback) => submitFeedback(feedback),
)
```

### Set Quantity

```dart
ArcaneInputDialog.number(
  isOpen: showQuantityDialog,
  title: 'Set Quantity',
  message: 'Enter a value between 1 and 100.',
  minValue: 1,
  maxValue: 100,
  initialValue: '10',
  onClose: () => close(),
  onSubmit: (value) => setQuantity(int.parse(value)),
)
```

## Related Components

- [ArcaneDialog](/arcane_jaspr/docs/feedback/arcane-dialog) - Generic dialog
- [ArcaneTimeDialog](/arcane_jaspr/docs/feedback/arcane-time-dialog) - Time picker dialog
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input component
