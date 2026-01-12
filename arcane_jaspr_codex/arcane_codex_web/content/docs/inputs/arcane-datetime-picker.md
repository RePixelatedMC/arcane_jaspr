---
title: ArcaneDateTimePicker
description: Unified date and time picker with three modes
layout: kb
component: datetime-picker
---

# ArcaneDateTimePicker

A unified picker component for dates, times, or both. Consolidates the previous `ArcaneDatePicker` and `ArcaneTimePicker` into a single component with mode selection.

## Date Only

```dart
ArcaneDateTimePicker.date(
  value: selectedDate,
  onDateChanged: (date) => setState(() => selectedDate = date),
  label: 'Birth Date',
  placeholder: 'Pick a date...',
)
```

## Time Only

```dart
ArcaneDateTimePicker.time(
  timeValue: selectedTime,
  onTimeChanged: (time) => setState(() => selectedTime = time),
  label: 'Start Time',
  placeholder: 'Pick a time...',
)
```

## Date and Time

```dart
ArcaneDateTimePicker(
  value: selectedDateTime,
  onChanged: (dateTime) => setState(() => selectedDateTime = dateTime),
  label: 'Event Time',
)
```

## Properties

### Common Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | - | Label above input |
| `placeholder` | `String?` | - | Placeholder text |
| `disabled` | `bool` | `false` | Disable picker |
| `error` | `String?` | - | Error message |
| `clearable` | `bool` | `true` | Allow clearing selection |
| `size` | `DateTimePickerSize` | `md` | Size variant |

### Date Mode Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `DateTime?` | - | Currently selected date |
| `onDateChanged` | `Function(DateTime?)?` | - | Called when date changes |
| `minDate` | `DateTime?` | - | Minimum selectable date |
| `maxDate` | `DateTime?` | - | Maximum selectable date |
| `disabledDates` | `Function(DateTime)?` | - | Custom disabled dates |
| `formatDate` | `Function(DateTime)?` | - | Custom date formatter |

### Time Mode Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `timeValue` | `TimeOfDay?` | - | Currently selected time |
| `onTimeChanged` | `Function(TimeOfDay?)?` | - | Called when time changes |
| `use24Hour` | `bool` | `false` | Use 24-hour format |
| `minuteInterval` | `int` | `1` | Minute step interval |
| `showSeconds` | `bool` | `false` | Show seconds selector |

### DateTime Mode Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `DateTime?` | - | Currently selected datetime |
| `onChanged` | `Function(DateTime?)?` | - | Called when datetime changes |

## With Date Constraints

```dart
ArcaneDateTimePicker.date(
  value: selectedDate,
  onDateChanged: (date) => setState(() => selectedDate = date),
  minDate: DateTime.now(),
  maxDate: DateTime.now().add(Duration(days: 365)),
  label: 'Future Date',
)
```

## 24-Hour Time Format

```dart
ArcaneDateTimePicker.time(
  timeValue: selectedTime,
  onTimeChanged: (time) => setState(() => selectedTime = time),
  use24Hour: true,
  minuteInterval: 15,
)
```

## Sizes

```dart
ArcaneDateTimePicker.date(value: date, size: DateTimePickerSize.sm)
ArcaneDateTimePicker.date(value: date, size: DateTimePickerSize.md)
ArcaneDateTimePicker.date(value: date, size: DateTimePickerSize.lg)
```

## Migration from ArcaneDatePicker/ArcaneTimePicker

### Before
```dart
ArcaneDatePicker(
  value: date,
  onChanged: (d) => setState(() => date = d),
)

ArcaneTimePicker(
  value: time,
  onChanged: (t) => setState(() => time = t),
)
```

### After
```dart
ArcaneDateTimePicker.date(
  value: date,
  onDateChanged: (d) => setState(() => date = d),
)

ArcaneDateTimePicker.time(
  timeValue: time,
  onTimeChanged: (t) => setState(() => time = t),
)
```

## Features

- Three modes: date only, time only, or both
- Calendar popup for date selection
- Dropdown time selector
- Custom date formatting
- 12/24 hour time formats
- Minute interval steps
- Clearable selection
- Min/max date constraints
- Size variants
