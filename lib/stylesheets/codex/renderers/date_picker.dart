import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/calendar_props.dart';
import '../../../core/props/date_picker_props.dart';
import 'calendar.dart';

/// Codex Date Picker renderer.
class CodexDatePicker extends StatelessComponent {
  final DatePickerProps props;

  const CodexDatePicker(this.props, {super.key});

  (String, String) get _sizeStyles => switch (props.size) {
        DatePickerSizeVariant.sm => ('40px', '0.8125rem'),
        DatePickerSizeVariant.md => ('48px', '0.875rem'),
        DatePickerSizeVariant.lg => ('56px', '0.875rem'),
      };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final hasValue = props.mode == CalendarModeVariant.range
        ? props.rangeValue != null
        : props.value != null;
    final (height, fontSize) = _sizeStyles;

    return dom.div(
      classes: 'codex-date-picker',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
      }),
      [
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Trigger button
        dom.button(
          classes: 'codex-date-picker-trigger',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.75rem',
            'width': '100%',
            'height': height,
            'padding': '0 1rem',
            'background-color': 'var(--input)',
            'border': '1px solid ${hasError ? 'var(--destructive)' : 'var(--border)'}',
            'border-radius': 'var(--radius)',
            'font-size': fontSize,
            'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'transition': 'border-color var(--arcane-transition), box-shadow var(--arcane-transition)',
            'text-align': 'left',
            if (props.disabled) 'opacity': '0.5',
          }),
          events: props.onToggle != null
              ? {'click': (_) => props.onToggle!()}
              : null,
          [
            dom.span(
              styles: const dom.Styles(raw: {
                'color': 'var(--muted-foreground)',
              }),
              [ArcaneIcon.calendar(size: IconSize.sm)],
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
              }),
              [Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'codex-date-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear date',
                },
                styles: const dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'color var(--arcane-transition)',
                }),
                events: props.onClear != null
                    ? {
                        'click': (e) {
                          e.stopPropagation();
                          props.onClear!();
                        },
                      }
                    : null,
                [ArcaneIcon.x(size: IconSize.xs)],
              ),
          ],
        ),

        // Calendar dropdown
        if (props.isOpen && props.calendarProps != null)
          dom.div(
            classes: 'codex-date-picker-dropdown',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.5rem',
              'z-index': '50',
              'box-shadow': '0 0 30px rgba(var(--primary-rgb), 0.1)',
            }),
            [CodexCalendar(props.calendarProps!)],
          ),

        // Error message
        if (hasError)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--destructive)',
            }),
            [Component.text(props.error!)],
          ),
      ],
    );
  }
}
