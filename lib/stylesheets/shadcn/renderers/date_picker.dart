import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/calendar_props.dart';
import '../../../core/props/date_picker_props.dart';
import 'calendar.dart';

/// ShadCN-style date picker component
/// Reference: https://ui.shadcn.com/docs/components/date-picker
class ShadcnDatePicker extends StatelessComponent {
  final DatePickerProps props;

  const ShadcnDatePicker(this.props, {super.key});

  (String, String) get _sizeStyles => switch (props.size) {
    DatePickerSizeVariant.sm => ('36px', '13px'),
    DatePickerSizeVariant.md => ('40px', '14px'),
    DatePickerSizeVariant.lg => ('44px', '14px'),
  };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final hasValue = props.mode == CalendarModeVariant.range
        ? props.rangeValue != null
        : props.value != null;
    final (height, fontSize) = _sizeStyles;

    return dom.div(
      classes: 'arcane-date-picker',
      attributes: {
        'data-state': props.isOpen ? 'open' : 'closed',
        'data-disabled': '${props.disabled}',
      },
      styles: const dom.Styles(
        raw: {
          'position': 'relative',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-1)',
        },
      ),
      [
        // Label
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--foreground)',
              },
            ),
            [Component.text(props.label!)],
          ),

        // Trigger button
        dom.button(
          classes: 'arcane-date-picker-trigger',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            if (props.disabled) 'disabled': 'true',
            'data-state': props.isOpen ? 'open' : 'closed',
            'data-disabled': '${props.disabled}',
            'data-error': '$hasError',
          },
          styles: dom.Styles(
            raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': 'var(--space-2)',
              'width': '100%',
              'height': height,
              'padding': '0 12px',
              'background-color': 'var(--background)',
              'border':
                  '1px solid ${hasError ? 'var(--destructive)' : 'var(--input)'}',
              'border-radius': 'var(--radius-sm)',
              'font-size': fontSize,
              'color': hasValue
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'cursor': props.disabled ? 'not-allowed' : 'pointer',
              'transition':
                  'border-color var(--transition), box-shadow var(--transition)',
              'text-align': 'left',
              if (props.disabled) 'opacity': '0.5',
            },
          ),
          events: props.onToggle != null
              ? {'click': (_) => props.onToggle!()}
              : null,
          [
            dom.span(
              styles: dom.Styles(raw: {'color': 'var(--muted-foreground)'}),
              [ArcaneIcon.calendar(size: IconSize.sm)],
            ),
            dom.span(
              styles: const dom.Styles(
                raw: {
                  'flex': '1',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              [Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'arcane-date-picker-clear',
                attributes: {'role': 'button', 'aria-label': 'Clear date'},
                styles: const dom.Styles(
                  raw: {
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                    'transition': 'color var(--transition)',
                  },
                ),
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
            classes: 'arcane-date-picker-dropdown',
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '100%',
                'left': '0',
                'margin-top': '4px',
                'z-index': '50',
                'box-shadow': 'var(--shadow-lg)',
              },
            ),
            [ShadcnCalendar(props.calendarProps!)],
          ),

        // Error message
        if (hasError)
          dom.span(
            styles: const dom.Styles(
              raw: {
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            [Component.text(props.error!)],
          ),
      ],
    );
  }
}
