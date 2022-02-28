part of screens;

/// Una pantalla para hacer login con la federación mediante un webview
class WayfWebViewScreen extends StatefulWidget {
  /// Crea un webview que sirve para hacer login con la federación y llama a
  /// [onWayfResolve] cuando el resultado es devuelto
  ///
  /// Este widget puede usarse en conjunto con [WayfLoginButtonScreen] para
  /// tener una mejor presentación inicial, pero es posible usar solo el webview
  const WayfWebViewScreen({
    Key? key,
    required this.onWayfResolve,
  }) : super(key: key);
  final OnWayfResolve onWayfResolve;
  @override
  _WayfWebViewScreenState createState() => _WayfWebViewScreenState();
}

class _WayfWebViewScreenState extends State<WayfWebViewScreen> {
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
        title: const Text('Inicio de sesión'),
      ),
      body: WebView(
        initialUrl: loginWebViewUrl,
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: {
          _createChannel(),
        },
      ),
    );
  }

  JavascriptChannel _createChannel() {
    return JavascriptChannel(
      name: 'Login',
      onMessageReceived: (jsMessage) {
        final wayfData = WayfLoginModel.fromJson(
          json.decode(jsMessage.message) as Map<String, dynamic>,
        );
        widget.onWayfResolve(wayfData);
      },
    );
  }
}
