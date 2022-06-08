import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// Helper for work with NSUserDefaults (on iOS) and SharedPreferences (on Android)
class SharedPreferencesHelper {
  final _prefs = SharedPreferences.getInstance();

  /// Reads a value of [T] type from persistent storage.
  Future<T> get<T>(String key, T defaultValue) async {
    final instance = await _prefs;
    final T? result;
    if (T == List<String>) {
      result = instance.getStringList(key) as T?;
      return result ?? defaultValue;
    }
    result = instance.get(key) as T?;

    return result ?? defaultValue;
  }

  /// Saves a [value] to persistent storage in the background.
  Future<void> set(String key, Object value) async {
    final instance = await _prefs;

    if (value is bool) {
      await instance.setBool(key, value);
    } else if (value is int) {
      await instance.setInt(key, value);
    } else if (value is double) {
      await instance.setDouble(key, value);
    } else if (value is String) {
      await instance.setString(key, value);
    } else if (value is List<String>) {
      await instance.setStringList(key, value);
    } else {
      throw Exception(
        "SharedPreferencesHelper: Does't support type ${value.runtimeType} yet.",
      );
    }
  }
}
