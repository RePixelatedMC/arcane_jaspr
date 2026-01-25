---
title: ArcaneDatePicker
description: Date selection component with calendar popup
layout: kb
component: date-picker
---

# ArcaneDatePicker

A date picker component with calendar dropdown for selecting dates. Part of the unified ArcaneDateTimePicker family.

## Basic Usage

```dart
ArcaneDatePicker(
  value: selectedDate,
  onChanged: (date) => setState(() => selectedDate = date),
)
```

## With Placeholder

```dart
ArcaneDatePicker(
  placeholder: 'Select a date',
  value: selectedDate,
  onChanged: (date) => updateDate(date),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `DateTime?` | `null` | Currently selected date |
| `onChanged` | `Function(DateTime)?` | `null` | Date change callback |
| `placeholder` | `String` | `'Select date'` | Placeholder text |
| `minDate` | `DateTime?` | `null` | Minimum selectable date |
| `maxDate` | `DateTime?` | `null` | Maximum selectable date |
| `disabled` | `bool` | `false` | Disable the picker |
| `format` | `String` | `'MMM d, yyyy'` | Date display format |

## Date Constraints

```dart
ArcaneDatePicker(
  minDate: DateTime.now(),
  maxDate: DateTime.now().add(Duration(days: 365)),
  value: selectedDate,
  onChanged: (date) => setDate(date),
)
```

## Custom Format

```dart
ArcaneDatePicker(
  format: 'yyyy-MM-dd',
  value: selectedDate,
  onChanged: (date) => setDate(date),
)
```

## Related Components

- **ArcaneTimePicker** - Time-only selection
- **ArcaneDateTimePicker** - Combined date and time selection
- **ArcaneCalendar** - Full calendar display component

## Use Cases

- Birth date selection
- Event scheduling
- Booking systems
- Report date filters
- Due date pickers
