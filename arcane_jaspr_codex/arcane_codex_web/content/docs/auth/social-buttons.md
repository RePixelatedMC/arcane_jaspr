---
title: Social Sign-In Buttons
description: Pre-styled OAuth provider buttons for authentication
layout: kb
component: social-buttons
---

# Social Sign-In Buttons

Pre-styled, branded buttons for OAuth authentication with popular providers. All buttons follow consistent sizing, loading states, and accessibility patterns.

## Basic Usage

Use factory constructors on `SocialSignInButton` for each provider:

```dart
// GitHub
const SocialSignInButton.github(
  onPressed: signInWithGitHub,
)

// Google
const SocialSignInButton.google(
  onPressed: signInWithGoogle,
)

// Apple
const SocialSignInButton.apple(
  onPressed: signInWithApple,
)
```

## Available Providers

### Primary Providers

```dart
const SocialSignInButton.github(onPressed: handleGitHub)
const SocialSignInButton.google(onPressed: handleGoogle)
const SocialSignInButton.apple(onPressed: handleApple)
const SocialSignInButton.microsoft(onPressed: handleMicrosoft)
```

### Social Providers

```dart
const SocialSignInButton.facebook(onPressed: handleFacebook)
const SocialSignInButton.twitter(onPressed: handleTwitter)
const SocialSignInButton.linkedin(onPressed: handleLinkedIn)
```

### Developer Providers

```dart
const SocialSignInButton.gitlab(onPressed: handleGitLab)
const SocialSignInButton.discord(onPressed: handleDiscord)
const SocialSignInButton.slack(onPressed: handleSlack)
```

## Common Properties

All social sign-in buttons share these properties:

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `void Function()?` | `null` | Click handler |
| `label` | `String?` | Provider-specific | Button text |
| `fullWidth` | `bool` | `false` | Expand to container width |

## Full Width

```dart
ArcaneColumn(
  gapSize: Gap.sm,
  children: [
    const SocialSignInButton.github(fullWidth: true, onPressed: null),
    const SocialSignInButton.google(fullWidth: true, onPressed: null),
    const SocialSignInButton.apple(fullWidth: true, onPressed: null),
  ],
)
```

## Custom Labels

```dart
const SocialSignInButton.github(
  label: 'Sign up with GitHub',
  onPressed: handleSignUp,
)

const SocialSignInButton.google(
  label: 'Link Google Account',
  onPressed: handleLink,
)
```

## Examples

### Login Form with Multiple Providers

```dart
ArcaneCard(
  child: ArcaneColumn(
    gapSize: Gap.md,
    children: [
      ArcaneHeading.h3(child: ArcaneText('Sign in')),

      // Email/password form
      ArcaneTextInput(label: 'Email'),
      ArcaneTextInput(label: 'Password', type: InputType.password),
      ArcaneButton.primary(
        label: 'Sign in',
        fullWidth: true,
        onPressed: handleEmailSignIn,
      ),

      // Divider
      ArcaneRow(
        children: [
          ArcaneDivider(),
          ArcaneText('or', color: TextColor.muted),
          ArcaneDivider(),
        ],
      ),

      // Social providers
      const SocialSignInButton.github(fullWidth: true, onPressed: null),
      const SocialSignInButton.google(fullWidth: true, onPressed: null),
    ],
  ),
)
```

### Provider Selection Grid

```dart
ArcaneFlow(
  gap: 8,
  children: [
    const SocialSignInButton.github(onPressed: null),
    const SocialSignInButton.google(onPressed: null),
    const SocialSignInButton.apple(onPressed: null),
    const SocialSignInButton.microsoft(onPressed: null),
    const SocialSignInButton.discord(onPressed: null),
    const SocialSignInButton.twitter(onPressed: null),
  ],
)
```

### All Providers Demo

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    // Primary providers
    ArcaneText('Primary Providers', weight: FontWeight.w600),
    const SocialSignInButton.github(fullWidth: true, onPressed: null),
    const SocialSignInButton.google(fullWidth: true, onPressed: null),
    const SocialSignInButton.apple(fullWidth: true, onPressed: null),
    const SocialSignInButton.microsoft(fullWidth: true, onPressed: null),

    // Social providers
    ArcaneText('Social Providers', weight: FontWeight.w600),
    const SocialSignInButton.facebook(fullWidth: true, onPressed: null),
    const SocialSignInButton.twitter(fullWidth: true, onPressed: null),
    const SocialSignInButton.linkedin(fullWidth: true, onPressed: null),

    // Developer providers
    ArcaneText('Developer Providers', weight: FontWeight.w600),
    const SocialSignInButton.gitlab(fullWidth: true, onPressed: null),
    const SocialSignInButton.discord(fullWidth: true, onPressed: null),
    const SocialSignInButton.slack(fullWidth: true, onPressed: null),
  ],
)
```

## Related Components

- [ArcaneLoginCard](/arcane_jaspr/docs/auth/arcane-login-card) - Complete login form
- [ArcaneSignupCard](/arcane_jaspr/docs/auth/arcane-signup-card) - Complete signup form
- [AuthSplitLayout](/arcane_jaspr/docs/auth/auth-split-layout) - Split layout for auth pages
