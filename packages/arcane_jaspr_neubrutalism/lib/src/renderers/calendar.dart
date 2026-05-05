import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/rendering/calendar_markup.dart';

/// Neubrutalism calendar component with restrained dark styling.
class NeubrutalismCalendar extends StatelessComponent {
  final CalendarProps props;

  const NeubrutalismCalendar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return buildCalendarMarkup(
      props,
      classes:
          'arcane-calendar arcane-calendar--neubrutalism neubrutalism-calendar',
      navButtonClasses: 'neubrutalism-calendar-nav-btn',
      todayButtonClasses: 'neubrutalism-calendar-today-btn',
      dayButtonClasses: 'neubrutalism-calendar-day',
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
          'width': 'min(100%, 20rem)',
        },
      ),
    );
  }
}
