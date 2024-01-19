// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:poloniexapp/src/data/core/enums/base_url_enum.dart';
import 'package:poloniexapp/src/data/core/enums/endpoints_enum.dart';
import 'package:poloniexapp/src/data/datasources/remote/base/base_http_client.dart';
import 'package:poloniexapp/src/domain/core/enums/connectivity_state_enum.dart';
import 'package:poloniexapp/src/domain/entities/crypto_ticker.dart';
import 'package:poloniexapp/src/domain/repositories/crypto_ticker_repository.dart';
import 'package:poloniexapp/src/domain/services/connectivity_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoTickerRepositoryImpl extends CryptoTickerRepository {
  final HttpClient _httpClient;
  final ConnectivityService _connectivityService;

  StreamSubscription<ConnectivityState>? _connectivitySubscription;

  CryptoTickerRepositoryImpl(
    this._httpClient,
    this._connectivityService,
  );

  @override
  Future<void> init() async {
    _connectivitySubscription?.cancel();
    _connectivitySubscription =
        _connectivityService.connectivityStream.listen((state) async {
      if (await _connectivityService.isConnected) {
        connect();
      }
    });
  }

  @override
  Future<bool> connect() async {
    try {
      final token = await _getToken();
      if (token == null) {
        return false;
      }

      final url =
          "${BaseUrl.polonixWSS.url}${Endpoints.wssEndpoint.url}?token=$token";

      final channel = WebSocketChannel.connect(Uri.parse(url));
    } catch (e) {
      return false;
    }
  }

  Future<String?> _getToken() async {
    try {
      final res = await _httpClient.post(
        Endpoints.connect,
        {},
        base: BaseUrl.polonix,
      );

      if (res.hasError) {
        return null;
      }

      return res.data['data']['token'];
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<CryptoTicker> get tickerStream => throw UnimplementedError();
}
