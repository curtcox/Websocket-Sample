import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  final channel = IOWebSocketChannel.connect('ws://localhost:5600');
  print('Connected to channel ' + channel.toString());
  channel.sink.add('sent');
  channel.stream.listen((message) {
    print('client message received ' + message.toString());
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
  });
}
