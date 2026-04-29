import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';

/// ShadCN-style calendar component
/// Reference: https://ui.shadcn.com/docs/components/calendar
class ShadcnCalendar extends StatelessComponent {
  final CalendarProps props;

  const ShadcnCalendar(this.props, {super.key});

  String _resolvedId(BuildContext context) =>
      props.id ?? 'cal-${identityHashCode(props)}';

  @override
  Component build(BuildContext context) {
    final String calendarId = _resolvedId(context);
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
      classes: 'arcane-calendar',
      attributes: attrs,
      styles: const dom.Styles(
        raw: <String, String>{
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
      const <Component>[],
    );
  }
}
