import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/newsletter_form_props.dart';

/// A newsletter signup form (Supabase-style)
class ArcaneNewsletterForm extends StatelessComponent {
  /// Placeholder text
  final String placeholder;

  /// Submit button text
  final String buttonText;

  /// Success message
  final String successMessage;

  /// Submit callback
  final void Function(String email)? onSubmit;

  /// Whether to show inline (horizontal) layout
  final bool inline;

  /// Whether the form is compact
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
    return context.renderers.newsletterForm(NewsletterFormProps(
      placeholder: placeholder,
      buttonText: buttonText,
      successMessage: successMessage,
      onSubmit: onSubmit,
      inline: inline,
      compact: compact,
    ));
  }
}

/// A waitlist form with additional fields
class ArcaneWaitlistForm extends StatelessComponent {
  /// Form title
  final String? title;

  /// Form description
  final String? description;

  /// Submit button text
  final String buttonText;

  /// Success message
  final String successMessage;

  /// Submit callback
  final void Function(String email, String? name)? onSubmit;

  /// Whether to collect name
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
    return context.renderers.waitlistForm(WaitlistFormProps(
      title: title,
      description: description,
      buttonText: buttonText,
      successMessage: successMessage,
      onSubmit: onSubmit,
      collectName: collectName,
    ));
  }
}
