// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:wayf_login_udc/wayf_login_udc.dart';

/// Botón con estilos predefinidos para cerrar sesión
///
/// Hace uso de [WayfWebViewLogoutScreen] para cerrar sesión, pero la pantalla
/// puede usarse de forma independiente
class WayfLogoutButton extends StatelessWidget {
  /// Crea un botón con comportamiento y estilo predefinido para
  /// cerrar una sesión en la federación
  const WayfLogoutButton({
    required this.onWayfResolve,
    super.key,
  });

  /// Función llamada cuando el proceso ha terminado
  final void Function(BuildContext) onWayfResolve;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
        backgroundColor: UdcColors.actionDanger,
      ),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
            builder: (context) => WayfWebViewLogoutScreen(
              onWayfResolve: () => onWayfResolve(context),
            ),
          ),
          (route) => false,
        );
      },
      label: const Text(
        'Salir',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      icon: const Icon(
        Icons.logout,
        color: Colors.white,
      ),
    );
  }
}
