import 'package:poloniexapp/src/data/datasources/remote/base/base_ws_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClientImpl extends WebSocketClient {
  WebSocketChannel? _channel;

  bool get isConnected => _channel != null && _channel!.;

  @override
  Future<void> connect(Uri uri) async {
    _channel = WebSocketChannel.connect(uri);
  }

  @override
  Future<void> disconnect() {
    _channel?.sink.close();
    return Future.value();
  }

  @override
  Future<void> send(String message) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  // TODO: implement stream
  Stream<String> get stream => throw UnimplementedError();
}
