---
title: ArcaneWorldMap
description: An interactive, themeable SVG world map component
layout: docs
component: world-map
---

# ArcaneWorldMap

An interactive SVG world map that displays location markers with hover tooltips and click callbacks. Fully themeable via CSS variables.

## Features

- Interactive SVG world map
- Location pins with hover effects and tooltips
- Custom tooltip support
- Multiple style presets (standard, subtle, prominent)
- Configurable pin colors and sizes
- Active/highlighted locations

## Usage

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
    ArcaneMapLocation(
      id: 'tok',
      name: 'Tokyo',
      latitude: 35.6762,
      longitude: 139.6503,
      code: 'TYO',
      region: 'Asia Pacific',
    ),
  ],
  onLocationTap: (location) => print('Tapped ${location.name}'),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `locations` | `List<ArcaneMapLocation>` | required | Locations to display as pins |
| `onLocationTap` | `MapLocationCallback?` | null | Callback when pin is clicked |
| `onLocationHover` | `MapLocationCallback?` | null | Callback when pin is hovered |
| `tooltipBuilder` | `Component Function(ArcaneMapLocation)?` | null | Custom tooltip builder |
| `style` | `ArcaneWorldMapStyle` | `ArcaneWorldMapStyle()` | Style configuration |
| `showTooltips` | `bool` | `true` | Show tooltips on hover |
| `height` | `String?` | null | Custom height |
| `className` | `String?` | null | Optional CSS class |
| `aspectRatio` | `double` | `2.33` | Aspect ratio (width:height) |

## ArcaneMapLocation

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

## Style Presets

```dart
// Standard (default)
ArcaneWorldMap(
  style: ArcaneWorldMapStyle.standard,
  locations: [...],
)

// Subtle - thinner lines, smaller pins
ArcaneWorldMap(
  style: ArcaneWorldMapStyle.subtle,
  locations: [...],
)

// Prominent - thicker lines, larger pins
ArcaneWorldMap(
  style: ArcaneWorldMapStyle.prominent,
  locations: [...],
)
```

## Custom Styling

```dart
ArcaneWorldMap(
  style: ArcaneWorldMapStyle(
    landFill: 'rgba(255, 255, 255, 0.05)',
    landStroke: 'rgba(255, 255, 255, 0.1)',
    oceanFill: 'transparent',
    pinColor: '#10b981',
    pinHoverColor: '#34d399',
    pinActiveColor: '#22c55e',
    pinSize: 8,
    pinGlowIntensity: 0.4,
  ),
  locations: [...],
)
```

## Custom Tooltips

```dart
ArcaneWorldMap(
  locations: [...],
  tooltipBuilder: (location) => ArcaneCard(
    child: ArcaneColumn(
      children: [
        ArcaneText(location.name, weight: FontWeight.bold),
        ArcaneText('Latency: ${location.metadata?['latency']}ms'),
      ],
    ),
  ),
)
```
