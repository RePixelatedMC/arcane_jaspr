import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/checkbox_props.dart';

/// ShadCN Checkbox renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/checkbox
class ShadcnCheckbox extends StatelessComponent {
  final CheckboxProps props;

  const ShadcnCheckbox(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // ShadCN size dimensions
    // Default: h-4 w-4 (16px), rounded-sm (4px)
    final String boxSize = switch (props.size) {
      CheckboxSize.small => '14px', // h-3.5
      CheckboxSize.medium => '16px', // h-4 (shadcn default)
      CheckboxSize.large => '20px', // h-5
    };

    final String checkSize = switch (props.size) {
      CheckboxSize.small => '10px',
      CheckboxSize.medium => '12px',
      CheckboxSize.large => '14px',
    };

    // Get variant colors - border is always the variant color (like radio)
    final (String checkedBg, String borderColor) = switch (props.variant) {
      CheckboxVariant.primary => (
          'var(--primary)',
          'var(--primary)',
        ),
      CheckboxVariant.success => (
          'var(--success, #22c55e)',
          'var(--success, #22c55e)',
        ),
      CheckboxVariant.warning => (
          'var(--warning, #f59e0b)',
          'var(--warning, #f59e0b)',
        ),
      CheckboxVariant.error => (
          'var(--destructive)',
          'var(--destructive)',
        ),
    };

    // Checkmark foreground color
    final String checkColor = switch (props.variant) {
      CheckboxVariant.primary => 'var(--primary-foreground)',
      CheckboxVariant.success => 'var(--success-foreground, #ffffff)',
      CheckboxVariant.warning => 'var(--warning-foreground, #000000)',
      CheckboxVariant.error => 'var(--destructive-foreground)',
    };

    return dom.div(
      classes: 'arcane-checkbox-wrapper',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': 'var(--arcane-space-2)', // gap-2
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        // ShadCN: disabled:opacity-50 disabled:cursor-not-allowed
        'opacity': props.disabled ? '0.5' : '1',
        'pointer-events': props.disabled ? 'none' : 'auto',
      }),
      events: props.disabled || props.onChanged == null
          ? null
          : {
              'click': (event) => props.onChanged!(!props.checked),
            },
      [
        // Checkbox box - ShadCN styling
        // peer h-4 w-4 shrink-0 rounded-sm border border-primary
        // ring-offset-background focus-visible:outline-none
        // focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2
        // disabled:cursor-not-allowed disabled:opacity-50
        // data-[state=checked]:bg-primary data-[state=checked]:text-primary-foreground
        dom.div(
          classes: 'arcane-checkbox',
          styles: dom.Styles(raw: {
            'width': boxSize,
            'height': boxSize,
            // ShadCN: rounded-sm (4px / 0.125rem)
            'border-radius': '0.125rem',
            // ShadCN: data-[state=checked]:bg-primary
            'background-color':
                props.checked ? checkedBg : 'transparent',
            // ShadCN: border border-primary
            'border': '1px solid $borderColor',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'flex-shrink': '0',
            // ShadCN: transition-colors
            'transition':
                'color var(--arcane-transition), background-color var(--arcane-transition), border-color var(--arcane-transition)',
          }),
          [
            if (props.checked)
              // ShadCN checkmark uses lucide Check icon, we use Unicode
              dom.span(
                styles: dom.Styles(raw: {
                  // ShadCN: text-primary-foreground when checked
                  'color': checkColor,
                  'font-size': checkSize,
                  'font-weight': 'var(--arcane-font-weight-bold)',
                  'line-height': '1',
                }),
                [const Component.text('\u2713')], // Unicode checkmark
              ),
          ],
        ),
        // Label and description
        if (props.label != null || props.description != null)
          dom.div(
            styles: const dom.Styles(raw: {
              'flex': '1',
            }),
            [
              if (props.label != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    // ShadCN: text-sm font-medium leading-none
                    // peer-disabled:cursor-not-allowed peer-disabled:opacity-70
                    'font-size': 'var(--arcane-font-size-sm)', // 14px
                    'font-weight': 'var(--arcane-font-weight-medium)',
                    'color': 'var(--foreground)',
                    'display': 'block',
                    'line-height': '1',
                  }),
                  [Component.text(props.label!)],
                ),
              if (props.description != null)
                dom.span(
                  styles: const dom.Styles(raw: {
                    // ShadCN: text-sm text-muted-foreground
                    'font-size': 'var(--arcane-font-size-sm)', // 14px
                    'color': 'var(--muted-foreground)',
                    'display': 'block',
                    'margin-top': '0.25rem', // 4px
                  }),
                  [Component.text(props.description!)],
                ),
            ],
          ),
      ],
    );
  }
}