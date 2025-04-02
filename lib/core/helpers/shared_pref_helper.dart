import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();
  late final SharedPreferences _sharedPreferences;

  factory SharedPrefHelper() {
    return _instance;
  }
  SharedPrefHelper._internal();

  Future<void> initSharedPreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Removes a value from SharedPreferences with given [key].
  removeData(String key) async {
    debugPrint('SharedPrefHelper : data with key : $key has been removed');
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    //  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await _sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  setData(String key, value) async {
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    debugPrint("SharedPrefHelper : setData with key : $key and value : $value");
    switch (value.runtimeType) {
      case String:
        await _sharedPreferences.setString(key, value);
        break;
      case int:
        await _sharedPreferences.setInt(key, value);
        break;
      case bool:
        await _sharedPreferences.setBool(key, value);
        break;
      case double:
        await _sharedPreferences.setDouble(key, value);
        break;
      default:
        return null;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  Future<bool> getBool(String key) async {
    debugPrint('SharedPrefHelper : getBool with key : $key');
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  getDouble(String key) async {
    debugPrint('SharedPrefHelper : getDouble with key : $key');
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  getInt(String key) async {
    debugPrint('SharedPrefHelper : getInt with key : $key');
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  getString(String key) async {
    debugPrint('SharedPrefHelper : getString with key : $key');
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static setSecuredString(String key, String value) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint(
      "FlutterSecureStorage : setSecuredString with key : $key and value : $value",
    );
    await flutterSecureStorage.write(key: key, value: value);
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static getSecuredString(String key) async {
    const flutterSecureStorage = FlutterSecureStorage();
    debugPrint('FlutterSecureStorage : getSecuredString with key : $key');
    return await flutterSecureStorage.read(key: key) ?? '';
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static clearAllSecuredData() async {
    debugPrint('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await flutterSecureStorage.deleteAll();
    // await sharedPreferences.remove('auth_status');
    // await sharedPreferences.remove(SharedPrefKeys.isRegister);
  }

  removeSecuredDataWhenFirstRun() async {
    if (_sharedPreferences.getBool('first_run') ?? true) {
      log("SharedPrefHelper : removeSecuredDataWhenFirstRun");
      const flutterSecureStorage = FlutterSecureStorage();
      await flutterSecureStorage.deleteAll();
      _sharedPreferences.setBool('first_run', false);
    }
  }
}
