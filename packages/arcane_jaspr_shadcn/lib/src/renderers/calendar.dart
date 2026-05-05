import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/rendering/calendar_markup.dart';

/// ShadCN-style calendar component
/// Reference: https://ui.shadcn.com/docs/components/calendar
class ShadcnCalendar extends StatelessComponent {
  final CalendarProps props;

  const ShadcnCalendar(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return buildCalendarMarkup(
      props,
      classes: 'arcane-calendar',
      navButtonClasses: '',
      todayButtonClasses: '',
      dayButtonClasses: '',
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)',
          'padding': '12px',
          'background-color': 'var(--card)',
          'border': '1px solid var(--border)',
          'border-radius': 'var(--radius-md)',
          'width': 'min(100%, 20rem)',
        },
      ),
    );
  }
}
