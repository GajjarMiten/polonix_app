abstract class WebSocketClient {
  Future<void> connect(Uri uri);
  Future<void> disconnect();
  Future<void> send(String message);
  Stream<String> get stream;
}
