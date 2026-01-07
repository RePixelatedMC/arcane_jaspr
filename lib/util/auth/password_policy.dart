/// Password validation policy with configurable requirements.
class PasswordPolicy {
  final int minLength;
  final int maxLength;
  final bool requireUppercase;
  final bool requireLowercase;
  final bool requireNumber;
  final bool requireSpecialChar;

  const PasswordPolicy({
    this.minLength = 6,
    this.maxLength = 128,
    this.requireUppercase = false,
    this.requireLowercase = false,
    this.requireNumber = false,
    this.requireSpecialChar = false,
  });

  static const PasswordPolicy strong = PasswordPolicy(
    minLength: 8,
    requireUppercase: true,
    requireLowercase: true,
    requireNumber: true,
    requireSpecialChar: true,
  );

  static const PasswordPolicy medium = PasswordPolicy(
    minLength: 8,
    requireUppercase: true,
    requireNumber: true,
  );

  static const PasswordPolicy weak = PasswordPolicy(
    minLength: 6,
  );

  String? validate(String password) {
    if (password.length < minLength) {
      return 'Password must be at least $minLength characters long.';
    }

    if (password.length > maxLength) {
      return 'Password must be no more than $maxLength characters long.';
    }

    if (requireUppercase && !password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (requireLowercase && !password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }

    if (requireNumber && !password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    if (requireSpecialChar &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  bool isValid(String password) => validate(password) == null;

  String get description {
    final List<String> requirements = <String>[];

    requirements.add('At least $minLength characters');

    if (requireUppercase) {
      requirements.add('one uppercase letter');
    }
    if (requireLowercase) {
      requirements.add('one lowercase letter');
    }
    if (requireNumber) {
      requirements.add('one number');
    }
    if (requireSpecialChar) {
      requirements.add('one special character');
    }

    if (requirements.length == 1) {
      return requirements.first;
    }

    return '${requirements.first}, ${requirements.sublist(1).join(', ')}';
  }
}
