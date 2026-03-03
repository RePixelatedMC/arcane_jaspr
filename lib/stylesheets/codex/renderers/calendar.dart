import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import '../../../core/props/calendar_props.dart';

/// Codex calendar component with restrained dark styling.
class CodexCalendar extends StatelessComponent {
  final CalendarProps props;

  const CodexCalendar(this.props, {super.key});

  static const List<String> _weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const List<String> _months = [
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

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isDisabled(DateTime date) {
    if (props.isDisabled?.call(date) ?? false) return true;
    if (props.minDate != null && date.isBefore(props.minDate!)) return true;
    if (props.maxDate != null && date.isAfter(props.maxDate!)) return true;
    return false;
  }

  bool _isSelected(DateTime date) => props.selected != null && _isSameDay(date, props.selected!);
  bool _isToday(DateTime date) => _isSameDay(date, DateTime.now());

  bool _isInRange(DateTime date) {
    if (props.selectedRange == null) return false;
    return date.isAfter(props.selectedRange!.start.subtract(const Duration(days: 1))) &&
        date.isBefore(props.selectedRange!.end.add(const Duration(days: 1)));
  }

  List<DateTime> _getDaysInMonth() {
    final List<DateTime> days = <DateTime>[];
    final DateTime displayMonth = props.displayMonth;
    final DateTime firstDay = DateTime(displayMonth.year, displayMonth.month, 1);
    final DateTime lastDay = DateTime(displayMonth.year, displayMonth.month + 1, 0);

    int startWeekday = firstDay.weekday % 7;
    if (props.firstDayOfWeek == 1) {
      startWeekday = (firstDay.weekday - 1) % 7;
    }

    for (int i = startWeekday - 1; i >= 0; i--) {
      days.add(firstDay.subtract(Duration(days: i + 1)));
    }

    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(displayMonth.year, displayMonth.month, i));
    }

    final int remaining = 7 - (days.length % 7);
    if (remaining < 7) {
      for (int i = 1; i <= remaining; i++) {
        days.add(DateTime(displayMonth.year, displayMonth.month + 1, i));
      }
    }

    return days;
  }

  int _getWeekNumber(DateTime date) {
    final DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    final int dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  @override
  Component build(BuildContext context) {
    final List<DateTime> days = _getDaysInMonth();
    final List<String> weekDays = props.firstDayOfWeek == 1
        ? <String>[..._weekDays.sublist(1), _weekDays[0]]
        : _weekDays;
    final DateTime month = props.displayMonth;

    return dom.div(
      classes: 'codex-calendar',
      attributes: {
        'role': 'application',
        'aria-label': 'Calendar',
        'data-mode': props.mode.name,
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '10px',
        'padding': '14px',
        'background': 'var(--codex-surface-1)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'width': 'fit-content',
      }),
      [
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': '8px',
          }),
          [
            _navButton(
              label: 'Previous month',
              symbol: '<',
              onClick: props.onPreviousMonth,
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'font-weight': 'var(--font-weight-medium)',
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--foreground)',
              }),
              [Component.text('${_months[month.month - 1]} ${month.year}')],
            ),
            _navButton(
              label: 'Next month',
              symbol: '>',
              onClick: props.onNextMonth,
            ),
          ],
        ),
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns': props.showWeekNumbers
                ? 'auto repeat(7, 1fr)'
                : 'repeat(7, 1fr)',
            'gap': '4px',
          }),
          [
            if (props.showWeekNumbers)
              const dom.div(styles: dom.Styles(raw: {'width': '34px'}), []),
            for (final String day in weekDays)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'height': '30px',
                  'font-size': '11px',
                  'font-weight': '600',
                  'color': 'var(--muted-foreground)',
                  'text-transform': 'uppercase',
                }),
                [Component.text(day)],
              ),
          ],
        ),
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns': props.showWeekNumbers
                ? 'auto repeat(7, 1fr)'
                : 'repeat(7, 1fr)',
            'gap': '4px',
          }),
          [
            for (int i = 0; i < days.length; i++) ...[
              if (props.showWeekNumbers && i % 7 == 0)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '34px',
                    'height': '32px',
                    'font-size': '11px',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text('${_getWeekNumber(days[i])}')],
                ),
              _buildDay(days[i]),
            ],
          ],
        ),
        if (props.showToday)
          dom.button(
            classes: 'codex-calendar-today-btn',
            attributes: {'type': 'button', 'data-state': 'today-action'},
            styles: const dom.Styles(raw: {
              'align-self': 'center',
              'padding': '7px 12px',
              'background': 'var(--codex-surface-2)',
              'border': '1px solid var(--codex-accent-border)',
              'border-radius': 'var(--radius)',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--codex-accent)',
              'cursor': 'pointer',
            }),
            events: props.onGoToToday == null ? null : {'click': (_) => props.onGoToToday!()},
            [const Component.text('Today')],
          ),
      ],
    );
  }

  Component _navButton({
    required String label,
    required String symbol,
    required void Function()? onClick,
  }) {
    return dom.button(
      classes: 'codex-calendar-nav-btn',
      attributes: {'type': 'button', 'aria-label': label},
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '30px',
        'height': '30px',
        'background': 'var(--codex-surface-2)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius-sm)',
        'cursor': 'pointer',
        'color': 'var(--foreground)',
      }),
      events: onClick == null ? null : {'click': (_) => onClick()},
      [Component.text(symbol)],
    );
  }

  Component _buildDay(DateTime date) {
    final bool isOutside = date.month != props.displayMonth.month;
    final bool isDisabled = _isDisabled(date);
    final bool isSelected = _isSelected(date);
    final bool isToday = _isToday(date);
    final bool isInRange = _isInRange(date);
    final bool isRangeStart =
        props.selectedRange != null && _isSameDay(date, props.selectedRange!.start);
    final bool isRangeEnd =
        props.selectedRange != null && _isSameDay(date, props.selectedRange!.end);

    return dom.button(
      classes: 'codex-calendar-day',
      attributes: {
        'type': 'button',
        'aria-label': '${date.day} ${_months[date.month - 1]} ${date.year}',
        'aria-selected': '$isSelected',
        'data-state': isSelected ? 'selected' : (isToday ? 'today' : 'idle'),
        'data-disabled': '$isDisabled',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '32px',
        'height': '32px',
        'border-radius': 'var(--radius-sm)',
        'border': isToday && !isSelected ? '1px solid var(--codex-accent-border)' : '1px solid transparent',
        'background': isSelected
            ? 'color-mix(in srgb, var(--codex-accent) 18%, var(--codex-surface-2))'
            : isInRange
                ? 'color-mix(in srgb, var(--codex-accent) 8%, var(--codex-surface-1))'
                : 'transparent',
        'font-size': '13px',
        'font-weight': isSelected || isToday ? '600' : '500',
        'color': isSelected
            ? 'var(--codex-accent)'
            : isOutside
                ? 'var(--muted-foreground)'
                : 'var(--foreground)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'opacity': isDisabled ? '0.35' : '1',
        if (isRangeStart) 'border-top-left-radius': 'var(--radius)',
        if (isRangeStart) 'border-bottom-left-radius': 'var(--radius)',
        if (isRangeEnd) 'border-top-right-radius': 'var(--radius)',
        if (isRangeEnd) 'border-bottom-right-radius': 'var(--radius)',
      }),
      events: props.onSelectDate != null && !isDisabled
          ? {'click': (_) => props.onSelectDate!(date)}
          : null,
      [Component.text('${date.day}')],
    );
  }
}
