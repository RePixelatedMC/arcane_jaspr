import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';

/// Neubrutalism calendar component with restrained dark styling.
class NeubrutalismCalendar extends StatelessComponent {
  final CalendarProps props;

  const NeubrutalismCalendar(this.props, {super.key});

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
      classes: 'arcane-calendar arcane-calendar--neubrutalism neubrutalism-calendar',
      attributes: attrs,
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'flex-direction': 'column',
          'gap': '0.5rem',
          'padding': '0.75rem',
          'background': 'var(--nb-paper, var(--card))',
          'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
          'box-shadow':
              'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
          'color': 'var(--nb-ink, var(--foreground))',
          'width': 'fit-content',
        },
      ),
      const <Component>[],
    );
  }
}
