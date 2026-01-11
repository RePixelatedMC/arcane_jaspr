import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/file_upload_props.dart';

/// Codex File Upload renderer.
///
/// Implements the Codex Neon Cyberpunk design language:
/// - Glowing neon dropzone with holographic effects
/// - Pulsing upload icon with glow trail
/// - Cyberpunk-style file list with neon accents
/// - Gradient backgrounds with intense glow effects
class CodexFileUpload extends StatelessComponent {
  final FileUploadProps props;

  const CodexFileUpload(this.props, {super.key});

  // Codex Neon sizes - larger with more presence
  (String padding, String fontSize, IconSize iconSize) get _sizeStyles =>
      switch (props.size) {
        FileUploadSize.sm => ('1.5rem', '0.875rem', IconSize.xl),
        FileUploadSize.md => ('2rem', '1rem', IconSize.xl2),
        FileUploadSize.lg => ('3rem', '1.125rem', IconSize.xl2),
      };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, iconSize) = _sizeStyles;

    return dom.div(
      classes: 'codex-file-upload codex-neon',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.875rem',
      }),
      [
        // Label with neon styling
        if (props.label != null)
          dom.label(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-semibold)',
              'letter-spacing': '0.025em',
              'text-transform': 'uppercase',
              'color': 'var(--foreground)',
            }),
            [Component.text(props.label!)],
          ),

        // Dropzone, button, or inline
        if (props.style == FileUploadStyle.dropzone)
          _buildDropzone(padding, fontSize, iconSize)
        else if (props.style == FileUploadStyle.button)
          _buildButton(fontSize)
        else
          _buildInline(fontSize),

        // Neon styled selected files list
        if (props.selectedFiles.isNotEmpty)
          dom.div(
            styles: const dom.Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': 'var(--space-2)',
            }),
            [
              for (final file in props.selectedFiles)
                dom.div(
                  classes: 'codex-file-upload-file codex-neon',
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    'padding': '0.875rem 1.25rem',
                    'background': 'linear-gradient(135deg, rgba(0, 0, 0, 0.6) 0%, rgba(var(--card-rgb), 0.4) 100%)',
                    'border': '1px solid rgba(var(--primary-rgb), 0.3)',
                    'border-radius': 'var(--radius)',
                    'font-size': 'var(--font-size-sm)',
                    'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.1)',
                  }),
                  [
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'color': 'var(--foreground)',
                        'overflow': 'hidden',
                        'text-overflow': 'ellipsis',
                        'white-space': 'nowrap',
                      }),
                      [Component.text(file.name)],
                    ),
                    dom.span(
                      styles: const dom.Styles(raw: {
                        'color': 'var(--primary)',
                        'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.4)',
                        'flex-shrink': '0',
                        'margin-left': '1rem',
                        'font-variant-numeric': 'tabular-nums',
                      }),
                      [Component.text(file.formattedSize)],
                    ),
                  ],
                ),
            ],
          ),

        // Helper text with neon styling
        if (props.helperText != null)
          dom.span(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-xs)',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }

  Component _buildDropzone(String padding, String fontSize, IconSize iconSize) {
    return dom.div(
      classes: 'codex-file-upload-dropzone codex-neon',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '1.5rem',
        'padding': padding,
        'border': props.isDragOver
            ? '2px dashed var(--primary)'
            : '2px dashed rgba(var(--primary-rgb), 0.3)',
        'border-radius': 'var(--radius)',
        'background': props.isDragOver
            ? 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.15) 0%, rgba(var(--primary-rgb), 0.05) 100%)'
            : 'linear-gradient(135deg, rgba(0, 0, 0, 0.4) 0%, rgba(var(--card-rgb), 0.3) 100%)',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.4' : '1',
        'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
        'text-align': 'center',
        // Neon glow when dragging
        'box-shadow': props.isDragOver
            ? '0 0 30px rgba(var(--primary-rgb), 0.3), inset 0 0 20px rgba(var(--primary-rgb), 0.1)'
            : '0 0 15px rgba(var(--primary-rgb), 0.05)',
      }),
      events: {
        'click': (_) => props.onClick?.call(),
        'dragover': (e) => props.onDragOver?.call(e),
        'dragleave': (e) => props.onDragLeave?.call(e),
        'drop': (e) => props.onDrop?.call(e),
      },
      [
        // Neon upload icon with glow
        dom.span(
          styles: dom.Styles(raw: {
            'color': props.isDragOver ? 'var(--primary)' : 'var(--muted-foreground)',
            'filter': props.isDragOver
                ? 'drop-shadow(0 0 8px rgba(var(--primary-rgb), 0.6))'
                : 'drop-shadow(0 0 4px rgba(var(--primary-rgb), 0.3))',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
          }),
          [ArcaneIcon.cloudUpload(size: iconSize)],
        ),

        // Text with neon styling
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'font-weight': 'var(--font-weight-medium)',
            'color': props.isDragOver ? 'var(--primary)' : 'var(--foreground)',
            'text-shadow': props.isDragOver
                ? '0 0 10px rgba(var(--primary-rgb), 0.4)'
                : 'none',
          }),
          [Component.text(props.dropzoneText)],
        ),

        // Neon browse button/link
        dom.span(
          styles: const dom.Styles(raw: {
            'color': 'var(--primary)',
            'font-weight': 'var(--font-weight-semibold)',
            'text-decoration': 'underline',
            'text-shadow': '0 0 10px rgba(var(--primary-rgb), 0.4)',
          }),
          [Component.text(props.browseText)],
        ),

        // Hidden file input
        _buildHiddenInput(),
      ],
    );
  }

  Component _buildButton(String fontSize) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '0.875rem',
      }),
      [
        dom.button(
          type: dom.ButtonType.button,
          classes: 'codex-file-upload-button codex-neon',
          attributes: props.disabled ? {'disabled': 'true'} : null,
          styles: dom.Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'gap': '0.75rem',
            'padding': '0.875rem 1.5rem',
            'font-size': fontSize,
            'font-weight': 'var(--font-weight-semibold)',
            'letter-spacing': '0.025em',
            'background': 'linear-gradient(135deg, rgba(var(--primary-rgb), 0.2) 0%, rgba(var(--primary-rgb), 0.1) 100%)',
            'border': '1px solid rgba(var(--primary-rgb), 0.4)',
            'border-radius': 'var(--radius)',
            'color': 'var(--primary)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'opacity': props.disabled ? '0.4' : '1',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
            // Neon glow
            'box-shadow': '0 0 15px rgba(var(--primary-rgb), 0.2)',
            'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.4)',
          }),
          events: {
            'click': (_) => props.onClick?.call(),
          },
          [
            dom.span(
              styles: const dom.Styles(raw: {
                'filter': 'drop-shadow(0 0 4px currentColor)',
              }),
              [ArcaneIcon.paperclip(size: IconSize.sm)],
            ),
            Component.text(props.browseText),
          ],
        ),
        _buildHiddenInput(),
      ],
    );
  }

  Component _buildInline(String fontSize) {
    return dom.div(
      styles: const dom.Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': 'var(--space-2)',
      }),
      [
        dom.a(
          href: '#',
          classes: 'codex-file-upload-link codex-neon',
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--primary)',
            'text-decoration': 'underline',
            'text-shadow': '0 0 8px rgba(var(--primary-rgb), 0.4)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'opacity': props.disabled ? '0.4' : '1',
            'transition': 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)',
          }),
          events: {
            'click': (e) {
              e.preventDefault();
              props.onClick?.call();
            },
          },
          [Component.text(props.browseText)],
        ),
        _buildHiddenInput(),
      ],
    );
  }

  Component _buildHiddenInput() {
    return dom.input(
      classes: 'codex-file-upload-input',
      type: dom.InputType.file,
      attributes: {
        if (props.acceptString.isNotEmpty) 'accept': props.acceptString,
        if (props.multiple) 'multiple': 'true',
      },
      styles: const dom.Styles(raw: {
        'position': 'absolute',
        'width': '1px',
        'height': '1px',
        'padding': '0',
        'margin': '-1px',
        'overflow': 'hidden',
        'clip': 'rect(0, 0, 0, 0)',
        'white-space': 'nowrap',
        'border': '0',
      }),
      events: {
        'change': (e) => props.onInputChange?.call(e),
      },
    );
  }
}
