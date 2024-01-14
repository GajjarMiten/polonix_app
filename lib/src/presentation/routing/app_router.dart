import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poloniexapp/src/core/logger/logger.dart';
import 'package:poloniexapp/src/presentation/core/enums/routes_enum.dart';
import 'package:poloniexapp/src/presentation/core/types.dart';
import 'package:poloniexapp/src/presentation/flow/auth_flow/login/login_screen.dart';
import 'package:poloniexapp/src/presentation/flow/auth_flow/registration/registration_screen.dart';
import 'package:poloniexapp/src/presentation/flow/splash_flow/splash_screen.dart';

part './routes.dart';

class AppRouter {
  final GoRouter _router;

  static AppRouter? _instance;

  static AppRouter get instance => AppRouter.init();

  factory AppRouter.init() {
    if (AppRouter._instance != null) return AppRouter._instance!;

    final router = GoRouter(
      initialLocation: Routes.splash.path,
      routes: _routeBuilder(),
    );

    AppRouter._instance ??= AppRouter._(router);

    return AppRouter._instance!;
  }

  AppRouter._(this._router);

  GoRouter get allRoutes => _router;
  Routes get currentRoute => _getCurrentRoute();

  String nextRoute = '';
  String rootRoute = '';

  Routes _getCurrentRoute() {
    final route = _router.routerDelegate.currentConfiguration.last;

    return Routes.values.firstWhere(
      (element) => element.path == route.matchedLocation,
      orElse: () => Routes.other,
    );
  }

  static List<RouteBase> _routeBuilder() {
    return Routes.values
        .map(
          (route) => GoRoute(
            path: route.path,
            name: route.name,
            builder: (context, state) {
              return _getPage(route, context, state);
            },
          ),
        )
        .toList();
  }

  static String _pathWithQueryParams(Routes route,
      [QueryParams queryParams = const {}]) {
    final path = Uri(path: route.path, queryParameters: queryParams).toString();
    return path;
  }

  static Future<T?> push<T>(Routes route,
      {QueryParams queryParams = const {}, Object? extra}) {
    return AppRouter.instance._router
        .push<T>(_pathWithQueryParams(route, queryParams), extra: extra);
  }

  static Future<T?> pushReplace<T>(Routes route,
      {QueryParams queryParams = const {}, Object? extra}) {
    if (route == AppRouter.instance.currentRoute) {
      console('didn\'t pushReplace becase route was same as current route',
          logLevel: Level.info);
      return Future.value(null);
    }
    return AppRouter.instance._router
        .pushReplacement<T>(_pathWithQueryParams(route), extra: extra);
  }

  static Future<T?> pushAndRemoveAll<T>(Routes route,
      {QueryParams queryParams = const {}, Object? extra, Routes? rootRoute}) {
    while (AppRouter.instance._router.canPop()) {
      AppRouter.instance._router.pop();
    }
    if (rootRoute != null) {
      AppRouter.instance._router
          .pushReplacement<T>(_pathWithQueryParams(rootRoute), extra: extra);
      return AppRouter.instance._router
          .push<T>(_pathWithQueryParams(route), extra: extra);
    } else {
      return AppRouter.instance._router
          .pushReplacement<T>(_pathWithQueryParams(route), extra: extra);
    }
  }

  static void pop<T extends Object>([T? result]) {
    return AppRouter.instance._router.pop(result);
  }

  static bool canPop() {
    return AppRouter.instance._router.canPop();
  }

  static void go(Routes route,
      {QueryParams queryParams = const {}, Object? extra}) {
    return AppRouter.instance._router
        .go(_pathWithQueryParams(route, queryParams), extra: extra);
  }
}
