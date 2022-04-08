part of screens;

/// Una pantalla para hacer logout de la federación mediante un webview
class WayfWebViewLogoutScreen extends StatefulWidget {
  /// Crea un webview para hacer login con la federación y llama a
  /// [onWayfResolve] cuando el logout se ha completado
  const WayfWebViewLogoutScreen({
    Key? key,
    required this.onWayfResolve,
  }) : super(key: key);

  /// Función llamada cuando el logout se ha completado
  final VoidCallback onWayfResolve;
  @override
  State<WayfWebViewLogoutScreen> createState() =>
      _WayfWebViewLogoutScreenState();
}

class _WayfWebViewLogoutScreenState extends State<WayfWebViewLogoutScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UdcColors.green,
        foregroundColor: Colors.white,
        title: const Text('Cerrar sesión'),
      ),
      body: WebView(
        initialUrl: logoutWebViewUrl,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          _createChannel(),
        },
      ),
    );
  }

  JavascriptChannel _createChannel() {
    return JavascriptChannel(
      name: 'Logout',
      onMessageReceived: (_) {
        widget.onWayfResolve();
      },
    );
  }
}
