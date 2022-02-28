part of screens;

class LoginResultScreen extends StatelessWidget {
  const LoginResultScreen({Key? key, required this.data}) : super(key: key);
  final WayfLoginModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0x00, 0x6b, 0x3f, 1),
        foregroundColor: Colors.white,
        title: const Text('Login correcto'),
      ),
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
    this.value, {
    Key? key,
  }) : super(key: key);
  final String field;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(field, style: Theme.of(context).textTheme.headline6),
        Text(value),
      ],
    );
  }
}
