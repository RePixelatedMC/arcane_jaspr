import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../../core/props/file_upload_props.dart';

/// ShadCN File Upload renderer.
class ShadcnFileUpload extends StatelessComponent {
  final FileUploadProps props;

  const ShadcnFileUpload(this.props, {super.key});

  (String padding, String fontSize, String iconSize) get _sizeStyles =>
      switch (props.size) {
        FileUploadSize.sm => ('1rem', '0.875rem', '24px'),
        FileUploadSize.md => ('1.5rem', '1rem', '32px'),
        FileUploadSize.lg => ('2rem', '1.125rem', '48px'),
      };

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, iconSize) = _sizeStyles;

    return dom.div(
      classes: 'arcane-file-upload',
      styles: const dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '0.5rem',
      }),
      [
        // Label
        if (props.label != null)
          dom.label(
            styles: const dom.Styles(raw: {
              'font-size': '0.875rem',
              'font-weight': '500',
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
              'gap': '0.25rem',
            }),
            [
              for (final file in props.selectedFiles)
                dom.div(
                  styles: const dom.Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    'padding': '0.5rem',
                    'background': 'var(--muted)',
                    'border-radius': 'var(--radius)',
                    'font-size': '0.875rem',
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
                        'margin-left': '0.5rem',
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
              'font-size': '0.75rem',
              'color': 'var(--muted-foreground)',
            }),
            [Component.text(props.helperText!)],
          ),
      ],
    );
  }

  Component _buildDropzone(String padding, String fontSize, String iconSize) {
    return dom.div(
      classes: 'arcane-file-upload-dropzone',
      styles: dom.Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': '1rem',
        'padding': padding,
        'border': props.isDragOver
            ? '2px dashed var(--primary)'
            : '2px dashed var(--border)',
        'border-radius': 'var(--radius)',
        'background': props.isDragOver
            ? 'hsl(var(--primary) / 0.05)'
            : 'transparent',
        'cursor': props.disabled ? 'not-allowed' : 'pointer',
        'opacity': props.disabled ? '0.5' : '1',
        'transition': 'all 150ms ease',
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
        dom.div(
          styles: dom.Styles(raw: {
            'width': iconSize,
            'height': iconSize,
            'color': props.isDragOver ? 'var(--primary)' : 'var(--muted-foreground)',
          }),
          [
            // Upload cloud icon SVG
            dom.RawText('''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 100%; height: 100%;">
              <path stroke-linecap="round" stroke-linejoin="round" d="M12 16.5V9.75m0 0 3 3m-3-3-3 3M6.75 19.5a4.5 4.5 0 0 1-1.41-8.775 5.25 5.25 0 0 1 10.233-2.33 3 3 0 0 1 3.758 3.848A3.752 3.752 0 0 1 18 19.5H6.75Z" />
            </svg>'''),
          ],
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
            'font-weight': '500',
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
        'gap': '0.5rem',
      }),
      [
        dom.button(
          type: dom.ButtonType.button,
          attributes: props.disabled ? {'disabled': 'true'} : null,
          styles: dom.Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'gap': '0.5rem',
            'padding': '0.5rem 1rem',
            'font-size': fontSize,
            'font-weight': '500',
            'background': 'var(--secondary)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius)',
            'color': 'var(--secondary-foreground)',
            'cursor': props.disabled ? 'not-allowed' : 'pointer',
            'opacity': props.disabled ? '0.5' : '1',
            'transition': 'all 150ms ease',
          }),
          events: {
            'click': (_) => props.onClick?.call(),
          },
          [
            // Paperclip icon
            dom.RawText('''<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" style="width: 16px; height: 16px;">
              <path stroke-linecap="round" stroke-linejoin="round" d="m18.375 12.739-7.693 7.693a4.5 4.5 0 0 1-6.364-6.364l10.94-10.94A3 3 0 1 1 19.5 7.372L8.552 18.32m.009-.01-.01.01m5.699-9.941-7.81 7.81a1.5 1.5 0 0 0 2.112 2.13" />
            </svg>'''),
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
        'gap': '0.25rem',
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
      classes: 'arcane-file-upload-input',
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
