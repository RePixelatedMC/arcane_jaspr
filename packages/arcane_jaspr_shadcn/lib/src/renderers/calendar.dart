import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';

/// ShadCN-style calendar component
/// Reference: https://ui.shadcn.com/docs/components/calendar
class ShadcnCalendar extends StatelessComponent {
  final CalendarProps props;

  const ShadcnCalendar(this.props, {super.key});

  static const List<String> _weekDays = [
    'Su',
    'Mo',
    'Tu',
    'We',
    'Th',
    'Fr',
    'Sa',
  ];
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

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isDisabled(DateTime date) {
    if (props.isDisabled?.call(date) ?? false) return true;
    if (props.minDate != null && date.isBefore(props.minDate!)) return true;
    if (props.maxDate != null && date.isAfter(props.maxDate!)) return true;
    return false;
  }

  bool _isSelected(DateTime date) {
    if (props.selected == null) return false;
    return _isSameDay(date, props.selected!);
  }

  bool _isToday(DateTime date) {
    return _isSameDay(date, DateTime.now());
  }

  bool _isInRange(DateTime date) {
    if (props.selectedRange == null) return false;
    return date.isAfter(
          props.selectedRange!.start.subtract(const Duration(days: 1)),
        ) &&
        date.isBefore(props.selectedRange!.end.add(const Duration(days: 1)));
  }

  List<DateTime> _getDaysInMonth() {
    final days = <DateTime>[];
    final displayMonth = props.displayMonth;
    final firstDay = DateTime(displayMonth.year, displayMonth.month, 1);
    final lastDay = DateTime(displayMonth.year, displayMonth.month + 1, 0);

    var startWeekday = firstDay.weekday % 7;
    if (props.firstDayOfWeek == 1) {
      startWeekday = (firstDay.weekday - 1) % 7;
    }

    for (var i = startWeekday - 1; i >= 0; i--) {
      days.add(firstDay.subtract(Duration(days: i + 1)));
    }

    for (var i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(displayMonth.year, displayMonth.month, i));
    }

    final remaining = 7 - (days.length % 7);
    if (remaining < 7) {
      for (var i = 1; i <= remaining; i++) {
        days.add(DateTime(displayMonth.year, displayMonth.month + 1, i));
      }
    }

