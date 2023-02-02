part of screens;

/// Screen that shows a webview for logging in with the federation
class WayfWebViewScreen extends StatelessWidget {
  /// Create a webview that serves for logging in with the federation and calls
  /// [onWayfResolve] when the result is returned.
  ///
  /// This widget can be used in conjunction with [WayfLoginButtonScreen] for a
  /// better initial presentation, but it is possible to use only the webview.
  const WayfWebViewScreen({
    super.key,
    required this.onWayfResolve,
  });

  /// Callback to be called when the login process is finished
  final OnWayfResolve onWayfResolve;

  @override
  Widget build(BuildContext context) {
    return WebViewTemplate(
      title: 'Inicio de sesión',
      initialUrl: UdcHttp.loginWebViewUrl,
      channelMessage: 'Login',
      onMessageReceived: _onMessageReceived,
    );
  }

  void _onMessageReceived(JavaScriptMessage jsMessage) {
    final wayfData = WayfLoginModel.fromJson(
      json.decode(jsMessage.message) as Map<String, dynamic>,
    );
    onWayfResolve(wayfData);
  }
}
