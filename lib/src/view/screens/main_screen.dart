part of 'screens_library.dart';

/// Una pantalla que muestra un botón para abrir un webview y comenzar el
/// proceso de login con la federación
class WayfLoginButtonScreen extends StatelessWidget {
  /// Crea una pantalla intermediaría entre una vista cualquiera y el webview
  ///
  /// Esta pantalla es solamente visual y puede ser omitida
  /// El callback [onWayfResolve] es pasado directamente a la pantalla del web
  /// view
  const WayfLoginButtonScreen({
    required this.onWayfResolve,
    required this.title,
    this.logo,
    super.key,
  });

  /// Callback to be called when the login process is finished
  final OnWayfResolve onWayfResolve;

  /// Widget to be displayed as title
  ///
  /// This widget is constrained based on the screen size, prefer using
  /// a simple image or a text
  final Widget title;

  /// Widget to be displayed as logo
  ///
  /// This widget is constrained based on the screen size, prefer using
  /// a simple image or a text, by default is the [UdcLogo]
  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TitleConstraints(
                      title: title,
                    ),
                    LogoConstraints(
                      child: logo ?? const UdcLogo(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BottomSecondaryButton(
                  onPressed: () => _toLogin(context),
                  text: 'Iniciar sesión',
                ),
              ),
            ],
          ),
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
