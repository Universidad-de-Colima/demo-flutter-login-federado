part of screens;

class WayfWebViewScreen extends StatefulWidget {
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
        gestureNavigationEnabled: false,
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
        print('pitooooo');
        final wayfData = WayfLoginModel.fromJson(
          json.decode(jsMessage.message),
        );
        widget.onWayfResolve(wayfData);
        print(wayfData.displayName.first);
      },
    );
  }
}
