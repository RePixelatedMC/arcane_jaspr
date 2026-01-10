import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/calendar_props.dart';

/// Codex-style calendar component
class CodexCalendar extends StatelessComponent {
  final CalendarProps props;

  const CodexCalendar(this.props, {super.key});

  static const List<String> _weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
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
    return date.isAfter(props.selectedRange!.start.subtract(const Duration(days: 1))) &&
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
      classes: 'codex-calendar',
      attributes: {
        'role': 'application',
        'aria-label': 'Calendar',
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '10px',
        'padding': '16px',
        'background-color': 'var(--card)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--radius)',
        'width': 'fit-content',
      }),
      [
        // Header with navigation
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': '10px',
          }),
          [
            dom.button(
              classes: 'codex-calendar-nav-btn',
              attributes: {
                'type': 'button',
                'aria-label': 'Previous month',
              },
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '36px',
                'height': '36px',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--radius)',
                'cursor': 'pointer',
                'color': 'var(--foreground)',
                'transition': 'background-color var(--arcane-transition)',
              }),
              events: props.onPreviousMonth != null
                  ? {'click': (_) => props.onPreviousMonth!()}
                  : null,
              [const Component.text('<')],
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'font-weight': 'var(--arcane-font-weight-semibold)',
                'font-size': 'var(--arcane-font-size-sm)',
                'color': 'var(--foreground)',
              }),
              [Component.text('${_months[displayMonth.month - 1]} ${displayMonth.year}')],
            ),
            dom.button(
              classes: 'codex-calendar-nav-btn',
              attributes: {
                'type': 'button',
                'aria-label': 'Next month',
              },
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '36px',
                'height': '36px',
                'background': 'transparent',
                'border': 'none',
                'border-radius': 'var(--radius)',
                'cursor': 'pointer',
                'color': 'var(--foreground)',
                'transition': 'background-color var(--arcane-transition)',
              }),
              events: props.onNextMonth != null
                  ? {'click': (_) => props.onNextMonth!()}
                  : null,
              [const Component.text('>')],
            ),
          ],
        ),

        // Week day headers
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
              const dom.div(
                styles: dom.Styles(raw: {'width': '36px'}),
                [],
              ),
            for (final day in weekDays)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'height': '36px',
                  'font-size': 'var(--arcane-font-size-xs)',
                  'font-weight': 'var(--arcane-font-weight-medium)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(day)],
              ),
          ],
        ),

        // Calendar grid
        dom.div(
          styles: dom.Styles(raw: {
            'display': 'grid',
            'grid-template-columns': props.showWeekNumbers
                ? 'auto repeat(7, 1fr)'
                : 'repeat(7, 1fr)',
            'gap': '4px',
          }),
          [
            for (var i = 0; i < days.length; i++) ...[
              if (props.showWeekNumbers && i % 7 == 0)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'center',
                    'width': '36px',
                    'height': '36px',
                    'font-size': 'var(--arcane-font-size-xs)',
                    'color': 'var(--muted-foreground)',
                  }),
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
            styles: const dom.Styles(raw: {
              'padding': '6px 12px',
              'background': 'transparent',
              'border': '1px solid var(--border)',
              'border-radius': 'var(--radius)',
              'font-size': '0.8125rem',
              'color': 'var(--muted-foreground)',
              'cursor': 'pointer',
              'transition': 'background-color var(--arcane-transition)',
              'align-self': 'center',
            }),
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
    final isRangeStart = props.selectedRange != null &&
        _isSameDay(date, props.selectedRange!.start);
    final isRangeEnd = props.selectedRange != null &&
        _isSameDay(date, props.selectedRange!.end);

    return dom.button(
      classes: 'codex-calendar-day',
      attributes: {
        'type': 'button',
        'aria-label': '${date.day} ${_months[date.month - 1]} ${date.year}',
        'aria-selected': '$isSelected',
        if (isDisabled) 'disabled': 'true',
      },
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '36px',
        'height': '36px',
        'border': isToday && !isSelected
            ? '1px solid var(--codex-accent)'
            : 'none',
        'border-radius': 'var(--radius)',
        'background': isSelected
            ? 'var(--codex-accent)'
            : isInRange
                ? 'rgba(var(--codex-accent-rgb), 0.2)'
                : 'transparent',
        'font-size': 'var(--arcane-font-size-sm)',
        'color': isSelected
            ? '#ffffff'
            : isOutside
                ? 'var(--muted)'
                : 'var(--foreground)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'background-color var(--arcane-transition), color var(--arcane-transition)',
        if (isDisabled) 'opacity': '0.5',
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
