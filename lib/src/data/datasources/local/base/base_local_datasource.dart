import 'dart:async';

abstract class BaseLocalDataSource {
  Future<void> init();
  Future<void> dispose();

  Future<void> save<T>(String key, T value);

  FutureOr<T?> get<T>(String key);

  Future<void> delete(String key);

  Future<void> clear();

  Future<bool> containsKey(String key);

  Future<int> getLength();

  Future<bool> isEmpty();

  Future<bool> isNotEmpty();
}
