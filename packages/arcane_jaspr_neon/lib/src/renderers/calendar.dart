import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';

/// Neon calendar component with restrained dark styling.
class NeonCalendar extends StatelessComponent {
  final CalendarProps props;

  const NeonCalendar(this.props, {super.key});

  String _resolvedId() => props.id ?? 'cal-${identityHashCode(props)}';

  @override
  Component build(BuildContext context) {
    final String calendarId = _resolvedId();
    final Map<String, String> attrs = mergeAttrs(<Map<String, String>>[
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
      <String, String>{
        'role': 'application',
        'aria-label': 'Calendar',
      },
    ]);

    return dom.div(
      classes: 'arcane-calendar arcane-calendar--neon',
      attributes: attrs,
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.5rem',
          'padding': '0.75rem',
          'background-color': 'var(--surface, #0b0d12)',
          'border': '1px solid var(--border, rgba(80, 200, 255, 0.18))',
          'border-radius': '0.75rem',
          'box-shadow':
              '0 0 30px rgba(80, 200, 255, 0.08), 0 0 0 1px rgba(80, 200, 255, 0.04)',
          'color': 'var(--foreground, #e0e6f0)',
          'width': 'fit-content',
        },
      ),
      const <Component>[],
    );
  }
}
