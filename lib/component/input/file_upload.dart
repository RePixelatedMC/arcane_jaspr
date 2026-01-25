import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/file_upload_props.dart';

/// File upload/dropzone component.
class ArcaneFileUpload extends StatefulComponent {
  final List<String> accept;
  final int? maxSize;
  final bool multiple;
  final void Function(List<UploadedFile>)? onFilesSelected;
  final void Function(String error)? onError;
  final FileUploadStyle style;
  final ComponentSize size;
  final bool disabled;
  final String? dropzoneText;
  final String browseText;
  final String? helperText;
  final String? label;

  const ArcaneFileUpload({
    this.accept = const [],
    this.maxSize,
    this.multiple = false,
    this.onFilesSelected,
    this.onError,
    this.style = FileUploadStyle.dropzone,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.dropzoneText,
    this.browseText = 'Browse files',
    this.helperText,
    this.label,
    super.key,
  });

  const ArcaneFileUpload.images({
    this.maxSize,
    this.multiple = true,
    this.onFilesSelected,
    this.onError,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.dropzoneText = 'Drag images here or click to browse',
    this.browseText = 'Select images',
    this.helperText,
    this.label,
    super.key,
  })  : accept = const ['image/*'],
        style = FileUploadStyle.dropzone;

  const ArcaneFileUpload.documents({
    this.maxSize,
    this.multiple = true,
    this.onFilesSelected,
    this.onError,
    this.size = ComponentSize.md,
    this.disabled = false,
    this.dropzoneText = 'Drag documents here or click to browse',
    this.browseText = 'Select documents',
    this.helperText,
    this.label,
    super.key,
  })  : accept = const ['.pdf', '.doc', '.docx', '.txt'],
        style = FileUploadStyle.dropzone;

  @override
  State<ArcaneFileUpload> createState() => _ArcaneFileUploadState();
}

class _ArcaneFileUploadState extends State<ArcaneFileUpload> {
  bool _isDragOver = false;
  List<UploadedFile> _selectedFiles = [];

  String get _acceptString => component.accept.join(',');

  String get _dropzoneText {
    if (component.dropzoneText != null) return component.dropzoneText!;
    if (component.multiple) {
      return 'Drag files here or click to browse';
    }
    return 'Drag a file here or click to browse';
  }

  void _handleFiles(dynamic files) {
    final List<UploadedFile> uploadedFiles = [];

    for (var i = 0; i < (files.length as int); i++) {
      final file = files[i];
      final name = file.name as String;
      final size = file.size as int;
      final type = file.type as String;

      if (component.maxSize != null && size > component.maxSize!) {
        component.onError?.call('File "$name" exceeds maximum size');
        continue;
      }

      uploadedFiles.add(UploadedFile(name: name, size: size, type: type));
    }

    if (uploadedFiles.isNotEmpty) {
      setState(() => _selectedFiles = uploadedFiles);
      component.onFilesSelected?.call(uploadedFiles);
    }
  }

  void _triggerFileInput() {
  }

  @override
  Component build(BuildContext context) {
    return context.renderers.fileUpload(FileUploadProps(
      style: component.style,
      size: component.size,
      isDragOver: _isDragOver,
      selectedFiles: _selectedFiles,
      disabled: component.disabled,
      label: component.label,
      dropzoneText: _dropzoneText,
      browseText: component.browseText,
      helperText: component.helperText,
      acceptString: _acceptString,
      multiple: component.multiple,
      onClick: component.disabled ? null : _triggerFileInput,
      onDragOver: (e) {
        e.preventDefault();
        if (!component.disabled) {
          setState(() => _isDragOver = true);
        }
      },
      onDragLeave: (_) {
        setState(() => _isDragOver = false);
      },
      onDrop: (e) {
        e.preventDefault();
        setState(() => _isDragOver = false);
        if (!component.disabled) {
          final files = (e as dynamic).dataTransfer?.files;
          if (files != null) {
            _handleFiles(files);
          }
        }
      },
      onInputChange: (e) {
        final files = (e.target as dynamic)?.files;
        if (files != null) {
          _handleFiles(files);
        }
      },
    ));
  }
}
