import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/calendar_props.dart';

/// Codex-style calendar component.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Holographic gradient backgrounds
/// - Glowing neon day selection with pulse effects
/// - Cyberpunk-style navigation with glow trails
/// - Intense neon accents on today and selected dates
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
      classes: 'codex-calendar codex-neon',
      attributes: {
        'role': 'application',
        'aria-label': 'Calendar',
      },
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '12px',
        'padding': '20px',
        'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.8) 0%, rgba(var(--card-rgb), 0.6) 100%)',
        'border': '1px solid rgba(var(--primary-rgb), 0.3)',
        'border-radius': 'var(--radius)',
        'width': 'fit-content',
        // Subtle neon glow
        'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.1)',
      }),
      [
        // Header with neon navigation
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': '12px',
          }),
          [
            // Previous month button
            dom.button(
              classes: 'codex-calendar-nav-btn codex-neon',
              attributes: {
                'type': 'button',
                'aria-label': 'Previous month',
              },
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'background': 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.15) 0%, rgba(var(--primary-rgb), 0.05) 100%)',
                'border': '1px solid rgba(var(--primary-rgb), 0.3)',
                'border-radius': 'var(--radius)',
                'cursor': 'pointer',
                'color': 'var(--primary)',
                'font-weight': 'var(--font-weight-bold)',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                // Neon glow
                'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.15)',
                'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.5)',
              }),
              events: props.onPreviousMonth != null
                  ? {'click': (_) => props.onPreviousMonth!()}
                  : null,
              [const Component.text('<')],
            ),
            // Month/year display with neon text
            dom.span(
              styles: const dom.Styles(raw: {
                'font-weight': 'var(--font-weight-semibold)',
                'font-size': 'var(--font-size-base)',
                'letter-spacing': '0.025em',
                'color': 'var(--foreground)',
                'text-shadow': '0 0 10px rgba(var(--primary-rgb), 0.3)',
              }),
              [Component.text('${_months[displayMonth.month - 1]} ${displayMonth.year}')],
            ),
            // Next month button
            dom.button(
              classes: 'codex-calendar-nav-btn codex-neon',
              attributes: {
                'type': 'button',
                'aria-label': 'Next month',
              },
              styles: const dom.Styles(raw: {
                'display': 'flex',
                'align-items': 'center',
                'justify-content': 'center',
                'width': '40px',
                'height': '40px',
                'background': 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.15) 0%, rgba(var(--primary-rgb), 0.05) 100%)',
                'border': '1px solid rgba(var(--primary-rgb), 0.3)',
                'border-radius': 'var(--radius)',
                'cursor': 'pointer',
                'color': 'var(--primary)',
                'font-weight': 'var(--font-weight-bold)',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                // Neon glow
                'box-shadow': '0 0 10px rgba(var(--primary-rgb), 0.15)',
                'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.5)',
              }),
              events: props.onNextMonth != null
                  ? {'click': (_) => props.onNextMonth!()}
                  : null,
              [const Component.text('>')],
            ),
          ],
        ),

        // Week day headers with neon styling
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
                styles: dom.Styles(raw: {'width': '40px'}),
                [],
              ),
            for (final day in weekDays)
              dom.div(
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'align-items': 'center',
                  'justify-content': 'center',
                  'height': '40px',
                  'font-size': 'var(--font-size-xs)',
                  'font-weight': 'var(--font-weight-semibold)',
                  'letter-spacing': '0.05em',
                  'text-transform': 'uppercase',
                  'color': 'var(--primary)',
                  'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.4)',
                }),
                [Component.text(day)],
              ),
          ],
        ),

        // Calendar grid with neon days
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
                    'width': '40px',
                    'height': '40px',
                    'font-size': 'var(--font-size-xs)',
                    'color': 'var(--muted-foreground)',
                  }),
                  [Component.text('${_getWeekNumber(days[i])}')],
                ),
              _buildDay(days[i]),
            ],
          ],
        ),

        // Today button with neon styling
        if (props.showToday)
          dom.button(
            classes: 'codex-calendar-today-btn codex-neon',
            attributes: {'type': 'button'},
            styles: const dom.Styles(raw: {
              'padding': '10px 20px',
              'background': 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.15) 0%, rgba(var(--primary-rgb), 0.05) 100%)',
              'border': '1px solid rgba(var(--primary-rgb), 0.3)',
              'border-radius': 'var(--radius)',
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'color': 'var(--primary)',
              'cursor': 'pointer',
              'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
              'align-self': 'center',
              // Neon glow
              'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2)',
              'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.4)',
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
      classes: 'codex-calendar-day codex-neon',
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
        'width': '40px',
        'height': '40px',
        'border': isToday && !isSelected
            ? '1px solid var(--primary)'
            : '1px solid transparent',
        'border-radius': 'var(--radius)',
        'background': isSelected
            ? 'linear-gradient(135deg, var(--primary) 0%, color-mix(in srgb, var(--primary) 70%, #ff00ff) 100%)'
            : isInRange
                ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)'
                : 'transparent',
        'font-size': 'var(--font-size-sm)',
        'font-weight': isSelected || isToday
            ? 'var(--font-weight-semibold)'
            : 'var(--font-weight-medium)',
        'color': isSelected
            ? '#ffffff'
            : isOutside
                ? 'var(--muted)'
                : isToday
                    ? 'var(--primary)'
                    : 'var(--foreground)',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        // Neon glow effects
        'box-shadow': isSelected
            ? '0 0 20px rgba(var(--primary-rgb), 0.5), 0 0 40px rgba(var(--primary-rgb), 0.2)'
            : isToday
                ? '0 0 10px rgba(var(--primary-rgb), 0.3)'
                : 'none',
        'text-shadow': isSelected
            ? '0 0 10px rgba(255, 255, 255, 0.5)'
            : isToday
                ? '0 0 8px rgba(var(--primary-rgb), 0.5)'
                : 'none',
        if (isDisabled) 'opacity': '0.4',
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
