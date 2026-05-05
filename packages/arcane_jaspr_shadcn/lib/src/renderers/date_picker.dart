import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/props/date_picker_props.dart';
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
    final bool hasError = props.error != null;
    final bool hasValue = props.mode == CalendarModeVariant.range
        ? props.rangeValue != null
        : props.value != null;
    final (String height, String fontSize) = _sizeStyles;
    final String pickerId = props.id ?? 'datepicker-${identityHashCode(props)}';
    final String popoverId = '$pickerId-pop';
    final String calendarId = props.calendarProps?.id ?? '$pickerId-cal';
    final String triggerAnchorId = '$pickerId-anchor';

    final Map<String, String> triggerAttrs = mergeAttrs(<Map<String, String>>[
      anchorAttrs(triggerAnchorId),
      calendarTriggerAttrs(calendarId),
      interactionAttrs(ArcaneInteraction.togglePopover(popoverId)),
      <String, String>{
        'type': 'button',
        'aria-haspopup': 'dialog',
        'aria-controls': popoverId,
        'data-arcane-placeholder': props.placeholder ?? '',
      },
    ]);

    final Map<String, String> popoverAttrs = mergeAttrs(<Map<String, String>>[
      surfaceAttrs(
        surface: 'popover',
        id: popoverId,
        anchorId: triggerAnchorId,
        anchorPlacement: 'bottom-start',
        anchorOffset: '4',
        focusTrap: false,
        initiallyOpen: props.isOpen,
      ),
      calendarPickerAttrs(calendarId),
    ]);

    return dom.div(
      classes: 'arcane-date-picker',
      attributes: <String, String>{'data-disabled': '${props.disabled}'},
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-1)',
        },
      ),
      <Component>[
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--foreground)',
              },
            ),
            <Component>[Component.text(props.label!)],
          ),
        dom.button(
          classes: 'arcane-date-picker-trigger',
          attributes: <String, String>{
            ...triggerAttrs,
            if (props.disabled) 'disabled': 'true',
            'data-error': '$hasError',
          },
          events: <String, EventCallback>{
            if (!props.disabled && props.onToggle != null)
              'click': (_) => props.onToggle?.call(),
          },
          styles: dom.Styles(
            raw: <String, String>{
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
          <Component>[
            dom.span(
              styles: const dom.Styles(
                raw: <String, String>{'color': 'var(--muted-foreground)'},
              ),
              <Component>[ArcaneIcon.calendar(size: IconSize.sm)],
            ),
            dom.span(
              attributes: const <String, String>{
                'data-arcane-calendar-display': '',
              },
              styles: const dom.Styles(
                raw: <String, String>{
                  'flex': '1',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                  'white-space': 'nowrap',
                },
              ),
              <Component>[Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'arcane-date-picker-clear',
                attributes: <String, String>{
                  'role': 'button',
                  'aria-label': 'Clear date',
                  ...interactionAttrs(
                    ArcaneInteraction.calendarToday(calendarId),
                  ),
                },
                events: <String, EventCallback>{
                  if (props.onClear != null)
                    'click': (event) {
                      event.stopPropagation();
                      props.onClear?.call();
                    },
                },
                styles: const dom.Styles(
                  raw: <String, String>{
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                    'transition': 'color var(--transition)',
                  },
                ),
                <Component>[ArcaneIcon.x(size: IconSize.xs)],
              ),
          ],
        ),
        dom.div(
          classes: 'arcane-date-picker-dropdown',
          attributes: popoverAttrs,
          styles: const dom.Styles(
            raw: <String, String>{
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '4px',
              'z-index': '50',
              'box-shadow': 'var(--shadow-lg)',
            },
          ),
          <Component>[
            if (props.calendarProps != null)
              ShadcnCalendar(props.calendarProps!),
          ],
        ),
        if (hasError)
          dom.span(
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            <Component>[Component.text(props.error!)],
          ),
      ],
    );
  }
}
