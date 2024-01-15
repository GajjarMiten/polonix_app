import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poloniexapp/src/core/logger/logger.dart';
import 'package:poloniexapp/src/di/base/injection_container.dart';
import 'package:poloniexapp/src/presentation/cubit/auth_cubit/auth_cubit.dart';
import 'package:poloniexapp/src/presentation/routing/app_router.dart';
import 'package:poloniexapp/src/presentation/shared/sizer.dart';
import 'package:poloniexapp/src/startup/startup.dart';

class AppRunnerTask extends LaunchTask {
  const AppRunnerTask();

  @override
  LaunchTaskType get type => LaunchTaskType.appLauncher;

  @override
  Future<void> initialize(LaunchContext context) async {
    console('Running AppRunnerTask');
    WidgetsFlutterBinding.ensureInitialized();

    final app = ApplicationWidget();

    Bloc.observer = ApplicationBlocObserver();
    runApp(app);

    return;
  }

  @override
  Future<void> dispose() async {}
}

class ApplicationWidget extends StatelessWidget {
  ApplicationWidget({
    super.key,
  });

  final getIt = InjectionContainer.instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            loginUserUseCase: getIt(),
            registerUserUseCase: getIt(),
          ),
        ),
      ],
      child: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter routerConfig;

  @override
  void initState() {
    super.initState();
    routerConfig = AppRouter.instance.allRoutes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Polonix App',
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        useMaterial3: true,
      ),
      builder: (context, child) => Sizer(
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1),
          ),
          child: child ?? const SizedBox(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
    );
  }
}

class ApplicationBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    console(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    console("$event");
    super.onEvent(bloc, event);
  }
}
