import 'package:poloniexapp/src/domain/entities/crypto_ticker.dart';

abstract class CryptoTickerRepository {
  Future<void> init();

  Future<void> connect();

  Stream<CryptoTicker> get tickerStream;
}
