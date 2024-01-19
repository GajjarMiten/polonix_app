import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:poloniexapp/src/domain/core/enums/connectivity_state_enum.dart';
import 'package:poloniexapp/src/domain/services/connectivity_service.dart';

class ConnectivityServiceImpl extends ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  ConnectivityState _mapConnectivityState(ConnectivityResult result) {
    return switch (result) {
      ConnectivityResult.wifi => ConnectivityState.wifi,
      ConnectivityResult.mobile => ConnectivityState.mobile,
      ConnectivityResult.none => ConnectivityState.none,
      ConnectivityResult.ethernet => ConnectivityState.ethernet,
      ConnectivityResult.vpn => ConnectivityState.vpn,
      ConnectivityResult.other => ConnectivityState.other,
      ConnectivityResult.bluetooth => ConnectivityState.bluetooth,
    };
  }

  @override
  Future<ConnectivityState> checkConnectivity() async {
    final res = await _connectivity.checkConnectivity();
    return _mapConnectivityState(res);
  }

  @override
  Stream<ConnectivityState> get connectivityStream =>
      _connectivity.onConnectivityChanged.map(_mapConnectivityState);

  @override
  Future<bool> get isConnected async {
    final res = await _connectivity.checkConnectivity();
    return ![
      ConnectivityResult.none,
      ConnectivityResult.other,
      ConnectivityResult.bluetooth
    ].contains(res);
  }
}
