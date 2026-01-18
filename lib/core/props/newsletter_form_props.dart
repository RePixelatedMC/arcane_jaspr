import 'package:jaspr/jaspr.dart';

/// Newsletter form component properties.
class NewsletterFormProps {
  final String placeholder;
  final String buttonText;
  final String successMessage;
  final void Function(String email)? onSubmit;
  final bool inline;
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

/// Waitlist form component properties.
class WaitlistFormProps {
  final String? title;
  final String? description;
  final String buttonText;
  final String successMessage;
  final void Function(String email, String? name)? onSubmit;
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

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for newsletter form components.
mixin NewsletterFormRendererContract {
  Component newsletterForm(NewsletterFormProps props);
  Component waitlistForm(WaitlistFormProps props);
}
