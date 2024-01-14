import 'package:flutter/foundation.dart';
import 'package:poloniexapp/src/core/logger/logger.dart';

import '../startup.dart';

class PlatformErrorCatcherTask extends LaunchTask {
  const PlatformErrorCatcherTask();

  @override
  Future<void> initialize(LaunchContext context) async {
    console('Running PlatformErrorCatcherTask');
    // if (!kDebugMode) {
    PlatformDispatcher.instance.onError = (error, stack) {
      console('Uncaught platform error',
          error: error, stackTrace: stack, logLevel: Level.error);
      return true;
    };
    // }
  }

  @override
  Future<void> dispose() async {}
}
