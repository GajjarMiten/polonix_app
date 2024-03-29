import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:poloniexapp/src/data/datasources/local/base/base_local_datasource.dart';
import 'package:poloniexapp/src/data/datasources/local/hive_datasource.dart';
import 'package:poloniexapp/src/data/datasources/local/user_datasource/user_datasource.dart';
import 'package:poloniexapp/src/data/repositories/authentication_repository.dart';
import 'package:poloniexapp/src/domain/repositories/authentication_repository.dart';
import 'package:poloniexapp/src/domain/usecases/auth_usecases/login_user_usecase.dart';
import 'package:poloniexapp/src/domain/usecases/auth_usecases/register_user_usecase.dart';
import 'package:poloniexapp/src/startup/startup.dart';

part "../injection_container_impl.dart";

abstract class InjectionContainer {
  static final InjectionContainer _instace = InjectionContainerImpl._();

  static InjectionContainer get instance => _instace;

  bool readySync();
  Future<void> readyAsync();

  T call<T extends Object>();

  T get<T extends Object>({
    dynamic param1,
    dynamic param2,
    String? instanceName,
    Type? type,
  });

  Future<T> getAsync<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
    Type? type,
  });

  T registerSingleton<T extends Object>(
    T instance, {
    String? instanceName,
    bool? signalsReady,
    FutureOr<dynamic> Function(T)? dispose,
  });

  void registerLazySingleton<T extends Object>(
    T Function() factoryFunc, {
    String? instanceName,
    FutureOr<dynamic> Function(T)? dispose,
  });

  void registerSingletonAsync<T extends Object>(
    Future<T> Function() factoryFunc, {
    String? instanceName,
    Iterable<Type>? dependsOn,
    bool? signalsReady,
    FutureOr<dynamic> Function(T)? dispose,
  });

  void registerLazySingletonAsync<T extends Object>(
    Future<T> Function() factoryFunc, {
    String? instanceName,
    FutureOr<dynamic> Function(T)? dispose,
  });
}
