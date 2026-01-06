/// Properties for newsletter form components.
class NewsletterFormProps {
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

  const NewsletterFormProps({
    this.placeholder = 'Enter your email',
    this.buttonText = 'Subscribe',
    this.successMessage = 'Thanks for subscribing!',
    this.onSubmit,
    this.inline = true,
    this.compact = false,
  });
}

/// Properties for waitlist form components.
class WaitlistFormProps {
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

  const WaitlistFormProps({
    this.title,
    this.description,
    this.buttonText = 'Join Waitlist',
    this.successMessage = "You're on the list! We'll be in touch.",
    this.onSubmit,
    this.collectName = true,
  });
}
