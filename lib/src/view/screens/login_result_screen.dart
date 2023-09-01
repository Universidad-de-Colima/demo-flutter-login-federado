part of 'screens_library.dart';

/// Una pantalla que muestra los datos del usuario
class LoginResultScreen extends StatelessWidget {
  /// Crea una pantalla que muestra los datos del usuario
  const LoginResultScreen({
    required this.data,
    super.key,
  });

  /// Los datos del usuario que se obtuvieron del webview
  final WayfLoginModel data;
  @override
  Widget build(BuildContext context) {
    return SimpleScaffoldTemplate(
      actions: [
        WayfLogoutButton(
          onWayfResolve: (context) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home', (route) => false);
          },
        ),
        const SizedBox(width: 8),
      ],
      title: 'Login correcto',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DataItem('Nombre', data.displayName.first),
            _DataItem('Tipo', data.uTipo.first),
            if (data.uTipo.first == 'Estudiante')
              _DataItem('No. Cuenta', data.uCuenta.first),
            if (data.uTipo.first != 'Estudiante')
              _DataItem('No. Trabajador', data.uTrabajador.first),
            _DataItem('Correo', data.uCorreo.first),
            _DataItem('Dependencia', data.uDependencia.first),
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
