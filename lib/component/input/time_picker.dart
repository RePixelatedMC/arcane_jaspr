import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

/// Represents a time of day with hour and minute.
class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({required this.hour, required this.minute});

  /// Creates a TimeOfDay from the current time.
  factory TimeOfDay.now() {
    final now = DateTime.now();
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  /// Creates a TimeOfDay from a DateTime.
  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  /// Returns the hour in 12-hour format (1-12).
  int get hourOfPeriod => hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

  /// Returns whether this time is AM or PM.
  bool get isPM => hour >= 12;

  /// Returns a formatted string.
  String format({bool use24Hour = false}) {
    if (use24Hour) {
      return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
    final period = isPM ? 'PM' : 'AM';
    return '${hourOfPeriod.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }

  /// Creates a copy with the given fields replaced.
  TimeOfDay copyWith({int? hour, int? minute}) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay && hour == other.hour && minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() => format();
}

/// A time picker input with dropdown selection.
///
/// Example:
/// ```dart
/// ArcaneTimePicker(
///   value: selectedTime,
///   onChanged: (time) => setState(() => selectedTime = time),
///   label: 'Start Time',
/// )
/// ```
class ArcaneTimePicker extends StatefulComponent {
  /// Currently selected time
  final TimeOfDay? value;

  /// Called when time changes
  final void Function(TimeOfDay?)? onChanged;

  /// Label above the input
  final String? label;

  /// Placeholder text
  final String? placeholder;

  /// Whether to use 24-hour format
  final bool use24Hour;

  /// Minute interval (1, 5, 10, 15, 30)
  final int minuteInterval;

  /// Whether the picker is disabled
  final bool disabled;

  /// Error message
  final String? error;

  /// Whether to allow clearing
  final bool clearable;

  /// Whether to show seconds
  final bool showSeconds;

  /// Size variant
  final TimePickerSize size;

  const ArcaneTimePicker({
    this.value,
    this.onChanged,
    this.label,
    this.placeholder,
    this.use24Hour = false,
    this.minuteInterval = 1,
    this.disabled = false,
    this.error,
    this.clearable = true,
    this.showSeconds = false,
    this.size = TimePickerSize.md,
    super.key,
  });

  @override
  State<ArcaneTimePicker> createState() => _ArcaneTimePickerState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-time-picker-trigger:hover:not(.disabled)').styles(raw: {
      'border-color': 'var(--accent)',
    }),
    css('.arcane-time-picker-trigger:focus').styles(raw: {
      'border-color': 'var(--accent)',
      'box-shadow': '0 0 0 2px hsl(var(--accent) / 0.2)',
      'outline': 'none',
    }),
    css('.arcane-time-picker-clear:hover').styles(raw: {
      'color': 'var(--destructive)',
    }),
    css('.arcane-time-picker-option:hover').styles(raw: {
      'background-color': 'var(--muted)',
    }),
    css('.arcane-time-picker-option.selected').styles(raw: {
      'background-color': 'var(--accent)',
      'color': 'var(--accent-foreground)',
    }),
  ];
}

class _ArcaneTimePickerState extends State<ArcaneTimePicker> {
  bool _isOpen = false;
  int _selectedHour = 0;
  int _selectedMinute = 0;
  bool _isPM = false;

  @override
  void initState() {
    super.initState();
    _initFromValue();
  }

  void _initFromValue() {
    if (component.value != null) {
      _selectedHour = component.use24Hour
          ? component.value!.hour
          : component.value!.hourOfPeriod;
      _selectedMinute = component.value!.minute;
      _isPM = component.value!.isPM;
    } else {
      final now = TimeOfDay.now();
      _selectedHour = component.use24Hour ? now.hour : now.hourOfPeriod;
      _selectedMinute = 0;
      _isPM = now.isPM;
    }
  }

  String get _displayText {
    if (component.value == null) {
      return component.placeholder ?? 'Select time...';
    }
    return component.value!.format(use24Hour: component.use24Hour);
  }

  void _toggleOpen() {
    if (component.disabled) return;
    setState(() => _isOpen = !_isOpen);
  }

  void _selectHour(int hour) {
    setState(() => _selectedHour = hour);
    _emitChange();
  }

  void _selectMinute(int minute) {
    setState(() => _selectedMinute = minute);
    _emitChange();
  }

  void _togglePeriod() {
    setState(() => _isPM = !_isPM);
    _emitChange();
  }

