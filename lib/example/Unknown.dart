import 'package:cc_web_socket/src/request/modules/request_module.dart';

class Unknown extends RequestModule {
  @override
  void request({required Map<String, dynamic> body}) {
    super.request(body: body);
  }

  @override
  void response(dynamic response) {}
}
