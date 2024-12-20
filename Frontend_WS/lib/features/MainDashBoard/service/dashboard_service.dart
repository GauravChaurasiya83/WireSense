import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../model/dashboard_model.dart';

class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService(String url) : channel = WebSocketChannel.connect(Uri.parse(url));

  Stream<UserData> get userDataStream {
    return channel.stream.map((data) {
      final jsonData = json.decode(data) as Map<String, dynamic>;
      return UserData.fromJson(jsonData);
    });
  }

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  void close() {
    channel.sink.close();
  }
}
