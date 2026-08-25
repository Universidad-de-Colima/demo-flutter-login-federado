part of 'screens_library.dart';

/// Screen that shows a webview for logging in with the federation
class WayfWebViewScreen extends StatelessWidget {
  /// Create a webview that serves for logging in with the federation and calls
  /// [onWayfResolve] when the result is returned.
  ///
  /// This widget can be used in conjunction with [WayfLoginButtonScreen] for a
  /// better initial presentation, but it is possible to use only the webview.
  const WayfWebViewScreen({
    required this.onWayfResolve,
    this.onWayfError,
    this.loginUrl,
    this.userAgent,
    super.key,
  });

  /// Callback to be called when the login process is finished
  final OnWayfResolve onWayfResolve;

  /// Callback to be called when the federation returns an error instead of
  /// a successful login payload (e.g. an unauthorized-organization response)
  final OnWayfError? onWayfError;

  /// URL for the login webview; if null, defaults to the built-in URL
  final String? loginUrl;

  /// User agent to be used by the webview; if null, the platform default is
  /// used
  final String? userAgent;

  @override
  Widget build(BuildContext context) {
    return WebViewTemplate(
      title: 'Inicio de sesión',
      initialUrl: loginUrl ?? UdcHttp.loginWebViewUrl,
      channelMessage: 'Login',
      onMessageReceived: (message) => _onMessageReceived(message, context),
      userAgent: userAgent,
    );
  }

  void _onMessageReceived(JavaScriptMessage jsMessage, BuildContext context) {
    debugPrint('WayfWebViewScreen payload: ${jsMessage.message}');
    try {
      final wayfData = WayfLoginModel.fromJson(
        json.decode(jsMessage.message) as Map<String, dynamic>,
      );
      onWayfResolve(wayfData);
    } on WayfLoginException catch (e) {
      debugPrint('WayfWebViewScreen error: ${e.message}');
      if (onWayfError != null) {
        onWayfError!(e.message);
      } else if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint('WayfWebViewScreen unexpected payload error: $e');
      if (onWayfError != null) {
        onWayfError!(e.toString());
      } else if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
