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
    this.onWayfError,
    this.loadExistingLogin,
    this.validateExistingLogin,
    this.logo,
    super.key,
    this.buttonTitle = 'Iniciar sesión',
    this.loginButtonIcon,
    this.loginButtonStyle,
    this.privacyUrl,
    this.showPrivacyNotice = true,
    this.version,
    this.copyrightPeriod,
    this.loginUrl,
    this.userAgent,
  });

  /// Callback to be called when the login process is finished
  final OnWayfResolve onWayfResolve;

  /// Callback to be called when the federation returns an error instead of
  /// a successful login payload (e.g. an unauthorized-organization response)
  final OnWayfError? onWayfError;

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

  final String buttonTitle;

  /// Optional icon to display inside the login button
  final Widget? loginButtonIcon;

  /// Optional style to apply to the login button
  final ButtonStyle? loginButtonStyle;

  /// URL for the privacy notice link; if null, defaults to the built-in URL
  final String? privacyUrl;

  /// Whether to show the privacy notice link at the bottom
  final bool showPrivacyNotice;

  /// Version string displayed next to the privacy notice, e.g. 'Versión 1.0.0'
  final String? version;

  /// Copyright period string, e.g. '2022 - 2026'
  final String? copyrightPeriod;

  /// Optional URL for the login page, if not provided, the default URL is used
  final String? loginUrl;

  /// Optional user agent for the login webview; if not provided, the
  /// platform default is used
  final String? userAgent;

  @override
  Widget build(BuildContext context) {
    final content = _HomeContent(
      title: title,
      logo: logo,
      authIcon: null,
      onWayfResolve: onWayfResolve,
      onWayfError: onWayfError,
      buttonTitle: buttonTitle,
      loginButtonIcon: loginButtonIcon,
      loginButtonStyle: loginButtonStyle,
      privacyUrl: privacyUrl,
      showPrivacyNotice: showPrivacyNotice,
      version: version,
      copyrightPeriod: copyrightPeriod,
      loginUrl: loginUrl,
      userAgent: userAgent,
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
                onWayfError: onWayfError,
                authIcon: _LoadExistingLogin(
                  data: snapshot.data!,
                  onWayfResolve: onWayfResolve,
                  validateExistingLogin: validateExistingLogin,
                ),
                buttonTitle: buttonTitle,
                loginButtonIcon: loginButtonIcon,
                loginButtonStyle: loginButtonStyle,
                privacyUrl: privacyUrl,
                showPrivacyNotice: showPrivacyNotice,
                version: version,
                copyrightPeriod: copyrightPeriod,
                loginUrl: loginUrl,
                userAgent: userAgent,
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
    this.onWayfError,
    this.buttonTitle = 'Iniciar sesión',
    this.loginButtonIcon,
    this.loginButtonStyle,
    this.privacyUrl,
    this.showPrivacyNotice = true,
    this.version,
    this.copyrightPeriod,
    this.loginUrl,
    this.userAgent,
  });

  final Widget title;
  final Widget? logo;
  final Widget? authIcon;
  final OnWayfResolve onWayfResolve;
  final OnWayfError? onWayfError;
  final String buttonTitle;
  final Widget? loginButtonIcon;
  final ButtonStyle? loginButtonStyle;
  final String? privacyUrl;
  final bool showPrivacyNotice;
  final String? version;
  final String? copyrightPeriod;

  /// URL for the login webview; if null, defaults to the built-in URL
  final String? loginUrl;

  /// User agent for the login webview; if null, the platform default is used
  final String? userAgent;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final isSmallHeight = media.size.height < 600;
    final isSmallWidth = media.size.width < 360;
    final isSmall = isSmallHeight || isSmallWidth;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: authIcon != null ? (isSmall ? 2 : 4) : (isSmall ? 2 : 3),
          child: _Title(title: title, logo: logo),
        ),
        Expanded(
          flex: isSmall ? 3 : (authIcon != null ? 2 : 1),
          child: Column(
            children: [
              Expanded(
                child: BottomSecondaryButton(
                  onPressed: () => _toLogin(context),
                  text: buttonTitle,
                  authButton: authIcon,
                  buttonIcon: loginButtonIcon,
                  buttonStyle: loginButtonStyle,
                  copyrightPeriod: copyrightPeriod,
                ),
              ),
              if (showPrivacyNotice)
                Container(
                  width: media.size.width,
                  padding: EdgeInsets.symmetric(vertical: isSmall ? 6 : 16),
                  decoration: const BoxDecoration(
                    color: UdcColors.actionSecondary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _PrivacyNoticeLink(
                        version: version ?? 'Versión 1.0.14+22',
                        privacyUrl: privacyUrl,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void _toLogin(BuildContext context) {
    // Guards against a double-tap pushing this route twice before the first
    // push completes, which races two WKWebView platform views for the same
    // native view id and crashes with a `recreating_view` PlatformException.
    if (ModalRoute.of(context)?.isCurrent != true) return;
    Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return WayfWebViewScreen(
            onWayfResolve: onWayfResolve,
            onWayfError: onWayfError,
            loginUrl: loginUrl,
            userAgent: userAgent,
          );
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
    return FittedBox(
      fit: BoxFit.scaleDown,
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
      child: Platform.isIOS
          ? Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5), // Rounded corners
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26, // Subtle shadow color
                    blurRadius: 6, // Slight blur for the shadow
                    offset: Offset(3, 5), // Shadow position (x, y)
                  ),
                ],
              ),
              child: IconButton(
                icon: Image.asset(
                  UdcAssets.faceId,
                  package: 'wayf_login_udc',
                  height: 35,
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                onPressed: () {
                  _loadExistingLogin(widget.data);
                },
              ),
            )
          : IconButton(
              icon: const Icon(
                Icons.fingerprint,
                size: 52,
                color: Colors.white,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                padding: WidgetStateProperty.all(EdgeInsets.zero),
                shape: WidgetStateProperty.all(
                  const CircleBorder(),
                ),
                overlayColor: WidgetStateProperty.all(
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
    // `isDeviceSupported` solo indica que el hardware/OS soporta biometría,
    // no que haya una huella/Face ID enrolada — un iPhone con Face ID nunca
    // configurado igual regresa `true`. Por eso se valida además que
    // `getAvailableBiometrics` no esté vacío.
    final canCheck = await _auth.canCheckBiometrics;
    final isDeviceSupported = await _auth.isDeviceSupported();
    if (!canCheck || !isDeviceSupported) return false;

    final availableBiometrics = await _auth.getAvailableBiometrics();
    return availableBiometrics.isNotEmpty;
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
        biometricOnly: true,
        persistAcrossBackgrounding: true,
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

class _PrivacyNoticeLink extends StatelessWidget {
  _PrivacyNoticeLink({required this.version, this.privacyUrl});

  final String version;
  final String? privacyUrl;
  final isiOS = Platform.isIOS ? 'i' : 'A';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPrivacyNotice(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Aviso de Privacidad',
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.underline,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            version + isiOS,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _openPrivacyNotice(BuildContext context) async {
    final url = privacyUrl ??
        'https://transparencia.ucol.mx/avisosdeprivacidad/asistenciasudec/';
    try {
      final uri = Uri.parse(url);

      // Simple approach: try launchUrl directly with external application mode
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      debugPrint('Error with externalApplication launch mode: $e');
      try {
        // Fallback: try with platform default mode
        final uri = Uri.parse(url);
        await launchUrl(
          uri,
          mode: LaunchMode.platformDefault,
        );
      } catch (e) {
        debugPrint('Error with platformDefault launch mode: $e');
        try {
          // Last resort: try inAppWebView
          final uri = Uri.parse(url);
          await launchUrl(
            uri,
            mode: LaunchMode.inAppWebView,
          );
        } catch (e) {
          debugPrint('Error with inAppWebView launch mode: $e');
          // Show user feedback
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('No se pudo abrir el enlace del aviso de privacidad'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      }
    }
  }
}
