/// Валидаторы текстовых полей.
abstract class TextFieldsValidators {
  static const requiredField = 'Заполните поле';
  static const numberRequired = 'Введите число';

  static String? checkNotEmpty(String? text) =>
      (text?.isEmpty ?? true) ? requiredField : null;

  static String? checkLatitude(String? text) => _checkRange(text, -90, 90);

  static String? checkLongitude(String? text) => _checkRange(text, -180, 180);

  static String _allowedRange(int start, int end) =>
      'Допустимо: $start .. $end';

  static String? _checkRange(String? text, int start, int end) {
    final res = checkNotEmpty(text);

    if (res != null) {
      return res;
    }

    final value = double.tryParse(text!);
    if (value == null) {
      return numberRequired;
    }

    if (value < start || value > end) {
      return _allowedRange(start, end);
    }

    return null;
  }
}
