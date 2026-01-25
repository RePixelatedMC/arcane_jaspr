---
title: ArcaneTimePicker
description: Time selection component with dropdown
layout: kb
component: time-picker
---

# ArcaneTimePicker

A time picker component for selecting hours and minutes. Part of the unified ArcaneDateTimePicker family.

## Basic Usage

```dart
ArcaneTimePicker(
  value: selectedTime,
  onChanged: (time) => setState(() => selectedTime = time),
)
```

## With Placeholder

```dart
ArcaneTimePicker(
  placeholder: 'Select time',
  value: selectedTime,
  onChanged: (time) => updateTime(time),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `TimeOfDay?` | `null` | Currently selected time |
| `onChanged` | `Function(TimeOfDay)?` | `null` | Time change callback |
| `placeholder` | `String` | `'Select time'` | Placeholder text |
| `use24Hour` | `bool` | `false` | Use 24-hour format |
| `minuteInterval` | `int` | `1` | Minute step interval |
| `disabled` | `bool` | `false` | Disable the picker |

## 24-Hour Format

```dart
ArcaneTimePicker(
  use24Hour: true,
  value: selectedTime,
  onChanged: (time) => setTime(time),
)
```

## Minute Intervals

```dart
// 15-minute intervals (00, 15, 30, 45)
ArcaneTimePicker(
  minuteInterval: 15,
  value: selectedTime,
  onChanged: (time) => setTime(time),
)

// 30-minute intervals
ArcaneTimePicker(
  minuteInterval: 30,
  value: selectedTime,
  onChanged: (time) => setTime(time),
)
```

## Related Components

- **ArcaneDatePicker** - Date-only selection
- **ArcaneDateTimePicker** - Combined date and time selection

## Use Cases

- Meeting time selection
- Appointment scheduling
- Alarm/reminder times
- Business hours configuration
- Event start/end times
