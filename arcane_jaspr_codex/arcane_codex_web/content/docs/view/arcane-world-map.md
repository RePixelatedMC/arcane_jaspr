---
title: ArcaneWorldMap & ArcaneUSAMap
description: Interactive, themeable SVG map components
layout: docs
component: world-map
---

# ArcaneWorldMap & ArcaneUSAMap

Interactive SVG map components for displaying location markers with hover tooltips and click callbacks. Both maps are fully themeable via CSS variables and support debug mode for coordinate discovery.

## Debug Mode

Both maps support a `debugMode` property that displays coordinates on hover and copies them to clipboard on click. This is useful for determining precise lat/lng values for location pins.

```dart
ArcaneWorldMap(
  debugMode: true,
  locations: const [],
)

ArcaneUSAMap(
  debugMode: true,
)
```

---

## ArcaneWorldMap

An interactive SVG world map for global location visualization.

### Usage

```dart
ArcaneWorldMap(
  locations: [
    ArcaneMapLocation(
      id: 'nyc',
      name: 'New York',
      latitude: 40.7128,
      longitude: -74.0060,
      code: 'NYC',
      region: 'North America',
    ),
    ArcaneMapLocation(
      id: 'lon',
      name: 'London',
      latitude: 51.5074,
      longitude: -0.1278,
      code: 'LON',
      region: 'Europe',
    ),
  ],
  onLocationTap: (location) => print('Tapped ${location.name}'),
)
```

### Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `locations` | `List<ArcaneMapLocation>` | required | Locations to display as pins |
| `onLocationTap` | `MapLocationCallback?` | null | Callback when pin is clicked |
| `onLocationHover` | `MapLocationCallback?` | null | Callback when pin is hovered |
| `tooltipBuilder` | `Component Function(ArcaneMapLocation)?` | null | Custom tooltip builder |
| `style` | `ArcaneWorldMapStyle` | `ArcaneWorldMapStyle()` | Style configuration |
| `showTooltips` | `bool` | `true` | Show tooltips on hover |
| `debugMode` | `bool` | `false` | Show coordinates on hover |
| `height` | `String?` | null | Custom height |
| `aspectRatio` | `double` | `2.33` | Aspect ratio (width:height) |

### ArcaneMapLocation

```dart
ArcaneMapLocation(
  id: String,           // Unique identifier
  name: String,         // Display name
  latitude: double,     // Latitude (-90 to 90)
  longitude: double,    // Longitude (-180 to 180)
  region: String?,      // Optional region/country
  code: String?,        // Optional short code (NYC, LHR)
  description: String?, // Optional tooltip description
  metadata: Map?,       // Custom metadata
  isActive: bool,       // Highlighted state
)
```

### Style Presets

```dart
ArcaneWorldMap(
  style: ArcaneWorldMapStyle.standard,  // Default
  locations: [...],
)

ArcaneWorldMap(
  style: ArcaneWorldMapStyle.subtle,    // Thinner lines, smaller pins
  locations: [...],
)

ArcaneWorldMap(
  style: ArcaneWorldMapStyle.prominent, // Thicker lines, larger pins
  locations: [...],
)
```

---

## ArcaneUSAMap

An interactive SVG map of the United States with state highlighting and location pins.

### Usage

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

### Properties

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
| `debugMode` | `bool` | `false` | Show coordinates on hover |
| `height` | `String?` | null | Custom height |
| `aspectRatio` | `double` | `1.70` | Aspect ratio (width:height) |

### ArcaneUSAMapLocation

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

### State Highlighting

```dart
ArcaneUSAMap(
  activeStates: {'CA', 'TX', 'NY', 'FL'},
  locations: [...],
)
```

### Style Presets

```dart
ArcaneUSAMap(
  style: ArcaneUSAMapStyle.standard,  // Default
  locations: [...],
)

ArcaneUSAMap(
  style: ArcaneUSAMapStyle.subtle,    // Thinner lines, smaller pins
  locations: [...],
)

ArcaneUSAMap(
  style: ArcaneUSAMapStyle.prominent, // Thicker lines, larger pins
  locations: [...],
)
```

### Available State Codes

All 50 US states plus DC:
`AL`, `AK`, `AZ`, `AR`, `CA`, `CO`, `CT`, `DE`, `DC`, `FL`, `GA`, `HI`, `ID`, `IL`, `IN`, `IA`, `KS`, `KY`, `LA`, `ME`, `MD`, `MA`, `MI`, `MN`, `MS`, `MO`, `MT`, `NE`, `NV`, `NH`, `NJ`, `NM`, `NY`, `NC`, `ND`, `OH`, `OK`, `OR`, `PA`, `RI`, `SC`, `SD`, `TN`, `TX`, `UT`, `VT`, `VA`, `WA`, `WV`, `WI`, `WY`
