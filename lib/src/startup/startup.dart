import 'dart:async';
import 'package:poloniexapp/src/di/base/injection_container.dart' as di;
import 'package:poloniexapp/src/startup/tasks/app_runner_task.dart';
import 'package:poloniexapp/src/startup/tasks/platform_error_catcher.dart';

Future<void> runPolonixApp() async {
  await AppRunner.run();
}

final getIt = di.InjectionContainer.instance;

class AppRunner {
  static Future<void> run() async {
    final LaunchContext launchContext = LaunchContext(getIt);
    await di.init(getIt, launchContext);

    final launcher = getIt<AppLauncher>();
    launcher.addTasks(
      [
        const PlatformErrorCatcherTask(),
        const AppRunnerTask(),
      ],
    );
    await launcher.launch();
  }
}

class LaunchContext {
  di.InjectionContainer getIt;

  LaunchContext(
    this.getIt,
  );
}

enum LaunchTaskType {
  dataProcessing,
  appLauncher,
}

abstract class LaunchTask {
  const LaunchTask();

  LaunchTaskType get type => LaunchTaskType.dataProcessing;

  Future<void> initialize(LaunchContext context);
  Future<void> dispose();
}

class AppLauncher {
  AppLauncher({
    required this.context,
  });

  final LaunchContext context;
  final List<LaunchTask> tasks = [];

  void addTask(LaunchTask task) {
    tasks.add(task);
  }

  void addTasks(Iterable<LaunchTask> tasks) {
    this.tasks.addAll(tasks);
  }

  Future<void> launch() async {
    for (final task in tasks) {
      await task.initialize(context);
    }
  }

  Future<void> dispose() async {
    for (final task in tasks) {
      await task.dispose();
    }
    tasks.clear();
  }
}
