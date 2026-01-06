import 'package:jaspr/jaspr.dart';

import '../../core/props/file_upload_props.dart';
import '../../core/theme_provider.dart';

// Re-export props for usage
export '../../core/props/file_upload_props.dart';

/// File upload/dropzone component
///
/// Allows users to upload files via drag-and-drop or click to browse.
///
/// ```dart
/// ArcaneFileUpload(
///   accept: ['image/*', '.pdf'],
///   maxSize: 5 * 1024 * 1024, // 5MB
///   onFilesSelected: (files) => print(files),
/// )
/// ```
class ArcaneFileUpload extends StatefulComponent {
  /// Accepted file types (MIME types or extensions)
  final List<String> accept;

  /// Maximum file size in bytes
  final int? maxSize;

  /// Whether multiple files can be selected
  final bool multiple;

  /// Callback when files are selected
  final void Function(List<UploadedFile>)? onFilesSelected;

  /// Callback for file errors
  final void Function(String error)? onError;

  /// Style variant
  final FileUploadStyle style;

  /// Size variant
  final FileUploadSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Custom dropzone text
  final String? dropzoneText;

  /// Custom browse button text
  final String browseText;

  /// Helper text
  final String? helperText;

  /// Label text
  final String? label;

  const ArcaneFileUpload({
    this.accept = const [],
    this.maxSize,
    this.multiple = false,
    this.onFilesSelected,
    this.onError,
    this.style = FileUploadStyle.dropzone,
    this.size = FileUploadSize.md,
    this.disabled = false,
    this.dropzoneText,
    this.browseText = 'Browse files',
    this.helperText,
    this.label,
    super.key,
  });

  /// Image upload preset
  const ArcaneFileUpload.images({
    this.maxSize,
    this.multiple = true,
    this.onFilesSelected,
    this.onError,
    this.size = FileUploadSize.md,
    this.disabled = false,
    this.dropzoneText = 'Drag images here or click to browse',
    this.browseText = 'Select images',
    this.helperText,
    this.label,
    super.key,
  })  : accept = const ['image/*'],
        style = FileUploadStyle.dropzone;

  /// Document upload preset
  const ArcaneFileUpload.documents({
    this.maxSize,
    this.multiple = true,
    this.onFilesSelected,
    this.onError,
    this.size = FileUploadSize.md,
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

    // Handle FileList from input/drop
    for (var i = 0; i < (files.length as int); i++) {
      final file = files[i];
      final name = file.name as String;
      final size = file.size as int;
      final type = file.type as String;

      // Check size limit
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
    // Trigger click on hidden file input via JavaScript
    // This would need JS interop in practice
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
