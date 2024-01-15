enum Routes {
  splash(
    name: 'splash',
    path: '/splashScreen',
    analyticsName: 'splash screen',
  ),
  registrationScreen(
    name: 'registration',
    path: '/registrationScreen',
    analyticsName: 'registration screen',
  ),
  loginScreen(
    name: 'login',
    path: '/loginScreen',
    analyticsName: 'login screen',
  ),
  homeScreen(
    name: 'home',
    path: '/homeScreen',
    analyticsName: 'home screen',
  ),
  other(
    name: 'other',
    path: '/other',
    analyticsName: 'Other Screen',
  );

  const Routes({
    required this.name,
    required this.path,
    required this.analyticsName,
  });

  final String name;
  final String path;
  final String analyticsName;

  @override
  String toString() => name;
}
