class CCSocketOptions {
  Uri uri;
  Duration? connectTimeout = Duration(seconds: 30);
  Duration? pingInterval = Duration(seconds: 120);

  String requestTypeName;
  bool? autoConnect = true;

  CCSocketOptions({
    required this.uri,
    required this.requestTypeName,
    this.connectTimeout,
    this.pingInterval,
    this.autoConnect,
  }) {}
}

class CCSocketLogging {
  bool logEnabled = true;
  Function(String)? onConnection;
  Function(String)? onReconnection;
  Function(String)? onRequest;
  Function(String)? onResponse;
  Function(String)? onClosed;
  Function(String)? onError;

  CCSocketLogging({
    required this.logEnabled,
    this.onConnection,
    this.onReconnection,
    this.onRequest,
    this.onResponse,
    this.onClosed,
    this.onError,
  });

  void broadcastConnection(String value) {
    if (!logEnabled) return;
    if (onConnection == null) return;
    String prompt = "[CCRestApi - Connection] $value";
    print(prompt);
    onConnection!(prompt);
  }

  void broadcastClosed(String value) {
    if (!logEnabled) return;
    if (onClosed == null) return;
    String prompt = "[CCRestApi - Connection] $value";
    print(prompt);
    onClosed!(prompt);
  }

  void broadcastReconnection(String value) {
    if (!logEnabled) return;
    if (onRequest == null) return;
    String prompt = "[CCRestApi - Reconnection] $value";
    print(prompt);
    onReconnection!(prompt);
  }

  void broadcastRequest(String value) {
    if (!logEnabled) return;
    if (onRequest == null) return;
    String prompt = "[CCRestApi - Request] $value";
    print(prompt);
    onRequest!("[CCRestApi - Request] $value");
  }

  void broadcastResponse(String value) {
    if (!logEnabled) return;
    if (onResponse == null) return;
    String prompt = "[CCRestApi - Response] $value";
    print(prompt);
    onResponse!(prompt);
  }

  void broadcastError(String value) {
    if (!logEnabled) return;
    if (onError == null) return;
    String prompt = "[CCRestApi - Error] $value";
    print(prompt);
    onError!(prompt);
  }
}
