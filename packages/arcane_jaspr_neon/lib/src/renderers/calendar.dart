import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/rendering/calendar_markup.dart';

/// Neon calendar component with restrained dark styling.
class NeonCalendar extends StatelessComponent {
  final CalendarProps props;

  const NeonCalendar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return buildCalendarMarkup(
      props,
      classes: 'arcane-calendar arcane-calendar--neon',
      navButtonClasses: 'neon-calendar-nav-btn',
      todayButtonClasses: 'neon-calendar-today-btn',
      dayButtonClasses: 'neon-calendar-day',
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
          'width': 'min(100%, 20rem)',
        },
      ),
    );
  }
}
