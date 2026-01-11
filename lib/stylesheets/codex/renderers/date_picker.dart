import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/calendar_props.dart';
import '../../../core/props/date_picker_props.dart';
import 'calendar.dart';

/// Codex Date Picker renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon trigger button with holographic effects
/// - Cyberpunk-style dropdown with glass morphism
/// - Intense neon accents on calendar icon
/// - Animated focus and open states with glow trails
class CodexDatePicker extends StatelessComponent {
  final DatePickerProps props;

  const CodexDatePicker(this.props, {super.key});

  // Codex Neon sizes - larger with more presence
  (String, String) get _sizeStyles => switch (props.size) {
        DatePickerSizeVariant.sm => ('48px', '0.875rem'),
        DatePickerSizeVariant.md => ('56px', '0.875rem'),
        DatePickerSizeVariant.lg => ('64px', '1rem'),
      };

  @override
  Component build(BuildContext context) {
    final hasError = props.error != null;
    final hasValue = props.mode == CalendarModeVariant.range
        ? props.rangeValue != null
        : props.value != null;
    final (height, fontSize) = _sizeStyles;

    return dom.div(
      classes: 'codex-date-picker codex-neon',
      styles: const dom.Styles(raw: {
        'position': 'relative',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--space-2)',
      }),
      [
        // Label with neon styling
        if (props.label != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Neon trigger button
        dom.button(
          classes: 'codex-date-picker-trigger codex-neon',
          attributes: {
            'type': 'button',
            'aria-haspopup': 'dialog',
            'aria-expanded': '${props.isOpen}',
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': '0.875rem',
            'width': '100%',
            'height': height,
            'padding': '0 1.25rem',
            'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
            'border': hasError
                ? '1px solid var(--destructive)'
                : props.isOpen
                    ? '1px solid var(--primary)'
                    : '1px solid rgba(var(--primary-rgb), 0.3)',
            'border-radius': 'var(--radius)',
            'font-size': fontSize,
            'color': hasValue ? 'var(--foreground)' : 'var(--muted-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            'text-align': 'left',
            // Neon glow effects
            'box-shadow': hasError
                ? '0 0 20px rgba(var(--destructive-rgb), 0.2)'
                : props.isOpen
                    ? '0 0 25px rgba(var(--primary-rgb), 0.3)'
                    : '0 0 15px rgba(var(--primary-rgb), 0.1)',
            if (props.disabled) 'opacity': '0.4',
          }),
          events: props.onToggle != null
              ? {'click': (_) => props.onToggle!()}
              : null,
          [
            // Neon calendar icon
            dom.span(
              styles: dom.Styles(raw: {
                'color': props.isOpen ? 'var(--primary)' : 'var(--muted-foreground)',
                'filter': props.isOpen
                    ? 'drop-shadow(0 0 6px rgba(var(--primary-rgb), 0.6))'
                    : 'drop-shadow(0 0 3px rgba(var(--primary-rgb), 0.3))',
                'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
              }),
              [ArcaneIcon.calendar(size: IconSize.sm)],
            ),
            // Display text
            dom.span(
              styles: dom.Styles(raw: {
                'flex': '1',
                'overflow': 'hidden',
                'text-overflow': 'ellipsis',
                'white-space': 'nowrap',
                'text-shadow': hasValue && props.isOpen
                    ? '0 0 8px rgba(var(--primary-rgb), 0.3)'
                    : 'none',
              }),
              [Component.text(props.displayText)],
            ),
            // Neon clear button
            if (hasValue && props.clearable)
              dom.span(
                classes: 'codex-date-picker-clear codex-neon',
                attributes: {
                  'role': 'button',
                  'aria-label': 'Clear date',
                },
                styles: const dom.Styles(raw: {
                  'color': 'var(--muted-foreground)',
                  'cursor': 'pointer',
                  'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
                  'filter': 'drop-shadow(0 0 3px rgba(var(--destructive-rgb), 0.3))',
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

        // Neon calendar dropdown with glass effect
        if (props.isOpen && props.calendarProps != null)
          dom.div(
            classes: 'codex-date-picker-dropdown codex-neon',
            styles: const dom.Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'margin-top': '0.75rem',
              'z-index': '50',
              // Intense neon glow around dropdown
              'box-shadow': '0 0 40px rgba(var(--primary-rgb), 0.2), 0 0 80px rgba(var(--primary-rgb), 0.1)',
              'border-radius': 'var(--radius)',
            }),
            [CodexCalendar(props.calendarProps!)],
          ),

        // Neon error message
        if (hasError)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--destructive)',
              'text-shadow': '0 0 8px rgba(var(--destructive-rgb), 0.4)',
            }),
            [Component.text(props.error!)],
          ),
      ],
    );
  }
}
