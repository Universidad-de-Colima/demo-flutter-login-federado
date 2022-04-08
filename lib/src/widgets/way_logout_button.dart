import 'package:flutter/material.dart';
import 'package:wayf_login_udc/src/constants/constants_library.dart';
import 'package:wayf_login_udc/src/view/screens/screens_library.dart';

/// Botón con estilos predefinidos para cerrar sesión
///
/// Hace uso de [WayfWebViewLogoutScreen] para cerrar sesión, pero la pantalla
/// puede usarse de forma independiente
class WayfLogoutButton extends StatelessWidget {
  /// Crea un botón con comportamiento y estilo predefinido para
  /// cerrar una sesión en la federación
  const WayfLogoutButton({
    required this.onWayfResolve,
    Key? key,
  }) : super(key: key);

  /// Función llamada cuando el proceso ha terminado
  final VoidCallback onWayfResolve;
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: false,
      onSelected: (_) {
        Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (context) => WayfWebViewLogoutScreen(
              onWayfResolve: onWayfResolve,
            ),
          ),
        );
      },
      backgroundColor: UdcColors.red,
      label: const Text(
        'Cerrar sesión',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      avatar: const CircleAvatar(
        backgroundColor: UdcColors.red,
        child: Icon(
          Icons.power_settings_new,
          color: Colors.white,
        ),
      ),
    );
  }
}
