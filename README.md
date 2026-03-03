# Arcane Jaspr

A Flutter-like UI component library for [Jaspr](https://github.com/schultek/jaspr) web applications. Write familiar Dart code, get semantic HTML + CSS.

**Works everywhere**: Full interactivity on both hydrated Jaspr apps and static sites.

## The Problem: Web Development in Dart

Building web UIs in Dart traditionally means wrestling with raw HTML and CSS strings:

### Raw HTML + CSS (The Pain)

```html
<div style="display: flex; flex-direction: column; gap: 8px; width: 100%;">
  <label style="font-size: 0.875rem; font-weight: 500; color: var(--text-secondary);">
    Username
  </label>
  <input
    type="text"
    placeholder="Enter username"
    style="
      padding: 10px 14px;
      font-size: 0.875rem;
      border: 1px solid var(--border-color);
      border-radius: 8px;
      background: var(--surface);
      color: var(--text-primary);
      outline: none;
      transition: border-color 0.15s ease, box-shadow 0.15s ease;
    "
  />
  <span style="font-size: 0.75rem; color: var(--text-muted);">
    Choose a unique username
  </span>
</div>
```

Problems:
- No autocomplete for CSS properties
- Typos become runtime bugs
- Copy-paste styling everywhere
- No type safety

### Jaspr (Better, but...)

```dart
div(
  styles: Styles(raw: {
    'display': 'flex',
    'flex-direction': 'column',
    'gap': '8px',
    'width': '100%',
  }),
  [
    label(
      styles: Styles(raw: {
        'font-size': '0.875rem',
        'font-weight': '500',
        'color': 'var(--text-secondary)',
      }),
      [text('Username')],
    ),
    input(
      type: InputType.text,
      attributes: {'placeholder': 'Enter username'},
      styles: Styles(raw: {
        'padding': '10px 14px',
        'font-size': '0.875rem',
        'border': '1px solid var(--border-color)',
        'border-radius': '8px',
        'background': 'var(--surface)',
        'color': 'var(--text-primary)',
        // ... more CSS strings
      }),
      [],
    ),
    span(
      styles: Styles(raw: {'font-size': '0.75rem', 'color': 'var(--text-muted)'}),
      [text('Choose a unique username')],
    ),
  ],
)
```

Still requires:
- Memorizing CSS property names
- String-based values with no validation
- Manual theming integration

### Arcane Jaspr (The Solution)

```dart
ArcaneTextInput(
  label: 'Username',
  placeholder: 'Enter username',
  helperText: 'Choose a unique username',
  onChanged: (value) => print(value),
)
```

**That's it.** One component, type-safe, themed, accessible.

## Flutter Developers Feel at Home

If you know Flutter, you already know Arcane Jaspr:

| Flutter | Arcane Jaspr |
|---------|-------------|
| `TextField(decoration: InputDecoration(...))` | `ArcaneTextInput(label: ..., placeholder: ...)` |
| `DropdownButton(items: [...])` | `ArcaneSelector(options: [...])` |
| `Column(children: [...])` | `ArcaneColumn(children: [...])` |
| `Container(padding: ..., child: ...)` | `ArcaneDiv(styles: ArcaneStyleData(...), children: [...])` |
| `ElevatedButton(onPressed: ...)` | `ArcaneButton.primary(onPressed: ...)` |

### Type-Safe Styling with Enums

No more magic strings. Every CSS property is an enum:

```dart
// Flutter
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.surface,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(...)],
  ),
  child: child,
)

// Arcane Jaspr
ArcaneDiv(
  styles: const ArcaneStyleData(
    padding: PaddingPreset.lg,          // Not 'padding': '16px'
    background: Background.surface,     // Not 'background': 'var(--surface)'
    borderRadius: Radius.md,            // Not 'border-radius': '8px'
    shadow: Shadow.md,                  // Not 'box-shadow': '0 4px 6px...'
  ),
  children: [child],
)
```

## Real-World Examples

### Searchable Dropdown (ArcaneSelector)

**Raw HTML approach** - ~150 lines of HTML, CSS, and JavaScript

**Arcane Jaspr approach:**

```dart
ArcaneSelector<String>(
  label: 'Country',
  options: [
    ArcaneSelectorOption(value: 'us', label: 'United States', icon: flagUs),
    ArcaneSelectorOption(value: 'uk', label: 'United Kingdom', icon: flagUk),
    ArcaneSelectorOption(value: 'ca', label: 'Canada', icon: flagCa),
  ],
  value: selectedCountry,
  onChanged: (value) => setState(() => selectedCountry = value),
  searchable: true,              // Built-in search
  clearable: true,               // Built-in clear button
  size: SelectorSize.md,         // Enum, not 'height': '40px'
  dropdownDirection: DropdownDirection.down,  // Type-safe positioning
)
```

### Native Select (ArcaneNativeSelect)

**The old way:** Build a text display, build an input, manage edit state, handle keyboard events, style both states...

**Arcane Jaspr:**

```dart
ArcaneNativeSelect(
  label: 'Plan',
  options: const [
    ArcaneSelectOption(label: 'Starter', value: 'starter'),
    ArcaneSelectOption(label: 'Pro', value: 'pro'),
    ArcaneSelectOption(label: 'Enterprise', value: 'enterprise'),
  ],
  value: selectedPlan,
  onChange: (value) => setState(() => selectedPlan = value),
)
```

## Features

- **59 Production Components** - Full catalog with distinct ShadCN and Codex systems (Codex rainbow mode is opt-in)
- **One-Line Theming** - 20+ built-in themes with full customization
- **Static Site Support** - Automatic JavaScript fallbacks when hydration is unavailable
- **Type-Safe Styling** - `ArcaneStyleData` with enum-based CSS properties
- **Auth Service Integration** - Firebase auth service and provider surfaces
- **Accessible** - ARIA attributes, keyboard navigation, semantic HTML

## Installation

```yaml
dependencies:
  arcane_jaspr: ^2.5.0
```

## Quick Start

```dart
import 'package:arcane_jaspr/arcane_jaspr.dart';

class App extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: ArcaneTheme.green,
      child: ArcaneDiv(
        styles: const ArcaneStyleData(
          padding: PaddingPreset.xl,
          display: Display.flex,
          flexDirection: FlexDirection.column,
          gap: Gap.md,
        ),
        children: [
          const ArcaneHeadline('Welcome'),
          const ArcaneTextInput(
            label: 'Email',
            placeholder: 'you@example.com',
            fullWidth: true,
          ),
          ArcaneButton.primary(
            label: 'Get Started',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
```

## Theming

Change your entire app's look with one line:

```dart
ArcaneApp(
  theme: ArcaneTheme.blue,  // or .green, .purple, .orange, etc.
  child: MyApp(),
)
```

### Available Themes

| Category | Themes |
|----------|--------|
| **Primary** | `red`, `orange`, `yellow`, `green`, `blue`, `indigo`, `purple`, `pink` |
| **Neutral** | `darkGrey`, `grey`, `lightGrey`, `white`, `black` |
| **OLED** | `oledRed`, `oledGreen`, `oledBlue`, `oledPurple`, `oledWhite` |

### Theme Customization

```dart
ArcaneApp(
  theme: ArcaneTheme.blue.copyWith(
    themeMode: ThemeMode.dark,
    radius: 0.75,           // Corner roundness
    surfaceOpacity: 0.9,    // Glass effect
  ),
  child: MyApp(),
)
```

## Components at a Glance

### Inputs
```dart
ArcaneTextInput(label: 'Email', placeholder: 'you@example.com')
ArcaneNativeSelect(options: [...], value: selected)
ArcaneCheckbox(checked: true, onChanged: (_) {})
ArcaneSlider(value: 50, min: 0, max: 100)
ArcaneCombobox(options: [...], value: selected, onChanged: (_) {})
```

### Layout
```dart
ArcaneRow(children: [...])
ArcaneColumn(children: [...])
ArcaneCard(child: ...)
ArcaneDiv(styles: const ArcaneStyleData(maxWidth: MaxWidth.content), children: [...])
```

### Navigation
```dart
ArcaneSidebar(children: [...])
ArcaneTabs(tabs: [...])
ArcaneDropdownMenu(trigger: ..., items: [...])
ArcaneBreadcrumbs(items: [...])
```

### Display
```dart
ArcaneAvatar(imageUrl: '...', size: 48)
ArcaneStatusBadge.success('New')
ArcaneProgressBar(value: 0.75)
ArcaneDataTable(columns: [...], rows: [...])
```

### Feedback
```dart
ArcaneDialog(title: 'Confirm', child: ...)
ArcaneToast(message: 'Saved!')
ArcaneSonner.success('Saved successfully')
```

### Promotional Components
```dart
// Top announcement bar
ArcaneTopAnnouncementBar(
  message: 'Summer Sale: 20% off all plans!',
  promoCode: 'SUMMER20',
  ctaText: 'Shop Now',
  ctaHref: '/sale',
)

// Bottom floating banner with countdown
ArcaneBottomFloatingBanner(
  title: 'Limited Time Offer',
  message: 'Get 50% off annual plans',
  ctaText: 'Claim Offer',
  countdownDuration: Duration(hours: 2),
)

// Corner toast notification
ArcaneCornerPromoToast(
  title: 'New Feature!',
  message: 'Try our new dashboard',
  position: PromoCornerPosition.bottomRight,
)

// Full-screen promo modal
ArcanePromoModal(
  headline: 'Black Friday Sale',
  discount: '50% OFF',
  promoCode: 'BLACKFRIDAY',
  ctaText: 'Shop Now',
)

// Inline hero banner
ArcaneInlineHeroBanner(
  badge: 'New',
  headline: 'Introducing Premium',
  description: 'Unlock advanced features',
  style: PromoInlineHeroBannerStyle.ribbon,
)

// Sliding sidebar banner
ArcaneSlidingSidebarBanner(
  title: 'Upgrade Today',
  message: 'Get exclusive features',
  position: PromoSidebarPosition.right,
  features: ['Feature 1', 'Feature 2'],
)

// Scrolling marquee ticker
ArcaneMarqueeTickerBar(
  messages: ['Flash Sale!', 'Free Shipping', 'New Arrivals'],
  ctaText: 'Shop Now',
)

// Expanding FAB promo
ArcaneExpandingFabPromo(
  title: 'Need Help?',
  message: 'Chat with us',
  ctaText: 'Start Chat',
)

// Progress claim banner
ArcaneProgressClaimBanner(
  title: 'Limited Offer',
  currentClaimed: 73,
  totalAvailable: 100,
  ctaText: 'Claim Now',
)

// Minimizable sidebar promo
ArcaneMinimizablePromo(
  tabLabel: 'SALE',
  title: 'Flash Sale',
  message: 'Save up to 40%',
  discount: '40% OFF',
)

// Full-screen takeover
ArcaneFullscreenTakeover(
  headline: 'Cyber Monday',
  subheadline: 'Biggest Sale of the Year',
  discount: '60% OFF',
  countdownDuration: Duration(hours: 24),
)
```

## Static Site Support

`ArcaneApp` automatically injects JavaScript fallbacks for static sites built with `jaspr build`. All interactive components work without hydration:

```dart
ArcaneApp(
  theme: ArcaneTheme.green,
  child: MyContent(),  // Works on static sites!
)
```

## Documentation

Full documentation with live examples: **[arcanearts.github.io/arcane_jaspr](https://arcanearts.github.io/arcane_jaspr/)**

## License

GNU Public
