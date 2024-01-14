part of 'base/injection_container.dart';

Future<void> init(InjectionContainer getIt, LaunchContext launchContext) async {
  getIt.registerSingleton(AppLauncher(context: launchContext));
  await getIt.readyAsync();
}

class InjectionContainerImpl implements InjectionContainer {
  InjectionContainerImpl._();

  final di = GetIt.I;

  @override
  Future<void> readyAsync() => di.allReady();

  @override
  bool readySync() => di.allReadySync();

  @override
  T get<T extends Object>({param1, param2, String? instanceName, Type? type}) =>
      di.get<T>(
          param1: param1,
          param2: param2,
          instanceName: instanceName,
          type: type);

  @override
  Future<T> getAsync<T extends Object>(
          {String? instanceName, param1, param2, Type? type}) =>
      di.getAsync<T>();

  @override
  void registerLazySingleton<T extends Object>(T Function() factoryFunc,
          {String? instanceName, FutureOr Function(T p1)? dispose}) =>
      di.registerLazySingleton<T>(factoryFunc);

  @override
  T registerSingleton<T extends Object>(T instance,
          {String? instanceName,
          bool? signalsReady,
          FutureOr Function(T p1)? dispose}) =>
      di.registerSingleton<T>(instance);

  @override
  void registerLazySingletonAsync<T extends Object>(
          Future<T> Function() factoryFunc,
          {String? instanceName,
          FutureOr Function(T p1)? dispose}) =>
      di.registerLazySingletonAsync<T>(factoryFunc);

  @override
  void registerSingletonAsync<T extends Object>(
          Future<T> Function() factoryFunc,
          {String? instanceName,
          Iterable<Type>? dependsOn,
          bool? signalsReady,
          FutureOr Function(T p1)? dispose}) =>
      di.registerSingletonAsync(factoryFunc);

  @override
  T call<T extends Object>() => get<T>();
}
