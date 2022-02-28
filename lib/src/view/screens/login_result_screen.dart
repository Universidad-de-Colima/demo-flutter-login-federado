part of screens;

class LoginResultScreen extends StatelessWidget {
  const LoginResultScreen({Key? key, required this.data}) : super(key: key);
  final WayfLoginModel data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login correcto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DataItem('Nombre', data.displayName.first),
            _DataItem('No. Cuenta', data.uCuenta.first),
            _DataItem('Correo', data.uCorreo.first),
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
