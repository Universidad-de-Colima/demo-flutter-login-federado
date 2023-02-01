part of screens;

/// Una pantalla para hacer login con la federación mediante un webview
class WayfWebViewScreen extends StatefulWidget {
  /// Crea un webview que sirve para hacer login con la federación y llama a
  /// [onWayfResolve] cuando el resultado es devuelto
  ///
  /// Este widget puede usarse en conjunto con [WayfLoginButtonScreen] para
  /// tener una mejor presentación inicial, pero es posible usar solo el webview
  const WayfWebViewScreen({
    super.key,
    required this.onWayfResolve,
  });
  final OnWayfResolve onWayfResolve;
  @override
  _WayfWebViewScreenState createState() => _WayfWebViewScreenState();
}

class _WayfWebViewScreenState extends State<WayfWebViewScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white70)
      ..loadRequest(Uri.parse(loginWebViewUrl))
      ..addJavaScriptChannel('Login', onMessageReceived: onMessageReceived);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UdcColors.green,
        foregroundColor: Colors.white,
        title: const Text(
          'Inicio de sesión',
        ),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  void onMessageReceived(JavaScriptMessage jsMessage) {
    final wayfData = WayfLoginModel.fromJson(
      json.decode(jsMessage.message) as Map<String, dynamic>,
    );
    widget.onWayfResolve(wayfData);
  }
}
