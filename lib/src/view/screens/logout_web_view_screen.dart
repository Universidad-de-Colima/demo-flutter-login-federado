part of screens;

/// Makes the logout process by showing a webview
class WayfWebViewLogoutScreen extends StatelessWidget {
  /// Creates a webview that serves for logging out with the federation and
  /// calls [onWayfResolve] when the result is returned.
  const WayfWebViewLogoutScreen({
    super.key,
    required this.onWayfResolve,
  });

  /// Callback to be called when the logout process is finished
  final VoidCallback onWayfResolve;

  @override
  Widget build(BuildContext context) {
    return WebViewTemplate(
      title: 'Cerrar sesión',
      channelMessage: 'Logout',
      initialUrl: UdcHttp.logoutWebViewUrl,
      onMessageReceived: (_) => onWayfResolve(),
    );
  }
}
