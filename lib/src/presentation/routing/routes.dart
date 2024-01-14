part of "./app_router.dart";

Widget _getPage(Routes route, BuildContext context, GoRouterState state) {
  return switch (route) {
    Routes.splash => const SplashScreen(),
    Routes.registrationScreen => const RegistrationScreen(),
    Routes.loginScreen => const LoginScreen(),
    _ => const Text("404"),
  };
}
