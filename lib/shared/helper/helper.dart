
class Helper{

  static String? validatePhoneNumber(String? value) {
    final numericValue = value?.replaceAll(RegExp(r'[^0-9+]'), '');

    if (numericValue == null || numericValue.isEmpty) {
      return 'الرقم الهاتفي مطلوب';
    } else if (numericValue.length < 8) {
      return 'يجب أن يكون رقم الهاتف على الأقل ١٠ أرقام';
    }

    return null;
  }
}