import 'dart:convert';

import 'package:cc_web_socket/src/socket_manager.dart';
import 'package:cc_web_socket/src/request/handlers/i_request.dart';

abstract class RequestModule implements IRequest {
  String requestName = "";

  RequestModule() {
    requestName = this.runtimeType.toString();
  }
  @override
  void flush(String request) {
    SocketManager.request(request);
  }

  @override
  void onError(int reasonCode, String reason) {}

  @override
  void request({required Map<String, dynamic> body}) {
    flush(jsonEncode(body));
  }
}
