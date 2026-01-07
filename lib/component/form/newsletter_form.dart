import 'package:jaspr/jaspr.dart';

import '../../core/theme_provider.dart';

export '../../core/props/newsletter_form_props.dart';

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
