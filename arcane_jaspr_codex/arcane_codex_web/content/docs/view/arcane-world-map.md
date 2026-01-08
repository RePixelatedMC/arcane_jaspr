---
title: ArcaneMap
description: Unified interactive SVG map component
layout: docs
component: world-map
---

# ArcaneMap

A unified interactive SVG map component supporting both world and USA maps. Display location markers with hover tooltips, region highlighting, and click callbacks. Fully styled with explicit colors and supports debug mode for coordinate discovery.

## Basic Usage

```dart
// World map
ArcaneMap(
  type: MapType.world,
  locations: [
    MapLocation(
      id: 'nyc',
      name: 'New York',
      latitude: 40.7128,
      longitude: -74.0060,
      code: 'NYC',
      region: 'North America',
    ),
  ],
)

// USA map
ArcaneMap(
  type: MapType.usa,
  locations: [...],
  activeRegions: {'CA', 'NY', 'TX'},
)
```

## Debug Mode

Displays coordinates on hover and copies them to clipboard on click. Useful for determining precise lat/lng values for location pins.

```dart
ArcaneMap(
  type: MapType.world,
  debugMode: true,
)

ArcaneMap(
  type: MapType.usa,
  debugMode: true,
)
```

---

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `type` | `MapType` | `world` | Map type (`MapType.world` or `MapType.usa`) |
| `locations` | `List<MapLocation>` | `[]` | Locations to display as pins |
| `onLocationTap` | `MapLocationCallback?` | null | Callback when pin is clicked |
| `onLocationHover` | `MapLocationCallback?` | null | Callback when pin is hovered |
| `onRegionTap` | `MapRegionCallback?` | null | Callback when region (state/country) is clicked |
| `onRegionHover` | `MapRegionCallback?` | null | Callback when region is hovered |
| `tooltipBuilder` | `Component Function(MapLocation)?` | null | Custom tooltip builder |
| `style` | `MapStyle` | `MapStyle()` | Style configuration |
| `showTooltips` | `bool` | `true` | Show tooltips on hover |
| `activeRegions` | `Set<String>` | `{}` | Set of highlighted region codes |
| `debugMode` | `bool` | `false` | Show coordinates on hover |
| `height` | `String?` | null | Custom height |

---

## MapLocation

```dart
MapLocation(
  id: String,           // Unique identifier
  name: String,         // Display name
  latitude: double,     // Latitude (-90 to 90)
  longitude: double,    // Longitude (-180 to 180)
  region: String?,      // Optional region name
  regionCode: String?,  // Optional region code (US, NY, CA)
  code: String?,        // Optional short code (NYC, LHR)
  description: String?, // Optional tooltip description
  metadata: Map?,       // Custom metadata
  isActive: bool,       // Highlighted state
)
```

---

## MapStyle

Explicit hex colors for reliable styling across all themes.

```dart
MapStyle(
  backgroundColor: '#111827',
  regionFill: '#374151',
  regionStroke: '#4b5563',
  strokeWidth: '0.5',
  regionHoverFill: '#4b5563',
  regionActiveFill: '#3b82f6',
  pinColor: '#3b82f6',
  pinHoverColor: '#60a5fa',
  pinActiveColor: '#22c55e',
  pinSize: 6,
  pinGlowIntensity: 0.3,
  pinGlowColor: '#3b82f6',
  tooltipBackground: '#1e1e2e',
  tooltipBorder: '#4b5563',
  tooltipTextColor: '#f8fafc',
  tooltipSecondaryColor: '#9ca3af',
)
```

### Style Presets

```dart
// Dark theme (default)
ArcaneMap(
  style: MapStyle.dark,
  type: MapType.world,
)

// Light theme
ArcaneMap(
  style: MapStyle.light,
  type: MapType.world,
)

// Subtle (thinner lines, smaller pins)
ArcaneMap(
  style: MapStyle.subtle,
  type: MapType.world,
)

// Prominent (thicker lines, larger pins)
ArcaneMap(
  style: MapStyle.prominent,
  type: MapType.world,
)
```

---

## Region Highlighting

Highlight specific regions (states for USA, countries for world):

```dart
// USA states
ArcaneMap(
  type: MapType.usa,
  activeRegions: {'CA', 'TX', 'NY', 'FL'},
)

// World countries (ISO 2-letter codes)
ArcaneMap(
  type: MapType.world,
  activeRegions: {'US', 'GB', 'DE', 'JP'},
)
```

---

## Region Callbacks

```dart
ArcaneMap(
  type: MapType.usa,
  onRegionTap: (region) {
    print('Tapped ${region.name} (${region.code})');
  },
  onRegionHover: (region) {
    print('Hovering ${region.name}');
  },
)
```

---

## Available State Codes (USA)

All 50 US states plus DC:
`AL`, `AK`, `AZ`, `AR`, `CA`, `CO`, `CT`, `DE`, `DC`, `FL`, `GA`, `HI`, `ID`, `IL`, `IN`, `IA`, `KS`, `KY`, `LA`, `ME`, `MD`, `MA`, `MI`, `MN`, `MS`, `MO`, `MT`, `NE`, `NV`, `NH`, `NJ`, `NM`, `NY`, `NC`, `ND`, `OH`, `OK`, `OR`, `PA`, `RI`, `SC`, `SD`, `TN`, `TX`, `UT`, `VT`, `VA`, `WA`, `WV`, `WI`, `WY`

---

## Map Dimensions

### World Map
- SVG Size: 2000 x 857
- Aspect Ratio: 2.33
- Projection: Equirectangular (83N to 60S)

### USA Map
- SVG Size: 1000 x 589
- Aspect Ratio: 1.70
- Projection: Linear interpolation
