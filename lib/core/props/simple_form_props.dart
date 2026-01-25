import 'package:jaspr/jaspr.dart';

/// Field type for simple forms.
enum SimpleFormFieldType {
  text,
  email,
  password,
  textarea,
  phone,
  url,
}

/// A single field in a simple form.
class SimpleFormField {
  final String name;
  final String? label;
  final String? placeholder;
  final String? hint;
  final SimpleFormFieldType type;
  final bool required;
  final String? Function(String?)? validator;

  const SimpleFormField({
    required this.name,
    this.label,
    this.placeholder,
    this.hint,
    this.type = SimpleFormFieldType.text,
    this.required = false,
    this.validator,
  });

  /// Email field with built-in validation.
  const SimpleFormField.email({
    this.name = 'email',
    this.label,
    this.placeholder = 'your@email.com',
    this.hint,
    this.required = true,
    this.validator,
  }) : type = SimpleFormFieldType.email;

  /// Name field.
  const SimpleFormField.name({
    this.name = 'name',
    this.label,
    this.placeholder = 'Your name',
    this.hint,
    this.required = false,
    this.validator,
  }) : type = SimpleFormFieldType.text;

  /// Message/textarea field.
  const SimpleFormField.message({
    this.name = 'message',
    this.label,
    this.placeholder = 'Your message',
    this.hint,
    this.required = false,
    this.validator,
  }) : type = SimpleFormFieldType.textarea;
}

/// Simple form layout style.
enum SimpleFormLayout {
  /// Fields stacked vertically with submit below.
  stacked,

  /// Single row with inline submit button (for single-field forms).
  inline,
}

/// Simple form component properties.
class SimpleFormProps {
  final String? title;
  final String? description;
  final List<SimpleFormField> fields;
  final String submitLabel;
  final String successMessage;
  final SimpleFormLayout layout;
  final bool compact;
  final void Function(Map<String, String> values)? onSubmit;

  const SimpleFormProps({
    this.title,
    this.description,
    required this.fields,
    this.submitLabel = 'Submit',
    this.successMessage = 'Thanks for your submission!',
    this.layout = SimpleFormLayout.stacked,
    this.compact = false,
    this.onSubmit,
  });

  /// Newsletter signup form with just email.
  factory SimpleFormProps.newsletter({
    String placeholder = 'Enter your email',
    String submitLabel = 'Subscribe',
    String successMessage = 'Thanks for subscribing!',
    bool inline = true,
    bool compact = false,
    void Function(String email)? onSubmit,
  }) {
    return SimpleFormProps(
      fields: [
        SimpleFormField.email(placeholder: placeholder),
      ],
      submitLabel: submitLabel,
      successMessage: successMessage,
      layout: inline ? SimpleFormLayout.inline : SimpleFormLayout.stacked,
      compact: compact,
      onSubmit: onSubmit != null
          ? (values) => onSubmit(values['email'] ?? '')
          : null,
    );
  }

  /// Waitlist form with optional name and email.
  factory SimpleFormProps.waitlist({
    String? title,
    String? description,
    String submitLabel = 'Join Waitlist',
    String successMessage = "You're on the list! We'll be in touch.",
    bool collectName = true,
    void Function(String email, String? name)? onSubmit,
  }) {
    return SimpleFormProps(
      title: title,
      description: description,
      fields: [
        if (collectName) const SimpleFormField.name(),
        const SimpleFormField.email(),
      ],
      submitLabel: submitLabel,
      successMessage: successMessage,
      layout: SimpleFormLayout.stacked,
      onSubmit: onSubmit != null
          ? (values) => onSubmit(
                values['email'] ?? '',
                collectName ? values['name'] : null,
              )
          : null,
    );
  }

  /// Contact form with name, email, and message.
  factory SimpleFormProps.contact({
    String? title,
    String? description,
    String submitLabel = 'Send Message',
    String successMessage = 'Thanks for reaching out!',
    void Function(String name, String email, String message)? onSubmit,
  }) {
    return SimpleFormProps(
      title: title,
      description: description,
      fields: const [
        SimpleFormField.name(required: true),
        SimpleFormField.email(),
        SimpleFormField.message(required: true),
      ],
      submitLabel: submitLabel,
      successMessage: successMessage,
      layout: SimpleFormLayout.stacked,
      onSubmit: onSubmit != null
          ? (values) => onSubmit(
                values['name'] ?? '',
                values['email'] ?? '',
                values['message'] ?? '',
              )
          : null,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for simple form components.
mixin SimpleFormRendererContract {
  Component simpleForm(SimpleFormProps props);
}
