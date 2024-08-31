typedef ValidatorFunction = String? Function(String value);

class Validator {
  static String? validateField(String? value, List<ValidatorFunction> validators) {
    if (value == null || value.isEmpty) {
      return "";
    }
    for (var validator in validators) {
      final error = validator(value);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  static String? validateEmptyText(String errorMessage, String? value) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? validateEmail(String errorMessage, String? value) {
    if (value == null) {
      return "";
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value.trim())) {
      return errorMessage;
    }

    return null;
  }

  static String? validatePassword(List<String> errorMessages, String? value) {
    const minCharacters = 8;
    if (value == null || value.isEmpty) {
      return '';
    }

    // Check for minimum password length
    if (value.length < minCharacters) {
      return errorMessages[0];
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return errorMessages[1];
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return errorMessages[2];
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return errorMessages[3];
    }

    return null;
  }

  static String? validatePhoneNumber(String errorMessage, String? value) {
    // Regular expression for phone number validation (assuming a 9-digit SN phone number format xx-xxx-xx-xx)
    final phoneRegExp = RegExp(r'^\d{9}$');

    if (value == null || !phoneRegExp.hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }
}
