import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import '../interaction/interaction.dart';
import '../interaction/interaction_attrs.dart';
import '../props/calendar_props.dart';

const List<String> _calendarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

const List<String> _calendarWeekdays = <String>[
  'Sun',
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

Component buildCalendarMarkup(
  CalendarProps props, {
  required String classes,
  required String navButtonClasses,
  required String todayButtonClasses,
  required String dayButtonClasses,
  required dom.Styles styles,
}) {
  String calendarId = props.id ?? 'cal-${identityHashCode(props)}';
  Map<String, String> attrs = mergeAttrs(<Map<String, String>>[
    calendarAttrs(
      calendarId: calendarId,
      year: props.displayMonth.year,
      month: props.displayMonth.month - 1,
      mode: props.mode == CalendarModeVariant.range ? 'range' : 'single',
      selected: props.selected,
      rangeStart: props.selectedRange?.start,
      rangeEnd: props.selectedRange?.end,
      minDate: props.minDate,
      maxDate: props.maxDate,
      showWeekNumbers: props.showWeekNumbers,
      showToday: props.showToday,
      firstDayOfWeek: props.firstDayOfWeek,
    ),
    <String, String>{'role': 'application', 'aria-label': 'Calendar'},
  ]);

  return dom.div(
    <Component>[
      _calendarHeader(props, calendarId, navButtonClasses),
      if (props.showToday) _todayButton(props, calendarId, todayButtonClasses),
      _weekdayRow(props),
      _dayGrid(props, calendarId, dayButtonClasses),
    ],
    classes: classes,
    attributes: attrs,
    styles: styles,
  );
}

Component _calendarHeader(
  CalendarProps props,
  String calendarId,
  String navButtonClasses,
) {
  String label =
      '${_calendarMonths[props.displayMonth.month - 1]} ${props.displayMonth.year}';
  return dom.div(
    <Component>[
      dom.button(
        <Component>[Component.text('‹')],
        classes:
            'arcane-calendar-nav arcane-calendar-nav-btn arcane-calendar-prev $navButtonClasses',
        attributes: mergeAttrs(<Map<String, String>>[
          interactionAttrs(ArcaneInteraction.calendarPrev(calendarId)),
          <String, String>{'type': 'button', 'aria-label': 'Previous month'},
        ]),
        events: <String, EventCallback>{
          if (props.onPreviousMonth != null)
            'click': (_) => props.onPreviousMonth?.call(),
        },
      ),
      dom.div(
        <Component>[Component.text(label)],
        classes: 'arcane-calendar-label',
        attributes: const <String, String>{'data-arcane-calendar-label': ''},
      ),
      dom.button(
        <Component>[Component.text('›')],
        classes:
            'arcane-calendar-nav arcane-calendar-nav-btn arcane-calendar-next $navButtonClasses',
        attributes: mergeAttrs(<Map<String, String>>[
          interactionAttrs(ArcaneInteraction.calendarNext(calendarId)),
          <String, String>{'type': 'button', 'aria-label': 'Next month'},
        ]),
        events: <String, EventCallback>{
          if (props.onNextMonth != null)
            'click': (_) => props.onNextMonth?.call(),
        },
      ),
    ],
    classes: 'arcane-calendar-header',
    attributes: const <String, String>{'data-arcane-calendar-header': ''},
  );
}

Component _todayButton(
  CalendarProps props,
  String calendarId,
  String todayButtonClasses,
) {
  return dom.div(<Component>[
    dom.button(
      <Component>[Component.text('Today')],
      classes:
          'arcane-calendar-today arcane-calendar-nav-btn $todayButtonClasses',
      attributes: mergeAttrs(<Map<String, String>>[
        interactionAttrs(ArcaneInteraction.calendarToday(calendarId)),
        <String, String>{'type': 'button'},
      ]),
      events: <String, EventCallback>{
        if (props.onGoToToday != null)
          'click': (_) => props.onGoToToday?.call(),
      },
    ),
  ], classes: 'arcane-calendar-today-row');
}

Component _weekdayRow(CalendarProps props) {
  List<Component> children = <Component>[];
  if (props.showWeekNumbers) {
    children.add(
      dom.div(<Component>[
        Component.text('#'),
      ], classes: 'arcane-calendar-weekday arcane-calendar-week-num'),
    );
  }
  for (int index = 0; index < 7; index++) {
    int weekdayIndex = (props.firstDayOfWeek + index) % 7;
    children.add(
      dom.div(<Component>[
        Component.text(_calendarWeekdays[weekdayIndex]),
      ], classes: 'arcane-calendar-weekday'),
    );
  }
  return dom.div(children, classes: 'arcane-calendar-weekdays');
}

Component _dayGrid(
  CalendarProps props,
  String calendarId,
  String dayButtonClasses,
) {
  List<Component> children = <Component>[];
  DateTime monthStart = DateTime(
    props.displayMonth.year,
    props.displayMonth.month,
    1,
  );
  int firstDayIndex = monthStart.weekday % 7;
  int startOffset = (firstDayIndex - props.firstDayOfWeek) % 7;
  DateTime cursor = monthStart.subtract(Duration(days: startOffset));

  for (int week = 0; week < 6; week++) {
    if (props.showWeekNumbers) {
      children.add(
        dom.div(<Component>[
          Component.text('${_weekNumber(cursor)}'),
        ], classes: 'arcane-calendar-weeknum'),
      );
    }
    for (int day = 0; day < 7; day++) {
      DateTime date = cursor;
      bool inMonth = date.month == props.displayMonth.month;
      children.add(
        _dayButton(props, calendarId, dayButtonClasses, date, inMonth),
      );
      cursor = cursor.add(const Duration(days: 1));
    }
  }

  return dom.div(children, classes: 'arcane-calendar-grid');
}

Component _dayButton(
  CalendarProps props,
  String calendarId,
  String dayButtonClasses,
  DateTime date,
  bool inMonth,
) {
  bool disabled = _isDisabled(props, date);
  bool selected = _sameDate(props.selected, date);
  bool today = _sameDate(DateTime.now(), date);
  bool inRange = _inSelectedRange(props, date);
  bool rangeStart = _sameDate(props.selectedRange?.start, date);
  bool rangeEnd = _sameDate(props.selectedRange?.end, date);
  bool pending = _sameDate(props.rangeStart, date);
  String value = _dateValue(date);

  return dom.button(
    <Component>[Component.text('${date.day}')],
    classes: _dayClasses(
      dayButtonClasses,
      inMonth: inMonth,
      disabled: disabled,
      selected: selected,
      today: today,
      inRange: inRange,
      rangeStart: rangeStart,
      rangeEnd: rangeEnd,
      pending: pending,
    ),
    attributes: <String, String>{
      ...interactionAttrs(ArcaneInteraction.calendarSelect(calendarId, value)),
      'type': 'button',
      'data-arcane-value': value,
      'aria-label': 'Select ${date.month}/${date.day}/${date.year}',
      if (selected) 'aria-selected': 'true',
      if (selected) 'data-state': 'selected',
      if (selected) 'data-selected': 'true',
      if (today) 'data-today': 'true',
      if (disabled) 'disabled': 'true',
      if (disabled) 'data-disabled': 'true',
      if (disabled) 'aria-disabled': 'true',
    },
    events: <String, EventCallback>{
      if (!disabled && props.onSelectDate != null)
        'click': (_) => props.onSelectDate?.call(date),
    },
  );
}

String _dayClasses(
  String dayButtonClasses, {
  required bool inMonth,
  required bool disabled,
  required bool selected,
  required bool today,
  required bool inRange,
  required bool rangeStart,
  required bool rangeEnd,
  required bool pending,
}) {
  List<String> classes = <String>['arcane-calendar-day', dayButtonClasses];
  if (!inMonth) classes.add('arcane-calendar-day-other-month');
  if (disabled) classes.add('arcane-calendar-day-disabled');
  if (today) classes.add('arcane-calendar-day-today');
  if (selected) classes.add('arcane-calendar-day-selected');
  if (inRange) classes.add('arcane-calendar-day-in-range');
  if (rangeStart) classes.add('arcane-calendar-day-range-start');
  if (rangeEnd) classes.add('arcane-calendar-day-range-end');
  if (pending) classes.add('arcane-calendar-day-pending');
  return classes.join(' ');
}

bool _sameDate(DateTime? left, DateTime right) =>
    left != null &&
    left.year == right.year &&
    left.month == right.month &&
    left.day == right.day;

bool _inSelectedRange(CalendarProps props, DateTime date) {
  DateRangeValue? range = props.selectedRange;
  if (range == null) return false;
  DateTime value = DateTime(date.year, date.month, date.day);
  DateTime start = DateTime(
    range.start.year,
    range.start.month,
    range.start.day,
  );
  DateTime end = DateTime(range.end.year, range.end.month, range.end.day);
  return !value.isBefore(start) && !value.isAfter(end);
}

bool _isDisabled(CalendarProps props, DateTime date) {
  if (props.isDisabled?.call(date) ?? false) return true;
  DateTime value = DateTime(date.year, date.month, date.day);
  DateTime? minDate = props.minDate == null
      ? null
      : DateTime(props.minDate!.year, props.minDate!.month, props.minDate!.day);
  DateTime? maxDate = props.maxDate == null
      ? null
      : DateTime(props.maxDate!.year, props.maxDate!.month, props.maxDate!.day);
  if (minDate != null && value.isBefore(minDate)) return true;
  if (maxDate != null && value.isAfter(maxDate)) return true;
  return false;
}

String _dateValue(DateTime date) => DateTime(
  date.year,
  date.month,
  date.day,
).toIso8601String().split('T').first;

int _weekNumber(DateTime date) {
  int dayIndex = (date.weekday + 6) % 7;
  DateTime thursday = date.add(Duration(days: 3 - dayIndex));
  DateTime firstThursday = DateTime(thursday.year, 1, 4);
  int firstDayIndex = (firstThursday.weekday + 6) % 7;
  DateTime weekOne = firstThursday.add(Duration(days: 3 - firstDayIndex));
  return 1 + thursday.difference(weekOne).inDays ~/ 7;
}
