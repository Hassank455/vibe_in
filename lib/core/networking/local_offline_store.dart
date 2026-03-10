import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class LocalOfflineStore {
  static const _boxName = 'offline_box_v1';
  static const _metaBox = 'offline_meta_v1';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_boxName);
    await Hive.openBox<int>(_metaBox);
  }

  Future<void> saveJson(String key, Object jsonEncodable) async {
    final box = Hive.box<String>(_boxName);
    await box.put(key, jsonEncode(jsonEncodable));
    await Hive.box<int>(
      _metaBox,
    ).put(_tsKey(key), DateTime.now().millisecondsSinceEpoch);
  }

  List<dynamic>? readJsonList(String key) {
    final box = Hive.box<String>(_boxName);
    final raw = box.get(key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw);
    if (decoded is List) return decoded;
    return null;
  }

  Map<String, dynamic>? readJsonObject(String key) {
    final box = Hive.box<String>(_boxName);
    final raw = box.get(key);
    if (raw == null) return null;
    final decoded = jsonDecode(raw);
    if (decoded is Map<String, dynamic>) return decoded;
    return null;
  }

  DateTime? lastSync(String key) {
    final ts = Hive.box<int>(_metaBox).get(_tsKey(key));
    return ts == null ? null : DateTime.fromMillisecondsSinceEpoch(ts);
  }

  String _tsKey(String key) => '${key}__ts';
}
