[![pub package](https://img.shields.io/pub/v/http.svg)](https://pub.dev/packages/cc_web_socket)

# CC Web Socket

CC Web Socket provides a robust and flexible WebSocket client for Flutter applications. This package allows you to easily manage and customize WebSocket connections.

**For more detailed information:**
https://ferhaterdem.medium.com/building-real-time-flutter-apps-with-cc-web-socket-c8429fa5c83c

## Features

- **Easy Initialization**: Quickly establish WebSocket connections with simple configuration options.
- **Timeout and Ping Settings**: Customize connection timeout and ping intervals.
- **Automatic Reconnection**: Automatically reconnect when the connection is lost.
- **Detailed Logging**: Options for logging connection status, requests, and responses.
- **Modular Structure**: Extend functionality with plugins and modules.

## Installation

Add this package to your project by including the following line in your `pubspec.yaml` file:

```yaml
dependencies:
  cc_web_socket: ^1.0.0
```

## Usage

### Initialization

To initialize CCWebSocket, use the following code:

```dart
CCWebSocket.init(
  socketOptions: CCSocketOptions(
    uri: Uri(
      scheme: "wss",
      host: "echo.websocket.org",
      port: 443,
      path: ".ws",
    ),
    connectTimeout: const Duration(seconds: 5),
    pingInterval: const Duration(seconds: 120),
    requestTypeName: "request_type",
    autoConnect: true,
  ),
  loggingOptions: CCSocketLogging(
    logEnabled: true,
    onConnection: (prompt) {},
    onReconnection: (prompt) {},
    onClosed: (prompt) {},
    onRequest: (prompt) {},
    onResponse: (prompt) {},
    onError: (prompt) {},
  ),
  modules: [
    Example(),
  ],
);
```

> **NOTE** The `requestTypeName` parameter is an identifier in the JSON content that matches the correct module for the returned data.

### Connection

To initiate the WebSocket connection, use the following code:

```dart
CCWebSocket.connect();
```

### Module Usage

To send a request through a module:

```dart
CCWebSocket.getModule<Example>().request(
  body: {
    "request_type": "Unknown",
  },
);
```

### Example Module

You can create your own module by defining a class like this:

```dart
class Example extends RequestModule {
  @override
  void request({required Map<String, dynamic> body}) {
    super.request(body: body);
  }

  @override
  void response(dynamic response) {}
}
```

or to handle only the response:

```dart
class Example extends RequestModule {
  @override
  void response(dynamic response) {}
}
```

## Contributing

If you want to contribute, please submit a pull request or open an issue. We value all kinds of feedback.

## License

This project is licensed under the MIT License. For more information, see the `LICENSE` file.
