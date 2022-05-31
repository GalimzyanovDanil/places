import 'dart:async';
import 'package:places/features/common/app_exceptions/exception_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  static final _storage = SharedPreferences.getInstance();

  Future<void> setValue(Object value, String key) async {
    if (value is bool) {
      return unawaited((await _storage).setBool(key, value));
    }
    if (value is int) return unawaited((await _storage).setInt(key, value));
    if (value is double) {
      return unawaited((await _storage).setDouble(key, value));
    }
    if (value is String) {
      return unawaited((await _storage).setString(key, value));
    }
    if (value is List<String>) {
      return unawaited((await _storage).setStringList(key, value));
    }
    throw UnimplementedError(ExceptionStrings.unsupportedDataType);
  }

  Future<T?> getValue<T>(String key) async {
    assert(T != dynamic, ExceptionStrings.unsupportedDataType);
    if (T == List<String>) return (await _storage).getStringList(key) as T?;
    return (await _storage).get(key) as T?;
  }
}
