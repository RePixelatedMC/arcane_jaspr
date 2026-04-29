import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/props/date_picker_props.dart';
import 'calendar.dart';

/// Neon date picker renderer with restrained panel styling.
class NeonDatePicker extends StatelessComponent {
  final DatePickerProps props;

  const NeonDatePicker(this.props, {super.key});

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
        anchorOffset: '8',
        focusTrap: false,
      ),
      calendarPickerAttrs(calendarId),
    ]);

    return dom.div(
      classes: 'neon-date-picker ${props.disabled ? 'disabled' : ''}',
      attributes: <String, String>{
        'data-disabled': '${props.disabled}',
        'data-size': props.size.name,
      },
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'flex',
          'flex-direction': 'column',
          'gap': 'var(--space-2)',
        },
      ),
      <Component>[
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(
              raw: <String, String>{
                'font-family': 'var(--font-heading)',
                'font-size': '0.75rem',
                'font-weight': '600',
                'letter-spacing': '0.08em',
                'text-transform': 'uppercase',
                'color': 'var(--muted-foreground)',
              },
            ),
            <Component>[Component.text(props.label!)],
          ),
        dom.button(
          classes: 'neon-date-picker-trigger',
          attributes: <String, String>{
            ...triggerAttrs,
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(
            raw: <String, String>{
              'display': 'flex',
              'align-items': 'center',
              'gap': '0.75rem',
              'width': '100%',
              'height': height,
              'padding': '0 1rem',
              'background':
                  'linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))',
              'border': hasError
                  ? '1px solid var(--destructive)'
                  : '1px solid var(--neon-control-border)',
              'clip-path': 'var(--neon-control-clip)',
              'font-size': fontSize,
              'color': hasValue
                  ? 'var(--foreground)'
                  : 'var(--muted-foreground)',
              'cursor': props.disabled ? 'not-allowed' : 'pointer',
              'transition': 'border-color 0.18s ease, box-shadow 0.18s ease',
              'box-shadow': 'var(--neon-inset)',
              if (props.disabled) 'opacity': '0.5',
            },
          ),
          <Component>[
            dom.span(
              styles: const dom.Styles(
                raw: <String, String>{
                  'display': 'flex',
                  'color': 'var(--muted-foreground)',
                },
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
                  'text-align': 'left',
                },
              ),
              <Component>[Component.text(props.displayText)],
            ),
            if (hasValue && props.clearable)
              dom.span(
                classes: 'neon-date-picker-clear',
                attributes: <String, String>{
                  'role': 'button',
                  'aria-label': 'Clear date',
                  'data-state': 'clearable',
                  ...interactionAttrs(ArcaneInteraction.calendarToday(calendarId)),
                },
                styles: const dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'color': 'var(--muted-foreground)',
                    'cursor': 'pointer',
                  },
                ),
                <Component>[ArcaneIcon.x(size: IconSize.xs)],
              ),
          ],
        ),
        dom.div(
          classes: 'neon-date-picker-dropdown neon-date-picker',
          attributes: popoverAttrs,
          styles: const dom.Styles(
            raw: <String, String>{
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.5rem',
              'z-index': '50',
            },
          ),
          <Component>[
            if (props.calendarProps != null) NeonCalendar(props.calendarProps!),
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
