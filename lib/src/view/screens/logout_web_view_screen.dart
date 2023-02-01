part of screens;

/// Una pantalla para hacer logout de la federación mediante un webview
class WayfWebViewLogoutScreen extends StatefulWidget {
  /// Crea un webview para hacer login con la federación y llama a
  /// [onWayfResolve] cuando el logout se ha completado
  const WayfWebViewLogoutScreen({
    super.key,
    required this.onWayfResolve,
  });

  /// Función llamada cuando el logout se ha completado
  final VoidCallback onWayfResolve;
  @override
  State<WayfWebViewLogoutScreen> createState() =>
      _WayfWebViewLogoutScreenState();
}

class _WayfWebViewLogoutScreenState extends State<WayfWebViewLogoutScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white70)
      ..loadRequest(Uri.parse(logoutWebViewUrl))
      ..addJavaScriptChannel(
        'Logout',
        onMessageReceived: (_) {
          widget.onWayfResolve();
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UdcColors.green,
        foregroundColor: Colors.white,
        title: const Text('Cerrar sesión'),
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
