abstract class IRequest {
  void request({required Map<String, dynamic> body});
  void flush(String request);
  void response(dynamic response);
  void onError(int reasonCode, String reason);
}
