import 'package:cc_web_socket/cc_socket_options.dart';
import 'package:cc_web_socket/cc_web_socket.dart';
import 'package:cc_web_socket/example/example.dart';
import 'package:flutter/material.dart';

void main() {
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
  CCWebSocket.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    CCWebSocket.getModule<Example>().request(
      body: {
        "request_type": "Unknown",
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
