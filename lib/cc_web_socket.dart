import 'dart:convert';

import 'package:cc_web_socket/cc_socket_options.dart';
import 'package:cc_web_socket/src/request/modules/request_module.dart';
import 'package:cc_web_socket/example/Example.dart';
import 'package:cc_web_socket/src/socket_manager.dart';

class CCWebSocket {
  static bool _connected = false;

  static bool isConnected() => _connected;

  static void setConnectState(bool value) => _connected = value;

  static Map<String, dynamic> _instances = <String, dynamic>{};

  static late CCSocketOptions socketOptions;

  static late CCSocketLogging loggingOptions;

  static void init(
      {required CCSocketOptions socketOptions,
      CCSocketLogging? loggingOptions,
      required List<dynamic> modules}) {
    CCWebSocket.socketOptions = socketOptions;

    CCWebSocket.loggingOptions =
        loggingOptions ?? CCSocketLogging(logEnabled: false);

    for (RequestModule module in modules) {
      register(module);
    }
  }

  static void connect() {
    SocketManager.connect();
  }

  static void register<T>(RequestModule instance) {
    CCWebSocket._instances[instance.requestName] = instance;
  }

  static T getModule<T>() {
    final instance = _instances[T.runtimeType.toString()];

    if (instance != null) {
      return instance as T;
    }

    CCWebSocket.loggingOptions.broadcastError(
        "Request type not found for request [" +
            instance.runtimeType.toString() +
            "]");
    return Example() as T;
  }

  static dedect(String response) async {
    try {
      Map<String, dynamic> data = jsonDecode(response);

      String requestTypeName = data.keys.firstWhere(
        (element) =>
            element.toLowerCase() ==
            CCWebSocket.socketOptions.requestTypeName.toLowerCase(),
        orElse: () => "",
      );

      String? requestType = data[requestTypeName];

      if (requestType == null) {
        CCWebSocket.loggingOptions.broadcastError("\"" +
            socketOptions.requestTypeName +
            "\" not detected in response");
        return;
      }

      final instance = _instances[requestType];

      if (instance != null) {
        (instance as RequestModule).response(data);
        CCWebSocket.loggingOptions.broadcastResponse(data.toString());
        return;
      }

      CCWebSocket.loggingOptions.broadcastError(
          "Request type not found for response [" +
              requestType! +
              ", Response = " +
              response +
              "]");
    } catch (e) {
      CCWebSocket.loggingOptions
          .broadcastError("Response error -> " + e.toString());
    }
  }
}
