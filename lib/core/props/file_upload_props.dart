/// File upload style variants
enum FileUploadStyle {
  /// Default dropzone style
  dropzone,

  /// Compact button style
  button,

  /// Inline style
  inline,
}

/// File upload size variants
enum FileUploadSize {
  sm,
  md,
  lg,
}

/// Uploaded file info
class UploadedFile {
  final String name;
  final int size;
  final String type;

  const UploadedFile({
    required this.name,
    required this.size,
    required this.type,
  });

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// Properties for file upload components.
class FileUploadProps {
  /// Style variant
  final FileUploadStyle style;

  /// Size variant
  final FileUploadSize size;

  /// Whether the dropzone is in drag-over state
  final bool isDragOver;

  /// List of selected files
  final List<UploadedFile> selectedFiles;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Dropzone text
  final String dropzoneText;

  /// Browse button text
  final String browseText;

  /// Helper text
  final String? helperText;

  /// Accept string for file input
  final String acceptString;

  /// Whether multiple files can be selected
  final bool multiple;

  /// Callback for click event
  final void Function()? onClick;

  /// Callback for drag over event
  final void Function(dynamic event)? onDragOver;

  /// Callback for drag leave event
  final void Function(dynamic event)? onDragLeave;

  /// Callback for drop event
  final void Function(dynamic event)? onDrop;

  /// Callback for file input change event
  final void Function(dynamic event)? onInputChange;

  const FileUploadProps({
    required this.style,
    required this.size,
    required this.isDragOver,
    required this.selectedFiles,
    required this.disabled,
    required this.dropzoneText,
    required this.browseText,
    required this.acceptString,
    required this.multiple,
    this.label,
    this.helperText,
    this.onClick,
    this.onDragOver,
    this.onDragLeave,
    this.onDrop,
    this.onInputChange,
  });
}
