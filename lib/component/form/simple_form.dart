import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/simple_form_props.dart';

/// A simple form component for common form patterns.
class ArcaneSimpleForm extends StatelessComponent {
  final String? title;
  final String? description;
  final List<SimpleFormField> fields;
  final String submitLabel;
  final String successMessage;
  final SimpleFormLayout layout;
  final bool compact;
  final void Function(Map<String, String> values)? onSubmit;

  const ArcaneSimpleForm({
    this.title,
    this.description,
    required this.fields,
    this.submitLabel = 'Submit',
    this.successMessage = 'Thanks for your submission!',
    this.layout = SimpleFormLayout.stacked,
    this.compact = false,
    this.onSubmit,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.simpleForm(SimpleFormProps(
      title: title,
      description: description,
      fields: fields,
      submitLabel: submitLabel,
      successMessage: successMessage,
      layout: layout,
      compact: compact,
      onSubmit: onSubmit,
    ));
  }
}

/// Newsletter signup form component.
class ArcaneNewsletterForm extends StatelessComponent {
  final String placeholder;
  final String buttonText;
  final String successMessage;
  final void Function(String email)? onSubmit;
  final bool inline;
  final bool compact;

  const ArcaneNewsletterForm({
    this.placeholder = 'Enter your email',
    this.buttonText = 'Subscribe',
    this.successMessage = 'Thanks for subscribing!',
    this.onSubmit,
    this.inline = true,
    this.compact = false,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.simpleForm(SimpleFormProps.newsletter(
      placeholder: placeholder,
      submitLabel: buttonText,
      successMessage: successMessage,
      inline: inline,
      compact: compact,
      onSubmit: onSubmit,
    ));
  }
}

/// Waitlist form with optional name collection.
class ArcaneWaitlistForm extends StatelessComponent {
  final String? title;
  final String? description;
  final String buttonText;
  final String successMessage;
  final void Function(String email, String? name)? onSubmit;
  final bool collectName;

  const ArcaneWaitlistForm({
    this.title,
    this.description,
    this.buttonText = 'Join Waitlist',
    this.successMessage = "You're on the list! We'll be in touch.",
    this.onSubmit,
    this.collectName = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.simpleForm(SimpleFormProps.waitlist(
      title: title,
      description: description,
      submitLabel: buttonText,
      successMessage: successMessage,
      collectName: collectName,
      onSubmit: onSubmit,
    ));
  }
}

/// Contact form with name, email, and message.
class ArcaneContactForm extends StatelessComponent {
  final String? title;
  final String? description;
  final String buttonText;
  final String successMessage;
  final void Function(String name, String email, String message)? onSubmit;

  const ArcaneContactForm({
    this.title,
    this.description,
    this.buttonText = 'Send Message',
    this.successMessage = 'Thanks for reaching out!',
    this.onSubmit,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return context.renderers.simpleForm(SimpleFormProps.contact(
      title: title,
      description: description,
      submitLabel: buttonText,
      successMessage: successMessage,
      onSubmit: onSubmit,
    ));
  }
}
