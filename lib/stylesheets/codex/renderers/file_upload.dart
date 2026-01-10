import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../component/view/icon.dart';
import '../../../core/props/file_upload_props.dart';

/// Codex File Upload renderer.
class CodexFileUpload extends StatelessComponent {
  final FileUploadProps props;

  const CodexFileUpload(this.props, {super.key});

  (String padding, String fontSize, IconSize iconSize) get _sizeStyles =>
      switch (props.size) {
        FileUploadSize.sm => ('1.25rem', '0.875rem', IconSize.lg),
        FileUploadSize.md => ('1.75rem', '1rem', IconSize.xl),
        FileUploadSize.lg => ('2.5rem', '1.125rem', IconSize.xl2),
      };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, iconSize) = _sizeStyles;

    return dom.div(
      classes: 'codex-file-upload',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.75rem',
      }),
      [
        // Label
        if (props.label != null)
          dom.label(
            styles: const dom.Styles(raw: {
              'font-size': 'var(--font-size-sm)',
              'font-weight': 'var(--font-weight-medium)',
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

        // Selected files list
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
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    'padding': '0.75rem 1rem',
                    'background': 'var(--card)',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius)',
                    'font-size': 'var(--font-size-sm)',
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
                        'color': 'var(--muted-foreground)',
                        'flex-shrink': '0',
                        'margin-left': '0.75rem',
                      }),
                      [Component.text(file.formattedSize)],
                    ),
                  ],
                ),
            ],
          ),

        // Helper text
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
      classes: 'codex-file-upload-dropzone',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '1.25rem',
        'padding': padding,
        'border': props.isDragOver
            ? '2px dashed var(--primary)'
            : '2px dashed var(--border)',
        'border-radius': 'var(--radius)',
        'background': props.isDragOver
            ? 'rgba(var(--primary-rgb), 0.05)'
            : 'transparent',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all var(--arcane-transition)',
        'text-align': 'center',
      }),
      events: {
        'click': (_) => props.onClick?.call(),
        'dragover': (e) => props.onDragOver?.call(e),
        'dragleave': (e) => props.onDragLeave?.call(e),
        'drop': (e) => props.onDrop?.call(e),
      },
      [
        // Upload icon
        dom.span(
          styles: dom.Styles(raw: {
            'color':
                props.isDragOver ? 'var(--primary)' : 'var(--muted-foreground)',
          }),
          [ArcaneIcon.cloudUpload(size: iconSize)],
        ),

        // Text
        dom.div(
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'color': 'var(--foreground)',
          }),
          [Component.text(props.dropzoneText)],
        ),

        // Browse button
        dom.span(
          styles: const dom.Styles(raw: {
            'color': 'var(--primary)',
            'font-weight': 'var(--font-weight-medium)',
            'text-decoration': 'underline',
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
        'gap': '0.75rem',
      }),
      [
        dom.button(
          type: dom.ButtonType.button,
          attributes: props.disabled ? {'disabled': 'true'} : null,
          styles: dom.Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'gap': '0.75rem',
            'padding': '0.75rem 1.25rem',
            'font-size': fontSize,
            'font-weight': 'var(--font-weight-medium)',
            'background': 'var(--secondary)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'color': 'var(--foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'opacity': props.disabled ? '0.5' : '1',
            'transition': 'all var(--arcane-transition)',
          }),
          events: {
            'click': (_) => props.onClick?.call(),
          },
          [
            ArcaneIcon.paperclip(size: IconSize.sm),
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
          styles: dom.Styles(raw: {
            'font-size': fontSize,
            'color': 'var(--primary)',
            'text-decoration': 'underline',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'opacity': props.disabled ? '0.5' : '1',
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
