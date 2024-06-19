# CC Web Socket

CC Web Socket, Flutter uygulamaları için güçlü ve esnek bir WebSocket istemcisi sağlar. Bu paket, WebSocket bağlantılarını kolayca yönetmenize ve özelleştirmenize olanak tanır.

## Özellikler

- **Kolay Başlatma**: Basit yapılandırma seçenekleriyle hızlıca WebSocket bağlantısı kurabilirsiniz.
- **Zaman Aşımı ve Ping Ayarları**: Bağlantı zaman aşımı ve ping aralıklarını özelleştirebilirsiniz.
- **Otomatik Bağlanma**: Bağlantı kesildiğinde otomatik yeniden bağlanma özelliği.
- **Detaylı Loglama**: Bağlantı durumu, istek ve yanıtlar gibi olayları loglama seçenekleri.
- **Modüler Yapı**: Eklentiler ve modüller ekleyerek işlevselliği genişletebilirsiniz.

## Kurulum

Projenize bu paketi eklemek için `pubspec.yaml` dosyanıza aşağıdaki satırı ekleyin:

```yaml
dependencies:
  cc_web_socket: ^1.0.0
```

## Kullanım

### Başlatma

CCWebSocket'i başlatmak için aşağıdaki kodu kullanın:

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
    Unknown(),
  ],
);
```

> **NOTE** requestTypeName parametresi dönen verinin doğru modül ile eşleştirilmesi için json içeriğinde bulan tanımlayıcıdır. 


### Bağlantı

WebSocket bağlantısını başlatmak için aşağıdaki kodu kullanın:

```dart
CCWebSocket.connect();
```

### Modül Kullanımı

Modül üzerinden istek göndermek için:

```dart
CCWebSocket.getModule<Unknown>().request(
  body: {
    "request_type": "Unknown",
  },
);
```

### Örnek Modül

Kendi modülünüzü oluşturmak için aşağıdaki gibi bir sınıf tanımlayabilirsiniz:

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

veya sadece yanıt işlemek için:

```dart
class Example extends RequestModule {
  @override
  void response(dynamic response) {}
}
```

## Katkıda Bulunma

Katkıda bulunmak isterseniz, lütfen bir `pull request` gönderin veya bir `issue` açın. Her türlü geri bildiriminiz bizim için değerlidir.

## Lisans

Bu proje MIT Lisansı ile lisanslanmıştır. Daha fazla bilgi için `LICENSE` dosyasına bakabilirsiniz.
```

Bu metni `Readme.md` dosyanıza yapıştırarak projenizi Flutter pub.dev'de yayınlayabilirsiniz.