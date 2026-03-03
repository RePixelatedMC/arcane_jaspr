import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import '../../../component/view/icon.dart';
import '../../../core/props/calendar_props.dart';
import '../../../core/props/date_picker_props.dart';
import 'calendar.dart';

/// Codex date picker renderer with restrained panel styling.
class CodexDatePicker extends StatelessComponent {
  final DatePickerProps props;

  const CodexDatePicker(this.props, {super.key});

  (String, String) get _sizeStyles => switch (props.size) {
        DatePickerSizeVariant.sm => ('42px', '0.8125rem'),
        DatePickerSizeVariant.md => ('48px', '0.875rem'),
        DatePickerSizeVariant.lg => ('54px', '0.95rem'),
      };

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null;
    final bool hasValue = props.mode == CalendarModeVariant.range
        ? props.rangeValue != null
        : props.value != null;
    final (String height, String fontSize) = _sizeStyles;

    return dom.div(
      classes: 'codex-date-picker ${props.disabled ? 'disabled' : ''} ${props.isOpen ? 'open' : ''}',
      attributes: {
        'data-state': props.isOpen ? 'open' : 'closed',
        'data-disabled': '${props.disabled}',
        'data-size': props.size.name,
      },
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
      }),
      [
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),
        dom.button(
          classes: 'codex-date-picker-trigger',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            'data-state': props.isOpen ? 'open' : 'closed',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.75rem',
            'width': '100%',
            'height': height,
            'padding': '0 1rem',
            'background': 'var(--codex-surface-1)',
            'border': hasError
                ? '1px solid var(--destructive)'
                : props.isOpen
                    ? '1px solid var(--codex-accent-border)'
                    : '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'font-size': fontSize,
            'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'transition': 'border-color 0.2s ease, box-shadow 0.2s ease',
            'box-shadow': props.isOpen ? '0 10px 24px rgba(0, 0, 0, 0.3)' : 'none',
            if (props.disabled) 'opacity': '0.5',
          }),
          events: props.disabled || props.onToggle == null
              ? null
              : {'click': (_) => props.onToggle!()},
          [
            dom.span(
              styles: dom.Styles(raw: {
                'display': 'flex',
                'color': props.isOpen ? 'var(--codex-accent)' : 'var(--muted-foreground)',
              }),
              [ArcaneIcon.calendar(size: IconSize.sm)],
            ),
            dom.span(
              styles: const dom.Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
                'text-align': 'left',
              }),
              [Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'codex-date-picker-clear',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear date',
                  'data-state': 'clearable',
                },
                styles: const dom.Styles(raw: {
                  'display': 'flex',
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                }),
                events: props.onClear == null
                    ? null
                    : {
                        'click': (e) {
                          e.stopPropagation();
                          props.onClear!();
                        },
                      },
                [ArcaneIcon.x(size: IconSize.xs)],
              ),
          ],
        ),
        if (props.isOpen && props.calendarProps != null)
          dom.div(
            classes: 'codex-date-picker-dropdown',
            attributes: {'data-state': 'open'},
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.5rem',
              'z-index': '50',
              'border-radius': 'var(--radius)',
              'box-shadow': '0 16px 36px rgba(0, 0, 0, 0.42)',
            }),
            [CodexCalendar(props.calendarProps!)],
          ),
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
