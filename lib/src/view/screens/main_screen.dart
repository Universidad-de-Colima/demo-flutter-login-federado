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
    this.loadExistingLogin,
    this.validateExistingLogin,
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

  /// Pass this function to check for an existing session,
  /// useful for take an existing session and skip the login process
  ///
  final Future<WayfLoginModel?> Function()? loadExistingLogin;

  /// Useful to check if an existing session is valid
  ///
  /// If this function returns true, the login process is skipped
  final bool Function(WayfLoginModel)? validateExistingLogin;

  @override
  Widget build(BuildContext context) {
    final content = _HomeContent(
      title: title,
      logo: logo,
      authIcon: null,
      onWayfResolve: onWayfResolve,
    );
    if (loadExistingLogin == null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: content,
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FutureBuilder<WayfLoginModel?>(
            future: loadExistingLogin!(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return content;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data == null) return content;
              return _HomeContent(
                title: title,
                logo: logo,
                onWayfResolve: onWayfResolve,
                authIcon: _LoadExistingLogin(
                  data: snapshot.data!,
                  onWayfResolve: onWayfResolve,
                  validateExistingLogin: validateExistingLogin,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.title,
    required this.logo,
    required this.authIcon,
    required this.onWayfResolve,
  });

  final Widget title;
  final Widget? logo;
  final Widget? authIcon;
  final OnWayfResolve onWayfResolve;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: authIcon != null ? 4 : 3,
          child: _Title(title: title, logo: logo),
        ),
        Expanded(
          flex: authIcon != null ? 2 : 1,
          child: BottomSecondaryButton(
            onPressed: () => _toLogin(context),
            text: 'Iniciar sesión',
            authButton: authIcon,
          ),
        ),
      ],
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

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    required this.logo,
  });

  final Widget title;
  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TitleConstraints(
          title: title,
        ),
        LogoConstraints(
          child: logo ?? const UdcLogo(),
        ),
      ],
    );
  }
}

class _LoadExistingLogin extends StatefulWidget {
  const _LoadExistingLogin({
    required this.data,
    required this.onWayfResolve,
    required this.validateExistingLogin,
  });
  final WayfLoginModel data;
  final bool Function(WayfLoginModel)? validateExistingLogin;
  final OnWayfResolve onWayfResolve;

  @override
  State<_LoadExistingLogin> createState() => _LoadExistingLoginState();
}

class _LoadExistingLoginState extends State<_LoadExistingLogin> {
  bool _isSupported = false;
  final _auth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isSupported = await _loadValid(widget.data);
      setState(() {
        _isSupported = isSupported;
      });
      if (isSupported) await _loadExistingLogin(widget.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isSupported) return const SizedBox.shrink();
    return Center(
      child: IconButton(
        icon: const Icon(
          Icons.fingerprint,
          size: 52,
          color: Colors.white,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(
            const CircleBorder(),
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.1),
          ),
        ),
        onPressed: () {
          _loadExistingLogin(widget.data);
        },
      ),
    );
  }

  Future<bool> _loadValid(WayfLoginModel data) async {
    final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
    final canAuthenticate =
        canAuthenticateWithBiometrics || await _auth.isDeviceSupported();

    if (!canAuthenticate) return false;
    return true;
  }

  Future<void> _loadExistingLogin(WayfLoginModel? data) async {
    if (data == null) return;
    if (widget.validateExistingLogin != null) {
      final isValid = widget.validateExistingLogin!(data);
      if (!isValid) return;
    }
    final allowed = await this.allowed();
    if (allowed) widget.onWayfResolve(data);
  }

  Future<bool> allowed() async {
    if (!_isSupported) return false;
    try {
      final allowed = await _auth.authenticate(
        localizedReason: 'Por favor, autentícate para continuar',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
        authMessages: [
          const AndroidAuthMessages(
            signInTitle: 'Iniciar sesión',
          ),
          const IOSAuthMessages(),
        ],
      );
      return allowed;
    } catch (e) {
      return false;
    }
  }
}
