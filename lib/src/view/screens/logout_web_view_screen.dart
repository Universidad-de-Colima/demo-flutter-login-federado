part of 'screens_library.dart';

/// Makes the logout process by showing a webview
class WayfWebViewLogoutScreen extends StatelessWidget {
  /// Creates a webview that serves for logging out with the federation and
  /// calls [onWayfResolve] when the result is returned.
  const WayfWebViewLogoutScreen({
    required this.onWayfResolve,
    this.logoutUrl,
    this.userAgent,
    super.key,
  });

  /// Callback to be called when the logout process is finished
  final VoidCallback onWayfResolve;

  /// URL for the logout webview; if null, defaults to the built-in URL
  final String? logoutUrl;

  /// User agent to be used by the webview; if null, the platform default is
  /// used
  final String? userAgent;

  @override
  Widget build(BuildContext context) {
    return WebViewTemplate(
      title: 'Cerrar sesión',
      channelMessage: 'Logout',
      initialUrl: logoutUrl ?? UdcHttp.logoutWebViewUrl,
      onMessageReceived: (_) => onWayfResolve(),
      userAgent: userAgent,
    );
  }
}
