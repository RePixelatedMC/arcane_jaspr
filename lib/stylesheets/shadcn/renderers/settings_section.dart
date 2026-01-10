import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/settings_section_props.dart';

/// ShadCN Settings Section renderer.
class ShadcnSettingsSection extends StatelessComponent {
  final SettingsSectionProps props;

  const ShadcnSettingsSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-settings-section ${props.danger ? 'danger' : ''}',
      styles: dom.Styles(raw: {
        'background': props.danger ? 'color-mix(in srgb, var(--destructive) 5%, transparent)' : 'var(--card)',
        'border': props.danger
            ? '1px solid color-mix(in srgb, var(--destructive) 20%, transparent)'
            : '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-md)',
        'padding': '1.5rem',
        'margin-bottom': '1.5rem',
      }),
      [
        // Header
        dom.div(
          classes: 'arcane-settings-section-header',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': 'var(--space-2)',
            'margin-bottom': '1.5rem',
            'padding-bottom': '1rem',
            'border-bottom': '1px solid ${props.danger ? 'color-mix(in srgb, var(--destructive) 20%, transparent)' : 'var(--border)'}',
          }),
          [
            dom.h2(
              styles: dom.Styles(raw: {
                'font-size': 'var(--font-size-lg)',
                'font-weight': 'var(--font-weight-semibold)',
                'color': props.danger ? 'var(--destructive)' : 'var(--foreground)',
                'margin': '0',
              }),
              [Component.text(props.title)],
            ),
          ],
        ),
        // Description
        if (props.description != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 1rem 0',
            }),
            [Component.text(props.description!)],
          ),
        // Content
        ...props.children,
      ],
    );
  }
}

/// ShadCN Settings Info Row renderer.
class ShadcnSettingsInfoRow extends StatelessComponent {
  final SettingsInfoRowProps props;

  const ShadcnSettingsInfoRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-settings-info-row',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '1rem 0',
        'border-bottom': '1px solid var(--border)',
      }),
      [
        dom.span(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
          }),
          [Component.text(props.label)],
        ),
        dom.span(
          styles: dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--foreground)',
            if (props.monospace) 'font-family': 'ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, "Liberation Mono", monospace',
          }),
          [Component.text(props.value)],
        ),
      ],
    );
  }
}

/// ShadCN Settings Toggle Row renderer.
class ShadcnSettingsToggleRow extends StatelessComponent {
  final SettingsToggleRowProps props;

  const ShadcnSettingsToggleRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-settings-toggle-row ${props.disabled ? 'disabled' : ''}',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '1rem',
        'border-bottom': '1px solid var(--border)',
        if (props.disabled) 'opacity': '0.5',
      }),
      [
        // Labels
        dom.div(
          styles: const dom.Styles(raw: {
            'flex': '1',
          }),
          [
            dom.div(
              styles: const dom.Styles(raw: {
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.title)],
            ),
            if (props.description != null)
              dom.div(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--font-size-xs)',
                  'color': 'var(--muted-foreground)',
                  'margin-top': '2px',
                }),
                [Component.text(props.description!)],
              ),
          ],
        ),
        // Toggle
        dom.button(
          classes: 'arcane-toggle ${props.enabled ? 'enabled' : ''}',
          type: dom.ButtonType.button,
          attributes: {
            'role': 'switch',
            'aria-checked': props.enabled.toString(),
            if (props.disabled) 'disabled': 'true',
          },
          styles: dom.Styles(raw: {
            'width': '44px',
            'height': '24px',
            'background': props.enabled ? 'var(--accent)' : 'var(--muted)',
            'border-radius': 'var(--arcane-radius-lg)',
            'border': 'none',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'position': 'relative',
            'transition': 'all var(--arcane-transition)',
            'flex-shrink': '0',
          }),
          events: {
            if (!props.disabled && props.onChanged != null)
              'click': (e) => props.onChanged!(!props.enabled),
          },
          [
            dom.div(
              classes: 'arcane-toggle-thumb',
              styles: dom.Styles(raw: {
                'width': '20px',
                'height': '20px',
                'background': 'var(--accent-foreground)',
                'border-radius': 'var(--arcane-radius-full)',
                'position': 'absolute',
                'top': '2px',
                'left': props.enabled ? '22px' : '2px',
                'transition': 'all var(--arcane-transition)',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// ShadCN Settings Subheader renderer.
class ShadcnSettingsSubheader extends StatelessComponent {
  final SettingsSubheaderProps props;

  const ShadcnSettingsSubheader(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'arcane-settings-subheader',
      styles: const dom.Styles(raw: {
        'margin-bottom': '1rem',
      }),
      [
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'font-weight': 'var(--font-weight-medium)',
            'color': 'var(--foreground)',
            'margin-bottom': props.description != null ? '0.25rem' : '0',
          }),
          [Component.text(props.title)],
        ),
        if (props.description != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
              'margin': '0',
            }),
            [Component.text(props.description!)],
          ),
      ],
    );
  }
}

/// ShadCN Settings Note renderer.
class ShadcnSettingsNote extends StatelessComponent {
  final SettingsNoteProps props;

  const ShadcnSettingsNote(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final background = _getBackground();
    return dom.div(
      classes: 'arcane-settings-note ${props.variant.name}',
      styles: dom.Styles(raw: {
        'margin-top': '1rem',
        'padding': '1rem',
        'background': background,
        'border-radius': 'var(--arcane-radius-sm)',
      }),
      [
        dom.p(
          styles: const dom.Styles(raw: {
            'font-size': 'var(--font-size-sm)',
            'color': 'var(--muted-foreground)',
            'margin': '0',
          }),
          [Component.text(props.text)],
        ),
      ],
    );
  }

  String _getBackground() {
    switch (props.variant) {
      case SettingsNoteVariant.info:
        return 'color-mix(in srgb, var(--accent) 10%, transparent)';
      case SettingsNoteVariant.warning:
        return 'color-mix(in srgb, var(--warning) 10%, transparent)';
      case SettingsNoteVariant.success:
        return 'color-mix(in srgb, var(--success) 10%, transparent)';
    }
  }
}
