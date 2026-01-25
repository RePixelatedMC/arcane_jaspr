---
title: ArcaneSimpleForm
description: Unified form component for newsletters, waitlists, contact forms, and custom forms
layout: kb
component: simple-form
---

# ArcaneSimpleForm

A unified form component that handles common form patterns including newsletter signups, waitlist forms, contact forms, and custom field collections. Includes built-in validation and success states.

## Quick Start

### Newsletter Form

Single-field inline email signup:

```dart
ArcaneNewsletterForm(
  placeholder: 'Enter your email',
  buttonText: 'Subscribe',
  successMessage: 'Thanks for subscribing!',
  onSubmit: (email) => handleNewsletterSignup(email),
)
```

### Waitlist Form

Waitlist with optional name collection:

```dart
ArcaneWaitlistForm(
  title: 'Join the Waitlist',
  description: 'Be the first to know when we launch.',
  buttonText: 'Join Waitlist',
  collectName: true,
  onSubmit: (email, name) => handleWaitlistSignup(email, name),
)
```

### Contact Form

Full contact form with name, email, and message:

```dart
ArcaneContactForm(
  title: 'Get in Touch',
  description: 'We\'d love to hear from you.',
  buttonText: 'Send Message',
  onSubmit: (name, email, message) => handleContactForm(name, email, message),
)
```

## Custom Forms

Build custom forms with any fields:

```dart
ArcaneSimpleForm(
  title: 'Create Account',
  description: 'Enter your details below.',
  fields: [
    SimpleFormField(
      name: 'username',
      type: SimpleFormFieldType.text,
      label: 'Username',
      placeholder: 'Choose a username',
      required: true,
    ),
    SimpleFormField(
      name: 'email',
      type: SimpleFormFieldType.email,
      label: 'Email',
      placeholder: 'you@example.com',
      required: true,
    ),
    SimpleFormField(
      name: 'password',
      type: SimpleFormFieldType.password,
      label: 'Password',
      placeholder: 'Create a password',
      required: true,
      validator: (value) {
        if (value.length < 8) return 'Password must be at least 8 characters';
        return null;
      },
    ),
    SimpleFormField(
      name: 'bio',
      type: SimpleFormFieldType.textarea,
      label: 'Bio',
      placeholder: 'Tell us about yourself',
      hint: 'Optional',
    ),
  ],
  submitLabel: 'Create Account',
  successMessage: 'Account created successfully!',
  onSubmit: (values) {
    final username = values['username'];
    final email = values['email'];
    final password = values['password'];
    final bio = values['bio'];
    handleCreateAccount(username, email, password, bio);
  },
)
```

## Field Types

```dart
enum SimpleFormFieldType {
  text,      // Standard text input
  email,     // Email input with validation
  password,  // Password input (obscured)
  phone,     // Phone number input
  url,       // URL input
  textarea,  // Multi-line text area
}
```

## Properties

### ArcaneSimpleForm

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String?` | `null` | Form header title |
| `description` | `String?` | `null` | Form description text |
| `fields` | `List<SimpleFormField>` | required | Form field definitions |
| `submitLabel` | `String` | `'Submit'` | Submit button text |
| `successMessage` | `String` | `'Thanks...'` | Message shown after submit |
| `layout` | `SimpleFormLayout` | `stacked` | Form layout style |
| `compact` | `bool` | `false` | Use compact sizing |
| `onSubmit` | `Function(Map<String, String>)?` | `null` | Submit callback |

### SimpleFormField

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `name` | `String` | required | Field identifier (key in values map) |
| `type` | `SimpleFormFieldType` | `text` | Input type |
| `label` | `String?` | `null` | Field label |
| `placeholder` | `String?` | `null` | Input placeholder |
| `hint` | `String?` | `null` | Help text below field |
| `required` | `bool` | `false` | Whether field is required |
| `validator` | `String? Function(String)?` | `null` | Custom validation |

## Layout Options

### Stacked (Default)

Fields stacked vertically with labels:

```dart
ArcaneSimpleForm(
  layout: SimpleFormLayout.stacked,
  fields: [...],
)
```

### Inline

Single field with button side-by-side (best for newsletter):

```dart
ArcaneSimpleForm(
  layout: SimpleFormLayout.inline,
  fields: [
    SimpleFormField(name: 'email', type: SimpleFormFieldType.email),
  ],
)
```

## Validation

### Built-in Validation

- Email fields automatically validate email format
- Required fields show error if empty on submit

### Custom Validation

```dart
SimpleFormField(
  name: 'password',
  type: SimpleFormFieldType.password,
  required: true,
  validator: (value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain a number';
    }
    return null; // No error
  },
)
```

## Migration Guide

If you were using the old separate form components:

```dart
// Old: NewsletterForm
NewsletterForm(buttonText: 'Subscribe', onSubmit: (email) => ...)

// New: ArcaneNewsletterForm (convenience wrapper)
ArcaneNewsletterForm(buttonText: 'Subscribe', onSubmit: (email) => ...)

// Or use SimpleFormProps directly
ArcaneSimpleForm(
  layout: SimpleFormLayout.inline,
  fields: [SimpleFormField(name: 'email', type: SimpleFormFieldType.email)],
  onSubmit: (values) => handleEmail(values['email']!),
)
```

## Use Cases

- Newsletter email collection
- Waitlist signups
- Contact forms
- Lead generation forms
- Quick feedback forms
- Account creation forms
