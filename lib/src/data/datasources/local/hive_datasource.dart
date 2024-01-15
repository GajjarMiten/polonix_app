import 'dart:async';

import 'base/base_local_datasource.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataSource implements BaseLocalDataSource {
  HiveDataSource._();
  static const String _boxName = 'poloniex';

  Box get _box => Hive.box(_boxName);

  @override
  Future<void> dispose() async {
    await Hive.close();
  }

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  static Future<HiveDataSource> initHive() async {
    final hiveDataSource = HiveDataSource._();
    await hiveDataSource.init();
    return hiveDataSource;
  }

  @override
  Future<void> clear() {
    return _box.clear();
  }

  @override
  Future<bool> containsKey(String key) {
    return Future.value(_box.containsKey(key));
  }

  @override
  Future<void> delete(String key) {
    return _box.delete(key);
  }

  @override
  FutureOr<T?> get<T>(String key) {
    return _box.get(key);
  }

  @override
  Future<int> getLength() {
    return Future.value(_box.length);
  }

  @override
  Future<bool> isEmpty() {
    return Future.value(_box.isEmpty);
  }

  @override
  Future<bool> isNotEmpty() {
    return Future.value(_box.isNotEmpty);
  }

  @override
  Future<void> save<T>(String key, T value) {
    return _box.put(key, value);
  }
}
