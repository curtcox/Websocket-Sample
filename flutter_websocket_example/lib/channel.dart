import 'package:web_socket_channel/web_socket_channel.dart';

class Channel {

  final WebSocketChannel _channel;

  Channel(this._channel);

  void sendMessage(String text) {
      _channel.sink.add(text);
  }

  stream() => _channel.stream;

  void close() {
    _channel.sink.close();
  }
}