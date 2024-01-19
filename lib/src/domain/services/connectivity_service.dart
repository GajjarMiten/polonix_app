import 'package:poloniexapp/src/domain/core/enums/connectivity_state_enum.dart';

abstract class ConnectivityService {
  Future<bool> get isConnected;

  Stream<ConnectivityState> get connectivityStream;

  Future<ConnectivityState> checkConnectivity();
}