  void _emitChange() {
    int hour24 = _selectedHour;
    if (!component.use24Hour) {
      if (_isPM && _selectedHour != 12) {
        hour24 = _selectedHour + 12;
      } else if (!_isPM && _selectedHour == 12) {
        hour24 = 0;
      }
    }
    component.onChanged?.call(TimeOfDay(hour: hour24, minute: _selectedMinute));
  }

  void _clear() {
    component.onChanged?.call(null);
    setState(() => _isOpen = false);
  }

  void _confirm() {
    _emitChange();
    setState(() => _isOpen = false);
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.error != null;
    final hasValue = component.value != null;
    final sizeStyles = component.size.styles;

    return div(
      classes:
          'arcane-time-picker ${_isOpen ? 'open' : ''} ${component.disabled ? 'disabled' : ''} ${hasError ? 'error' : ''}',
      attributes: {
        'data-time-picker': 'true',
      },
      styles: const Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
      }),
      [
        // Label
        if (component.label != null)
          span(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
              'color': 'var(--foreground)',
            }),
            [Component.text(component.label!)],
          ),

        // Trigger button
        button(
          classes:
              'arcane-time-picker-trigger ${component.disabled ? 'disabled' : ''}',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'dialog',
            'aria-expanded': '$_isOpen',
            if (component.disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.5rem',
            'width': '100%',
            'height': sizeStyles['height']!,
            'padding': '0 1rem',
            'background-color': 'var(--card)',
            'border':
                '1px solid ${hasError ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': '0.375rem',
            'font-size': sizeStyles['fontSize']!,
            'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            'transition': 'all 150ms ease',
            'text-align': 'left',
            if (component.disabled) 'opacity': '0.5',
          }),
          events: {
            'click': (e) => _toggleOpen(),
          },
          [
            const span(
              styles: Styles(raw: {
                'color': 'var(--muted-foreground)',
              }),
              [Component.text('🕐')],
            ),
            span(
              styles: const Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(_displayText)],
            ),
            if (hasValue && component.clearable)
              span(
                classes: 'arcane-time-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear time',
                },
                styles: const Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'all 150ms ease',
                }),
                events: {
                  'click': (e) {
                    e.stopPropagation();
                    _clear();
                  },
                },
                [const Component.text('✕')],
              ),
          ],
        ),

        // Time picker dropdown
        if (_isOpen)
          div(
            classes: 'arcane-time-picker-dropdown',
            styles: const Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.25rem',
              'z-index': '100',
              'background-color': 'var(--card)',
              'border': '1px solid var(--border)',
              'border-radius': '0.5rem',
              'box-shadow': '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
              'padding': '1rem',
              'min-width': '280px',
            }),
            [
              // Time selection columns
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'gap': '1rem',
                }),
                [
                  // Hours column
                  _buildTimeColumn(
                    label: 'Hour',
                    values: component.use24Hour
                        ? List.generate(24, (i) => i)
                        : List.generate(12, (i) => i == 0 ? 12 : i),
                    selectedValue: _selectedHour,
                    onSelect: _selectHour,
                  ),

                  // Minutes column
                  _buildTimeColumn(
                    label: 'Minute',
                    values: List.generate(
                      60 ~/ component.minuteInterval,
                      (i) => i * component.minuteInterval,
                    ),
                    selectedValue: _selectedMinute,
                    onSelect: _selectMinute,
                    padZero: true,
                  ),

                  // AM/PM selector (12-hour mode only)
                  if (!component.use24Hour)
                    div(
                      styles: const Styles(raw: {
                        'display': 'flex',
                        'flex-direction': 'column',
                        'gap': '0.25rem',
                      }),
                      [
                        const span(
                          styles: Styles(raw: {
                            'font-size': '0.75rem',
                            'font-weight': '500',
                            'color': 'var(--muted-foreground)',
                            'text-transform': 'uppercase',
                            'margin-bottom': '0.25rem',
                          }),
                          [Component.text('Period')],
                        ),
                        button(
                          classes:
                              'arcane-time-picker-option ${!_isPM ? 'selected' : ''}',
                          styles: Styles(raw: {
                            'padding': '0.5rem 1rem',
                            'border': 'none',
                            'border-radius': '0.375rem',
                            'background-color':
                                !_isPM ? 'var(--accent)' : 'transparent',
                            'color': !_isPM
                                ? 'var(--accent-foreground)'
                                : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': '0.875rem',
                            'transition': 'all 150ms ease',
                          }),
                          events: {
                            'click': (e) {
                              if (_isPM) _togglePeriod();
                            },
                          },
                          [const Component.text('AM')],
                        ),
                        button(
                          classes:
                              'arcane-time-picker-option ${_isPM ? 'selected' : ''}',
                          styles: Styles(raw: {
                            'padding': '0.5rem 1rem',
                            'border': 'none',
                            'border-radius': '0.375rem',
                            'background-color':
                                _isPM ? 'var(--accent)' : 'transparent',
                            'color': _isPM
                                ? 'var(--accent-foreground)'
                                : 'var(--foreground)',
                            'cursor': 'pointer',
                            'font-size': '0.875rem',
                            'transition': 'all 150ms ease',
                          }),
                          events: {
                            'click': (e) {
                              if (!_isPM) _togglePeriod();
                            },
                          },
                          [const Component.text('PM')],
                        ),
                      ],
                    ),
                ],
              ),

              // Action buttons
              div(
                styles: const Styles(raw: {
                  'display': 'flex',
                  'justify-content': 'flex-end',
                  'gap': '0.5rem',
                  'margin-top': '1rem',
                  'padding-top': '1rem',
                  'border-top': '1px solid var(--border)',
                }),
                [
                  button(
                    styles: const Styles(raw: {
                      'padding': '0.5rem 1rem',
                      'border': '1px solid var(--border)',
                      'border-radius': '0.375rem',
                      'background-color': 'transparent',
                      'color': 'var(--foreground)',
                      'cursor': 'pointer',
                      'font-size': '0.875rem',
                    }),
                    events: {
                      'click': (e) => setState(() => _isOpen = false),
                    },
                    [const Component.text('Cancel')],
                  ),
                  button(
                    styles: const Styles(raw: {
                      'padding': '0.5rem 1rem',
                      'border': 'none',
                      'border-radius': '0.375rem',
                      'background-color': 'var(--accent)',
                      'color': 'var(--accent-foreground)',
                      'cursor': 'pointer',
                      'font-size': '0.875rem',
                    }),
                    events: {
                      'click': (e) => _confirm(),
                    },
                    [const Component.text('Confirm')],
                  ),
                ],
              ),
            ],
          ),

        // Error message
        if (hasError)
          span(
            styles: const Styles(raw: {
              'font-size': '0.875rem',
              'color': 'var(--destructive)',
            }),
            [Component.text(component.error!)],
          ),
      ],
    );
  }

  Component _buildTimeColumn({
    required String label,
    required List<int> values,
    required int selectedValue,
    required void Function(int) onSelect,
    bool padZero = false,
  }) {
    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.25rem',
      }),
      [
        span(
          styles: const Styles(raw: {
            'font-size': '0.75rem',
            'font-weight': '500',
            'color': 'var(--muted-foreground)',
            'text-transform': 'uppercase',
            'margin-bottom': '0.25rem',
          }),
          [Component.text(label)],
        ),
        div(
          styles: const Styles(raw: {
            'max-height': '200px',
            'overflow-y': 'auto',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            for (final value in values)
              button(
                classes:
                    'arcane-time-picker-option ${value == selectedValue ? 'selected' : ''}',
                styles: Styles(raw: {
                  'padding': '0.25rem 1rem',
                  'border': 'none',
                  'border-radius': '0.375rem',
                  'background-color': value == selectedValue
                      ? 'var(--accent)'
                      : 'transparent',
                  'color': value == selectedValue
                      ? 'var(--accent-foreground)'
                      : 'var(--foreground)',
                  'cursor': 'pointer',
                  'font-size': '0.875rem',
                  'text-align': 'center',
                  'min-width': '48px',
                  'transition': 'all 150ms ease',
                }),
                events: {
                  'click': (e) => onSelect(value),
                },
                [
                  Component.text(
                      padZero ? value.toString().padLeft(2, '0') : '$value')
                ],
              ),
          ],
        ),
      ],
    );
  }
}

/// Size variants for time picker
enum TimePickerSize {
  sm,
  md,
  lg,
}

extension TimePickerSizeExtension on TimePickerSize {
  Map<String, String> get styles => switch (this) {
        TimePickerSize.sm => {
            'height': '32px',
            'fontSize': '0.875rem',
          },
        TimePickerSize.md => {
            'height': '40px',
            'fontSize': '0.875rem',
          },
        TimePickerSize.lg => {
            'height': '48px',
            'fontSize': '1rem',
          },
      };
}
