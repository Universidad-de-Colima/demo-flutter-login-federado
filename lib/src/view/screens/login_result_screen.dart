part of 'screens_library.dart';

/// Una pantalla que muestra los datos del usuario
class LoginResultScreen extends StatelessWidget {
  /// Crea una pantalla que muestra los datos del usuario
  const LoginResultScreen({
    required this.data,
    this.onLogout,
    this.logoutUrl,
    this.userAgent,
    super.key,
  });

  /// Los datos del usuario que se obtuvieron del webview
  final WayfLoginModel data;

  /// Called when the user press the logout button
  final Future<void> Function()? onLogout;

  /// URL para el webview de cierre de sesión; si es null, se usa la URL
  /// predefinida
  final String? logoutUrl;

  /// User agent para el webview de cierre de sesión; si es null, se usa el
  /// predefinido de la plataforma
  final String? userAgent;
  @override
  Widget build(BuildContext context) {
    return SimpleScaffoldTemplate(
      actions: [
        WayfLogoutButton(
          onWayfResolve: (context) {
            onLogout?.call();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          },
          logoutUrl: logoutUrl,
          userAgent: userAgent,
        ),
        const SizedBox(width: 8),
      ],
      title: 'Login correcto',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DataItem('Nombre', data.displayName),
            _DataItem('Tipo', data.uTipo),
            if (data.uTipo == 'Estudiante')
              _DataItem('No. Cuenta', data.uCuenta),
            if (data.uTipo != 'Estudiante')
              _DataItem('No. Trabajador', data.uTrabajador),
            _DataItem('Correo', data.uCorreo),
            _DataItem('Dependencia', data.uDependencia),
          ],
        ),
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  const _DataItem(
    this.field,
    this.value,
  );
  final String field;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field, style: Theme.of(context).textTheme.titleLarge),
        Text(value),
      ],
    );
  }
}
