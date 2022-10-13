import 'package:flutter/material.dart';
import 'package:flutter_websocket_example/state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'channel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState(Channel(WebSocketChannel.connect(Uri.parse('ws://localhost:5601'))));
}