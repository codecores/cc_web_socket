import 'dart:async';
import 'package:cc_web_socket/cc_web_socket.dart';
import 'package:synchronized/synchronized.dart';
import 'package:web_socket_channel/io.dart';

class SocketManager {
  static late IOWebSocketChannel channel;
  static var lock = Lock();

  static listen() {
    lock.synchronized(
      () async {
        await channel.ready;
        channel.stream.listen(
          (message) {
            CCWebSocket.dedect(message.toString());
          },
          onError: (v) async {
            CCWebSocket.loggingOptions.broadcastError("Socket error -> " + v);
            Future.delayed(const Duration(seconds: 2), () {
              reconnect();
            });
            CCWebSocket.setConnectState(false);
          },
          onDone: () async {
            CCWebSocket.loggingOptions.broadcastClosed("Connection closed");
            reconnect();
            CCWebSocket.setConnectState(false);
          },
        );
      },
    );
  }

  static ping() async {
    lock.synchronized(
      () async {
        CCWebSocket.loggingOptions.broadcastConnection("Connected to " +
            CCWebSocket.socketOptions.uri.toString() +
            " [4/4]");
        while (CCWebSocket.isConnected()) {
          await Future.delayed(
            const Duration(seconds: 1),
            () async {
              if (channel.closeCode == null) {
                CCWebSocket.setConnectState(false);
              }
            },
          );
        }

        CCWebSocket.loggingOptions.broadcastReconnection("Reconnecting...");
        reconnect();
      },
    );
  }

  static prepare() async {
    try {
      CCWebSocket.loggingOptions
          .broadcastConnection("Connected checking... [2/4]");
      await channel.ready;
      channel.stream.timeout(CCWebSocket.socketOptions.connectTimeout!,
          onTimeout: (sink) {
        CCWebSocket.setConnectState(false);
        ping();
      });
      CCWebSocket.setConnectState(true);
      CCWebSocket.loggingOptions
          .broadcastConnection("Connected dedected [3/4]");
      listen();
      ping();
    } catch (e) {
      CCWebSocket.loggingOptions
          .broadcastError("An error on connection : " + e.toString());
      Future.delayed(const Duration(seconds: 5), () {
        reconnect();
      });
      CCWebSocket.setConnectState(false);
      return;
    }
  }

  static void reconnect() {
    if (!CCWebSocket.socketOptions.autoConnect!) return;
    connect();
  }

  static Future<bool> connect() async {
    if (CCWebSocket.isConnected()) return true;
    CCWebSocket.loggingOptions.broadcastConnection("Connection starting [1/4]");
    channel = IOWebSocketChannel.connect(
      CCWebSocket.socketOptions.uri,
      connectTimeout: CCWebSocket.socketOptions.connectTimeout,
      pingInterval: CCWebSocket.socketOptions.pingInterval,
    );

    await prepare();
    return CCWebSocket.isConnected();
  }

  void closeServer() async {
    channel.sink.close();
  }

  static request(String body) async {
    channel.sink.add(body);
    CCWebSocket.loggingOptions.broadcastRequest(body);
  }
}
