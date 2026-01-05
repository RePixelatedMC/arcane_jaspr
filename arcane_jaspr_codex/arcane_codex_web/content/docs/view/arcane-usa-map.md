---
title: ArcaneUSAMap
description: An interactive, themeable SVG USA map component
layout: docs
component: usa-map
---

# ArcaneUSAMap

An interactive SVG map of the United States with state highlighting, location pins, and hover tooltips. Perfect for displaying regional data, office locations, or service coverage.

## Features

- Interactive SVG USA map with all 50 states
- State highlighting and selection
- Location pins with hover effects and tooltips
- State hover and click callbacks
- Multiple style presets
- Configurable pin and state colors

## Usage

```dart
ArcaneUSAMap(
  locations: [
    ArcaneUSAMapLocation(
      id: 'nyc',
      name: 'New York City',
      latitude: 40.7128,
      longitude: -74.0060,
      code: 'NYC',
      state: 'NY',
    ),
    ArcaneUSAMapLocation(
      id: 'lax',
      name: 'Los Angeles',
      latitude: 34.0522,
      longitude: -118.2437,
      code: 'LAX',
      state: 'CA',
    ),
  ],
  activeStates: {'CA', 'NY', 'TX'},
  onLocationTap: (location) => print('Tapped ${location.name}'),
  onStateTap: (stateCode) => print('Tapped $stateCode'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `locations` | `List<ArcaneUSAMapLocation>` | `[]` | Locations to display as pins |
| `onLocationTap` | `USAMapLocationCallback?` | null | Callback when pin is clicked |
| `onLocationHover` | `USAMapLocationCallback?` | null | Callback when pin is hovered |
| `onStateTap` | `USAMapStateCallback?` | null | Callback when state is clicked |
| `onStateHover` | `USAMapStateCallback?` | null | Callback when state is hovered |
| `tooltipBuilder` | `Component Function(ArcaneUSAMapLocation)?` | null | Custom tooltip builder |
| `style` | `ArcaneUSAMapStyle` | `ArcaneUSAMapStyle()` | Style configuration |
| `showTooltips` | `bool` | `true` | Show tooltips on hover |
| `activeStates` | `Set<String>` | `{}` | Set of highlighted state codes |
| `showStateBorders` | `bool` | `true` | Show state border lines |
| `height` | `String?` | null | Custom height |
| `aspectRatio` | `double` | `1.70` | Aspect ratio (width:height) |

## ArcaneUSAMapLocation

```dart
ArcaneUSAMapLocation(
  id: String,           // Unique identifier
  name: String,         // Display name
  latitude: double,     // Latitude coordinate
  longitude: double,    // Longitude coordinate
  state: String?,       // State code (NY, CA, TX)
  code: String?,        // Optional short code (NYC, LAX)
  description: String?, // Optional tooltip description
  metadata: Map?,       // Custom metadata
  isActive: bool,       // Highlighted state
)
```

## State Highlighting

Highlight specific states using the `activeStates` property:

```dart
ArcaneUSAMap(
  activeStates: {'CA', 'TX', 'NY', 'FL'},  // Highlight these states
  locations: [...],
)
```

## Style Presets

```dart
// Standard (default)
ArcaneUSAMap(
  style: ArcaneUSAMapStyle.standard,
  locations: [...],
)

// Subtle - thinner lines, smaller pins
ArcaneUSAMap(
  style: ArcaneUSAMapStyle.subtle,
  locations: [...],
)

// Prominent - thicker lines, larger pins
ArcaneUSAMap(
  style: ArcaneUSAMapStyle.prominent,
  locations: [...],
)
```

## Custom Styling

```dart
ArcaneUSAMap(
  style: ArcaneUSAMapStyle(
    stateFill: 'rgba(255, 255, 255, 0.05)',
    stateStroke: 'rgba(255, 255, 255, 0.2)',
    stateHoverFill: 'rgba(255, 255, 255, 0.1)',
    stateActiveFill: '#10b981',
    backgroundFill: 'transparent',
    pinColor: '#3b82f6',
    pinSize: 8,
  ),
  locations: [...],
)
```

## State Interaction

```dart
ArcaneUSAMap(
  locations: [...],
  onStateTap: (stateCode) {
    // stateCode is like 'CA', 'NY', 'TX'
    print('Selected state: $stateCode');
  },
  onStateHover: (stateCode) {
    print('Hovering: $stateCode');
  },
)
```

## Available State Codes

The map includes all 50 US states plus DC:
`AL`, `AK`, `AZ`, `AR`, `CA`, `CO`, `CT`, `DE`, `DC`, `FL`, `GA`, `HI`, `ID`, `IL`, `IN`, `IA`, `KS`, `KY`, `LA`, `ME`, `MD`, `MA`, `MI`, `MN`, `MS`, `MO`, `MT`, `NE`, `NV`, `NH`, `NJ`, `NM`, `NY`, `NC`, `ND`, `OH`, `OK`, `OR`, `PA`, `RI`, `SC`, `SD`, `TN`, `TX`, `UT`, `VT`, `VA`, `WA`, `WV`, `WI`, `WY`