    return days;
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final dayOfYear = date.difference(firstDayOfYear).inDays + 1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  @override
  Component build(BuildContext context) {
    final days = _getDaysInMonth();
    final weekDays = props.firstDayOfWeek == 1
        ? [..._weekDays.sublist(1), _weekDays[0]]
        : _weekDays;
    final displayMonth = props.displayMonth;

    return dom.div(
      classes: 'arcane-calendar',
      attributes: {'role': 'application', 'aria-label': 'Calendar'},
      styles: const dom.Styles(
        raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)',
          'padding': '12px',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-md)',
          'width': 'fit-content',
        },
      ),
      [
        // Header with navigation
        dom.div(
          styles: const dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'space-between',
              'gap': 'var(--space-2)',
            },
          ),
          [
            dom.button(
              classes: 'arcane-calendar-nav-btn',
              attributes: {'type': 'button', 'aria-label': 'Previous month'},
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '32px',
                  'height': '32px',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': 'var(--radius-xs)',
                  'cursor': 'pointer',
                  'color': 'var(--foreground)',
                  'transition': 'background-color var(--transition)',
                },
              ),
              events: props.onPreviousMonth != null
                  ? {'click': (_) => props.onPreviousMonth!()}
                  : null,
              [ArcaneIcon.chevronLeft(size: IconSize.sm)],
            ),
            dom.span(
              styles: const dom.Styles(
                raw: {
                  'font-weight': 'var(--font-weight-semibold)',
                  'font-size': 'var(--font-size-sm)',
                  'color': 'var(--foreground)',
                },
              ),
              [
                Component.text(
                  '${_months[displayMonth.month - 1]} ${displayMonth.year}',
                ),
              ],
            ),
            dom.button(
              classes: 'arcane-calendar-nav-btn',
              attributes: {'type': 'button', 'aria-label': 'Next month'},
              styles: const dom.Styles(
                raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'width': '32px',
                  'height': '32px',
                  'background': 'transparent',
                  'border': 'none',
                  'border-radius': 'var(--radius-xs)',
                  'cursor': 'pointer',
                  'color': 'var(--foreground)',
                  'transition': 'background-color var(--transition)',
                },
              ),
              events: props.onNextMonth != null
                  ? {'click': (_) => props.onNextMonth!()}
                  : null,
              [ArcaneIcon.chevronRight(size: IconSize.sm)],
            ),
          ],
        ),

        // Week day headers
        dom.div(
          styles: dom.Styles(
            raw: {
              'display': 'grid',
              'grid-template-columns': props.showWeekNumbers
                  ? 'auto repeat(7, 1fr)'
                  : 'repeat(7, 1fr)',
              'gap': '2px',
            },
          ),
          [
            if (props.showWeekNumbers)
              const dom.div(styles: dom.Styles(raw: {'width': '32px'}), []),
            for (final day in weekDays)
              dom.div(
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'height': '32px',
                    'font-size': 'var(--font-size-xs)',
                    'font-weight': 'var(--font-weight-medium)',
                    'color': 'var(--muted-foreground)',
                  },
                ),
                [Component.text(day)],
              ),
          ],
        ),

        // Calendar grid
        dom.div(
          styles: dom.Styles(
            raw: {
              'display': 'grid',
              'grid-template-columns': props.showWeekNumbers
                  ? 'auto repeat(7, 1fr)'
                  : 'repeat(7, 1fr)',
              'gap': '2px',
            },
          ),
          [
            for (var i = 0; i < days.length; i++) ...[
              if (props.showWeekNumbers && i % 7 == 0)
                dom.div(
                  styles: const dom.Styles(
                    raw: {
                      'display': 'flex',
                      'align-items': 'center',
                      'justify-content': 'center',
                      'width': '32px',
                      'height': '32px',
                      'font-size': 'var(--font-size-xs)',
                      'color': 'var(--muted-foreground)',
                    },
                  ),
                  [Component.text('${_getWeekNumber(days[i])}')],
                ),
              _buildDay(days[i]),
            ],
          ],
        ),

        // Today button
        if (props.showToday)
          dom.button(
            attributes: {'type': 'button'},
            styles: const dom.Styles(
              raw: {
                'padding': '4px 8px',
                'background': 'transparent',
                'border': '1px solid var(--border)',
                'border-radius': 'var(--radius-xs)',
                'font-size': '13px',
                'color': 'var(--muted-foreground)',
                'cursor': 'pointer',
                'transition': 'background-color var(--transition)',
                'align-self': 'center',
              },
            ),
            events: props.onGoToToday != null
                ? {'click': (_) => props.onGoToToday!()}
                : null,
            [const Component.text('Today')],
          ),
      ],
    );
  }

  Component _buildDay(DateTime date) {
    final isOutside = date.month != props.displayMonth.month;
    final isDisabled = _isDisabled(date);
    final isSelected = _isSelected(date);
    final isToday = _isToday(date);
    final isInRange = _isInRange(date);
    final isRangeStart =
        props.selectedRange != null &&
        _isSameDay(date, props.selectedRange!.start);
    final isRangeEnd =
        props.selectedRange != null &&
        _isSameDay(date, props.selectedRange!.end);

    return dom.button(
      classes: 'arcane-calendar-day',
      attributes: {
        'type': 'button',
        'aria-label': '${date.day} ${_months[date.month - 1]} ${date.year}',
        'aria-selected': '$isSelected',
        if (isDisabled) 'disabled': 'true',
        'data-state': isSelected
            ? 'selected'
            : isInRange
            ? 'in-range'
            : isToday
            ? 'today'
            : 'default',
        'data-disabled': '$isDisabled',
      },
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'width': '32px',
          'height': '32px',
          'border': isToday && !isSelected
              ? '1px solid var(--primary)'
              : 'none',
          'border-radius': 'var(--radius-xs)',
          'background': isSelected
              ? 'var(--primary)'
              : isInRange
              ? 'var(--accent)'
              : 'transparent',
          'font-size': 'var(--font-size-sm)',
          'color': isSelected
              ? 'var(--primary-foreground)'
              : isOutside
              ? 'var(--muted)'
              : 'var(--foreground)',
          'cursor': isDisabled ? 'not-allowed' : 'pointer',
          'transition':
              'background-color var(--transition), color var(--transition)',
          if (isDisabled) 'opacity': '0.5',
          if (isRangeStart) 'border-top-left-radius': '6px',
          if (isRangeStart) 'border-bottom-left-radius': '6px',
          if (isRangeEnd) 'border-top-right-radius': '6px',
          if (isRangeEnd) 'border-bottom-right-radius': '6px',
        },
      ),
      events: props.onSelectDate != null && !isDisabled
          ? {'click': (_) => props.onSelectDate!(date)}
          : null,
      [Component.text('${date.day}')],
    );
  }
}
