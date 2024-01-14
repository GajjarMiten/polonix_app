import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:poloniexapp/src/presentation/core/enums/routes_enum.dart';
import 'package:poloniexapp/src/presentation/routing/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(1.seconds, () {
      AppRouter.push(Routes.registrationScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
