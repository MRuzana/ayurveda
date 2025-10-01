class Validator {
  static String? validatePhoneNumber(String? value) {
    final phoneNumberRegExp = RegExp(r"^(?:\+91)?[0-9]{10}$");
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!phoneNumberRegExp.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}
