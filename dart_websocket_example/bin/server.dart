import 'dart:io';

String socketMessage = "";
String requestString = "";

void main() async {
  startHttpServer();
  startWebSocketServer();
}

void startHttpServer() async {
  HttpServer server = await startOn('HTTP',5600);
  server.listen(handleGetRequest);
}

void startWebSocketServer() async {
  HttpServer server = await startOn('WebSocket',5601);
  server.transform(WebSocketTransformer()).listen(onWebSocketData);
}

Future<HttpServer> startOn(String name, int port) async {
  HttpServer server = await HttpServer.bind('0.0.0.0', port);
  print(name + ' server bound to ' + port.toString());
  return server;
}

void handleGetRequest(HttpRequest request) {
  HttpResponse response = request.response;
  if (request.uri.path=='/favicon.ico') {
    return;
  }
  requestString = 'Received request ${request.method}: ${request.uri.path}';
  print('HTTP Received : ' + requestString);
  response.writeln('Received : $requestString');
  response.writeln('Message : $socketMessage');
  response.close();
}

void onWebSocketData(WebSocket client) {
  client.listen((data) {
    socketMessage = data.toString();
    print('WebSocket received ' + socketMessage);
    client.add('$socketMessage $requestString');
  });
}
