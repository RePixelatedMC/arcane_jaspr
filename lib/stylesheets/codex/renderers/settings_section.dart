import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/settings_section_props.dart';

/// Codex SettingsSection renderer.
class CodexSettingsSection extends StatelessComponent {
  final SettingsSectionProps props;

  const CodexSettingsSection(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-settings-section ${props.danger ? 'danger' : ''}',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': 'var(--arcane-space-2)',
      }),
      [
        // Header
        dom.div(
          classes: 'codex-settings-section-header',
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'margin-bottom': '0.5rem',
          }),
          [
            dom.h3(
              styles: dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-base)',
                'font-weight': 'var(--arcane-font-weight-semibold)',
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
            classes: 'codex-settings-section-description',
            styles: const dom.Styles(raw: {
              'font-size': '0.8125rem',
              'color': 'var(--muted-foreground)',
              'margin': '0 0 0.5rem 0',
            }),
            [Component.text(props.description!)],
          ),

        // Children
        dom.div(
          classes: 'codex-settings-section-content',
          styles: dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '8px',
            'padding': '1rem',
            'background-color': 'var(--card)',
            'border': props.danger
                ? '1px solid var(--destructive)'
                : '1px solid var(--border)',
            'border-radius': 'var(--radius)',
          }),
          props.children,
        ),
      ],
    );
  }
}

/// Codex SettingsInfoRow renderer.
class CodexSettingsInfoRow extends StatelessComponent {
  final SettingsInfoRowProps props;

  const CodexSettingsInfoRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-settings-info-row',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '0.75rem 0',
      }),
      [
        // Label
        dom.span(
          classes: 'codex-settings-info-label',
          styles: const dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-sm)',
            'color': 'var(--muted-foreground)',
          }),
          [Component.text(props.label)],
        ),

        // Value
        dom.span(
          classes: 'codex-settings-info-value',
          styles: dom.Styles(raw: {
            'font-size': 'var(--arcane-font-size-sm)',
            'font-weight': 'var(--arcane-font-weight-medium)',
            'color': 'var(--foreground)',
            if (props.monospace) 'font-family': 'var(--font-mono)',
          }),
          [Component.text(props.value)],
        ),
      ],
    );
  }
}

/// Codex SettingsToggleRow renderer.
class CodexSettingsToggleRow extends StatelessComponent {
  final SettingsToggleRowProps props;

  const CodexSettingsToggleRow(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-settings-toggle-row',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '0.75rem 0',
      }),
      [
        // Label and description
        dom.div(
          styles: const dom.Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--arcane-space-1)',
          }),
          [
            dom.span(
              classes: 'codex-settings-toggle-label',
              styles: const dom.Styles(raw: {
                'font-size': 'var(--arcane-font-size-sm)',
                'color': 'var(--foreground)',
              }),
              [Component.text(props.title)],
            ),
            if (props.description != null)
              dom.span(
                styles: const dom.Styles(raw: {
                  'font-size': 'var(--arcane-font-size-xs)',
                  'color': 'var(--muted-foreground)',
                }),
                [Component.text(props.description!)],
              ),
          ],
        ),

        // Toggle
        dom.button(
          classes: 'codex-settings-toggle ${props.enabled ? 'enabled' : ''}',
          styles: dom.Styles(raw: {
            'width': '44px',
            'height': '24px',
            'border-radius': 'var(--arcane-radius-lg)',
            'border': 'none',
            'padding': '2px',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'background-color':
                props.enabled ? 'var(--codex-accent)' : 'var(--muted)',
            'transition': 'background-color var(--arcane-transition)',
            'display': 'flex',
            'align-items': 'center',
            'justify-content': props.enabled ? 'flex-end' : 'flex-start',
            if (props.disabled) 'opacity': '0.5',
          }),
          events: (!props.disabled && props.onChanged != null)
              ? {'click': (_) => props.onChanged!(!props.enabled)}
              : null,
          [
            const dom.span(
              styles: dom.Styles(raw: {
                'width': '20px',
                'height': '20px',
                'background-color': '#ffffff',
                'border-radius': '50%',
                'transition': 'transform var(--arcane-transition)',
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// Codex SettingsSubheader renderer.
class CodexSettingsSubheader extends StatelessComponent {
  final SettingsSubheaderProps props;

  const CodexSettingsSubheader(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-settings-subheader',
      styles: const dom.Styles(raw: {
        'padding': '1rem 0 0.5rem',
        'border-bottom': '1px solid var(--border)',
        'margin-bottom': '0.5rem',
      }),
      [
        dom.h4(
          styles: const dom.Styles(raw: {
            'font-size': '0.8125rem',
            'font-weight': 'var(--arcane-font-weight-semibold)',
            'text-transform': 'uppercase',
            'letter-spacing': '0.05em',
            'color': 'var(--muted-foreground)',
            'margin': '0',
          }),
          [Component.text(props.title)],
        ),
        if (props.description != null)
          dom.p(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--arcane-font-size-xs)',
              'color': 'var(--muted-foreground)',
              'margin': '0.25rem 0 0 0',
            }),
            [Component.text(props.description!)],
          ),
      ],
    );
  }
}

/// Codex SettingsNote renderer.
class CodexSettingsNote extends StatelessComponent {
  final SettingsNoteProps props;

  const CodexSettingsNote(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: 'codex-settings-note codex-settings-note-${props.variant.name}',
      styles: dom.Styles(raw: {
        'padding': '0.75rem 1rem',
        'border-radius': 'var(--radius)',
        'font-size': '0.8125rem',
        'line-height': '1.5',
        'background-color': _getBackgroundColor(),
        'color': _getTextColor(),
        'border-left': '3px solid ${_getBorderColor()}',
        'display': 'flex',
        'align-items': 'center',
        'gap': 'var(--arcane-space-2)',
      }),
      [
        _getIcon(),
        Component.text(props.text),
      ],
    );
  }

  String _getBackgroundColor() {
    return switch (props.variant) {
      SettingsNoteVariant.info => 'rgba(var(--codex-accent-rgb), 0.1)',
      SettingsNoteVariant.warning => 'rgba(245, 158, 11, 0.1)',
      SettingsNoteVariant.success => 'rgba(34, 197, 94, 0.1)',
    };
  }

  String _getTextColor() {
    return 'var(--foreground)';
  }

  String _getBorderColor() {
    return switch (props.variant) {
      SettingsNoteVariant.info => 'var(--codex-accent)',
      SettingsNoteVariant.warning => 'rgb(245, 158, 11)',
      SettingsNoteVariant.success => 'rgb(34, 197, 94)',
    };
  }

  Component _getIcon() {
    return switch (props.variant) {
      SettingsNoteVariant.info => ArcaneIcon.info(size: IconSize.sm),
      SettingsNoteVariant.warning => ArcaneIcon.triangleAlert(size: IconSize.sm),
      SettingsNoteVariant.success => ArcaneIcon.circleCheck(size: IconSize.sm),
    };
  }
}