part of screens;

/// Una pantalla que muestra un botón para abrir un webview y comenzar el
/// proceso de login con la federación
class WayfLoginButtonScreen extends StatelessWidget {
  /// Crea una pantalla intermediaría entre una vista cualquiera y el webview
  ///
  /// Esta pantalla es solamente visual y puede ser omitida
  /// El callback [onWayfResolve] es pasado directamente a la pantalla del web
  /// view
  const WayfLoginButtonScreen({
    Key? key,
    required this.onWayfResolve,
  }) : super(key: key);
  final OnWayfResolve onWayfResolve;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UdcLogo(),
            const SizedBox(height: 24),
            BlueButton(onPressed: () => _toLogin(context)),
          ],
        ),
      ),
    );
  }

  void _toLogin(BuildContext context) {
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WayfWebViewScreen(onWayfResolve: onWayfResolve);
        },
      ),
    );
  }
}
